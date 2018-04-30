FAIO_lastHitter = {}

FAIO_lastHitter.lastHitterDelay = 0
FAIO_lastHitter.lastHitterKillableImage = nil
FAIO_lastHitter.lastHitterOrbSkill = nil
FAIO_lastHitter.lastHitterOrbSkillEnemy = nil

FAIO_lastHitter.lastHitCreepHPPrediction = {}
FAIO_lastHitter.lastHitCreepHPPredictionTime = {}

function FAIO_lastHitter.OnEntityDestroy(ent)

	if FAIO_lastHitter.lastHitCreepHPPrediction[ent] ~= nil then
		FAIO_lastHitter.lastHitCreepHPPrediction[ent] = nil
	end

	if FAIO_lastHitter.lastHitCreepHPPredictionTime[ent] ~= nil then
		FAIO_lastHitter.lastHitCreepHPPredictionTime[ent] = nil
	end

end

function FAIO_lastHitter.OnUnitAnimation(animation)

	if Entity.IsNPC(animation.unit) and not NPC.IsRanged(animation.unit) then
		if NPC.IsEntityInRange(Heroes.GetLocal(), animation.unit, 1000) then
			if NPC.IsLaneCreep(animation.unit) then
				if FAIO_lastHitter.lastHitterGetTarget(Heroes.GetLocal(), animation.unit) ~= nil then
					local targetCreep = FAIO_lastHitter.lastHitterGetTarget(Heroes.GetLocal(), animation.unit)
					local creepHP = math.floor(Entity.GetHealth(targetCreep) + NPC.GetHealthRegen(targetCreep))
					local creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(animation.unit, targetCreep) * ((NPC.GetMinDamage(animation.unit) + NPC.GetBonusDamage(animation.unit)) * NPC.GetArmorDamageMultiplier(targetCreep)))
						if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
							creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(animation.unit, targetCreep) * (((NPC.GetTrueMaximumDamage(animation.unit) + NPC.GetTrueDamage(animation.unit)) / 2) * NPC.GetArmorDamageMultiplier(targetCreep)))
						end
					local hitTime = FAIO_lastHitter.utilityRoundNumber((GameRules.GetGameTime() + animation.castpoint - 0.035), 3)
					local sourceIndex = Entity.GetIndex(animation.unit)
					if FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] == nil then
						FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] = {}
						table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) > 0.45 then
							if creepHP > 2 * creepDMG then
								table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(animation.unit), creepDMG, sourceIndex })
							end
						end
					else
						local inserted = false
						for _, info in ipairs(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep]) do
							if info and info[3] == sourceIndex and math.abs(hitTime - info[1]) < 0.25 then
								inserted = true
							end
						end
						if not inserted then
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
							if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) > 0.45 then
								if creepHP > 2 * creepDMG then
									table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(animation.unit), creepDMG, sourceIndex })
								end
							end
						else
							if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) > 0.45 then
								if creepHP > 2 * creepDMG then
									table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(animation.unit), creepDMG, sourceIndex })
								end
							end
						end
					end
					local removeInstance = 0
					local removeTarget = nil
					for target, table in pairs(FAIO_lastHitter.lastHitCreepHPPrediction) do
						if table then
							if target ~= targetCreep then
								for i, info in ipairs(table) do
									if info and info[3] == sourceIndex and info[1] > GameRules.GetGameTime() and math.abs(hitTime - info[1]) > 0.1 then
										removeInstance = i
										removeTarget = target
									end
								end
							end
						end
					end
					if removeInstance > 0 and removeTarget ~= nil then
						table.remove(FAIO_lastHitter.lastHitCreepHPPrediction[removeTarget], removeInstance)
					end
				end
			else
				if Entity.IsHero(animation.unit) then
					if FAIO_lastHitter.lastHitterGetTarget(Heroes.GetLocal(), animation.unit) ~= nil then
						local targetCreep = FAIO_lastHitter.lastHitterGetTarget(Heroes.GetLocal(), animation.unit)
						local creepHP = math.floor(Entity.GetHealth(targetCreep) + NPC.GetHealthRegen(targetCreep))
						local creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(animation.unit, targetCreep) * ((NPC.GetMinDamage(animation.unit) + NPC.GetBonusDamage(animation.unit)) * NPC.GetArmorDamageMultiplier(targetCreep)))
							if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
								creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(animation.unit, targetCreep) * (((NPC.GetTrueMaximumDamage(animation.unit) + NPC.GetTrueDamage(animation.unit)) / 2) * NPC.GetArmorDamageMultiplier(targetCreep)))
							end
						local hitTime = FAIO_lastHitter.utilityRoundNumber((GameRules.GetGameTime() + animation.castpoint - 0.035), 3)
						local sourceIndex = Entity.GetIndex(animation.unit)
						if FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] == nil then
							FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] = {}
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						else
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						end
					end
				end
			end
		end
	end

end

