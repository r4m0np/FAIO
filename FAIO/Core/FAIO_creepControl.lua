FAIO_creepControl = {}

FAIO_creepControl.ControllableEntityTable = {}
FAIO_creepControl.ControllableActionTable = {}
FAIO_creepControl.mainTick = 0
FAIO_creepControl.cycleTick = 0

FAIO_creepControl.humanizerTimer = 0

function FAIO_creepControl.comboHandler(myHero, enemy)

	if not myHero then return end

	FAIO_creepControl.GetControllableEntities(myHero)
	
	if next(FAIO_creepControl.ControllableEntityTable) == nil then return end

	FAIO_creepControl.createActionTable(myHero)	

	if enemy then

		if Menu.IsKeyDown(FAIO_options.optionComboKey) then

			if Menu.GetValue(FAIO_options.optionCreepControlMode) < 1 then

				FAIO_creepControl.controllableLegitHandler(myHero, enemy)

			else

				FAIO_creepControl.controllableHandler(myHero, enemy)

			end
		end

	end

	return

end

function FAIO_creepControl.controllableHandler(myHero, target)

	if not myHero then return end
	if not target then return end

	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
		if FAIO_creepControl.controllableActionTracker(v, os.clock(), "attack", target, 0.0) == true then
			Player.AttackTarget(Players.GetLocal(), v, target, false)
			FAIO_creepControl.ControllableActionTable[Entity.GetIndex(v)] = { time = os.clock(), order = "attack", target = target, recurring = os.clock() }
			FAIO_creepControl.mainTick = os.clock()
		end
	end

	local neutralNPC
	local neutralAbility
	local neutralTargeting
	local neutralRange
		for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
			for k, l in ipairs(FAIO_data.neutralsAbilityListDebuff) do
				if NPC.HasAbility(v, l[1]) and FAIO_creepControl.heroCanCastSpells(v, target) == true and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					if Ability.IsCastable(NPC.GetAbility(v, l[1]), NPC.GetMana(v)) then
						neutralNPC = v
						neutralAbility = NPC.GetAbility(v, l[1])
						neutralTargeting = l[2]
						neutralRange = l[3]
						break
					end
				end
			end
		end

	if neutralNPC and neutralAbility then

		if neutralTargeting == "no target" then
			local range = neutralRange
				if NPC.IsRunning(target) then
					range = math.max(0.6 * neutralRange, 150)
				end
			if NPC.IsEntityInRange(neutralNPC, target, range) then
				if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.055) == true then
					Ability.CastNoTarget(neutralAbility)
					FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25 }
					FAIO_creepControl.mainTick = os.clock()
					return
				end
			end

		elseif neutralTargeting == "target" then
			if NPC.IsEntityInRange(neutralNPC, target, neutralRange) then
				if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.055) == true then
					Ability.CastTarget(neutralAbility, target)
					FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45 }
					FAIO_creepControl.mainTick = os.clock()
					return
				end
			end
		elseif neutralTargeting == "special" then
			if Ability.GetName(neutralAbility) == "satyr_hellcaller_shockwave" then
				if NPC.IsEntityInRange(neutralNPC, target, 1000) then
					if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.055) == true then
						local shockPrediction = 0.5 + (Entity.GetAbsOrigin(target):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 900) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
						local predictedPos = Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.castLinearPrediction(myHero, target, shockPrediction) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.min(695, (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(target)):Length2D()))
						if predictedPos ~= nil and NPC.IsPositionInRange(neutralNPC, predictedPos, 700, 0) then
							Ability.CastPosition(neutralAbility, predictedPos)
							FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45 }
							FAIO_creepControl.mainTick = os.clock()
							return
						end
					end
				end
			elseif Ability.GetName(neutralAbility) == "dark_troll_warlord_raise_dead" then
				if NPC.IsEntityInRange(neutralNPC, target, 700) then
					if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.055) == true then
						local check = false
							for i = 1, NPCs.Count() do
              							local corpses = NPCs.Get(i)
								if corpses and Entity.IsNPC(corpses) and not Entitiy.IsDormant(corpses) and not Entity.IsAlive(corpses) and NPC.IsEntityInRange(neutralNPC, corpses, 550) then
									check = true
									break
								end
							end
						if check then
							Ability.CastNoTarget(neutralAbility)
							FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25 }
							FAIO_creepControl.mainTick = os.clock()
							return
						end
					end
				end
			end
		end		
	end	

	return

