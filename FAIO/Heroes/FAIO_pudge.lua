FAIO_pudge = {}

FAIO_pudge.PudgeRotComboActivation = false
FAIO_pudge.PudgeRotComboDeactivation = 0
FAIO_pudge.PudgeHookStartTimer = 0
FAIO_pudge.PudgeHookDelayer = 0
FAIO_pudge.PudgeHookRotDelayer = 0
FAIO_pudge.PudgeHookTarget = nil
FAIO_pudge.PudgeHookTargetedPos = nil
FAIO_pudge.PudgeHookHit = false
FAIO_pudge.PudgecurrentParticle = 0
FAIO_pudge.PudgecurrentParticleTarget = nil
FAIO_pudge.PudgeRotFarmToggled = false
FAIO_pudge.PudgeRotFarmToggledTime = 0

local Q = nil
local W = nil
local ult = nil

local blink = nil
local force = nil

function FAIO_pudge.OnPrepareUnitOrders(orders)

	if not orders then return end

	if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION or orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET then
		if FAIO_pudge.PudgeHookHit then
			FAIO_pudge.PudgeHookHit = false
		end
	end

end

function FAIO_pudge.rotDeactivator(myHero)

	if not W then return end

	if FAIO_pudge.PudgeHookHit then return end

	if FAIO_pudge.PudgeRotComboActivation and not Menu.IsKeyDown(FAIO_options.optionComboKey) then
		if Ability.GetToggleState(W) then
			local checkEnemies = false
				for i, v in ipairs(Entity.GetHeroesInRadius(myHero, 250, Enum.TeamType.TEAM_ENEMY)) do
					if v and Entity.IsHero(v) and Entity.IsAlive(v) and not NPC.IsIllusion(v) then
						checkEnemies = true
						break
					end
				end

				if Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) < 0.2 then
					checkEnemies = false
				end

			if not checkEnemies then		
				if os.clock() > FAIO_pudge.PudgeRotComboDeactivation then
					Ability.Toggle(W)
					FAIO_pudge.PudgeRotComboActivation = false
					FAIO_pudge.PudgeRotComboDeactivation = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING) + 0.05
					return
				end
			end
		end
	end

	return

end