function FAIO_lastHitter.OnProjectile(projectile)

	if projectile.source and Entity.IsNPC(projectile.source) and projectile.isAttack then
		if NPC.IsEntityInRange(Heroes.GetLocal(), projectile.source, 1250) then
			if NPC.IsLaneCreep(projectile.source) or NPC.IsTower(projectile.source) then
				if projectile.target and Entity.IsNPC(projectile.target) and (NPC.IsLaneCreep(projectile.target) or NPC.IsTower(projectile.target)) then
					local projectileSpeed = projectile.moveSpeed
					local distance = math.max((Entity.GetAbsOrigin(projectile.source) - Entity.GetAbsOrigin(projectile.target)):Length2D() - NPC.GetHullRadius(projectile.target) - NPC.GetHullRadius(projectile.source), 1)
					local travelTime = distance / projectileSpeed - 0.035
					local targetCreep = projectile.target
					local creepHP = Entity.GetHealth(targetCreep) + NPC.GetHealthRegen(targetCreep)
					local creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(projectile.source, targetCreep) * ((NPC.GetMinDamage(projectile.source) + NPC.GetBonusDamage(projectile.source)) * NPC.GetArmorDamageMultiplier(targetCreep)))
						if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
							creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(projectile.source, targetCreep) * (((NPC.GetTrueMaximumDamage(projectile.source) + NPC.GetTrueDamage(projectile.source)) / 2) * NPC.GetArmorDamageMultiplier(targetCreep)))
						end
						if Entity.GetClassName(projectile.source) == "C_DOTA_BaseNPC_Creep_Siege" and Entity.GetClassName(projectile.target) == "C_DOTA_BaseNPC_Creep_Siege" then
							creepDMG = math.ceil((NPC.GetMinDamage(projectile.source) + NPC.GetBonusDamage(projectile.source)) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
								creepDMG = math.ceil(((NPC.GetTrueMaximumDamage(projectile.source) + NPC.GetTrueDamage(projectile.source)) / 2) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							end
						elseif Entity.GetClassName(projectile.source) == "C_DOTA_BaseNPC_Tower" and Entity.GetClassName(projectile.target) == "C_DOTA_BaseNPC_Creep_Siege" then
							creepDMG = math.ceil((NPC.GetMinDamage(projectile.source) + NPC.GetBonusDamage(projectile.source)) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
								creepDMG = math.ceil(((NPC.GetTrueMaximumDamage(projectile.source) + NPC.GetTrueDamage(projectile.source)) / 2) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							end
						elseif Entity.GetClassName(projectile.source) == "C_DOTA_BaseNPC_Creep_Siege" and Entity.GetClassName(projectile.target) == "C_DOTA_BaseNPC_Tower" then
							creepDMG = math.ceil((NPC.GetMinDamage(projectile.source) + NPC.GetBonusDamage(projectile.source)) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
								creepDMG = math.ceil(((NPC.GetTrueMaximumDamage(projectile.source) + NPC.GetTrueDamage(projectile.source)) / 2) * 2.5 * NPC.GetArmorDamageMultiplier(targetCreep))
							end
						end
					local hitTime = FAIO_lastHitter.utilityRoundNumber((GameRules.GetGameTime() + travelTime - 0.035), 3)
					local sourceIndex = Entity.GetIndex(projectile.source)
					if FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] == nil then
						FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] = {}
						table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and travelTime < FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) * 1.2 then
							if creepHP > 2 * creepDMG then
								table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(projectile.source), creepDMG, sourceIndex })
							end
						end
					else
						local inserted = false
						local insertedKey = 0
						for i, info in ipairs(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep]) do
							if info and info[3] == sourceIndex then
								if info[1] > GameRules.GetGameTime() then
									if math.abs(hitTime - info[1]) < 0.25 then
										inserted = true
										insertedKey = i
									end
								end
							end
						end
						if not inserted then
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
							if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and travelTime < FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) * 1.2 then
								if creepHP > 2 * creepDMG then
									table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(projectile.source), creepDMG, sourceIndex })
								end
							end
						else
							table.remove(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], insertedKey)
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
							if FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) ~= nil and travelTime < FAIO_lastHitter.lastHitterTimingOffsetter(Heroes.GetLocal(), targetCreep) * 1.2 then
								if creepHP > 2 * creepDMG then
									table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime + NPC.GetAttackTime(projectile.source), creepDMG, sourceIndex })
								end
							end
						end
					end
					local removeInstance = 0
					local removeTarget = nil
					for target, table in pairs(FAIO_lastHitter.lastHitCreepHPPrediction) do
						if table then
							if target ~= targetCreep then
								for i, info in ipairs(table) do
									if info and info[3] == sourceIndex then
										if info[1] > GameRules.GetGameTime() and math.abs(hitTime - info[1]) > 0.1 then
											removeInstance = i
											removeTarget = target
										end
									end
								end
							end
						end
					end
					if removeInstance > 0 and removeTarget ~= nil then
						table.remove(FAIO_lastHitter.lastHitCreepHPPrediction[removeTarget], removeInstance)
					end
				end
			else
				if Entity.IsHero(projectile.source) then
					if projectile.target and Entity.IsNPC(projectile.target) and (NPC.IsLaneCreep(projectile.target) or NPC.IsTower(projectile.target)) then
						local projectileSpeed = projectile.moveSpeed
						local distance = math.max((Entity.GetAbsOrigin(projectile.source) - Entity.GetAbsOrigin(projectile.target)):Length2D() - NPC.GetHullRadius(projectile.target) - NPC.GetHullRadius(projectile.source), 1)
						local travelTime = distance / projectileSpeed - 0.035
						local targetCreep = projectile.target
						local creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(projectile.source, targetCreep) * ((NPC.GetMinDamage(projectile.source) + NPC.GetBonusDamage(projectile.source)) * NPC.GetArmorDamageMultiplier(targetCreep)))
							if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
								creepDMG = math.ceil(NPC.GetDamageMultiplierVersus(projectile.source, targetCreep) * (((NPC.GetTrueMaximumDamage(projectile.source) + NPC.GetTrueDamage(projectile.source)) / 2) * NPC.GetArmorDamageMultiplier(targetCreep)))
							end
						local hitTime = FAIO_lastHitter.utilityRoundNumber((GameRules.GetGameTime() + travelTime - 0.035), 3)
						local sourceIndex = Entity.GetIndex(projectile.source)
						if FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] == nil then
							FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep] = {}
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						else
							table.insert(FAIO_lastHitter.lastHitCreepHPPrediction[targetCreep], { hitTime, math.ceil(creepDMG), sourceIndex })
						end
					end
				end	
			end
		end
	end

