FAIO_utility_functions = {}

function FAIO_utility_functions.utilityRoundNumber(number, digits)

	if not number then return end

  	local mult = 10^(digits or 0)
  	return math.floor(number * mult + 0.5) / mult

end

function FAIO_utility_functions.utilityGetTableLength(table)

	if not table then return 0 end
	if next(table) == nil then return 0 end

	local count = 0
	for i, v in pairs(table) do
		count = count + 1
	end

	return count

end

function FAIO_utility_functions.utilityIsInTable(table, arg)

	if not table then return false end
	if not arg then return false end
	if next(table) == nil then return false end

	for i, v in pairs(table) do
		if i == arg then
			return true
		end
		if type(v) ~= 'table' and v == arg then
			return true
		end
	end

	return false

end

function FAIO_utility_functions.castLinearPrediction(myHero, enemy, adjustmentVariable)

	if not myHero then return end
	if not enemy then return end

	local enemyRotation = Entity.GetRotation(enemy):GetVectors()
		enemyRotation:SetZ(0)
    	local enemyOrigin = NPC.GetAbsOrigin(enemy)
		enemyOrigin:SetZ(0)


	local cosGamma = (NPC.GetAbsOrigin(myHero) - enemyOrigin):Dot2D(enemyRotation:Scaled(100)) / ((NPC.GetAbsOrigin(myHero) - enemyOrigin):Length2D() * enemyRotation:Scaled(100):Length2D())

		if enemyRotation and enemyOrigin then
			if not NPC.IsRunning(enemy) then
				return enemyOrigin
			else return enemyOrigin:__add(enemyRotation:Normalized():Scaled(FAIO_utility_functions.GetMoveSpeed(enemy) * adjustmentVariable * (1 - cosGamma)))
			end
		end
end

function FAIO_utility_functions.castPrediction(myHero, enemy, adjustmentVariable)

	if not myHero then return end
	if not enemy then return end

	local enemyRotation = Entity.GetRotation(enemy):GetVectors()
		enemyRotation:SetZ(0)
    	local enemyOrigin = NPC.GetAbsOrigin(enemy)
		enemyOrigin:SetZ(0)

	if enemyRotation and enemyOrigin then
			if not NPC.IsRunning(enemy) then
				return enemyOrigin
			else return enemyOrigin:__add(enemyRotation:Normalized():Scaled(FAIO_utility_functions.GetMoveSpeed(enemy) * adjustmentVariable))
			end
	end
end