function FAIO_pudge.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroPudge) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)
	ult = NPC.GetAbility(myHero, "pudge_dismember")

	blink = NPC.GetItem(myHero, "item_blink", true)
	force = NPC.GetItem(myHero, "item_force_staff", true)

	local myMana = NPC.GetMana(myHero)

		-- items
	FAIO_itemHandler.itemUsage(myHero, enemy)

		-- pudge features
	FAIO_pudge.PudgeHookTargetIndicatorDel(myHero)
	FAIO_pudge.rotDeactivator(myHero)

	if Menu.IsEnabled(FAIO_options.optionHeroPudgeFarm) then
		FAIO_pudge.PudgeAutoFarm(myHero, myMana, W)
	end

	if Menu.IsEnabled(FAIO_options.optionHeroPudgeSuicide) then
		FAIO_pudge.PudgeAutoSuicide(myHero, myMana, W)
	end

	local maxInitRange = 0
		if blink and Ability.IsReady(blink) and Menu.IsEnabled(FAIO_options.optionHeroPudgeBlink) then
			maxInitRange = maxInitRange + 1200
		end
		if force and Ability.IsCastable(force, myMana) and Menu.IsEnabled(FAIO_options.optionHeroPudgeStaff) then
			maxInitRange = maxInitRange + 600
		end
		if enemy then
			if NPC.HasModifier(enemy, "modifier_pudge_meat_hook") then
				maxInitRange = 0
			end
		end
		if Q and Ability.SecondsSinceLastUse(Q) > -1 and Ability.SecondsSinceLastUse(Q) < 0.5 then
			maxInitRange = 0
		end

	local switch = FAIO_pudge.comboExecutionTimer(myHero)

	if Menu.IsEnabled(FAIO_options.optionHeroPudgeHook) then
		if Menu.IsKeyDown(FAIO_options.optionHeroPudgeHookKey) then
			local target = FAIO_pudge.PudgeHookGetTarget(myHero)
			if FAIO_pudge.PudgeHookTarget == nil and target ~= nil then
				FAIO_pudge.PudgeHookTarget = target
			end
			if FAIO_pudge.PudgeHookTarget ~= nil then
				if Entity.IsHero(FAIO_pudge.PudgeHookTarget) and Entity.IsAlive(FAIO_pudge.PudgeHookTarget) then

					if FAIO_pudge.PudgeHookCanceller(myHero, FAIO_pudge.PudgeHookTarget) then
						Player.HoldPosition(Players.GetLocal(), myHero, false)
						FAIO_pudge.PudgeHookStartTimer = 0
						FAIO_pudge.PudgeHookDelayer = 0
						FAIO_pudge.PudgeHookTargetedPos = nil
						return
					end

					if W and Ability.IsReady(W) and not Ability.GetToggleState(W) and Menu.IsEnabled(FAIO_options.optionHeroPudgeHookRot) then
						if FAIO_pudge.PudgeHookHit or NPC.IsEntityInRange(myHero, FAIO_pudge.PudgeHookTarget, 250) then
							if os.clock() > FAIO_pudge.PudgeHookRotDelayer then
								Ability.Toggle(W)
								FAIO_pudge.PudgeRotComboActivation = true
								FAIO_pudge.PudgeHookRotDelayer = os.clock() + 0.55
								return
							end
						end
					end

					FAIO_pudge.system(switch, function (continue, wait)

						continue(FAIO_pudge.hookComboExecute(myHero, myMana, FAIO_pudge.PudgeHookTarget))
						wait()

					end)()
					
				else
					FAIO_pudge.PudgeHookTarget = nil
				end	
			end
		else
			if FAIO_pudge.PudgeHookTarget ~= nil then
				FAIO_pudge.PudgeHookTarget = nil
			end
		end
	end					

	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000) then return end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then

		if FAIO_pudge.PudgeHookCanceller(myHero, enemy) then
			Player.HoldPosition(Players.GetLocal(), myHero, false)
			FAIO_pudge.PudgeHookStartTimer = 0
			FAIO_pudge.mainTick = 0
			FAIO_pudge.PudgeHookTargetedPos = nil
			return
		end

		if W and Ability.IsReady(W) and not Ability.GetToggleState(W) then
			if NPC.IsEntityInRange(myHero, enemy, 250) then
				if os.clock() > FAIO_pudge.PudgeHookRotDelayer then	
					Ability.Toggle(W)
					FAIO_pudge.PudgeRotComboActivation = true
					FAIO_pudge.PudgeHookRotDelayer = os.clock() + 0.55
					return
				end
			end
		end

		FAIO_pudge.system(switch, function (continue, wait)

			continue(FAIO_pudge.comboExecute(myHero, enemy, myMana, maxInitRange))
			wait()

		end)()
		
	end

	return

end

