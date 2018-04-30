FAIO_dodgeIT = {}

FAIO_dodgeIT.dodgeTiming = 0
FAIO_dodgeIT.dodgerProjectileAdjustmentTick = 0
FAIO_dodgeIT.saverTiming = 0

FAIO_dodgeIT.dodgeItTable = {}
FAIO_dodgeIT.dodgeItReadyTable = {}
FAIO_dodgeIT.dodgeItSkillReady = {}

function FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange)

	if not myHero then return false end
	if not unit then return false end

	local angle = Entity.GetRotation(unit)

	local direction = angle:GetForward()
    	local name = NPC.GetUnitName(unit)
    		direction:SetZ(0)

    	local origin = NPC.GetAbsOrigin(unit)

	if radius == 0 then
		radius = 100
	end

    	local pointsNum = math.floor(castrange/50) + 1
    	for i = pointsNum,1,-1 do 
        	direction:Normalize()
        	direction:Scale(50*(i-1))
        	local pos = origin + direction
        	if NPC.IsPositionInRange(myHero, pos, radius + NPC.GetHullRadius(myHero), 0) then 
            		return true 
        	end
    	end 
    	return false

end

function FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)

	if not myHero then return end
	if not unit then return end

	local angle = Entity.GetRotation(unit)

	local direction = angle:GetForward()
    		direction:SetZ(0)

    	local origin = NPC.GetAbsOrigin(unit)

	if radius == 0 then
		radius = 100
	end

	local alliesAround = Entity.GetHeroesInRadius(unit, radius + castrange, Enum.TeamType.TEAM_ENEMY)
		if #alliesAround < 1 then return end

	local pointsNum = math.floor(castrange/50) + 1
	
	local targetAlly = nil
	local facing = 99999
	local lowest = 99999
	for i, v in ipairs(alliesAround) do
		if v and Entity.IsHero(v) and Entity.IsAlive(v) and v ~= myHero then
			if NPC.IsEntityInRange(unit, v, radius + castrange) and NPC.IsEntityInRange(myHero, v, 885) then
				if castrange > 1 then
					if NPC.GetTimeToFace(unit, v) < facing then
						facing = NPC.GetTimeToFace(unit, v)
						targetAlly = v
					end
				else
					if Entity.GetHealth(v) < lowest then
						lowest = Entity.GetHealth(v)
						targetAlly = v
					end
				end	
			end
		end
	end	

	return targetAlly

end

function FAIO_dodgeIT.dodgerEmberSkillsChecker(myHero, skillName)

	if not myHero then return false end
	if not skillName then return false end

	if skillName == "ember_spirit_sleight_of_fist" then
		local effectRange = Ability.GetLevel(NPC.GetAbility(myHero, "ember_spirit_sleight_of_fist")) * 100 + 150
		for i = 0, math.floor(700 / effectRange) do
			if #NPCs.InRadius(Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(i * effectRange), effectRange, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) > 0 then
				return true
			end
		end
	end

	if skillName == "ember_spirit_activate_fire_remnant" then
		if NPC.HasModifier(myHero, "modifier_ember_spirit_fire_remnant_timer") then
			return true
		end
	end

	return false

end

