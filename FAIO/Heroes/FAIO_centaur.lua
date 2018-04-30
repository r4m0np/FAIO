FAIO_centaur = {}

local hoofStomp = nil
local doubleEdge = nil

local blademail = nil

function FAIO_centaur.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroCentaur) then return end

	hoofStomp = NPC.GetAbilityByIndex(myHero, 0)
	doubleEdge = NPC.GetAbilityByIndex(myHero, 1)

	blademail = NPC.GetItem(myHero, "item_blade_mail", true)

	local myMana = NPC.GetMana(myHero)

	local cursorCheck
	if Menu.IsEnabled(FAIO_options.optionHeroCentaurForceBlink) then
		if NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionHeroCentaurForceBlinkRange)-1, 0) then
			cursorCheck = true
		else
			cursorCheck = false
		end
	else
		cursorCheck = true
	end

	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end
	
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local stunRange = 315
		if NPC.IsRunning(enemy) then
			if not blink then
				stunRange = 175
			else
				if Ability.SecondsSinceLastUse(blink) > 0.75 then
					stunRange = 175
				end
			end
		end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_centaur.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and cursorCheck then

		FAIO_centaur.system(switch, function (continue, wait)

			continue(FAIO_centaur.comboExecute(myHero, enemy, myMana, stunRange))
			wait()

		end)()
		
	end

	return

end

function FAIO_centaur.comboExecute(myHero, enemy, myMana, stunRange)

	if FAIO_centaur.heroCanCastSpells(myHero, enemy) == true then

		if Menu.GetValue(FAIO_options.optionHeroCentaurJump) == 0 then
			FAIO_centaur.blinkHandler(myHero, enemy, stunRange, 0, false)
		else
			FAIO_centaur.blinkHandler(myHero, enemy, stunRange, 0, true, stunRange)
		end

		if hoofStomp and Ability.IsCastable(hoofStomp, myMana) and NPC.IsEntityInRange(myHero, enemy, stunRange) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then 
			FAIO_centaur.executeSkillOrder(hoofStomp)		
			return
		end

		if blademail and Ability.IsCastable(blademail, myMana) and NPC.IsEntityInRange(myHero, enemy, stunRange) then 
			FAIO_centaur.executeSkillOrder(blademail)
			return
		end

		if doubleEdge and Ability.IsCastable(doubleEdge, myMana) and NPC.IsEntityInRange(myHero, enemy, 150) and not NPC.IsLinkensProtected(enemy) then 
			FAIO_centaur.executeSkillOrder(doubleEdge, enemy)
			return
		end

	end

	FAIO_centaur.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_centaur