function FAIO_pudge.comboExecute(myHero, enemy, myMana, maxInitRange)

	if FAIO_pudge.heroCanCastSpells(myHero, enemy) == true then

		if maxInitRange > 1200 then
			if not NPC.IsEntityInRange(myHero, enemy, 1200) then
				if NPC.IsEntityInRange(myHero, enemy, 1750) then
					local pred = 600/1200 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local predPos = FAIO_pudge.castPrediction(myHero, enemy, pred)
					if FAIO_pudge.AmIFacingPos(myHero, predPos, 10) then
						Ability.CastTarget(force, myHero)
						FAIO_pudge.mainTock = os.clock() + 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
						return
					else
						FAIO_pudge.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, predPos)
						return
					end
				end
			else
				if not NPC.HasModifier(myHero, "modifier_item_forcestaff_active") then
					FAIO_pudge.blinkHandler(myHero, enemy, Menu.GetValue(FAIO_options.optionHeroPudgeBlinkMinRange), 0, false)
				end
			end
		end
		if maxInitRange == 1200 then
			if NPC.IsEntityInRange(myHero, enemy, 1200) then
				if not NPC.HasModifier(myHero, "modifier_item_forcestaff_active") then
					FAIO_pudge.blinkHandler(myHero, enemy, Menu.GetValue(FAIO_options.optionHeroPudgeBlinkMinRange), 0, false)
				end
			end
		end
		if maxInitRange == 600 then
			if NPC.IsEntityInRange(myHero, enemy, 725) then
				if not NPC.IsEntityInRange(myHero, enemy, 550) then
					local pred = 600/1200 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local predPos = FAIO_pudge.castPrediction(myHero, enemy, pred)
					if FAIO_pudge.AmIFacingPos(myHero, predPos, 5) then
						FAIO_pudge.executeSkillOrder(force, myHero)
						return
					else
						FAIO_pudge.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, predPos)
						return
					end
				end
			end
		end

		if ult and Ability.IsCastable(ult, myMana) then
			if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(ult)) then
				if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) then
					FAIO_pudge.executeSkillOrder(ult, enemy)
					return
				end
			end	
		end

		local check = false
			if maxInitRange == 600 then
				if NPC.IsEntityInRange(myHero, enemy, 725) then
					if not NPC.IsEntityInRange(myHero, enemy, 550) then
						check = true
					end
				end
			end
			if ult and Ability.IsCastable(ult, myMana) then
				if force and Ability.SecondsSinceLastUse(force) > -1 and Ability.SecondsSinceLastUse(force) < 1 then
					check = true
				end
				if blink and Ability.SecondsSinceLastUse(blink) > -1 and Ability.SecondsSinceLastUse(blink) < 0.5 then
					check = true
				end
			end

		if Menu.IsEnabled(FAIO_options.optionHeroPudgeHookCombo) and not check and not NPC.HasModifier(myHero, "modifier_item_forcestaff_active") then
			if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Menu.GetValue(FAIO_options.optionHeroPudgeHookComboMaxRange)) and not NPC.IsChannellingAbility(myHero) then
				if FAIO_pudge.PudgeHookCollisionChecker(myHero, enemy) and not FAIO_pudge.PudgeHookJukingChecker(myHero, enemy) then
					local hookPrediction = Ability.GetCastPoint(Q) + NPC.GetTimeToFace(myHero, enemy) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1450) + FAIO_pudge.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy)) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local hookPredictedPos = FAIO_pudge.castPrediction(myHero, enemy, hookPrediction)
					FAIO_pudge.executeSkillOrder(Q, enemy, hookPredictedPos)
					FAIO_pudge.PudgeHookStartTimer = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_pudge.TimeToFacePosition(myHero, hookPredictedPos) + FAIO_pudge.humanizerMouseDelayCalc(hookPredictedPos)
					FAIO_pudge.PudgeHookTargetedPos = hookPredictedPos
					return
				end
			end
		end
	end

	local attCheck = false
		if ult and Ability.IsCastable(ult, myMana) then
			if force and Ability.SecondsSinceLastUse(force) > -1 and Ability.SecondsSinceLastUse(force) < 1 then
				check = true
			end
			if blink and Ability.SecondsSinceLastUse(blink) > -1 and Ability.SecondsSinceLastUse(blink) < 0.5 then
				check = true
			end
		end

	if not NPC.HasModifier(enemy, "modifier_pudge_meat_hook") and not attCheck then
		FAIO_pudge.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

	return

end