function FAIO_dodgeIT.saveIt(info)

	local myHero = Heroes.GetLocal()
		if not myHero then return end
		if not Entity.IsAlive(myHero) then return end
	
	if not info then return end

	if not Menu.IsEnabled(FAIO_options.optionDefensiveItemsSaver) then return end

	local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)
	local lotus = NPC.GetItem(myHero, "item_lotus_orb", true)
	local myMana = NPC.GetMana(myHero)

	local itemCheck = glimmer or lotus or nil
		if not itemCheck then return end

	if glimmer then
		if not Ability.IsCastable(glimmer, myMana) then
			if lotus then
				if not Ability.IsCastable(lotus, myMana) then
					return
				end
			else
				return
			end
		end
	else
		if lotus then
			if not Ability.IsCastable(lotus, myMana) then
				return
			end
		else
			return
		end
	end

	if info.target and Entity.IsHero(info.target) and Entity.IsAlive(info.target) then
		if info.lotus == 1 and NPC.IsLinkensProtected(info.target) then return end
		if info.lotus == 1 and NPC.HasModifier(info.target, "modifier_item_lotus_orb_active") then return end
		if info.style == 2 and NPC.HasState(info.target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end
		if NPC.HasModifier(info.target, "modifier_item_glimmer_cape_fade") then return end
		if NPC.HasModifier(info.target, "modifier_templar_assassin_refraction_absorb") then return end
	end

	if os.clock() - FAIO_dodgeIT.saverTiming < 0.5 then return end

	local curTime = GameRules.GetGameTime()

	local saveObject
		if lotus then
			if Ability.IsCastable(lotus, myMana) then
				if info.lotus == 0 then
					if glimmer then
						if Ability.IsCastable(glimmer, myMana) then
							saveObject = glimmer
						else
							saveObject = nil
						end
					else
						saveObject = nil
					end
				else
					saveObject = lotus
				end
			else
				if glimmer then
					if Ability.IsCastable(glimmer, myMana) then
						saveObject = glimmer
					else
						saveObject = nil
					end
				else
					saveObject = nil
				end
			end
		else
			if glimmer then
				if Ability.IsCastable(glimmer, myMana) then
					saveObject = glimmer
				else
					saveObject = nil
				end
			else
				saveObject = nil
			end
		end
	
	if saveObject == nil then return end		

	local target = info.target

	if target and Entity.IsHero(target) and NPC.IsEntityInRange(myHero, target, 895) then
		Ability.CastTarget(saveObject, target)
		FAIO_dodgeIT.saverTiming = os.clock()
		FAIO_dodgeIT.lastDefItemPop = os.clock()
		return
	end

end

function FAIO_dodgeIT.dodgeIt(info)

	local myHero = Heroes.GetLocal()
		if not myHero then return end
		if not Entity.IsAlive(myHero) then return end
	
	if not info then return end

	if next(FAIO_dodgeIT.dodgeItReadyTable) == nil then return end

	if not Menu.IsEnabled(FAIO_options.dodgeEnemySkillsOptionsTable[info.spellname]) then return end

	local myMana = NPC.GetMana(myHero)	

	local dodgeSelector
	local dodgeItemStyle
	local dodgeTargeting
	local dodgeTiming

	if next(FAIO_dodgeIT.dodgeItSkillReady) ~= nil then
		if NPC.HasAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"]) then
			if Ability.IsReady(NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"])) and Ability.IsCastable(NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"]), myMana) then
				if FAIO_dodgeIT.dodgeItSkillReady[1]["skillstyle"] <= info.style then
					if FAIO_dodgeIT.dodgeItSkillReady[1]["skilloffset"] < info.delay then
						if FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"] == "slark_dark_pact" then
							if info.type == "disable" then
								dodgeSelector = NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"])
								dodgeItemStyle = FAIO_dodgeIT.dodgeItSkillReady[1]["skillstyle"]
								dodgeTargeting = FAIO_dodgeIT.dodgeItSkillReady[1]["skilltargeting"]
								dodgeTiming = FAIO_dodgeIT.dodgeItSkillReady[1]["skilloffset"]
							end
						else
							dodgeSelector = NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[1]["skillname"])
							dodgeItemStyle = FAIO_dodgeIT.dodgeItSkillReady[1]["skillstyle"]
							dodgeTargeting = FAIO_dodgeIT.dodgeItSkillReady[1]["skilltargeting"]
							dodgeTiming = FAIO_dodgeIT.dodgeItSkillReady[1]["skilloffset"]
						end
					end
				end
			end
		end
		if #FAIO_dodgeIT.dodgeItSkillReady > 1 then
			if dodgeSelector == nil then
				if NPC.HasAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[2]["skillname"]) then
					if Ability.IsReady(NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[2]["skillname"])) and Ability.IsCastable(NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[2]["skillname"]), myMana) then
						if FAIO_dodgeIT.dodgeItSkillReady[2]["skillstyle"] <= info.style then
							if FAIO_dodgeIT.dodgeItSkillReady[2]["skilloffset"] < info.delay then
								dodgeSelector = NPC.GetAbility(myHero, FAIO_dodgeIT.dodgeItSkillReady[2]["skillname"])
								dodgeItemStyle = FAIO_dodgeIT.dodgeItSkillReady[2]["skillstyle"]
								dodgeTargeting = FAIO_dodgeIT.dodgeItSkillReady[2]["skilltargeting"]
								dodgeTiming = FAIO_dodgeIT.dodgeItSkillReady[2]["skilloffset"]
							end
						end
					end
				end
			end
		end		
	end

	if dodgeSelector ~= nil and Ability.GetName(dodgeSelector) == "ember_spirit_sleight_of_fist" then
		if not FAIO_dodgeIT.dodgerEmberSkillsChecker(myHero, "ember_spirit_sleight_of_fist") then
			dodgeSelector = nil
		end
	end

	if dodgeSelector == nil then
		for i, v in ipairs(FAIO_dodgeIT.dodgeItReadyTable) do
			if info.lotus == 0 then
				if info.global == 0 then
					if v.itemname ~= "item_lotus_orb" then
						if (NPC.GetUnitName(info.source) == "npc_dota_hero_lion" and info.style == 1) or NPC.GetUnitName(info.source) == "npc_dota_hero_nyx_assassin" or NPC.GetUnitName(info.source) == "npc_dota_hero_tidehunter" then
							if v.itemname ~= "item_manta" then
								if v.itemstyle <= info.style then
									if NPC.HasItem(myHero, v.itemname) then
										if Ability.IsReady(NPC.GetItem(myHero, v.itemname)) and Ability.IsCastable(NPC.GetItem(myHero, v.itemname), myMana) then
											dodgeSelector = NPC.GetItem(myHero, v.itemname, true)
											dodgeItemStyle = v.itemstyle
											dodgeTargeting = v.itemtargeting
											dodgeTiming = v.itemoffset
											break
										end
									end
								end
							end

						else
							if v.itemstyle <= info.style then
								if NPC.HasItem(myHero, v.itemname) then
									if Ability.IsReady(NPC.GetItem(myHero, v.itemname)) and Ability.IsCastable(NPC.GetItem(myHero, v.itemname), myMana) then
										dodgeSelector = NPC.GetItem(myHero, v.itemname, true)
										dodgeItemStyle = v.itemstyle
										dodgeTargeting = v.itemtargeting
										dodgeTiming = v.itemoffset
										break
									end
								end
							end
						end
					end
				else
					if v.itemname ~= "item_blink" then
						if v.itemstyle <= info.style then
							if NPC.HasItem(myHero, v.itemname) then
								if Ability.IsReady(NPC.GetItem(myHero, v.itemname)) and Ability.IsCastable(NPC.GetItem(myHero, v.itemname), myMana) then
									dodgeSelector = NPC.GetItem(myHero, v.itemname, true)
									dodgeItemStyle = v.itemstyle
									dodgeTargeting = v.itemtargeting
									dodgeTiming = v.itemoffset
									break
								end
							end
						end
					end
				end			
			else
				if v.itemstyle <= info.style then
					if NPC.HasItem(myHero, v.itemname) then
						if Ability.IsReady(NPC.GetItem(myHero, v.itemname)) and Ability.IsCastable(NPC.GetItem(myHero, v.itemname), myMana) then
							dodgeSelector = NPC.GetItem(myHero, v.itemname, true)
							dodgeItemStyle = v.itemstyle
							dodgeTargeting = v.itemtargeting
							dodgeTiming = v.itemoffset
							break
						end
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_ember_spirit" and dodgeSelector == nil then
		if Menu.IsEnabled(FAIO_dodgeIT.dodgeEnemyHeroSpecialEmber) then
			if FAIO_dodgeIT.dodgerEmberSkillsChecker(myHero, "ember_spirit_activate_fire_remnant") then
				dodgeSelector = NPC.GetAbility(myHero, "ember_spirit_activate_fire_remnant")
				dodgeItemStyle = 0
				dodgeTargeting = "position"
				dodgeTiming = 0.1
			end
		end
	end		

	if dodgeSelector == nil then 
		return
	end


	local delay = info.delay
		if NPC.GetUnitName(info.source) == "npc_dota_hero_lina" then
			if Ability.GetName(dodgeSelector) == "item_blink" or Ability.GetName(dodgeSelector) == "item_lotus_orb" or Ability.GetName(dodgeSelector) == "nyx_assassin_spiked_carapace" or Ability.GetName(dodgeSelector) == "sandking_sand_storm" or Ability.GetName(dodgeSelector) == "templar_assassin_meld" then
				delay = info.delay - 0.225
			end
		elseif NPC.GetUnitName(info.source) == "npc_dota_hero_lion" and info.spellname == "lion_finger_of_death" then
			if Ability.GetName(dodgeSelector) == "item_blink" or Ability.GetName(dodgeSelector) == "item_lotus_orb" or Ability.GetName(dodgeSelector) == "nyx_assassin_spiked_carapace" or Ability.GetName(dodgeSelector) == "sandking_sand_storm" or Ability.GetName(dodgeSelector) == "templar_assassin_meld" then
				delay = info.delay - 0.275
			end
		end

	if info.time + delay - dodgeTiming + 0.05 < GameRules.GetGameTime() then return end

	if info.lotus == 1 and NPC.IsLinkensProtected(myHero) then return end
	if info.lotus == 1 and NPC.HasModifier(myHero, "modifier_item_lotus_orb_active") then return end
	if info.style == 2 and NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end
	if NPC.HasModifier(myHero, "modifier_item_glimmer_cape_fade") then return end
	if NPC.HasModifier(myHero, "modifier_templar_assassin_refraction_absorb") then return end
	if NPC.HasModifier(myHero, "modifier_item_blade_mail_reflect") then return end
	if NPC.HasModifier(myHero, "modifier_item_hurricane_pike_range") then return end
	
	if NPC.HasItem(myHero, "item_blade_mail", true) and Menu.IsEnabled(FAIO_options.optionItemBlademail) and Ability.IsCastable(NPC.GetItem(myHero, "item_blade_mail", true), myMana) then return end
	if NPC.HasItem(myHero, "item_hurricane_pike", true) and Menu.IsEnabled(FAIO_options.optionItemHurricane) and Ability.IsCastable(NPC.GetItem(myHero, "item_hurricane_pike", true), myMana) then return end

	if NPC.HasItem(myHero, "item_blade_mail", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_blade_mail", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_blade_mail", true)) < 0.25 then return end
	if NPC.HasItem(myHero, "item_hurricane_pike", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_hurricane_pike", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_hurricane_pike", true)) < 0.25 then return end
	
	local projectilespeed = 0
		if info.projectilespeed ~= nil then
			projectilespeed = info.projectilespeed
		end

	local projectileextradelay = 0
		if info.projectileextradelay ~= nil then
			projectileextradelay = info.projectileextradelay
		end

	if next(FAIO_dodgeIT.dodgeItTable) == nil then
		table.insert(FAIO_dodgeIT.dodgeItTable, {casttime = info.time, delay = delay, unit = info.source, dodgeobject = dodgeSelector, objecttargeting = dodgeTargeting, objectoffset = dodgeTiming, castpoint = info.castpoint, spellname = info.spellname, originpos = Entity.GetAbsOrigin(info.source), projectilespeed = projectilespeed, projectileextradelay = projectileextradelay})
	end