function FAIO_utility_functions.isEnemyTurning(enemy)

	if enemy == nil then return true end
	if not NPC.IsRunning(enemy) then return true end

	local rotationSpeed = Entity.GetAngVelocity(enemy):Length2D()
	if NPC.IsRunning(enemy) then
		table.insert(FAIO_utility_functions.rotationTable, rotationSpeed)
			if #FAIO_utility_functions.rotationTable > (Menu.GetValue(FAIO_options.optionKillStealInvokerTurn) + 1) then
				table.remove(FAIO_utility_functions.rotationTable, 1)
			end
	end
	
	if #FAIO_utility_functions.rotationTable < Menu.GetValue(FAIO_options.optionKillStealInvokerTurn) then 
		return true
	else
		local rotationSpeedCounter = 0
		i = 1
		repeat
			rotationSpeedCounter = rotationSpeedCounter + FAIO_utility_functions.rotationTable[#FAIO_utility_functions.rotationTable + 1 - i]
			i = i + 1
		until i > Menu.GetValue(FAIO_options.optionKillStealInvokerTurn)

		if rotationSpeedCounter / Menu.GetValue(FAIO_options.optionKillStealInvokerTurn) <= 10 then
			return false
		else
			return true
		end
	end
 
end

function FAIO_utility_functions.GetMoveSpeed(enemy)

	if not enemy then return end

	local base_speed = NPC.GetBaseSpeed(enemy)
	local bonus_speed = NPC.GetMoveSpeed(enemy) - NPC.GetBaseSpeed(enemy)
	local modifierHex
    	local modSheep = NPC.GetModifier(enemy, "modifier_sheepstick_debuff")
    	local modLionVoodoo = NPC.GetModifier(enemy, "modifier_lion_voodoo")
    	local modShamanVoodoo = NPC.GetModifier(enemy, "modifier_shadow_shaman_voodoo")

	if modSheep then
		modifierHex = modSheep
	end
	if modLionVoodoo then
		modifierHex = modLionVoodoo
	end
	if modShamanVoodoo then
		modifierHex = modShamanVoodoo
	end

	if modifierHex then
		if math.max(Modifier.GetDieTime(modifierHex) - GameRules.GetGameTime(), 0) > 0 then
			return 140 + bonus_speed
		end
	end

    	if NPC.HasModifier(enemy, "modifier_invoker_ice_wall_slow_debuff") then 
		return 100 
	end

	if NPC.HasModifier(enemy, "modifier_invoker_cold_snap_freeze") or NPC.HasModifier(enemy, "modifier_invoker_cold_snap") then
		return (base_speed + bonus_speed) * 0.5
	end

	if NPC.HasModifier(enemy, "modifier_spirit_breaker_charge_of_darkness") then
		local chargeAbility = NPC.GetAbility(enemy, "spirit_breaker_charge_of_darkness")
		if chargeAbility then
			local specialAbility = NPC.GetAbility(enemy, "special_bonus_unique_spirit_breaker_2")
			if specialAbility then
				 if Ability.GetLevel(specialAbility) < 1 then
					return Ability.GetLevel(chargeAbility) * 50 + 550
				else
					return Ability.GetLevel(chargeAbility) * 50 + 1050
				end
			end
		end
	end
			
    	return base_speed + bonus_speed
end

function FAIO_utility_functions.getBestPosition(unitsAround, radius)

	if not unitsAround or #unitsAround < 1 then
		return 
	end

	local countEnemies = #unitsAround

	if countEnemies == 1 then 
		return Entity.GetAbsOrigin(unitsAround[1]) 
	end

	return FAIO_utility_functions.getMidPoint(unitsAround)



end

function FAIO_utility_functions.getMidPoint(entityList)

	if not entityList then return end
	if #entityList < 1 then return end

	local pts = {}
		for i, v in ipairs(entityList) do
			if v and not Entity.IsDormant(v) then
				local pos = Entity.GetAbsOrigin(v)
				local posX = pos:GetX()
				local posY = pos:GetY()
				table.insert(pts, { x=posX, y=posY })
			end
		end
	
	local x, y, c = 0, 0, #pts

		if (pts.numChildren and pts.numChildren > 0) then c = pts.numChildren end

	for i = 1, c do

		x = x + pts[i].x
		y = y + pts[i].y

	end

	return Vector(x/c, y/c, 0)

end

function FAIO_utility_functions.GetMyFaction(myHero)

	if not myHero then return end
	
	local radiantFountain = Vector(-7600, -7300, 640)
	local direFountain = Vector(7800, 7250, 640)
	
	local myFountain
	if myFountain == nil then
		for i = 1, NPCs.Count() do 
		local npc = NPCs.Get(i)
    			if Entity.IsSameTeam(myHero, npc) and NPC.IsStructure(npc) then
    				if NPC.GetUnitName(npc) ~= nil then
        				if NPC.GetUnitName(npc) == "dota_fountain" then
						myFountain = npc
					end
				end
			end
		end
	end

	local myFaction
	if myFaction == nil and myFountain ~= nil then
		if NPC.IsPositionInRange(myFountain, radiantFountain, 1000, 0) then
			myFaction = "radiant"
		else myFaction = "dire"
		end
	end

	return myFaction

end

function FAIO_utility_functions.GetMyFountainPos(myHero)

	if not myHero then return end

	local myFaction 
		if myFaction == nil then 
			myFaction = FAIO_utility_functions.GetMyFaction(myHero)
		end

	local myFountainPos
	if myFaction ~= nil then
		if myFaction == "radiant" then
			myFountainPos = Vector(-7600, -7300, 640)
		else 
			myFountainPos = Vector(7800, 7250, 640)
		end
	end

	return myFountainPos

end

function FAIO_utility_functions.GetEnemyFountainPos(myHero)

	if not myHero then return end

	local myFaction
		if myFaction == nil then 
			myFaction = FAIO_utility_functions.GetMyFaction(myHero)
		end

	local enemyFountainPos
	if myFaction ~= nil then
		if myFaction == "radiant" then
			enemyFountainPos = Vector(7800, 7250, 640)
		else 
			enemyFountainPos = Vector(-7600, -7300, 640)
		end
	end

	return enemyFountainPos

end

function FAIO_utility_functions.IsCreepAncient(npc)

	if not npc then return false end

	ancientNameList = { 
		"npc_dota_neutral_black_drake",
    		"npc_dota_neutral_black_dragon",
    		"npc_dota_neutral_blue_dragonspawn_sorcerer",
    		"npc_dota_neutral_blue_dragonspawn_overseer",
    		"npc_dota_neutral_granite_golem",
    		"npc_dota_neutral_elder_jungle_stalker",
    		"npc_dota_neutral_prowler_acolyte",
    		"npc_dota_neutral_prowler_shaman",
    		"npc_dota_neutral_rock_golem",
    		"npc_dota_neutral_small_thunder_lizard",
    		"npc_dota_neutral_jungle_stalker",
    		"npc_dota_neutral_big_thunder_lizard",
    		"npc_dota_roshan" }

	for _, creepName in ipairs(ancientNameList) do
		if creepName and NPC.GetUnitName(npc) ~= nil then
			if NPC.GetUnitName(npc) == creepName then
				return true
			end
		end
	end

	return false

end

function FAIO_utility_functions.inSkillAnimation(myHero)

	if not myHero then return false end

	local abilities = {}

	if next(abilities) == nil then
		for i = 0, 25 do
			local ability = NPC.GetAbilityByIndex(myHero, i)
			if ability and Entity.IsAbility(ability) then
				table.insert(abilities, ability)
			end
		end
	end

	for i, v in ipairs(abilities) do
		if Ability.IsInAbilityPhase(v) then
			return true
		end
	end

	return false

end

------ bis hier angepasst

return FAIO_utility_functions