function FAIO_pudge.hookComboExecute(myHero, myMana, npc)

	if not myHero then return end
	if not npc then return end

	if not Q then return end
		if Ability.GetLevel(Q) < 1 then return end

	FAIO_pudge.PudgeHookTargetIndicator(myHero, npc)
	FAIO_pudge.PudgeHookHitTracker(myHero, Q)

	if not Entity.IsSameTeam(myHero, npc) then
		if ult and Ability.IsCastable(ult, myMana) and Menu.IsEnabled(FAIO_options.optionHeroPudgeHookUlt) then
			if not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_STUNNED) then
				if NPC.IsEntityInRange(myHero, FAIO_pudge.PudgeHookTarget, Ability.GetCastRange(ult)) then
					FAIO_pudge.executeSkillOrder(ult, FAIO_pudge.PudgeHookTarget)
					return
				end
			end
		end

		if FAIO_pudge.PudgeHookHit then
			if Menu.IsEnabled(FAIO_options.optionHeroPudgeHookItems) then
				FAIO_itemHandler.itemUsageSmartOrder(myHero, npc, true)
			end
			if not NPC.HasModifier(npc, "modifier_pudge_meat_hook") then
				FAIO_pudge.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", npc, nil)
			end
		end	
	end

	local hookRange = Ability.GetCastRange(Q)
	local pred = Ability.GetCastPoint(Q) + NPC.GetTimeToFace(myHero, npc) + (Entity.GetAbsOrigin(npc):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1450) + FAIO_pudge.humanizerMouseDelayCalc(Entity.GetAbsOrigin(npc)) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
	local predPos = FAIO_pudge.castPrediction(myHero, npc, pred)

	if not NPC.IsPositionInRange(myHero, predPos, hookRange + 100, 20) then return end

	local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)

	if Q and Ability.IsCastable(Q, myMana) and not NPC.IsChannellingAbility(myHero) then	
		if not FAIO_pudge.PudgeHookJukingChecker(myHero, npc) then
			if FAIO_pudge.PudgeHookCollisionChecker(myHero, npc) then
				if FAIO_pudge.PudgeHookTiming(myHero, npc) > GameRules.GetGameTime() then
					local modTiming = FAIO_pudge.PudgeHookTiming(myHero, npc) + 0.1
					local hookTiming = Ability.GetCastPoint(Q) + NPC.GetTimeToFace(myHero, npc) + ((Entity.GetAbsOrigin(npc):__sub(Entity.GetAbsOrigin(myHero)):Length2D() - 125) / 1450) + FAIO_pudge.humanizerMouseDelayCalc(Entity.GetAbsOrigin(npc)) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					if GameRules.GetGameTime() > modTiming - hookTiming then
						FAIO_pudge.executeSkillOrder(Q, npc, Entity.GetAbsOrigin(npc))
						FAIO_pudge.PudgeHookStartTimer = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_pudge.TimeToFacePosition(myHero, predPos) + FAIO_pudge.humanizerMouseDelayCalc(predPos)
						return	
					end
				else
					if atos and Ability.IsCastable(atos, myMana) and NPC.IsEntityInRange(myHero, npc, 1150) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(npc) then
						FAIO_pudge.executeSkillOrder(atos, npc)
						FAIO_pudge.PudgeHookTarget = npc
						return
					else
						if atos and Ability.SecondsSinceLastUse(atos) > -1 and Ability.SecondsSinceLastUse(atos) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(npc)):Length2D() / 1500) + 0.55 then
							local atosTiming = GameRules.GetGameTime() - math.max(Ability.SecondsSinceLastUse(atos), 0) + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(npc)):Length2D() / 1500) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) - 0.1
							if GameRules.GetGameTime() >= atosTiming then
								FAIO_pudge.executeSkillOrder(Q, npc, Entity.GetAbsOrigin(npc))
								FAIO_pudge.PudgeHookStartTimer = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_pudge.TimeToFacePosition(myHero, predPos) + FAIO_pudge.humanizerMouseDelayCalc(Entity.GetAbsOrigin(npc))
								return
							end	
						else
							FAIO_pudge.executeSkillOrder(Q, npc, predPos)
							FAIO_pudge.PudgeHookStartTimer = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_pudge.TimeToFacePosition(myHero, predPos) + FAIO_pudge.humanizerMouseDelayCalc(predPos)
							FAIO_pudge.PudgeHookTargetedPos = predPos
							return
						end
					end
				end
			else
				if FAIO_pudge.PudgeHookForceStaffFun(myHero, myMana, npc, Q) then
					local targetRotation = Entity.GetRotation(npc):GetForward()
					local targetForcedPos = Entity.GetAbsOrigin(npc) + targetRotation:Normalized():Scaled(600)
					Ability.CastTarget(NPC.GetItem(myHero, "item_force_staff", true), npc)
					FAIO_pudge.PudgeHookTarget = npc
					FAIO_pudge.executeSkillOrder(Q, npc, targetForcedPos)
					FAIO_pudge.PudgeHookStartTimer = os.clock() + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_pudge.TimeToFacePosition(myHero, targetForcedPos) + FAIO_pudge.humanizerMouseDelayCalc(predPos)
					return	
				end
							
			end
		end

	end

	return

end