end

function FAIO_creepControl.controllableLegitHandler(myHero, target)

	if not myHero then return end
	if not target then return end

	local check = false
	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
		if FAIO_creepControl.controllableActionTracker(v, os.clock(), "attack", target, 0.055) == true then
			check = true
			break
		end
	end

	if check then
		FAIO_creepControl.selectControllableUnits(myHero, FAIO_creepControl.ControllableEntityTable)
	end

	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
		if FAIO_creepControl.controllableActionTracker(v, os.clock(), "attack", target, 0.055) == true then
			Player.AttackTarget(Players.GetLocal(), v, target, false)
			FAIO_creepControl.ControllableActionTable[Entity.GetIndex(v)] = { time = os.clock(), order = "attack", target = target, recurring = os.clock() }
			FAIO_creepControl.mainTick = os.clock()
		end
	end

--	local check = false
--	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
--		if FAIO_creepControl.controllableActionTracker(v, os.clock(), "attack", target, 0.255) == true then
--			check = true
--			break
--		end
--	end
--
--	if check then
--		FAIO_creepControl.selectControllableUnits(myHero, FAIO_creepControl.ControllableEntityTable)
--		for i = 1, #Player.GetSelectedUnits(Players.GetLocal()) do
--			local index = Entity.GetIndex(Player.GetSelectedUnits(Players.GetLocal())[i])
--			if FAIO_creepControl.ControllableActionTable[index] ~= nil then
--				Player.AttackTarget(Players.GetLocal(), Player.GetSelectedUnits(Players.GetLocal())[i], target, false)
--				FAIO_creepControl.ControllableActionTable[index] = { time = os.clock(), order = "attack", target = target, recurring = os.clock() }
--			end
--		end	
--		FAIO_creepControl.mainTick = os.clock()
--		return
--	end

	local neutralNPC
	local neutralAbility
	local neutralTargeting
	local neutralRange
		for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
			for k, l in ipairs(FAIO_data.neutralsAbilityListDebuff) do
				if NPC.HasAbility(v, l[1]) and FAIO_creepControl.heroCanCastSpells(v, target) == true and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					if Ability.IsCastable(NPC.GetAbility(v, l[1]), NPC.GetMana(v)) then
						neutralNPC = v
						neutralAbility = NPC.GetAbility(v, l[1])
						neutralTargeting = l[2]
						neutralRange = l[3]
						break
					end
				end
			end
		end

	if neutralNPC and neutralAbility then

		if neutralTargeting == "no target" then
			local range = neutralRange
				if NPC.IsRunning(target) then
					range = math.max(0.6 * neutralRange, 150)
				end
			if NPC.IsEntityInRange(neutralNPC, target, range) then
				if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.255) == true then
					FAIO_creepControl.selectControllableUnits(myHero, neutralNPC)
					local check = false
						if Player.GetSelectedUnits(Players.GetLocal())[1] ~= neutralNPC then
							if os.clock() > FAIO_creepControl.cycleTick + (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000) then
								Engine.ExecuteCommand("dota_cycle_selected")
								FAIO_creepControl.cycleTick = os.clock()
								return
							end
						else
							check = true
						end
		
					if check then
						Ability.CastNoTarget(neutralAbility)
						FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25 }
						FAIO_creepControl.mainTick = os.clock()
						return
					end
				end
			end

		elseif neutralTargeting == "target" then
			if NPC.IsEntityInRange(neutralNPC, target, neutralRange) then
				if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.255) == true then
					FAIO_creepControl.selectControllableUnits(myHero, neutralNPC)
					local check = false
						if Player.GetSelectedUnits(Players.GetLocal())[1] ~= neutralNPC then
							if os.clock() > FAIO_creepControl.cycleTick + (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000) then
								Engine.ExecuteCommand("dota_cycle_selected")
								FAIO_creepControl.cycleTick = os.clock()
								return
							end
						else
							check = true
						end
		
					if check then
						Ability.CastTarget(neutralAbility, target)
						FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45 }
						FAIO_creepControl.mainTick = os.clock()
						return
					end
				end
			end
		elseif neutralTargeting == "special" then
			if Ability.GetName(neutralAbility) == "satyr_hellcaller_shockwave" then
				if NPC.IsEntityInRange(neutralNPC, target, 1000) then
					if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.255) == true then
						FAIO_creepControl.selectControllableUnits(myHero, neutralNPC)
						local check = false
							if Player.GetSelectedUnits(Players.GetLocal())[1] ~= neutralNPC then
								if os.clock() > FAIO_creepControl.cycleTick + (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000) then
									Engine.ExecuteCommand("dota_cycle_selected")
									FAIO_creepControl.cycleTick = os.clock()
									return
								end
							else
								check = true
							end
						if check then
							local shockPrediction = 0.5 + (Entity.GetAbsOrigin(target):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 900) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
							local predictedPos = Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.castLinearPrediction(myHero, target, shockPrediction) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.min(695, (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(target)):Length2D()))
							if predictedPos ~= nil and NPC.IsPositionInRange(neutralNPC, predictedPos, 700, 0) then
								Ability.CastPosition(neutralAbility, predictedPos)
								FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.45 }
								FAIO_creepControl.mainTick = os.clock()
								return
							end
						end
					end
				end
			elseif Ability.GetName(neutralAbility) == "dark_troll_warlord_raise_dead" then
				if NPC.IsEntityInRange(neutralNPC, target, 700) then
					if FAIO_creepControl.controllableActionTracker(neutralNPC, os.clock(), Ability.GetName(neutralAbility), target, 0.255) == true then
						FAIO_creepControl.selectControllableUnits(myHero, neutralNPC)
						local check = false
							if Player.GetSelectedUnits(Players.GetLocal())[1] ~= neutralNPC then
								if os.clock() > FAIO_creepControl.cycleTick + (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000) then
									Engine.ExecuteCommand("dota_cycle_selected")
									FAIO_creepControl.cycleTick = os.clock()
									return
								end
							else
								check = true
							end
						if check then
							local corpseCheck = false
								for i = 1, NPCs.Count() do
              								local corpses = NPCs.Get(i)
									if corpses and Entity.IsNPC(corpses) and not Entitiy.IsDormant(corpses) and not Entity.IsAlive(corpses) and NPC.IsEntityInRange(neutralNPC, corpses, 550) then
										corpseCheck = true
										break
									end
								end
							if corpseCheck then
								Ability.CastNoTarget(neutralAbility)
								Ability.CastNoTarget(neutralAbility)
								FAIO_creepControl.ControllableActionTable[Entity.GetIndex(neutralNPC)] = { time = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25, order = Ability.GetName(neutralAbility), target = target, recurring = os.clock() + Ability.GetCastPoint(neutralAbility) + 0.25 }
								FAIO_creepControl.mainTick = os.clock()
								return
							end
						end
					end
				end
			end
		end
	end

	if os.clock() > FAIO_creepControl.mainTick + math.max(0.45, (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000)) then
		FAIO_creepControl.selectControllableUnits(myHero, FAIO_creepControl.ControllableEntityTable)
		if Player.GetSelectedUnits(Players.GetLocal())[1] ~= myHero then
			if os.clock() > FAIO_creepControl.cycleTick + (Menu.GetValue(FAIO_options.optionCreepControlDelay)/1000) then
				Engine.ExecuteCommand("dota_cycle_selected")
				FAIO_creepControl.cycleTick = os.clock()
				return
			end
		end
	end

	return