end

function FAIO_dodgeIT.dodgerSkillAvailable(myHero)

	if not myHero then return end

	if next(FAIO_dodgeIT.dodgeItSkillReady) == nil then

		for i = 1, #FAIO_data.dodgeItSkills do
			if NPC.HasAbility(myHero, FAIO_data.dodgeItSkills[i][1]) then
				if Menu.IsEnabled(FAIO_dodgeIT.dodgeEnemyHeroskillsOptionsTable[FAIO_data.dodgeItSkills[i][1]]) then
					if Ability.GetLevel(NPC.GetAbility(myHero, FAIO_data.dodgeItSkills[i][1])) > 0 then
						table.insert(FAIO_dodgeIT.dodgeItSkillReady, {skillname = FAIO_data.dodgeItSkills[i][1], skillstyle = FAIO_data.dodgeItSkills[i][2], skilltargeting = FAIO_data.dodgeItSkills[i][3], skilloffset = FAIO_data.dodgeItSkills[i][4] })
					end
				end
			end
		end
	end

end
				
function FAIO_dodgeIT.dodgerSelectItemorSkill(myHero)

	if not myHero then return end

	if next(FAIO_dodgeIT.dodgeItReadyTable) == nil then

		for i = 1, #FAIO_data.dodgeItItems do
			if Menu.GetValue(FAIO_options.dodgeItOptionTable[i]) > 0 then
				table.insert(FAIO_dodgeIT.dodgeItReadyTable, { prio = Menu.GetValue(FAIO_options.dodgeItOptionTable[i]), itemname = FAIO_data.dodgeItItems[i][1], itemstyle = FAIO_data.dodgeItItems[i][2], itemtargeting = FAIO_data.dodgeItItems[i][3], itemoffset = FAIO_data.dodgeItItems[i][4] })
			end
		end
	end

	table.sort(FAIO_dodgeIT.dodgeItReadyTable, function(a, b)
       		return a.prio < b.prio
    	end)

