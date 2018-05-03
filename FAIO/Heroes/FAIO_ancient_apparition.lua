FAIO_ancient_apparition = {}

local Q = nil
local W = nil

function FAIO_ancient_apparition.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroAA) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)

	local myMana = NPC.GetMana(myHero)
	
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_ancient_apparition.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
		FAIO_ancient_apparition.system(switch, function (continue, wait)

			continue(FAIO_ancient_apparition.comboExecute(myHero, enemy, myMana))
			wait()

		end)()
		
	end

	return

end

function FAIO_ancient_apparition.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroAABlink) then
		FAIO_ancient_apparition.blinkHandler(myHero, enemy, 999, Menu.GetValue(FAIO_options.optionHeroAABlinkRange), false)
	end
		
	if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, nil, false) then
		FAIO_skillHandler.executeSkillOrder(Q, enemy, nil)
		return
	end

	local pred = 0.87 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
	local predPos = FAIO_ancient_apparition.castPrediction(myHero, enemy, pred)
	if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, predPos, false) then
		if not NPC.HasModifier(enemy, "modifier_ice_vortex") then
			FAIO_skillHandler.executeSkillOrder(W, enemy, predPos)
			return
		end
	end

	FAIO_ancient_apparition.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_ancient_apparition