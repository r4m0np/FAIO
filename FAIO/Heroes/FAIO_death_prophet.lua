FAIO_death_prophet = {}

local Q = nil
local W = nil
local E = nil

function FAIO_death_prophet.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroDP) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)
	E = NPC.GetAbilityByIndex(myHero, 2)

	local myMana = NPC.GetMana(myHero)
	
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_death_prophet.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
		FAIO_death_prophet.system(switch, function (continue, wait)

			continue(FAIO_death_prophet.comboExecute(myHero, enemy, myMana))
			wait()

		end)()
		
	end

	return

end

function FAIO_death_prophet.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroDPBlink) then
		FAIO_death_prophet.blinkHandler(myHero, enemy, 999, Menu.GetValue(FAIO_options.optionHeroDPBlinkRange), false)
	end

	local carrionRange = 950
		if NPC.IsRunning(enemy) then
			carrionRange = 700
		end
	
	if NPC.IsEntityInRange(myHero, enemy, carrionRange) then
		local carrionPrediction = 0.5 + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
		local predictedPos = Entity.GetAbsOrigin(myHero) + (FAIO_death_prophet.castLinearPrediction(myHero, enemy, carrionPrediction) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.min(Ability.GetCastRange(Q), (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D()))
		if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, predictedPos, false) then
			FAIO_skillHandler.executeSkillOrder(Q, enemy, predictedPos)
			return
		end
	end

	local bestPos = FAIO_death_prophet.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 820, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 410)
	if bestPos ~= nil then
		if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, bestPos, false) then
			FAIO_skillHandler.executeSkillOrder(W, enemy, bestPos)
			return
		end
	end

	local siphonCharges = 0
	local siphonModifier = NPC.GetModifier(myHero, "modifier_death_prophet_spirit_siphon_charge_counter")
		if siphonModifier then
			siphonCharges = Modifier.GetStackCount(siphonModifier)
		end
	
	if siphonCharges > 0 then	
		if FAIO_skillHandler.skillIsCastable(E, Ability.GetCastRange(E), enemy, nil, false) then
			if not NPC.HasModifier(myHero, "modifier_death_prophet_spirit_siphon") then
				FAIO_skillHandler.executeSkillOrder(E, enemy)
				return
			end
		end
	end

	FAIO_death_prophet.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_death_prophet