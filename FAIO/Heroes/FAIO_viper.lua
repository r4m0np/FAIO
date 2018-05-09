FAIO_viper = {}

local Q = nil
local W = nil
local ult = nil

function FAIO_viper.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroViper) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)
	ult = NPC.GetAbility(myHero, "viper_viper_strike")

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroViperHarass) then
		if Menu.IsKeyDown(FAIO_options.optionHeroViperHarassKey) then
			FAIO_viper.ViperAutoHarass(myHero, myMana)
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroViperFarm) then

		FAIO_viper.ViperFarmHelper(myHero, myMana)
	end

	local switch = FAIO_viper.comboExecutionTimer(myHero)

	if enemy and NPC.IsEntityInRange(myHero, enemy, 3000) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
			FAIO_viper.system(switch, function (continue, wait)

				continue(FAIO_viper.comboExecute(myHero, enemy, myMana))
				wait()

			end)()
		
		end

	end

	return

end

function FAIO_viper.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroViperBlink) then
		FAIO_viper.blinkHandler(myHero, enemy, 925, Menu.GetValue(FAIO_options.optionHeroViperBlinkRange), false)
	end

	if not NPC.HasModifier(enemy, "modifier_viper_nethertoxin") then
		local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 570, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 285)
		if bestPos ~= nil then
			if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, bestPos, false) then
				FAIO_skillHandler.executeSkillOrder(W, enemy, bestPos)
				return
			end
		end
	end

	if FAIO_skillHandler.skillIsReady(ult) then
		if Menu.IsEnabled(FAIO_options.optionHeroViperForceUlt) then
			if not NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(ult)) then
				FAIO_viper.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
				return
			else
				if FAIO_skillHandler.skillIsCastable(ult, Ability.GetCastRange(ult), enemy, nil, false) then
					FAIO_skillHandler.executeSkillOrder(ult, enemy)
					return
				end
			end

		else
			if FAIO_skillHandler.skillIsCastable(ult, Ability.GetCastRange(ult), enemy, nil, false) then
				FAIO_skillHandler.executeSkillOrder(ult, enemy)
				return
			end
		end
	end
							
	FAIO_viper.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

function FAIO_viper.ViperAutoHarass(myHero, myMana)

	if not myHero then return end

	if not Q then return end
		if Ability.GetLevel(Q) < 1 then return end

	if FAIO_viper.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO_viper.isHeroChannelling(myHero) == true then return end 
	if FAIO_viper.IsHeroInvisible(myHero) == true then return end

	local harassTarget = nil
		for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, NPC.GetAttackRange(myHero), Enum.TeamType.TEAM_ENEMY)) do
			if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then 
				if Entity.IsAlive(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
        				harassTarget = hero
					break
				end
      			end			
		end

	local mousePos = Input.GetWorldCursorPos()
	if harassTarget ~= nil then
		if not FAIO_lastHitter.lastHitBackswingChecker(myHero) then
			Ability.CastTarget(Q, harassTarget)
			return
		else
			if not NPC.IsPositionInRange(myHero, mousePos, 50, 0) then
				FAIO_viper.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
				return
			end
		end
	else
		if not NPC.IsPositionInRange(myHero, mousePos, 50, 0) then
			FAIO_viper.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
			return
		end
	end

	return

end

function FAIO_viper.ViperFarmHelper(myHero, myMana)

	if not myHero then return end

	local myManaPerc = math.floor((myMana / NPC.GetMaxMana(myHero)) * 100)
		if myManaPerc < Menu.GetValue(FAIO_options.optionHeroViperFarmMana) then return end

	if not W then return end
		if not Ability.IsCastable(W, myMana) then return end

	if FAIO_viper.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO_viper.isHeroChannelling(myHero) == true then return end 
	if FAIO_viper.IsHeroInvisible(myHero) == true then return end
Log.Write("test")
	for _, creeps in ipairs(Entity.GetUnitsInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
		if creeps and Entity.IsNPC(creeps) and not Entity.IsHero(creeps) and Entity.IsAlive(creeps) and not Entity.IsDormant(creeps) and not NPC.IsWaitingToSpawn(creeps) and NPC.GetUnitName(creeps) ~= "npc_dota_neutral_caster" and NPC.IsCreep(creeps) and NPC.GetUnitName(creeps) ~= nil then
			if creeps ~= nil and not NPC.IsRunning(creeps) and NPC.IsAttacking(creeps) and not NPC.IsRanged(creeps) and not NPC.HasModifier(creeps, "modifier_viper_nethertoxin") and #Entity.GetUnitsInRadius(creeps, 290, Enum.TeamType.TEAM_FRIEND) >= Menu.GetValue(FAIO_options.optionHeroViperFarmCount) - 1 then
				local bestPos = FAIO_utility_functions.getBestPosition(NPCs.InRadius(Entity.GetAbsOrigin(creeps), 580, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 290)
				if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, Ability.GetCastRange(W), 0) then

					Ability.CastPosition(W, bestPos)
					break
					return
				end
			end
		end
	end

	return

end

return FAIO_viper