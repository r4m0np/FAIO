FAIO_crystal_maiden = {}

local Q = nil
local W = nil

function FAIO_crystal_maiden.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroCM) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)

	local myMana = NPC.GetMana(myHero)
	
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_crystal_maiden.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
		FAIO_crystal_maiden.system(switch, function (continue, wait)

			continue(FAIO_crystal_maiden.comboExecute(myHero, enemy, myMana))
			wait()

		end)()
		
	end

	if Menu.IsEnabled(FAIO_options.optionHeroCMUlt) then
		local ult = NPC.GetAbility(myHero, "crystal_maiden_freezing_field")
		local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)
		local bkb = NPC.GetItem(myHero, "item_black_king_bar", true)
			if not ult or (ult and not Ability.IsCastable(ult, myMana)) then return end
			if not NPC.HasItem(myHero, "item_blink", true) or (NPC.HasItem(myHero, "item_blink", true) and not Ability.IsReady(NPC.GetItem(myHero, "item_blink", true))) then return end

		if Menu.IsKeyDown(FAIO_options.optionHeroCMUltKey) and Entity.IsAlive(enemy) and NPC.IsEntityInRange(myHero, enemy, 1150 + 450) then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO_crystal_maiden.heroCanCastSpells(myHero, enemy) == true then
			
				FAIO_crystal_maiden.system(switch, function (continue, wait)

					continue(FAIO_crystal_maiden.executeUltCombo(myHero, myMana, enemy, ult, glimmer, bkb))
					wait()

				end)()
			end
		end
	end

	return

end

function FAIO_crystal_maiden.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroCMBlinkRange) then
		FAIO_crystal_maiden.blinkHandler(myHero, enemy, 800, Menu.GetValue(FAIO_options.optionHeroCMBlinkRange), false)
	end
	
	if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, nil, true) then
		if FAIO_crystal_maiden.TargetGotDisableModifier(myHero, enemy) == false then
			FAIO_skillHandler.executeSkillOrder(W, enemy, nil)
			return
		end
	end

	local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 820, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 410)
	if bestPos ~= nil then
		if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, bestPos, false) then
			FAIO_skillHandler.executeSkillOrder(Q, enemy, bestPos)
			return
		end
	end

	FAIO_crystal_maiden.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

function FAIO_crystal_maiden.executeUltCombo(myHero, myMana, enemy, ult, glimmer, bkb)

	local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 1220, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 600)
	if bestPos ~= nil and #Heroes.InRadius(bestPos, 700, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroCMUltMin) then
		if #Heroes.InRadius(bestPos, 700, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) == 1 then
			if NPC.IsPositionInRange(myHero, bestPos, 1150 + 350, 0) then
				if FAIO_skillHandler.skillIsCastable(bkb, 1, myHero, nil, false) then
					FAIO_skillHandler.executeSkillOrder(bkb)
					return
				end
				if FAIO_skillHandler.skillIsCastable(glimmer, 1, myHero, nil, false) then
					FAIO_skillHandler.executeSkillOrder(glimmer, myHero)
					return
				end
				FAIO_crystal_maiden.blinkHandler(myHero, enemy, 650, 350, false)
				FAIO_skillHandler.executeSkillOrder(ult)
				return
			else
				FAIO_crystal_maiden.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
				return
			end
		else
			if NPC.IsPositionInRange(myHero, bestPos, 1150, 0) then
				if FAIO_skillHandler.skillIsCastable(bkb, 1, myHero, nil, false) then
					FAIO_skillHandler.executeSkillOrder(bkb)
					return
				end
				if FAIO_skillHandler.skillIsCastable(glimmer, 1, myHero, nil, false) then
					FAIO_skillHandler.executeSkillOrder(glimmer, myHero)
					return
				end

				local savePos = bestPos
					if #Heroes.InRadius(savePos, 350, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) > 0 then
						local myPos = Entity.GetAbsOrigin(myHero)
						local dist = (myPos - savePos):Length2D()
						for k = 1, math.floor(dist/25) do
							local searchPos = savePos + (myPos - savePos):Normalized():Scaled(k*25)
							if #Heroes.InRadius(searchPos, 350, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) < 1 then
								savePos = searchPos
								break
							end
						end		
					end

				if not NPC.IsPositionInRange(myHero, savePos, 300, 0) then
					Ability.CastPosition(NPC.GetItem(myHero, "item_blink", true), savePos)
				end

				FAIO_skillHandler.executeSkillOrder(ult)
				return
			else
				FAIO_crystal_maiden.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
				return
			end
		end
	end

	return

end

return FAIO_crystal_maiden