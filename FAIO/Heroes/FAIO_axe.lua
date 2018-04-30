FAIO_axe = {}

local call = nil
local hunger = nil
local culling = nil
local blademail = nil

function FAIO_axe.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroAxe) then return end

	call = NPC.GetAbilityByIndex(myHero, 0)
	hunger = NPC.GetAbilityByIndex(myHero, 1)
	culling = NPC.GetAbility(myHero, "axe_culling_blade")

	blademail = NPC.GetItem(myHero, "item_blade_mail", true)

	local myMana = NPC.GetMana(myHero)

	local callRange = 270
		if NPC.HasAbility(myHero, "special_bonus_unique_axe_2") then
			if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_axe_2")) > 0 then
				callRange = 370
			end
		end
		if enemy and NPC.IsRunning(enemy) then
			if not blink then
				callRange = callRange - 100
			else
				if Ability.SecondsSinceLastUse(blink) > 0.75 then
					callRange = callRange - 100
				end
			end	
		end

	if Menu.IsEnabled(FAIO_options.optionHeroAxeCulling) then
		if culling and Ability.IsCastable(culling, myMana) and FAIO_axe.isHeroChannelling(myHero) == false and FAIO_axe.IsHeroInvisible(myHero) == false then
			local cullingEnemy = NPC.GetHeroesInRadius(myHero, 150 + NPC.GetCastRangeBonus(myHero), Enum.TeamType.TEAM_ENEMY)
			for i, v in ipairs(cullingEnemy) do
				if v then
					if not NPC.IsDormant(v) and not NPC.IsIllusion(v) and Entity.IsAlive(v) then
						if Entity.GetHealth(v) + NPC.GetHealthRegen(v) < Ability.GetLevelSpecialValueFor(culling, "kill_threshold") and not NPC.IsLinkensProtected(v) then
							Ability.CastTarget(culling, v)
							break
						end
					end
				end
			end
		end
	end

	local cursorCheck
	if Menu.IsEnabled(FAIO_options.optionHeroAxeForceBlink) then
		if enemy and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionHeroAxeForceBlinkRange)-1, 0) then
			cursorCheck = true
		else
			cursorCheck = false
		end
	else
		cursorCheck = true
	end
	
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_axe.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and cursorCheck then

		FAIO_axe.system(switch, function (continue, wait)

			continue(FAIO_axe.comboExecute(myHero, enemy, myMana, callRange))
			wait()

		end)()
		
	end

	return

end

function FAIO_axe.comboExecute(myHero, enemy, myMana, callRange)

	if FAIO_axe.heroCanCastSpells(myHero, enemy) == true then

		if Menu.GetValue(FAIO_options.optionHeroAxeJump) == 0 then
			FAIO_axe.blinkHandler(myHero, enemy, callRange, 0, false)
		else
			FAIO_axe.blinkHandler(myHero, enemy, callRange, 0, true, callRange)
		end

		if culling and Ability.IsCastable(culling, myMana) and NPC.IsEntityInRange(myHero, enemy, 150) then
			if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) < Ability.GetLevelSpecialValueFor(culling, "kill_threshold") and not NPC.IsLinkensProtected(enemy) then
				FAIO_axe.executeSkillOrder(culling, enemy)
				return
			end
		end

		if call and Ability.IsCastable(call, myMana) and NPC.IsEntityInRange(myHero, enemy, callRange) then
			FAIO_axe.executeSkillOrder(call)
			return
		end

		if blademail and Ability.IsCastable(blademail, myMana) and NPC.IsEntityInRange(myHero, enemy, callRange) then 
			FAIO_axe.executeSkillOrder(blademail)
			return
		end

		if hunger and Ability.IsCastable(hunger, myMana - 120) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(hunger)) and not NPC.HasModifier(enemy, "modifier_axe_battle_hunger") then
			if NPC.HasItem(myHero, "item_blink", true) and Ability.IsReady(NPC.GetItem(myHero, "item_blink", true)) and not NPC.IsEntityInRange(myHero, enemy, callRange) then 
				return 
			end
			FAIO_axe.executeSkillOrder(hunger, enemy)
			return
		end
	end

	FAIO_axe.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_axe