function FAIO_pudge.PudgeAutoSuicide(myHero, myMana, rot)

	if not myHero then return end
	if not rot then return end

	if FAIO_pudge.heroCanCastItems(myHero) == false then return end
	if FAIO_pudge.isHeroChannelling(myHero) == true then return end
	if FAIO_pudge.IsHeroInvisible(myHero) == true then return end

	if os.clock() < FAIO_pudge.PudgeRotFarmToggledTime then return end

	if NPC.HasItem(myHero, "item_armlet", true) then return end

	local rotDamage = Ability.GetLevelSpecialValueFor(rot, "rot_damage")
		if NPC.HasAbility(myHero, "special_bonus_unique_pudge_2") then
			if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_pudge_2")) > 0 then
				rotDamage = rotDamage + 35
			end
		end

	rotDamage = ((1 - NPC.GetMagicalArmorValue(myHero)) * rotDamage + rotDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100)) / 4

	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)
		if soulRing and Ability.IsReady(soulRing) and FAIO_pudge.heroCanCastItems(myHero) then
			rotDamage = rotDamage + 150
		end

	local myHP = Entity.GetHealth(myHero)

	if myHP <= rotDamage then
		for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
				if NPC.IsAttacking(v) then
					if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
						if NPC.FindFacingNPC(v) == myHero then
							if soulRing and Ability.IsReady(soulRing) and FAIO_pudge.heroCanCastItems(myHero) then
								Ability.CastNoTarget(soulRing)
								if not Ability.GetToggleState(rot) then
									Ability.Toggle(rot)
								end
								FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
								break
								return
							else
								if not Ability.GetToggleState(rot) then
									Ability.Toggle(rot)
								end
								FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
								break
								return
							end		
						end
					end
				end
				for ability, info in pairs(FAIO_data.RawDamageAbilityEstimation) do
					if NPC.HasAbility(v, ability) and Ability.IsInAbilityPhase(NPC.GetAbility(v, ability)) then
						local abilityRange = math.max(Ability.GetCastRange(NPC.GetAbility(v, ability)), info[2])
						local abilityRadius = info[3]
						if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
							if next(FAIO_dodgeIT.dodgeItTable) == nil then
								if soulRing and Ability.IsReady(soulRing) and FAIO_pudge.heroCanCastItems(myHero) then
									Ability.CastNoTarget(soulRing)
									if not Ability.GetToggleState(rot) then
										Ability.Toggle(rot)
									end
									FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
									break
									return
								else
									if not Ability.GetToggleState(rot) then
										Ability.Toggle(rot)
									end
									FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
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

	return	

end

function FAIO_pudge.PudgeAutoFarm(myHero, myMana, rot)

	if not myHero then return end
	if not rot then return end

	if FAIO_pudge.heroCanCastItems(myHero) == false then return end
	if FAIO_pudge.isHeroChannelling(myHero) == true then return end
	if FAIO_pudge.IsHeroInvisible(myHero) == true then return end

	if os.clock() < FAIO_pudge.PudgeRotFarmToggledTime then return end

	if FAIO_pudge.PudgeRotFarmToggled and not Ability.GetToggleState(rot) then
		FAIO_pudge.PudgeRotFarmToggled = false
		return
	end

	if Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) < Menu.GetValue(FAIO_options.optionHeroPudgeFarmHP) / 100 then
		if Ability.GetToggleState(rot) and FAIO_pudge.PudgeRotFarmToggled then
			Ability.Toggle(rot)
			FAIO_pudge.PudgeRotFarmToggled = false
			FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		else
			return
		end
	end

	local rotDamage = Ability.GetLevelSpecialValueFor(rot, "rot_damage")
		if NPC.HasAbility(myHero, "special_bonus_unique_pudge_2") then
			if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_pudge_2")) > 0 then
				rotDamage = rotDamage + 35
			end
		end

	if #Entity.GetUnitsInRadius(myHero, 240, Enum.TeamType.TEAM_ENEMY) < 1 then
		if Ability.GetToggleState(rot) and FAIO_pudge.PudgeRotFarmToggled then
			Ability.Toggle(rot)
			FAIO_pudge.PudgeRotFarmToggled = false
			FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
	end	

	
	for _, creeps in ipairs(Entity.GetUnitsInRadius(myHero, 240, Enum.TeamType.TEAM_ENEMY)) do
		if creeps and Entity.IsNPC(creeps) and not Entity.IsHero(creeps) and Entity.IsAlive(creeps) and not Entity.IsDormant(creeps) and not NPC.IsWaitingToSpawn(creeps) and NPC.GetUnitName(creeps) ~= "npc_dota_neutral_caster" and NPC.IsCreep(creeps) and NPC.GetUnitName(creeps) ~= nil and NPC.IsKillable(creeps) then
			local rotTrueDamage = ((1 - NPC.GetMagicalArmorValue(creeps)) * rotDamage + rotDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100)) / 4
			if Entity.GetHealth(creeps) < rotTrueDamage then
				if not Ability.GetToggleState(rot) then
					Ability.Toggle(rot)
					FAIO_pudge.PudgeRotFarmToggled = true
					FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			else
				if Ability.GetToggleState(rot) and FAIO_pudge.PudgeRotFarmToggled then
					Ability.Toggle(rot)
					FAIO_pudge.PudgeRotFarmToggled = false
					FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			end
		else
			if Ability.GetToggleState(rot) and FAIO_pudge.PudgeRotFarmToggled then
				Ability.Toggle(rot)
				FAIO_pudge.PudgeRotFarmToggled = false
				FAIO_pudge.PudgeRotFarmToggledTime = os.clock() + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end
		end
	end
	
	return
		