end

function FAIO_lastHitter.lastHitter(myHero)
	
	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionLastHitEnable) then return end

	local increasedAS = NPC.GetIncreasedAttackSpeed(myHero)

	local attackPoint = 0
	for i, v in pairs(FAIO_data.attackPointTable) do
		if i == NPC.GetUnitName(myHero) then
			attackPoint = v[1] / (1 + (increasedAS/100))
			break
		end
	end

	FAIO_lastHitter.lastHitterPredictDieTime(myHero)
	FAIO_lastHitter.lastHitterDieTimeCleaner(myHero, attackPoint)
	FAIO_lastHitter.lastHitterGetOrbSkill(myHero)
	FAIO_lastHitter.lastHitterGetOrbSkillHarass(myHero)
	FAIO_lastHitter.lastHitterExecuteLastHit(myHero, attackPoint)
			
end

function FAIO_lastHitter.lastHitterExecuteLastHit(myHero, attackPoint)

	if not myHero then return end

	local curTime = GameRules.GetGameTime()

	if Menu.IsEnabled(FAIO_options.optionLastHitDrawRange) and NPC.IsRanged(myHero) then
		if Menu.IsKeyDown(FAIO_options.optionLastHitKey) then
			Engine.ExecuteCommand("dota_range_display " .. NPC.GetAttackRange(myHero))
		else
			Engine.ExecuteCommand("dota_range_display 0")
		end
	end

	local lastHitTarget = nil
	local lastHitTime = 0
		for i, v in pairs(FAIO_lastHitter.lastHitCreepHPPredictionTime) do
			if i and Entity.IsNPC(i) and Entity.IsAlive(i) then
				if (not Entity.IsSameTeam(myHero, i) and (not NPC.IsTower(i) or (NPC.IsTower(i) and Entity.GetHealth(i) < 159))) or (Entity.IsSameTeam(myHero, i) and ((not NPC.IsTower(i) and Entity.GetHealth(i)/Entity.GetMaxHealth(i) < 0.5) or (NPC.IsTower(i) and Entity.GetHealth(i) < 159))) then
					if Menu.GetValue(FAIO_options.optionLastHitStyle) == 0 then
						if FAIO_lastHitter.utilityGetTableLength(FAIO_lastHitter.lastHitCreepHPPredictionTime) <= 1 then
							lastHitTarget = i
							lastHitTime = v
							break
						else
							local tempTable = {}

							for k, l in pairs(FAIO_lastHitter.lastHitCreepHPPredictionTime) do
								table.insert(tempTable, { l, k })
							end

							if #tempTable > 1 then
								if Entity.IsNPC(tempTable[1][2]) and Entity.IsNPC(tempTable[2][2]) then
									if math.abs(tempTable[2][1] - tempTable[1][1]) < NPC.GetAttackTime(myHero) + 0.1 then
										if not Entity.IsSameTeam(myHero, tempTable[1][2]) then
											lastHitTarget = tempTable[1][2]
											lastHitTime = tempTable[1][1]
										else
											if not Entity.IsSameTeam(myHero, tempTable[2][2]) then
												lastHitTarget = tempTable[2][2]
												lastHitTime = tempTable[2][1]
											else
												lastHitTarget = tempTable[1][2]
												lastHitTime = tempTable[1][1]
											end
										end
									else
										lastHitTarget = tempTable[1][2]
										lastHitTime = tempTable[1][1]
									end
								end
							end
						end
					elseif Menu.GetValue(FAIO_options.optionLastHitStyle) == 1 then
						if not Entity.IsSameTeam(myHero, i) then
							lastHitTarget = i
							lastHitTime = v
							break
						end
					elseif Menu.GetValue(FAIO_options.optionLastHitStyle) == 2 then
						if Entity.IsSameTeam(myHero, i) then
							lastHitTarget = i
							lastHitTime = v
							break
						end
					end
				end
			end
		end


	if Menu.IsKeyDown(FAIO_options.optionLastHitKey) then
		if FAIO_lastHitter.myUnitName == "npc_dota_hero_invoker" then
			FAIO_lastHitter.invokerProcessInstances(myHero, Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET)
		end

		if lastHitTarget == nil then 

			if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeEnemy) then
				local searchRange = NPC.GetAttackRange(myHero) + 150
					if FAIO_lastHitter.lastHitterOrbSkillEnemy ~= nil and Ability.GetName(FAIO_lastHitter.lastHitterOrbSkillEnemy) == "skywrath_mage_arcane_bolt" then
						searchRange = Ability.GetCastRange(FAIO_lastHitter.lastHitterOrbSkillEnemy)
					end
				if #Entity.GetHeroesInRadius(myHero, searchRange, Enum.TeamType.TEAM_ENEMY) < 1 then
					if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
						if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
							FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
							return
						else
							if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
								Player.HoldPosition(Players.GetLocal(), myHero, false)
								return
							end
						end
					else
						if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
							Player.HoldPosition(Players.GetLocal(), myHero, false)
							return
						end
					end
				else
					if not FAIO_lastHitter.lastHitBackswingChecker(myHero) then
						for _, v in ipairs(Entity.GetHeroesInRadius(myHero, searchRange, Enum.TeamType.TEAM_ENEMY)) do
							if v then
								local target = FAIO_lastHitter.targetChecker(v)
								if target then
									if not FAIO_lastHitter.lastHitRoughCalcForHit(myHero) then
										if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeEnemySave) then
											if FAIO_lastHitter.lastHitCheckCreepAggro(myHero) == false then
												if FAIO_lastHitter.lastHitterOrbSkillEnemy ~= nil and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
													Ability.CastTarget(FAIO_lastHitter.lastHitterOrbSkillEnemy, target)
													return
												else
													FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", v, nil)
													return
												end
											else
												if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
													if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
														FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
														return
													else
														if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
															Player.HoldPosition(Players.GetLocal(), myHero, false)
															return
														end
													end
												else
													if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
														Player.HoldPosition(Players.GetLocal(), myHero, false)
														return
													end
												end
											end	
										else
											if FAIO_lastHitter.lastHitterOrbSkillEnemy ~= nil and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
												Ability.CastTarget(FAIO_lastHitter.lastHitterOrbSkillEnemy, target)
												return
											else
												FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", v, nil)
												return
											end
										end
									else
										if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
											if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
												FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
												return
											else
												if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
													Player.HoldPosition(Players.GetLocal(), myHero, false)
													return
												end
											end
										else
											if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
												Player.HoldPosition(Players.GetLocal(), myHero, false)
												return
											end
										end
									end
								else
									if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
										if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
											FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
											return
										else
											if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
												Player.HoldPosition(Players.GetLocal(), myHero, false)
												return
											end
										end
									else
										if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
											Player.HoldPosition(Players.GetLocal(), myHero, false)
											return
										end
									end
								end
							else
								if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
									if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
										FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
										return
									else
										if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
											Player.HoldPosition(Players.GetLocal(), myHero, false)
											return
										end
									end
								else
									if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
										Player.HoldPosition(Players.GetLocal(), myHero, false)
										return
									end
								end
							end
						end
					else
						if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
							if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
								FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
								return
							else
								if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
									Player.HoldPosition(Players.GetLocal(), myHero, false)
									return
								end
							end
						else
							if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
								Player.HoldPosition(Players.GetLocal(), myHero, false)
								return
							end
						end
					end
				end
			else
				if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
					if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
						FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
						return
					else
						if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
							Player.HoldPosition(Players.GetLocal(), myHero, false)
							return
						end
					end
				else
					if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
						Player.HoldPosition(Players.GetLocal(), myHero, false)
						return
					end
				end
			end
		else
			local target = lastHitTarget
			local hitTime = FAIO_lastHitter.utilityRoundNumber((lastHitTime + (Menu.GetValue(FAIO_options.optionLastHitOffset) / 20) - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)), 3)
			if Entity.IsNPC(target) and Entity.IsAlive(target) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				if curTime > hitTime - FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) then
					if not FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) then
						if FAIO_lastHitter.lastHitterOrbSkill ~= nil and not Entity.IsSameTeam(myHero, target) and not NPC.IsTower(target) then
							Ability.CastTarget(FAIO_lastHitter.lastHitterOrbSkill, target)
							return
						else
							Player.AttackTarget(Players.GetLocal(), myHero, target, false)
							return
						end
					end	
				else
					if FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint) == true then
						if (GameRules.GetGameTime() - (os.clock() - FAIO_lastHitter.AttackAnimationCreate)) + FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) < hitTime then
							Player.HoldPosition(Players.GetLocal(), myHero, false)
							return
						end
					else
						if Menu.IsEnabled(FAIO_options.optionLastHitAutoModeMove) then
							if hitTime - curTime - FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) > 0.15 then
								if not NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), Menu.GetValue(FAIO_options.optionLastHitAutoModeMoveRange), 0) then
									FAIO_lastHitter.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
									return
								end
							end
						end
					end
				end	
			end
		end
	end
	
	return