end

function FAIO_dodgeIT.dodgerRangeOffsetter(myHero, enemy, dodgeSkillName, attackSkillName)

	if not myHero then return end

	if not dodgeSkillName and not attackSkillName then 
		return 
	end

	if dodgeSkillName == "item_blink" then 
		return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(1150)
	end

	local maxRange = 1000
		if dodgeSkillName == "morphling_waveform" then
			maxRange = 990
		elseif dodgeSkillName == "phantom_lancer_doppelwalk" then
			maxRange = 590
		elseif dodgeSkillName == "faceless_void_time_walk" then
			maxRange = 670
		elseif dodgeSkillName == "ember_spirit_sleight_of_fist" then
			maxRange = 690
		end

	local minRange = 190
		if dodgeSkillName == "morphling_waveform" or dodgeSkillName == "faceless_void_time_walk" then
			minRange = maxRange
		end


	if dodgeSkillName ~= "ember_spirit_sleight_of_fist" then
		if attackSkillName == "enigma_black_hole" or attackSkillName == "faceless_void_chronosphere" then
			return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(590)
		elseif attackSkillName == "lion_impale" or attackSkillName == "nyx_assassin_impale" or spellname == "pudge_dismember" then
			return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(350)
		elseif attackSkillName == "queenofpain_sonic_wave" or attackSkillName == "tidehunter_ravage" then
			return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(maxRange)
		else
			return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(minRange)
		end
	else
		local effectRange = Ability.GetLevel(NPC.GetAbility(myHero, "ember_spirit_sleight_of_fist")) * 100 + 150 - 1
		for i = 0, math.ceil(maxRange / effectRange) do
			if #NPCs.InRadius(Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(i * effectRange), effectRange, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) > 0 then
				return Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(i * effectRange + 1)
			end
		end
	end

end