end

function FAIO_creepControl.controllableActionTracker(source, time, order, target, delay)

	if not source then return false end
	if not time then return false end
	if not order then return false end
	if not target then return false end

	local timing = delay
		if timing == nil then
			timing = 0
		end

	if os.clock() < FAIO_creepControl.mainTick + timing then
		return false
	end

	if next(FAIO_creepControl.ControllableActionTable) == nil then return false end

	local index = Entity.GetIndex(source)

	local lastTime = FAIO_creepControl.ControllableActionTable[index]["time"]
	local lastOrder = FAIO_creepControl.ControllableActionTable[index]["order"]
	local lastTarget = FAIO_creepControl.ControllableActionTable[index]["target"]

	if os.clock() < lastTime + timing then
		return false
	end

	if lastOrder == order and lastTarget == target then
		if order ~= "attack" then
			if os.clock() > lastTime + 1 then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	if order == "attack" and lastOrder ~= "attack" and lastTarget == target then
		local attackRange = NPC.GetAttackRange(source)
		if NPC.IsEntityInRange(source, target, attackRange) then
			return false
		end
	end

	return true

end

function FAIO_creepControl.OnPrepareUnitOrders(orders)

	if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION or orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET then
		FAIO_creepControl.ControllableActionTable = {}
		return true
	end

	return true