end

function FAIO_lastHitter.lastHitterGetOrbSkill(myHero)

	if not myHero then return end

	local orbSkill = nil
	if Menu.IsEnabled(FAIO_options.optionLastHitOrb) then
		local orbSkillTable = {
			npc_dota_hero_clinkz = "clinkz_searing_arrows",
			npc_dota_hero_obsidian_destroyer = "obsidian_destroyer_arcane_orb",
			npc_dota_hero_silencer = "silencer_glaives_of_wisdom"
				}

		if orbSkillTable[FAIO_lastHitter.myUnitName] ~= nil then
			orbSkill = NPC.GetAbility(myHero, orbSkillTable[FAIO_lastHitter.myUnitName])
		end

		if orbSkill ~= nil then
			if Ability.GetLevel(orbSkill) < 1 then
				orbSkill = nil
			elseif (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) * 100 < Menu.GetValue(FAIO_options.optionLastHitOrbMana) then
				orbSkill = nil
			elseif FAIO_lastHitter.heroCanCastSpells(myHero, target) == false then
				orbSkill = nil
			elseif not Ability.IsReady(orbSkill) then
				orbSkill = nil
			elseif not Ability.IsCastable(orbSkill, NPC.GetMana(myHero)) then
				orbSkill = nil
			end
		end
	end

	if orbSkill then
		FAIO_lastHitter.lastHitterOrbSkill = orbSkill
	else
		FAIO_lastHitter.lastHitterOrbSkill = nil
	end

	return	