function FAIO_dodgeIT.dodgerProjectileTimingAdjuster(myHero)

	if not myHero then return end

	if next(FAIO_dodgeIT.dodgeItTable) == nil then return end

	if os.clock() - FAIO_dodgeIT.dodgerProjectileAdjustmentTick < 0.05 then return end

	for i, info in pairs(FAIO_dodgeIT.dodgeItTable) do
		if info.delay > info.castpoint then
			if info.spellname ~= "lion_finger_of_death" and info.spellname ~= "lina_laguna_blade" then
				local originPos = info.originpos
				local myHullSize = NPC.GetHullRadius(myHero)
				local projectileStart = info.casttime + info.castpoint
				local projectileSpeed = info.projectilespeed
				local timeElapsed = math.max((GameRules.GetGameTime() - projectileStart), 0)
				local projectilePos = originPos + (Entity.GetAbsOrigin(myHero) - originPos):Normalized():Scaled(timeElapsed*projectileSpeed)
				local myDisToOrigin = (Entity.GetAbsOrigin(myHero) - originPos):Length2D() - myHullSize
				local projectilDisToOrigin = (projectilePos - originPos):Length2D()
				local myDisToProjectile = (Entity.GetAbsOrigin(myHero) - projectilePos):Length2D() 
				if projectilDisToOrigin < myDisToOrigin then
					if myDisToProjectile > 100 and timeElapsed > 0 then
						local remainingTravelTime = ((Entity.GetAbsOrigin(myHero) - projectilePos):Length2D() - myHullSize) / projectileSpeed
						local adjustedDelay = math.max(info.projectileextradelay, 0.034)
							if info.projectileextradelay < 0 then
								adjustedDelay = info.projectileextradelay
							end
						local processImpactTime = info.castpoint + timeElapsed + remainingTravelTime - adjustedDelay
						if math.abs(info.delay - processImpactTime) > 0.015 then
							if FAIO_dodgeIT.dodgeItTable[i] ~= nil then
								FAIO_dodgeIT.dodgeItTable[i]["delay"] = processImpactTime
								FAIO_dodgeIT.dodgerProjectileAdjustmentTick = os.clock()
							end
						end
					end
				else
					FAIO_dodgeIT.dodgeItTable[i] = nil
				end
			end
		end
	end			

end

