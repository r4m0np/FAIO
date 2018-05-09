FAIO_vengeful_spirit = {}

local Q = nil
local W = nil

function FAIO_vengeful_spirit.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroVS) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)

	local myMana = NPC.GetMana(myHero)
	
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_vengeful_spirit.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
		FAIO_vengeful_spirit.system(switch, function (continue, wait)

			continue(FAIO_vengeful_spirit.comboExecute(myHero, enemy, myMana))
			wait()

		end)()
		
	end

	return

end

function FAIO_vengeful_spirit.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroVSBlink) then
		FAIO_vengeful_spirit.blinkHandler(myHero, enemy, 999, Menu.GetValue(FAIO_options.optionHeroVSBlinkRange), false)
	end

	if not Menu.IsEnabled(FAIO_options.optionHeroVSStun) then
		
		if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, nil, true) then
			FAIO_skillHandler.executeSkillOrder(Q, enemy, nil)
			return
		end

		local pred = 0.3 + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 2000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
		local predPos = FAIO_utility_functions.castPrediction(myHero, enemy, pred)
		if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, predPos, false) then
			if not NPC.HasModifier(enemy, "modifier_vengefulspirit_wave_of_terror") then
				FAIO_skillHandler.executeSkillOrder(W, enemy, predPos)
				return
			end
		end

	else

		if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, nil, true) then
			FAIO_skillHandler.executeSkillOrder(Q, enemy, nil)
			return
		end

		local check = false
			if Q and Ability.IsCastable(Q, myMana) then
				check = true
			end
			if NPC.IsLinkensProtected(enemy) then
				check = false
			end	

		if not check then
			local pred = 0.3 + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 2000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
			local predPos = FAIO_utility_functions.castPrediction(myHero, enemy, pred)
			if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, predPos, false) then
				if not NPC.HasModifier(enemy, "modifier_vengefulspirit_wave_of_terror") then
					FAIO_skillHandler.executeSkillOrder(W, enemy, predPos)
					return
				end
			end
		end
	end	

	FAIO_vengeful_spirit.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_vengeful_spirit