end

function FAIO_lastHitter.lastHitterGetOrbSkillHarass(myHero)

	if not myHero then return end

	local orbSkill = nil
	if Menu.IsEnabled(FAIO_options.optionLastHitOrb) then
		local orbSkillTable = {
			npc_dota_hero_clinkz = "clinkz_searing_arrows",
			npc_dota_hero_drow_ranger = "drow_ranger_frost_arrows",
			npc_dota_hero_enchantress = "enchantress_impetus",
			npc_dota_hero_huskar = "huskar_burning_spear",
			npc_dota_hero_obsidian_destroyer = "obsidian_destroyer_arcane_orb",
			npc_dota_hero_silencer = "silencer_glaives_of_wisdom",
			npc_dota_hero_viper = "viper_poison_attack",
			npc_dota_hero_skywrath_mage = "skywrath_mage_arcane_bolt"
				}

		if orbSkillTable[FAIO_lastHitter.myUnitName] ~= nil then
			orbSkill = NPC.GetAbility(myHero, orbSkillTable[FAIO_lastHitter.myUnitName])
		end

		if orbSkill ~= nil then
			if Ability.GetLevel(orbSkill) < 1 then
				orbSkill = nil
			elseif (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) * 100 < Menu.GetValue(FAIO_options.optionLastHitOrbMana) then
				orbSkill = nil
			elseif FAIO_lastHitter.heroCanCastSpells(myHero, target) == false then
				orbSkill = nil
			elseif not Ability.IsReady(orbSkill) then
				orbSkill = nil
			elseif not Ability.IsCastable(orbSkill, NPC.GetMana(myHero)) then
				orbSkill = nil
			end
		end
	end

	if orbSkill then
		FAIO_lastHitter.lastHitterOrbSkillEnemy = orbSkill
	else
		FAIO_lastHitter.lastHitterOrbSkillEnemy = nil
	end

	return	
end

function FAIO_lastHitter.lastHitCheckCreepAggro(myHero)

	if not myHero then return false end

	if FAIO_lastHitter.lastHitterOrbSkillEnemy ~= nil then return false end
	
	local creepsAround = Entity.GetUnitsInRadius(myHero, 500, Enum.TeamType.TEAM_ENEMY)
		if #creepsAround < 1 then return false end

	for _, v in ipairs(creepsAround) do
		if v and Entity.IsNPC(v) and Entity.IsAlive(v) then
			if NPC.IsLaneCreep(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" then
				if v ~= nil then
					return true
				end
			end
		end
	end

	return false

end

function FAIO_lastHitter.lastHitRoughCalcForHit(myHero)

	if not myHero then return false end

	local attackTime = NPC.GetAttackTime(myHero)

	if next(FAIO_lastHitter.lastHitCreepHPPrediction) == nil then return false end

	for i, v in pairs(FAIO_lastHitter.lastHitCreepHPPrediction) do
		if i and Entity.IsNPC(i) and Entity.IsAlive(i) then
			local creepHP = Entity.GetHealth(i)
			local attackerCount = FAIO_lastHitter.lastHitGetAttackerCount(myHero, i)
			if creepHP < math.ceil(2 * attackTime) * attackerCount * 18 then
				return true
			end
		end
	end

	return false

end

function FAIO_lastHitter.lastHitGetAttackerCount(myHero, target)

	if not myHero then return 0 end
	if not target then return 0 end

	local count = 0
	for i, v in pairs(FAIO_lastHitter.lastHitCreepHPPrediction) do
		if i and Entity.IsNPC(i) and Entity.IsAlive(i) then
			if i == target then
				local temp = {}
				for k, l in ipairs(v) do
					if not FAIO_lastHitter.utilityIsInTable(temp, l[3]) and GameRules.GetGameTime() > l[1] then
						table.insert(temp, l[3])
					end
				end
				count = #temp or 0
			end
		end
	end
				
	return count

end

function FAIO_lastHitter.lastHitBackswingChecker(myHero)

	if not myHero then return false end

	local increasedAS = NPC.GetIncreasedAttackSpeed(myHero)
	local attackTime = NPC.GetAttackTime(myHero)
	local attackPoint
	local attackBackSwing
	for i, v in pairs(FAIO_data.attackPointTable) do
		if i == NPC.GetUnitName(myHero) then
			attackPoint = v[1] / (1 + (increasedAS/100))
			attackBackSwing = v[2] / (1 + (increasedAS/100))
			break
		end
	end

	local idleTime = attackTime - attackPoint - attackBackSwing

	if NPC.IsRanged(myHero) then
		if FAIO_lastHitter.AttackProjectileCreate > 0 then
			if os.clock() > FAIO_lastHitter.AttackAnimationCreate and os.clock() < FAIO_lastHitter.AttackProjectileCreate + attackBackSwing + idleTime then
				return true
			else
				return false
			end
		end
	else
		if FAIO_lastHitter.AttackParticleCreate > 0 then
			if NPC.HasItem(myHero, "item_echo_sabre", true) then
				if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_echo_sabre", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_echo_sabre", true)) < (attackPoint / 1.49) + 0.15 then
					return false
				else
					if os.clock() > FAIO_lastHitter.AttackAnimationCreate and os.clock() < FAIO_lastHitter.AttackParticleCreate + attackBackSwing + idleTime then
						return true
					else
						return false
					end
				end
			else
				if os.clock() > FAIO_lastHitter.AttackAnimationCreate and os.clock() < FAIO_lastHitter.AttackParticleCreate + attackBackSwing + idleTime then
					return true
				else
					return false
				end
			end
		end
	end

	return false