function FAIO_dodgeIT.dodger(myHero)

	if not myHero then return end

	local myMana = NPC.GetMana(myHero)

	if next(FAIO_dodgeIT.dodgeItTable) == nil then
		for i = 1, Heroes.Count() do
			local enemy = Heroes.Get(i)
			if enemy and Entity.IsHero(enemy) and not Entity.IsSameTeam(myHero, enemy) and not Entity.IsDormant(enemy) and (NPC.GetUnitName(enemy) == "npc_dota_hero_axe" or NPC.GetUnitName(enemy) == "npc_dota_hero_sand_king") and not NPC.IsIllusion(enemy) then
				if Entity.IsAlive(enemy) then
					local axe_call = NPC.GetAbility(enemy, "axe_berserkers_call")
					local call_range = 300
					if axe_call and Ability.IsInAbilityPhase(axe_call) and NPC.IsEntityInRange(myHero, enemy, call_range) then
						FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = 0.4; style = 1; source = enemy, lotus = 0, castpoint = 0.4, spellname = "axe_berserkers_call", global = 0, type = "disable"})
						break
						return
					end
					local burrowStrike = NPC.GetAbility(enemy, "sandking_burrowstrike")
					local burrowRange = 650
					local hitRange = 175
						if NPC.HasItem(enemy, "item_ultimate_scepter", true) or NPC.HasModifier(enemy, "modifier_item_ultimate_scepter_consumed") then
							burrowRange = 1300
						end
					if NPC.HasModifier(enemy, "modifier_sandking_burrowstrike") then
						if FAIO_dodgeIT.dodgeIsTargetMe(myHero, enemy, hitRange, burrowRange) then
							FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = 0.05; style = 2; source = enemy, lotus = 1, castpoint = 0, spellname = "sandking_burrowstrike", global = 0, type = "disable"})
							break
							return
						else
							if NPC.IsEntityInRange(myHero, enemy, hitRange+burrowRange+885) then
								local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, enemy, hitRange, burrowRange)
								if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
									FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
								end
							end
						end
					end
				end
			end
		end
	end

	if next(FAIO_dodgeIT.dodgeItTable) == nil then
		if NPC.GetUnitName(myHero) == "npc_dota_hero_alchemist" then
			if NPC.HasModifier(myHero, "modifier_alchemist_unstable_concoction") then
				if Modifier.GetCreationTime(NPC.GetModifier(myHero, "modifier_alchemist_unstable_concoction")) + 5.5 - GameRules.GetGameTime() < 0.15 then
					FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = 0.15; style = 1; source = myHero, lotus = 0, castpoint = 0, spellname = "alchemist_unstable_concoction_throw", global = 0, type = "disable"})
					return
				end
			end
		end
	end

	if next(FAIO_dodgeIT.dodgeItTable) == nil then return end
	FAIO_dodgeIT.dodgerProjectileTimingAdjuster(myHero)
	local curTime = GameRules.GetGameTime()

	if not FAIO_dodgeIT.heroCanCastItems(myHero) then
		return
	end

	if os.clock() - FAIO_dodgeIT.dodgeTiming < 0.5 then return end

	local dodgeInfo = FAIO_dodgeIT.dodgeItTable[1]
		local casttime = dodgeInfo.casttime
		local delay = dodgeInfo.delay
		local unit = dodgeInfo.unit
		local castpoint = dodgeInfo.castpoint
		local spellname = dodgeInfo.spellname
		local dodgeobject = dodgeInfo.dodgeobject
		local objecttargeting = dodgeInfo.objecttargeting
		local objectoffset = dodgeInfo.objectoffset

		if curTime > casttime + delay + 0.05 then
			FAIO_dodgeIT.dodgeItTable = {}
			return
		end

	if NPC.GetUnitName(unit) == "npc_dota_hero_sniper" then
		if curTime >= casttime + delay - objectoffset - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
			if NPC.HasModifier(myHero, "modifier_sniper_assassinate") then
				if objecttargeting == "no target" then
					Ability.CastNoTarget(dodgeobject)
					FAIO_dodgeIT.dodgeTiming = os.clock()
					FAIO_dodgeIT.dodgeItTable = {}
					return
				elseif objecttargeting == "position" then
					if FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname) ~= nil then
						Ability.CastPosition(dodgeobject, FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname))
						FAIO_dodgeIT.dodgeTiming = os.clock()
						FAIO_dodgeIT.dodgeItTable = {}
						return
					end
				elseif objecttargeting == "target" then
					Ability.CastTarget(dodgeobject, myHero)
					FAIO_dodgeIT.dodgeTiming = os.clock()
					FAIO_dodgeIT.dodgeItTable = {}
					return
				end
			end
		end
	else	
		if unit and not Entity.IsDormant(unit) then
			if curTime >= casttime + castpoint - objectoffset - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
				if not Ability.IsInAbilityPhase(NPC.GetAbility(unit, spellname)) and castpoint > 0 then
					if delay > castpoint then
						if Ability.SecondsSinceLastUse(NPC.GetAbility(unit, spellname)) == -1 and spellname ~= "alchemist_unstable_concoction_throw" then
							FAIO_dodgeIT.dodgeItTable = {}
							return
						else
							if curTime >= casttime + delay - objectoffset - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then

								if objecttargeting == "no target" then
									Ability.CastNoTarget(dodgeobject)
									FAIO_dodgeIT.dodgeTiming = os.clock()
									FAIO_dodgeIT.dodgeItTable = {}
									return
								elseif objecttargeting == "position" then
									if FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname) ~= nil then
										Ability.CastPosition(dodgeobject, FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname))
										FAIO_dodgeIT.dodgeTiming = os.clock()
										FAIO_dodgeIT.dodgeItTable = {}
										return
									end
								elseif objecttargeting == "target" then
									Ability.CastTarget(dodgeobject, myHero)
									FAIO_dodgeIT.dodgeTiming = os.clock()
									FAIO_dodgeIT.dodgeItTable = {}
									return
								end
							end
						end
					else
						FAIO_dodgeIT.dodgeItTable = {}
						return
					end
				else
					if curTime >= casttime + delay - objectoffset - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
						if objecttargeting == "no target" then
							Ability.CastNoTarget(dodgeobject)
							FAIO_dodgeIT.dodgeTiming = os.clock()
							FAIO_dodgeIT.dodgeItTable = {}
							return
						elseif objecttargeting == "position" then
							if FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname) ~= nil then
								Ability.CastPosition(dodgeobject, FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname))
								FAIO_dodgeIT.dodgeTiming = os.clock()
								FAIO_dodgeIT.dodgeItTable = {}
								return
							end
						elseif objecttargeting == "target" then
							Ability.CastTarget(dodgeobject, myHero)
							FAIO_dodgeIT.dodgeTiming = os.clock()
							FAIO_dodgeIT.dodgeItTable = {}
							return
						end
					end
				end
			end
		else
			if curTime >= casttime + delay - objectoffset - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
				if objecttargeting == "no target" then
					Ability.CastNoTarget(dodgeobject)
					FAIO_dodgeIT.dodgeTiming = os.clock()
					FAIO_dodgeIT.dodgeItTable = {}
					return
				elseif objecttargeting == "position" then
					if FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname) ~= nil then
						Ability.CastPosition(dodgeobject, FAIO_dodgeIT.dodgerRangeOffsetter(myHero, unit, Ability.GetName(dodgeobject), spellname))
						FAIO_dodgeIT.dodgeTiming = os.clock()
						FAIO_dodgeIT.dodgeItTable = {}
						return
					end
				elseif objecttargeting == "target" then
					Ability.CastTarget(dodgeobject, myHero)
					FAIO_dodgeIT.dodgeTiming = os.clock()
					FAIO_dodgeIT.dodgeItTable = {}
					return
				end
			end
		end
	end

end