end

function FAIO_pudge.PudgeHookCollisionChecker(myHero, target)

	if not myHero then return false end
	if not target then return false end

	local pred = 0.3 + NPC.GetTimeToFace(myHero, target) + (Entity.GetAbsOrigin(target):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1450) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_pudge.humanizerMouseDelayCalc(Entity.GetAbsOrigin(target))
	local predPos = FAIO_pudge.castPrediction(myHero, target, pred)

	local searchRadius = 125
	local distance = (Entity.GetAbsOrigin(myHero) - predPos):Length2D()

	for i = 1, math.floor(distance / searchRadius) do
		local checkVec = (predPos - Entity.GetAbsOrigin(myHero)):Normalized()
		local checkPos = Entity.GetAbsOrigin(myHero) + checkVec:Scaled(i * searchRadius)
		local unitsAround = NPCs.InRadius(checkPos, searchRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH)
		local check = false
			for _, unit in ipairs(unitsAround) do
				if unit and Entity.IsNPC(unit) and unit ~= target and unit ~= myHero and Entity.IsAlive(unit) and not Entity.IsDormant(unit) and not NPC.IsStructure(unit) and not NPC.IsBarracks(unit) and not NPC.IsWaitingToSpawn(unit) and NPC.GetUnitName(unit) ~= "npc_dota_neutral_caster" and NPC.GetUnitName(unit) ~= nil then
					check = true
					break
				end
			end

		if check then
			return false
		end	

	end

	return true

end

function FAIO_pudge.PudgeHookCanceller(myHero, target)

	if not myHero then return false end
	if not target then return true end

	local hook = NPC.GetAbilityByIndex(myHero, 0)
		if not hook then return false end
			if Ability.GetLevel(hook) < 1 then return false end

	local hookRange = Ability.GetCastRange(hook)

	if FAIO_pudge.PudgeHookTargetedPos == nil then return false end

	if os.clock() > FAIO_pudge.PudgeHookStartTimer + 0.33 then return false end
	if os.clock() < FAIO_pudge.PudgeHookStartTimer + 0.175  then return false end

	local timePassed = math.min(os.clock() - FAIO_pudge.PudgeHookStartTimer, 0.3)

	local pred = (0.3 - timePassed) + (Entity.GetAbsOrigin(target):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1450)
	local predPos = FAIO_pudge.castPrediction(myHero, target, pred)
	
	if (predPos - Entity.GetAbsOrigin(myHero)):Length2D() > hookRange + 100 then return true end

	local searchRadius = 120
	local distance = (Entity.GetAbsOrigin(myHero) - predPos):Length2D()

	local check = false
		for i = 1, math.ceil(distance / searchRadius) do
			local checkVec = (FAIO_pudge.PudgeHookTargetedPos - Entity.GetAbsOrigin(myHero)):Normalized()
			local checkPos = Entity.GetAbsOrigin(myHero) + checkVec:Scaled(i * searchRadius)
			if (checkPos - predPos):Length2D() < searchRadius then
				check = true
				break
			end
		end

	if not check then
		return true
	end

	return false