end

function FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target)

	if not myHero then return 0 end
	if not target then return 0 end
	if target and not Entity.IsNPC(target) then return 0 end

	local increasedAS = NPC.GetIncreasedAttackSpeed(myHero)

	local attackPoint = 0
	local projectileSpeed = 0
	for i, v in pairs(FAIO_data.attackPointTable) do
		if i == NPC.GetUnitName(myHero) then
			if NPC.IsRanged(myHero) then
				attackPoint = v[1] / (1 + (increasedAS/100))
				projectileSpeed = v[3]
				break
			else
				attackPoint = v[1] / (1 + (increasedAS/100))
				projectileSpeed = 0
				break
			end
		end
	end

	local faceTime = math.max(NPC.GetTimeToFace(myHero, target) - ((0.033 * math.pi / NPC.GetTurnRate(myHero) / 180) * 11.5), 0)

	local myAttackRange = NPC.GetAttackRange(myHero)
	local myMovementSpeed = NPC.GetMoveSpeed(myHero)
	local distanceToTarget = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(target)):Length2D()
	local projectileDistance = distanceToTarget - math.max(distanceToTarget - (myAttackRange + NPC.GetHullRadius(myHero) + NPC.GetHullRadius(target)), 0)
	local moveDistance = distanceToTarget - projectileDistance

	local projectileOffset = 0
		if projectileSpeed > 0 then
			projectileOffset = (projectileDistance - 24) / projectileSpeed
		end

	local moveTime = 0
		if moveDistance > 0 then
			moveTime = moveDistance / myMovementSpeed
		end

	local overallOffset = FAIO_lastHitter.utilityRoundNumber(attackPoint + projectileOffset + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + faceTime + moveTime, 3)

	return overallOffset or 0

end

function FAIO_lastHitter.myCreepDamageAdjuster(myHero, target)

	if not myHero then return 0 end

	local quelling = NPC.GetItem(myHero, "item_quelling_blade", true)

	local minCreepDamage = NPC.GetMinDamage(myHero)
	local bonusCreepDamage = 0
		if quelling then
			if NPC.IsRanged(myHero) then
				bonusCreepDamage = 7
			else
				bonusCreepDamage = 24
			end
		end

	local orbSkill = FAIO_lastHitter.lastHitterOrbSkill
	if orbSkill ~= nil then
		if not Entity.IsSameTeam(myHero, target) and not NPC.IsTower(target) then
			local orbSkillName = Ability.GetName(orbSkill)
			if orbSkillName == "clinkz_searing_arrows" then
				minCreepDamage = minCreepDamage + (20 + 10 * Ability.GetLevel(orbSkill))
				if NPC.HasAbility(myHero, "special_bonus_unique_clinkz_1") then
					if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_clinkz_1")) > 0 then
						minCreepDamage = minCreepDamage + 30
					end
				end
			elseif orbSkillName == "obsidian_destroyer_arcane_orb" then
				local bonusDMG = (0.05 + (0.01 * Ability.GetLevel(orbSkill))) * NPC.GetMana(myHero)
				local bonusPureDMG = bonusDMG * (1 + (1 - NPC.GetDamageMultiplierVersus(myHero, target)) + (1 - NPC.GetArmorDamageMultiplier(target)))
				minCreepDamage = minCreepDamage + bonusPureDMG
			elseif orbSkillName == "silencer_glaives_of_wisdom" then
				local myInt = Hero.GetIntellectTotal(myHero)
				local bonusDMG = 0.15 * Ability.GetLevel(orbSkill) * myInt
					if NPC.HasAbility(myHero, "special_bonus_unique_silencer_3") then
						if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_silencer_3")) > 0 then
							bonusDMG = (0.2 + 0.15 * Ability.GetLevel(orbSkill)) * myInt
						end
					end
				local bonusPureDMG = bonusDMG * (1 + (1 - NPC.GetDamageMultiplierVersus(myHero, target)) + (1 - NPC.GetArmorDamageMultiplier(target)))
				minCreepDamage = minCreepDamage + bonusPureDMG
			end
		end
	end

	if NPC.HasModifier(myHero, "modifier_storm_spirit_overload") then
		local overload = NPC.GetAbility(myHero, "storm_spirit_overload")
		local bonus = 0
		if overload and Ability.GetLevel(overload) > 0 then
			bonus = Ability.GetDamage(overload)
		end
		local bonusTrue = (1 - NPC.GetMagicalArmorValue(target)) * bonus + bonus * (Hero.GetIntellectTotal(myHero) / 14 / 100)
		minCreepDamage = minCreepDamage + bonusTrue
	end

	local overallCreepDamage = minCreepDamage + bonusCreepDamage

	return math.floor(overallCreepDamage)