function FAIO_dodgeIT.dodgeProcessing(myHero, unit, activity, castpoint)

	if not myHero then return end
	if Entity.IsSameTeam(myHero, unit) then return end

	local distance = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(unit)):Length2D() - 25

	if NPC.GetUnitName(unit) == "npc_dota_hero_antimage" then
		local radius = 500
		local castrange = 600
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "antimage_mana_void", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end



	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_alchemist" then
		local radius = 0
		local castrange = 775
		local impactTime = distance / 900
		if activity == Enum.GameActivity.ACT_DOTA_ALCHEMIST_CONCOCTION_THROW then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint + impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "alchemist_unstable_concoction_throw", global = 0, type = "disable", projectilespeed = 900, projectileextradelay = -0.001})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end		
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_bane" then
		local radius = 0
		local castrange = 800
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "bane_fiends_grip", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end		
	end	

	if NPC.GetUnitName(unit) == "npc_dota_hero_batrider" then
		local radius = 0
		local castrange = 200
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "batrider_flaming_lasso", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end	

	if NPC.GetUnitName(unit) == "npc_dota_hero_bloodseeker" then
		local radius = 0
		local castrange = 1000
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "bloodseeker_rupture", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end	

	if NPC.GetUnitName(unit) == "npc_dota_hero_centaur" then
		local radius = 315
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "centaur_hoof_stomp", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, 0)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_chaos_knight" then
		local radius = 0
		local castrange = 500
		local impactTime = distance / 1000 - 0.15
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "chaos_knight_chaos_bolt", global = 0, type = "disable", projectilespeed = 1000, projectileextradelay = 0.15})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end	
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_crystal_maiden" then
		local radius = 0
		local castrange = 650
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "crystal_maiden_frostbite", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_death_prophet" then
		local radius = 425
		local castrange = 1000
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, 425, 1000) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "death_prophet_silence", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_doom_bringer" then
		local radius = 0
		local castrange = 550
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_6 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "doom_bringer_doom", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_drow_ranger" then
		local radius = 900
		local castrange = 250
		local impactTime = distance / 2000 - 0.1
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "drow_ranger_wave_of_silence", global = 0, type = "disable", projectilespeed = 2000, projectileextradelay = 0.080})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_earthshaker" then
		local radius1 = 225
		local castrange = 1400
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius1+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius1, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "earthshaker_fissure", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius1+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius1, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end

		local radius2 = 350
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius2) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "earthshaker_enchant_totem", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius2+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius2, 0)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_enigma" then
		local radius = 420
		local castrange = 275
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 0; source = unit, lotus = 0, castpoint = castpoint, spellname = "enigma_black_hole", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_faceless_void" then
		local radius = 425
		local castrange = 600
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 0; source = unit, lotus = 0, castpoint = castpoint, spellname = "faceless_void_chronosphere", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_juggernaut" then
		local radius = 425
		local castrange = 350
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "juggernaut_omni_slash", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_legion_commander" then
		local radius = 0
		local castrange = 300
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 0, castpoint = castpoint, spellname = "legion_commander_duel", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_lich" then
		local radius = 0
		local castrange = 1000
		local impactTime = distance / 850
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint + impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "lich_chain_frost", global = 0, type = "nuke", projectilespeed = 850, projectileextradelay = 0})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_lina" then
		local radius = 0
		local castrange = 725
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint + 0.275; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "lina_laguna_blade", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_lion" then
		local radius1 = 125
		local castrange1 = 725
		local impactTime = distance / 1600 - 0.2
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius1+castrange1) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius1, castrange1) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "lion_impale", global = 0, type = "disable", projectilespeed = 1600, projectileextradelay = 0.2})
			else
				if NPC.IsEntityInRange(myHero, unit, radius1+castrange1+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius1, castrange1)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end

		local radius2 = 0
		local castrange2 = 900
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius2+castrange2) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius2, castrange2) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint + 0.275; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "lion_finger_of_death", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius2+castrange2+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius2, castrange2)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_luna" then
		local radius = 0
		local castrange = 800
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "luna_lucent_beam", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_magnataur" then
		local radius = 0
		local castrange = 460
		local instant_radius = 150 + 50
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) then
				local delay = castpoint
					if distance <= instant_radius then delay = 0 end
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 0, castpoint = castpoint, spellname = "magnataur_reverse_polarity", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end	
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_necrolyte" then
		local radius = 0
		local castrange = 650
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "necrolyte_reapers_scythe", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_night_stalker" then
		local radius = 0
		local castrange = 650
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+0.075; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "night_stalker_crippling_fear", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_nyx_assassin" then
		local radius = 125
		local castrange = 700
		local impactTime = distance / 1600 + 0.1
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "nyx_assassin_impale", global = 0, type = "disable", projectilespeed = 1600, projectileextradelay = -0.1})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_ogre_magi" then
		local radius = 0
		local castrange = 600
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "ogre_magi_fireblast", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_obsidian_destroyer" then
		local radius1 = 0
		local castrange1 = 450
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius1+castrange1) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius1, castrange1) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "obsidian_destroyer_astral_imprisonment", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius1+castrange1+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius1, castrange1)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end	
		end

		local radius2 = 575
		local castrange2 = 700
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius2+castrange2) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius2, castrange2) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "obsidian_destroyer_sanity_eclipse", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius2+castrange2+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius2, castrange2)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_puck" then
		local radius = 450
		local castrange = 0
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "puck_waning_rift", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_pudge" then
		local radius = 0
		local castrange = 250
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "pudge_dismember", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_queenofpain" then
		local radius = 450
		local castrange = 900
		local impactTime = distance / 900 - 0.25
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 0; source = unit, lotus = 0, castpoint = castpoint, spellname = "queenofpain_sonic_wave", global = 0, type = "nuke", projectilespeed = 900, projectileextradelay = 0.25})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_rubick" then
		local radius = 0
		local castrange = 700
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "rubick_telekinesis", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_shadow_demon" then
		local radius = 0
		local castrange = 700
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "shadow_demon_disruption", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_shadow_shaman" then
		local radius = 0
		local castrange = 500
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_3 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "shadow_shaman_shackles", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_silencer" then
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 0, castpoint = castpoint, spellname = "silencer_global_silence", global = 1, type = "disable"})
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_skywrath_mage" then
		local radius = 0
		local castrange = 750
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_3 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "skywrath_mage_ancient_seal", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_slardar" then
		local radius = 350
		local castrange = 0
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "slardar_slithereen_crush", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_sniper" then
		local radius = 0
		local castrange = 3000
		local impactTime = distance / 2500 - 0.05
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then	
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "sniper_assassinate", global = 0, type = "nuke", projectilespeed = 2500, projectileextradelay = 0.05})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_storm_spirit" then
		local radius = 0
		local castrange = 350
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "storm_spirit_electric_vortex", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_sven" then
		local radius = 0
		local castrange = 600
		local impactTime = distance / 1000 - 0.15
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "sven_storm_bolt", global = 0, type = "disable", projectilespeed = 1000, projectileextradelay = 0.15})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_terrorblade" then
		local radius = 0
		local castrange = 600
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 1, castpoint = castpoint, spellname = "terrorblade_sunder", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_tidehunter" then
		local radius = 0
		local castrange = 1100
		local impactTime = distance / 775 - 0.35
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) then
				local adjust = impactTime
					if distance <= 250 then adjust = 0 end
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint + adjust; style = 2; source = unit, lotus = 0, castpoint = castpoint, spellname = "tidehunter_ravage", global = 0, type = "disable", projectilespeed = 775, projectileextradelay = 0.35})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_tinker" then
		local radius = 0
		local castrange = 900
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+0.1; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "tinker_laser", global = 0, type = "nuke"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_vengefulspirit" then
		local radius = 0
		local castrange = 500
		local impactTime = distance / 1250 - 0.1
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "vengefulspirit_magic_missile", global = 0, type = "disable", projectilespeed = 1250, projectileextradelay = 0.1})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_warlock" then
		local radius = 600
		local castrange = 1200
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_4 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+0.5; style = 1; source = unit, lotus = 0, castpoint = castpoint, spellname = "warlock_rain_of_chaos", global = 0, type = "disable"})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 0, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_windrunner" then
		local radius = 0
		local castrange = 800
		local impactTime = distance / 1650 - 0.1
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "windrunner_shackleshot", global = 0, type = "disable", projectilespeed = 1650, projectileextradelay = 0.1})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end	
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_skeleton_king" then
		local radius = 0
		local castrange = 525
		local impactTime = distance / 1000 - 0.15
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_1 then
			if NPC.IsEntityInRange(myHero, unit, radius+castrange) and FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint+impactTime; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "skeleton_king_hellfire_blast", global = 0, type = "disable", projectilespeed = 1000, projectileextradelay = 0.15})
			else
				if NPC.IsEntityInRange(myHero, unit, radius+castrange+885) then
					local targetAlly = FAIO_dodgeIT.saverGetAllyTarget(myHero, unit, radius, castrange)
					if targetAlly and NPC.IsEntityInRange(myHero, targetAlly, 885) then
						FAIO_dodgeIT.saveIt({lotus = 1, target = targetAlly})
					end
				end
			end
		end
	end

	if NPC.GetUnitName(unit) == "npc_dota_hero_zuus" then
		local radius = 375
		local castrange = 900
		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_2 and NPC.IsEntityInRange(myHero, unit, radius+castrange) then
			if FAIO_dodgeIT.dodgeIsTargetMe(myHero, unit, radius, castrange) then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 2; source = unit, lotus = 1, castpoint = castpoint, spellname = "zuus_lightning_bolt", global = 0, type = "nuke"})
			end
		end

		if activity == Enum.GameActivity.ACT_DOTA_CAST_ABILITY_5 then
			if FAIO_dodgeIT.IsHeroInvisible(myHero) == false and not NPC.HasModifier(myHero, "modifier_smoke_of_deceit") then
				FAIO_dodgeIT.dodgeIt({time = GameRules.GetGameTime(); delay = castpoint; style = 1; source = unit, lotus = 0, castpoint = castpoint, spellname = "zuus_thundergods_wrath", global = 1, type = "nuke"})
			end
		end
	end

end

return FAIO_dodgeIT