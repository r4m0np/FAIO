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

	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

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
	
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local stunRange = 285
		if NPC.IsRunning(enemy) then
			if not NPC.HasItem(myHero, "item_blink", true) then
				stunRange = 170
			else
				if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_blink", true)) > 0.75 then
					stunRange = 170
				end
			end
		end

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

	if Menu.GetValue(FAIO_options.optionHeroCentaurJump) == 0 then
		FAIO_centaur.blinkHandler(myHero, enemy, stunRange, 0, false)
	else
		FAIO_centaur.blinkHandler(myHero, enemy, stunRange, 0, true, stunRange)
	end

	if FAIO_skillHandler.skillIsCastable(hoofStomp, stunRange, enemy, nil, false) then
		FAIO_skillHandler.executeSkillOrder(hoofStomp)		
		return
	end

	if FAIO_skillHandler.skillIsCastable(blademail, stunRange, enemy, nil, false) then
		FAIO_skillHandler.executeSkillOrder(blademail)
		return
	end

	if FAIO_skillHandler.skillIsCastable(doubleEdge, 150, enemy, nil, true) then
		FAIO_skillHandler.executeSkillOrder(doubleEdge, enemy)
		return
	end

	FAIO_centaur.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_centaur