end

function FAIO_lastHitter.lastHitInAttackAnimation(myHero, attackPoint)

	if not myHero then return false end
	if not attackPoint then return false end
		if attackPoint == 0 then return false end

	if os.clock() >= FAIO_lastHitter.AttackAnimationCreate - 0.035 then
		if os.clock() <= (FAIO_lastHitter.AttackAnimationCreate + attackPoint + 0.075) then
			return true
		end
	end

	return false

end

function FAIO_lastHitter.lastHitterDrawing(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionLastHitDrawCreepEnable) then return end
	
	if next(FAIO_lastHitter.lastHitCreepHPPredictionTime) == nil then return end

	if Menu.IsEnabled(FAIO_options.optionLastHitDrawCreepTimer) then
		local imageHandle = FAIO_lastHitter.lastHitterKillableImage
			if imageHandle == nil then
				imageHandle = Renderer.LoadImage("resource/flash3/images/heroes/selection/fav_heart.png")
				FAIO_lastHitter.lastHitterKillableImage = imageHandle
			end
		for i, v in pairs(FAIO_lastHitter.lastHitCreepHPPredictionTime) do
			local target = i
			local dieTime = v
			if target and Entity.IsNPC(target) then
				local pos = Entity.GetAbsOrigin(target)
				local posY = NPC.GetHealthBarOffset(target)
					pos:SetZ(pos:GetZ() + posY)	
				local x, y, visible = Renderer.WorldToScreen(pos)
				if Menu.GetValue(FAIO_options.optionLastHitDrawStyle) < 1 then
					if visible then
						if dieTime - GameRules.GetGameTime() > FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) then
							Renderer.SetDrawColor(255,215,0,200)
							Renderer.DrawImage(imageHandle, x-20, y-49, 40, 40)
						else
							Renderer.SetDrawColor(50,205,50,200)
							Renderer.DrawImage(imageHandle, x-20, y-49, 40, 40)
						end
					end
				else
					if not Entity.IsSameTeam(myHero, i) then
						if visible then
							if dieTime - GameRules.GetGameTime() > FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) then
								Renderer.SetDrawColor(255,215,0,200)
								Renderer.DrawImage(imageHandle, x-20, y-49, 40, 40)
							else
								Renderer.SetDrawColor(50,205,50,200)
								Renderer.DrawImage(imageHandle, x-20, y-49, 40, 40)
							end
						end
					end
				end
			end
		end
	end

end