end

function FAIO_creepControl.GetControllableEntities(myHero)

	if not myHero then return end

	for i = 1, NPCs.Count() do 
		local npc = NPCs.Get(i)
		if Entity.IsNPC(npc) and Entity.IsAlive(npc) and Entity.IsSameTeam(myHero, npc) then
			if npc ~= myHero and Entity.GetOwner(npc) == Entity.GetOwner(myHero) or Entity.OwnedBy(myHero, npc) or Entity.OwnedBy(npc, myHero) then
				local entityClass = Entity.GetClassName(npc)
				if entityClass ~= "CDOTA_Unit_Hero_ArcWarden" and entityClass ~= "C_DOTA_Unit_VisageFamiliar" then
					if FAIO_utility_functions.utilityIsInTable(FAIO_creepControl.ControllableEntityTable, npc) == false then
						table.insert(FAIO_creepControl.ControllableEntityTable, npc)
					end
				end
			end
		end
	end

	if next(FAIO_creepControl.ControllableEntityTable) == nil then
		if #Player.GetSelectedUnits(Players.GetLocal()) > 1 then
			local check = false
				for i, v in ipairs(Player.GetSelectedUnits(Players.GetLocal())) do
					local entityClass = Entity.GetClassName(v)
					if v ~= myHero then
						if entityClass == "CDOTA_Unit_Hero_ArcWarden" or entityClass == "C_DOTA_Unit_VisageFamiliar" then
							check = true
						end
					end
				end

			if not check then
				Player.ClearSelectedUnits(Players.GetLocal())
				return
			end

		else
			return
		end
	end

	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
		if not Entity.IsNPC(v) then
			table.remove(FAIO_creepControl.ControllableEntityTable, i)
		elseif not Entity.IsAlive(v) then
			table.remove(FAIO_creepControl.ControllableEntityTable, i)
		elseif not Entity.IsSameTeam(myHero, v) then
			table.remove(FAIO_creepControl.ControllableEntityTable, i)
		end
	end

	return

end

function FAIO_creepControl.createActionTable(myHero)

	if not myHero then return end

	for i, v in ipairs(FAIO_creepControl.ControllableEntityTable) do
		local index = Entity.GetIndex(v)
		if FAIO_creepControl.ControllableActionTable[index] == nil then
			FAIO_creepControl.ControllableActionTable[index] = { time = 0, order = nil, target = nil, recurring = 0 }
		end
		if not NPC.IsAttacking(v) then
			if not NPC.IsRunning(v) then
				if os.clock() > FAIO_creepControl.ControllableActionTable[index]["time"] + 0.55 then
					if FAIO_creepControl.ControllableActionTable[index]["recurring"] > FAIO_creepControl.ControllableActionTable[index]["time"] then
						if os.clock() > FAIO_creepControl.ControllableActionTable[index]["recurring"] + NPC.GetAttackTime(v) + 0.25 then
							FAIO_creepControl.ControllableActionTable[index] = { time = 0, order = nil, target = nil, recurring = 0 }
						end
					end
				end
			else
				FAIO_creepControl.ControllableActionTable[index]["recurring"] = os.clock()
			end
		else
			FAIO_creepControl.ControllableActionTable[index]["recurring"] = os.clock()
		end	
	end

	for i, v in pairs(FAIO_creepControl.ControllableActionTable) do
		local check = false
			for k, l in ipairs(FAIO_creepControl.ControllableEntityTable) do
				local index = Entity.GetIndex(l)
				if i == index then
					check = true
				end
			end
		if not check then
			FAIO_creepControl.ControllableActionTable[i] = nil
		end
	end

end

function FAIO_creepControl.selectControllableUnits(myHero, units)

	if not myHero then return end
	if not units then return end

	local selectTable = {}
		if type(units) == "table" then
			selectTable = units
		else
			selectTable = { units }
		end

	local selectedUnits = Player.GetSelectedUnits(Players.GetLocal())
		
	for i = 1, #selectTable do
		if FAIO_utility_functions.utilityIsInTable(selectedUnits, selectTable[i]) == false then
			Player.AddSelectedUnit(Players.GetLocal(), selectTable[i])
		end
	end
	if FAIO_utility_functions.utilityIsInTable(selectedUnits, myHero) == false then
		Player.AddSelectedUnit(Players.GetLocal(), myHero)
	end

	return

end

return FAIO_creepControl