end

function FAIO_pudge.PudgeHookJukingChecker(myHero, target)

	if Menu.GetValue(FAIO_options.optionHeroPudgeHookJuke) < 1 then return false end

	if not myHero then return false end
	if not target then return false end

	if not NPC.IsRunning(target) then return false end

	local turning = Entity.IsTurning(target)

	if NPC.IsRunning(target) then
		if NPC.IsRunning(target) then
			table.insert(FAIO_pudge.rotationTable, turning)
			if #FAIO_pudge.rotationTable > Menu.GetValue(FAIO_options.optionHeroPudgeHookJuke) then
				table.remove(FAIO_pudge.rotationTable, 1)
			end
		end
	end

	if #FAIO_pudge.rotationTable < Menu.GetValue(FAIO_options.optionHeroPudgeHookJuke) then 
		return true
	else
		local check = false
		for i = 1, #FAIO_pudge.rotationTable do
			if FAIO_pudge.rotationTable[i] == true then
				check = true
				break
			end
		end

		if check then
			return true
		end
	end

	return false
 
end

function FAIO_pudge.PudgeHookGetTarget(myHero)

	if not myHero then return end

	local targetingRange = Menu.GetValue(FAIO_options.optionHeroPudgeHookAcquiRange)
	local mousePos = Input.GetWorldCursorPos()

	
	local enemyTable = Heroes.InRadius(mousePos, targetingRange, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		if Menu.IsEnabled(FAIO_options.optionHeroPudgeHookAllies) then
			enemyTable = Heroes.InRadius(mousePos, targetingRange, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH)
		end
		if #enemyTable < 1 then return end

	local nearestTarget = nil
	local distance = 99999

	for i, v in ipairs(enemyTable) do
		if v and Entity.IsHero(v) and Entity.IsAlive(v) and v ~= myHero then
			if FAIO_pudge.targetChecker(v) ~= nil then
				local enemyDist = (Entity.GetAbsOrigin(v) - mousePos):Length2D()
				if enemyDist < distance then
					nearestTarget = v
					distance = enemyDist
				end
			end
		end
	end

	return nearestTarget or nil

end

function FAIO_pudge.PudgeHookTiming(myHero, target)

	if not myHero then return 0 end
	if not target then return 0 end

	local invulnerabilityList = {
		"modifier_eul_cyclone",
		"modifier_obsidian_destroyer_astral_imprisonment_prison",
		"modifier_shadow_demon_disruption",
		"modifier_invoker_tornado"
			}
	
	local searchMod
	for _, modifier in ipairs(invulnerabilityList) do
		if NPC.HasModifier(target, modifier) then
			searchMod = NPC.GetModifier(target, modifier)
			break
		end
	end

	if not searchMod then return 0 end

	local timing = 0
	if searchMod then
		local dieTime = Modifier.GetDieTime(searchMod)
		timing = dieTime
	end

	return timing

end

function FAIO_pudge.PudgeHookHitTracker(myHero, hook)

	if not myHero then return end
	if not hook then return end

	if Ability.SecondsSinceLastUse(hook) == -1 and FAIO_pudge.PudgeHookHit then
		FAIO_pudge.PudgeHookHit = false
	end

	if FAIO_pudge.PudgeHookTarget == nil and FAIO_pudge.PudgeHookHit then
		FAIO_pudge.PudgeHookHit = false
	end

	if FAIO_pudge.PudgeHookTarget then
		if NPC.HasModifier(FAIO_pudge.PudgeHookTarget, "modifier_pudge_meat_hook") then
			FAIO_pudge.PudgeHookHit = true
		end
	end
	
	return

end

function FAIO_pudge.PudgeHookForceStaffFun(myHero, myMana, target, hook)

	if not myHero then return false end
	if not target then return false end
		if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return false end

	if not Menu.IsEnabled(FAIO_options.optionHeroPudgeHookStaff) then return false end
	if not hook then return false end

	local force = NPC.GetItem(myHero, "item_force_staff", true)
		if not force then return false end
		if not Ability.IsCastable(force, myMana) then return false end

	if FAIO_pudge.heroCanCastSpells(myHero, target) == false then return false end
	if FAIO_pudge.isHeroChannelling(myHero) == true then return false end 

	local staffTargetRange = 750
		if NPC.HasItem(myHero, "item_aether_lens", true) then
			staffTargetRange = 1000
		end	

	if not NPC.IsEntityInRange(myHero, target, staffTargetRange) then return false end
	if FAIO_pudge.PudgeHookJukingChecker(myHero, target) then return false end

	local targetTurnTime90 = (0.03 * math.pi) / NPC.GetTurnRate(target) / 3.5
	if NPC.GetTimeToFace(target, myHero) > targetTurnTime90 then return false end

	local targetRotation = Entity.GetRotation(target):GetForward()
	local targetForcedPos = Entity.GetAbsOrigin(target) + targetRotation:Normalized():Scaled(600)

	if not FAIO_pudge.PudgeHookCollisionCheckerPosition(myHero, targetForcedPos) then return false end
	local hookRange = Ability.GetCastRange(hook)
		if (Entity.GetAbsOrigin(myHero) - targetForcedPos):Length2D() > hookRange then return false end

	return true

end

function FAIO_pudge.PudgeHookCollisionCheckerPosition(myHero, pos)

	if not myHero then return false end
	if not pos then return false end

	local searchRadius = 125
	local distance = (Entity.GetAbsOrigin(myHero) - pos):Length2D()

	for i = 1, math.floor(distance / searchRadius) do
		local checkVec = (pos - Entity.GetAbsOrigin(myHero)):Normalized()
		local checkPos = Entity.GetAbsOrigin(myHero) + checkVec:Scaled(i * searchRadius)
		local unitsAround = NPCs.InRadius(checkPos, searchRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH)
		local check = false
			for _, unit in ipairs(unitsAround) do
				if unit and Entity.IsNPC(unit) and unit ~= target and unit ~= myHero and Entity.IsAlive(unit) and not Entity.IsDormant(unit) and not NPC.IsStructure(unit) and not NPC.IsBarracks(unit) and not NPC.IsWaitingToSpawn(unit) and NPC.GetUnitName(unit) ~= "npc_dota_neutral_caster" and NPC.GetUnitName(unit) ~= nil then
					check = true
					break
				end
			end

		if check then
			return false
		end	

	end

	return true

end
			
function FAIO_pudge.PudgeHookTargetIndicatorDel(myHero)

	if not myHero then return end

	local curtime = GameRules.GetGameTime()

	if not Menu.IsKeyDown(FAIO_options.optionHeroPudgeHookKey) or FAIO_pudge.PudgeHookTarget == nil then
		if FAIO_pudge.PudgecurrentParticle > 0 then
			Particle.Destroy(FAIO_pudge.PudgecurrentParticle)			
			FAIO_pudge.PudgecurrentParticle = 0
		end
	end

	return

end

function FAIO_pudge.PudgeHookTargetIndicator(myHero, target)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroPudgeHook) then return end

	local curtime = GameRules.GetGameTime()
		
	if (not target or target ~= FAIO_pudge.PudgecurrentParticleTarget) and FAIO_pudge.PudgecurrentParticle > 0 then
		Particle.Destroy(FAIO_pudge.PudgecurrentParticle)			
		FAIO_pudge.PudgecurrentParticle = 0
		FAIO_pudge.PudgecurrentParticleTarget = target
	else
		if FAIO_pudge.PudgecurrentParticle == 0 and target then
			local Particle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, target)	
			FAIO_pudge.PudgecurrentParticle = Particle
			FAIO_pudge.PudgecurrentParticleTarget = target			
		end
		if FAIO_pudge.PudgecurrentParticle > 0 then
			Particle.SetControlPoint(FAIO_pudge.PudgecurrentParticle, 2, Entity.GetOrigin(myHero))
			Particle.SetControlPoint(FAIO_pudge.PudgecurrentParticle, 6, Vector(1, 0, 0))
			Particle.SetControlPoint(FAIO_pudge.PudgecurrentParticle, 7, Entity.GetOrigin(FAIO_pudge.PudgecurrentParticleTarget))
		end
	end

end

return FAIO_pudge