function FAIO_lastHitter.lastHitterPredictDieTime(myHero)

	if not myHero then return end

	if next(FAIO_lastHitter.lastHitCreepHPPredictionTime) ~= nil then
		table.sort(FAIO_lastHitter.lastHitCreepHPPredictionTime, function(a, b)
       			return a < b
    		end)
	end

	for target, attackTable in pairs(FAIO_lastHitter.lastHitCreepHPPrediction) do
		if attackTable then
			if target and Entity.IsNPC(target) and Entity.IsAlive(target) then
				local creepHP = math.ceil(Entity.GetHealth(target) + NPC.GetHealthRegen(target))
				local myAttackDMG = math.floor(math.floor(NPC.GetDamageMultiplierVersus(myHero, target) * ((FAIO_lastHitter.myCreepDamageAdjuster(myHero, target) + NPC.GetBonusDamage(myHero)) * NPC.GetArmorDamageMultiplier(target))) * 0.975)
					if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
						local avgDmgGap = math.floor((NPC.GetTrueMaximumDamage(myHero) - NPC.GetTrueDamage(myHero)) / 2)
						myAttackDMG = math.floor(math.floor(NPC.GetDamageMultiplierVersus(myHero, target) * ((FAIO_lastHitter.myCreepDamageAdjuster(myHero, target) + NPC.GetBonusDamage(myHero) + avgDmgGap) * NPC.GetArmorDamageMultiplier(target))) * 0.975)
					end
				table.sort(attackTable, function(a, b)
       					return a[1] < b[1]
    				end)

				for i, info in ipairs(attackTable) do
					if info then
						local hitTime = info[1]
						local hitDamage = info[2]
						if hitTime > GameRules.GetGameTime() and math.abs(hitTime - GameRules.GetGameTime()) > 0.15 then
							creepHP = creepHP - hitDamage
							if FAIO_lastHitter.lastHitCreepHPPredictionTime[target] == nil then
								local offSet = FAIO_lastHitter.lastHitGetAttackerCount(myHero, target)
									if Menu.IsEnabled(FAIO_options.optionLastHitPredict) then
										offSet = math.ceil(offSet / 2)
									end
								if creepHP > myAttackDMG and creepHP - myAttackDMG <= math.ceil(math.ceil(0.025 * myAttackDMG) + offSet) then
									if hitTime > GameRules.GetGameTime() and hitTime - GameRules.GetGameTime() < FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) * 1.25 then
										FAIO_lastHitter.lastHitCreepHPPredictionTime[target] = hitTime + 0.075
										break
										return
									end
								elseif creepHP <= myAttackDMG then
									if hitTime > GameRules.GetGameTime() and hitTime - GameRules.GetGameTime() < FAIO_lastHitter.lastHitterTimingOffsetter(myHero, target) * 1.25 then
										FAIO_lastHitter.lastHitCreepHPPredictionTime[target] = hitTime + 0.075
										break
										return
									end
								end
							else
								if creepHP <= myAttackDMG then
									if hitTime + 0.075 < FAIO_lastHitter.lastHitCreepHPPredictionTime[target] then
										FAIO_lastHitter.lastHitCreepHPPredictionTime[target] = hitTime + 0.075
										break
										return
									end
								end
							end	
						end
					end
				end
		
				


			end
		end
	end

	for i, v in ipairs(Entity.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_BOTH)) do
		if v and Entity.IsNPC(v) and not Entity.IsDormant(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" and (NPC.IsCreep(v) or NPC.IsTower(v)) then
			local creepHP = Entity.GetHealth(v) + NPC.GetHealthRegen(v)
			local myAttackDMG = NPC.GetDamageMultiplierVersus(myHero, v) * ((FAIO_lastHitter.myCreepDamageAdjuster(myHero, v) + NPC.GetBonusDamage(myHero)) * NPC.GetArmorDamageMultiplier(v))
			if creepHP < myAttackDMG then
				FAIO_lastHitter.lastHitCreepHPPredictionTime[v] = GameRules.GetGameTime()
			end
		end
	end
	
end

function FAIO_lastHitter.lastHitterDieTimeCleaner(myHero, attackPoint)

	if next(FAIO_lastHitter.lastHitCreepHPPredictionTime) == nil then return end

	if not myHero then
		FAIO_lastHitter.lastHitCreepHPPredictionTime = {}
	end

	if not Entity.IsAlive(myHero) then
		FAIO_lastHitter.lastHitCreepHPPredictionTime = {}
	end

	if #NPC.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_BOTH) <= 1 then
		FAIO_lastHitter.lastHitCreepHPPredictionTime = {}
	end

	if next(FAIO_lastHitter.lastHitCreepHPPredictionTime) ~= nil then
		for i, v in pairs(FAIO_lastHitter.lastHitCreepHPPredictionTime) do
			local target = i
			local dieTime = v
			if not target then
				FAIO_lastHitter.lastHitCreepHPPredictionTime[i] = nil
				break
				return
			end
			if target and Entity.IsNPC(target) and not Entity.IsAlive(target) then
				FAIO_lastHitter.lastHitCreepHPPredictionTime[i] = nil
				break
				return
			end
			if GameRules.GetGameTime() > dieTime then
				FAIO_lastHitter.lastHitCreepHPPredictionTime[i] = nil
				break
				return
			end
		end
	end	

end

function FAIO_lastHitter.lastHitterGetTarget(myHero, creep)

	if not myHero then return end
	if not creep then return end

	if not Entity.IsNPC(creep) then return end
	if not NPC.IsLaneCreep(creep) then return end
	if NPC.IsRanged(creep) then return end
	if not Entity.IsAlive(creep) then return end
	
	local creepRotation = Entity.GetRotation(creep):GetForward():Normalized()
	
	local targets = Entity.GetUnitsInRadius(creep, 148, Enum.TeamType.TEAM_ENEMY)
		if next(targets) == nil then return end
		if #targets < 1 then return end

	if #targets == 1 then
		if Entity.IsNPC(targets[1]) and NPC.IsLaneCreep(targets[1]) then
			return targets[1]
		end
	else
		local adjustedHullSize = 20
		for i, v in ipairs(targets) do
			if v and Entity.IsNPC(v) and NPC.IsLaneCreep(v) and Entity.IsAlive(v) then
				local vpos = Entity.GetAbsOrigin(v)
				local vposZ = vpos:GetZ()
				local pos = Entity.GetAbsOrigin(creep)
				for i = 1, 9 do
					local searchPos = pos + creepRotation:Scaled(25*(9-i))
						searchPos:SetZ(vposZ)
					if NPC.IsPositionInRange(v, searchPos, adjustedHullSize, 0) then
						return v
					end
				end
			end
		end
	end

	return

end

return FAIO_lastHitter