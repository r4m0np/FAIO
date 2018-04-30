FAIO_itemHandler = {}

FAIO_itemHandler.itemDelay = 0
FAIO_itemHandler.lastItemCast = 0
FAIO_itemHandler.lastDefItemPop = 0
FAIO_itemHandler.lastItemTick = 0
FAIO_itemHandler.ItemCastStop = false
FAIO_itemHandler.isArmletManuallyToggled = false
FAIO_itemHandler.isArmletManuallyToggledTime = 0
FAIO_itemHandler.armletDelayer = 0
FAIO_itemHandler.armletRightClickToggle = false
FAIO_itemHandler.armletRightClickToggleTimer = 0
FAIO_itemHandler.armletRightClickDoubleClick = 0
FAIO_itemHandler.isArmletActive = false
FAIO_itemHandler.armletCurrentHPGain = 0
FAIO_itemHandler.armletToggleTime = 0
FAIO_itemHandler.armletToggleTimePingAdjuster = 0
FAIO_itemHandler.armletProjectileAdjustmentTick = 0

FAIO_itemHandler.LinkensBreakerItemOrder = {}
FAIO_itemHandler.ItemCastOrder = {}
FAIO_itemHandler.armletDamageInstanceTable = {}

function FAIO_itemHandler.init()

	if next(FAIO_itemHandler.ItemCastOrder) == nil then
		FAIO_itemHandler.setOrderItem()
	end
 	if next(FAIO_itemHandler.LinkensBreakerItemOrder) == nil then
		FAIO_itemHandler.setOrderLinkens()
	end

end

function FAIO_itemHandler.setOrderItem()

	FAIO_itemHandler.ItemCastOrder = {
        	{Menu.GetValue(FAIO_options.optionItemVeil), "item_veil_of_discord", "position"},
        	{Menu.GetValue(FAIO_options.optionItemHex), "item_sheepstick", "target"},
        	{Menu.GetValue(FAIO_options.optionItemBlood), "item_bloodthorn", "target"},
        	{Menu.GetValue(FAIO_options.optionItemeBlade), "item_ethereal_blade", "target"},
        	{Menu.GetValue(FAIO_options.optionItemOrchid),"item_orchid", "target"},
        	{Menu.GetValue(FAIO_options.optionItemAtos),"item_rod_of_atos", "target"},
		{Menu.GetValue(FAIO_options.optionItemAbyssal),"item_abyssal_blade", "target"},
		{Menu.GetValue(FAIO_options.optionItemHalberd),"item_heavens_halberd", "target"},
		{Menu.GetValue(FAIO_options.optionItemShivas),"item_shivas_guard", "no target"},
		{Menu.GetValue(FAIO_options.optionItemDagon),"item_dagon", "target"},
		{Menu.GetValue(FAIO_options.optionItemDagon),"item_dagon_2", "target"},
		{Menu.GetValue(FAIO_options.optionItemDagon),"item_dagon_3", "target"},
		{Menu.GetValue(FAIO_options.optionItemDagon),"item_dagon_4", "target"},
		{Menu.GetValue(FAIO_options.optionItemDagon),"item_dagon_5", "target"},
		{Menu.GetValue(FAIO_options.optionItemUrn),"item_urn_of_shadows", "target"},
		{Menu.GetValue(FAIO_options.optionItemMedallion),"item_medallion_of_courage", "target"},
		{Menu.GetValue(FAIO_options.optionItemCrest),"item_solar_crest", "target"},
		{Menu.GetValue(FAIO_options.optionItemDiffusal),"item_diffusal_blade", "target"},
		{Menu.GetValue(FAIO_options.optionItemSpirit),"item_spirit_vessel", "target"},
		{Menu.GetValue(FAIO_options.optionItemNull),"item_nullifier", "target"},
    				}

    	table.sort(FAIO_itemHandler.ItemCastOrder, function(a, b)
        	return a[1] > b[1]
    	end)

end			

function FAIO_itemHandler.setOrderLinkens()
	
	FAIO_itemHandler.LinkensBreakerItemOrder = {
        	{Menu.GetValue(FAIO_options.optionLinkensForce), "item_force_staff"},
        	{Menu.GetValue(FAIO_options.optionLinkensEul), "item_cyclone"},
        	{Menu.GetValue(FAIO_options.optionLinkensHalberd), "item_heavens_halberd"},
        	{Menu.GetValue(FAIO_options.optionLinkensHex), "item_sheepstick"},
        	{Menu.GetValue(FAIO_options.optionLinkensBlood),"item_bloodthorn"},
        	{Menu.GetValue(FAIO_options.optionLinkensOrchid),"item_orchid"},
		{Menu.GetValue(FAIO_options.optionLinkensDiffusal),"item_diffusal_blade", "target"},
		{Menu.GetValue(FAIO_options.optionLinkensPike),"item_hurricane_pike"}
    				}

    	table.sort(FAIO_itemHandler.LinkensBreakerItemOrder, function(a, b)
        	return a[1] > b[1]
    	end)		
	
end

function FAIO_itemHandler.OnMenuOptionChange(option, old, new)

	if option == FAIO_options.optionItemVeil or
		option == FAIO_options.optionItemHex or
		option == FAIO_options.optionItemBlood or
		option == FAIO_options.optionItemeBlade or 
		option == FAIO_options.optionItemOrchid or 
		option == FAIO_options.optionItemAtos or 
		option == FAIO_options.optionItemAbyssal or 
		option == FAIO_options.optionItemHalberd or 
		option == FAIO_options.optionItemShivas or 
		option == FAIO_options.optionItemDagon or 
		option == FAIO_options.optionItemUrn or
		option == FAIO_options.optionItemManta or
		option == FAIO_options.optionItemMjollnir or
		option == FAIO_options.optionItemMedallion or
		option == FAIO_options.optionItemCrest or
		option == FAIO_options.optionItemDiffusal or
		option == FAIO_options.optionItemSpirit or
		option == FAIO_options.optionItemNull then
			FAIO_itemHandler.setOrderItem()
	end
	
	if option == FAIO_options.optionLinkensForce or
		option == FAIO_options.optionLinkensEul or
		option == FAIO_options.optionLinkensHalberd or
		option == FAIO_options.optionLinkensHex or
		option == FAIO_options.optionLinkensBlood or
		option == FAIO_options.optionLinkensOrchid or
		option == FAIO_options.optionLinkensDiffusal or
		option == FAIO_options.optionLinkensPike then
        		FAIO_itemHandler.setOrderLinkens()
    	end

end

function FAIO_itemHandler.OnUnitAnimation(animation)

	local myHero = Heroes.GetLocal()

	if animation.unit and Entity.IsNPC(animation.unit) and not Entity.IsSameTeam(Heroes.GetLocal(), animation.unit) and animation.type == 1 then
		if not NPC.IsRanged(animation.unit) then
			local attackRange = NPC.GetAttackRange(animation.unit) + 155
			if NPC.IsEntityInRange(Heroes.GetLocal(), animation.unit, attackRange) and NPC.FindFacingNPC(animation.unit) == Heroes.GetLocal() then
				local damage = FAIO_itemHandler.getAdjustedMaxTrueDamage(animation.unit, Heroes.GetLocal())
				table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = Entity.GetIndex(animation.unit), time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + animation.castpoint - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = animation.castpoint, backswingstart = GameRules.GetGameTime() + animation.castpoint - 0.035, backswingend = GameRules.GetGameTime() + NPC.GetAttackTime(animation.unit) - 0.035, type = "attack", damage = damage, isProjectile = false })
			end
		else
			local attackRange = NPC.GetAttackRange(animation.unit) + 264
			if Entity.IsHero(animation.unit) and NPC.IsEntityInRange(Heroes.GetLocal(), animation.unit, attackRange) and NPC.FindFacingNPC(animation.unit) == Heroes.GetLocal() then
				local myProjectedPosition = Entity.GetAbsOrigin(Heroes.GetLocal())
				local projectileTiming = ((Entity.GetAbsOrigin(animation.unit) - myProjectedPosition):Length2D() - NPC.GetHullRadius(Heroes.GetLocal())) / FAIO_data.attackPointTable[NPC.GetUnitName(animation.unit)][3]
				local damage = FAIO_itemHandler.getAdjustedMaxTrueDamage(animation.unit, Heroes.GetLocal())
				table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = Entity.GetIndex(animation.unit), time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + animation.castpoint + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = animation.castpoint, backswingstart = GameRules.GetGameTime() + animation.castpoint - 0.035, backswingend = GameRules.GetGameTime() + NPC.GetAttackTime(animation.unit) - 0.035, type = "rangeattack", damage = damage, projectileorigin = Entity.GetAbsOrigin(animation.unit), projectilestarttime = GameRules.GetGameTime() + animation.castpoint - 0.035, projectilespeed = FAIO_data.attackPointTable[NPC.GetUnitName(animation.unit)][3], isProjectile = true })
			end
		end
	end

end

function FAIO_itemHandler.OnProjectile(projectile)

	local myHero = Heroes.GetLocal()

	local armletProjectileList = {
		"npc_dota_hero_abaddon",
		"npc_dota_hero_broodmother",
		"npc_dota_hero_dragon_knight",
		"npc_dota_hero_enchantress",
		"npc_dota_hero_oracle",
		"npc_dota_hero_phantom_assassin",
		"npc_dota_hero_queenofpain",
		"npc_dota_hero_skywrath_mage",
		"npc_dota_hero_tidehunter",
		"npc_dota_hero_tiny",
		"npc_dota_hero_visage",
		"npc_dota_hero_winter_wyvern",
		"npc_dota_hero_bounty_hunter",
		"npc_dota_hero_earthshaker",
		"npc_dota_hero_morphling",
		"npc_dota_hero_phantom_lancer",
		"npc_dota_hero_tinker",
		"npc_dota_hero_gyrocopter",
		"npc_dota_hero_mirana",
		"npc_dota_hero_spectre",
		"npc_dota_hero_treant",
		"npc_dota_hero_medusa",
		"npc_dota_hero_arcwarden",
		"npc_dota_hero_necrolyte",
		"npc_dota_hero_witch_doctor",
		"npc_dota_hero_tusk",
		"npc_dota_hero_huskar",
		"npc_dota_hero_nyx_assassin",
		"npc_dota_hero_lion",
		"npc_dota_hero_lich",
		"npc_dota_hero_chaos_knight",
		"npc_dota_hero_alchemist",
		"npc_dota_hero_skeleton_king",
		"npc_dota_hero_sniper",
		"npc_dota_hero_sven",
		"npc_dota_hero_vengefulspirit",
			}

	if projectile.source and Entity.IsNPC(projectile.source) and NPC.IsRanged(projectile.source) and not Entity.IsSameTeam(Heroes.GetLocal(), projectile.source) and projectile.isAttack then
		local attackRange = NPC.GetAttackRange(projectile.source)
		if not Entity.IsHero(projectile.source) then
			if projectile.target == Heroes.GetLocal() then
				local casttime = 0.5
					if FAIO_itemHandler.creepAttackPointData[NPC.GetUnitName(projectile.source)] ~= nil then
						casttime = FAIO_itemHandler.creepAttackPointData[NPC.GetUnitName(projectile.source)]
					end
				local myProjectedPosition = Entity.GetAbsOrigin(myHero)
				local projectileTiming = ((Entity.GetAbsOrigin(projectile.source) - myProjectedPosition):Length() - NPC.GetHullRadius(projectile.target)) / projectile.moveSpeed
				local damage = FAIO_itemHandler.getAdjustedMaxTrueDamage(projectile.source, Heroes.GetLocal())
				table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = Entity.GetIndex(projectile.source), time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = casttime, backswingstart = GameRules.GetGameTime() - 0.035, backswingend = GameRules.GetGameTime() + NPC.GetAttackTime(projectile.source) - casttime - 0.035, type = "rangeattack", damage = damage, projectileorigin = Entity.GetAbsOrigin(projectile.source), projectilestarttime = GameRules.GetGameTime() - 0.035, projectilespeed = projectile.moveSpeed, isProjectile = true })
			end
		else
			if projectile.target == Heroes.GetLocal() then
				local myProjectedPosition = Entity.GetAbsOrigin(myHero)
				local projectileTiming = ((Entity.GetAbsOrigin(projectile.source) - myProjectedPosition):Length2D() - NPC.GetHullRadius(projectile.target)) / projectile.moveSpeed
				local damage = FAIO_itemHandler.getAdjustedMaxTrueDamage(projectile.source, Heroes.GetLocal())
				local inserted = false
				for k, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
					if info and info.instanceindex == Entity.GetIndex(projectile.source) then
						if math.abs(info.time - FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3)) < NPC.GetAttackTime(projectile.source) * 0.75 then
							inserted = true
						end
					end
				end
				if not inserted then
					local casttime = FAIO_data.attackPointTable[NPC.GetUnitName(projectile.source)][1] / (1 + NPC.GetIncreasedAttackSpeed(projectile.source))
					table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = Entity.GetIndex(projectile.source), time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = casttime, backswingstart = GameRules.GetGameTime() - 0.035, backswingend = GameRules.GetGameTime() + NPC.GetAttackTime(projectile.source) - casttime - 0.035, type = "rangeattack", damage = damage, projectileorigin = Entity.GetAbsOrigin(projectile.source), projectilestarttime = GameRules.GetGameTime() - 0.035, projectilespeed = projectile.moveSpeed, isProjectile = true })
				end	
			end
		end
	end

	if projectile.source and Entity.IsNPC(projectile.source) and not projectile.isAttack and projectile.name ~= "rod_of_atos_attack" then
		if projectile.target == Heroes.GetLocal() then
			local myProjectedPosition = Entity.GetAbsOrigin(myHero)
			local projectileTiming = ((Entity.GetAbsOrigin(projectile.source) - myProjectedPosition):Length2D() - NPC.GetHullRadius(projectile.target)) / projectile.moveSpeed
			if not Entity.IsSameTeam(Heroes.GetLocal(), projectile.source) then
				if projectile.name ~= "nullifier_proj" then
					local insert = false
					for i, v in ipairs(armletProjectileList) do
						if v and v == NPC.GetUnitName(projectile.source) then
							insert = true
						end
					end
					if insert then
						table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = projectile.name, time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = 0, type = "ability", damage = 250, projectileorigin = Entity.GetAbsOrigin(projectile.source), projectilestarttime = GameRules.GetGameTime() - 0.035, projectilespeed = projectile.moveSpeed, isProjectile = true })
					end
				else
					table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = projectile.name, time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = 0, type = "ability", damage = 1000, projectileorigin = Entity.GetAbsOrigin(projectile.source), projectilestarttime = GameRules.GetGameTime() - 0.035, projectilespeed = projectile.moveSpeed, isProjectile = true })
				end	
			else
				if projectile.name == "medusa_mystic_snake_projectile" or projectile.name == "earthshaker_echoslam" or projectile.name == "bounty_hunter_suriken_toss" or projectile.name == "wyvern_splinter_blast" then
					table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = projectile.name, time = FAIO_itemHandler.utilityRoundNumber((GameRules.GetGameTime() + projectileTiming - 0.035 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)), 3), casttime = 0, type = "ability", damage = 250, projectileorigin = Entity.GetAbsOrigin(projectile.source), projectilestarttime = GameRules.GetGameTime(), projectilespeed = projectile.moveSpeed, isProjectile = true })
				end
			end
		end
	end

end

function FAIO_itemHandler.OnPrepareUnitOrders(orders)

	local myHero = Heroes.GetLocal()

	if Menu.IsEnabled(FAIO_options.optionItemArmlet) and Menu.IsEnabled(FAIO_options.optionItemArmletRightClick) then
		local armlet = NPC.GetItem(myHero, "item_armlet", true)
		if armlet then
			if not FAIO_itemHandler.armletRightClickToggle then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET then
					if not Entity.IsSameTeam(myHero, orders.target) then
						if Menu.GetValue(FAIO_options.optionItemArmletRightClickStyle) > 0 then
							if os.clock() - FAIO_itemHandler.armletRightClickDoubleClick > 0.3 then
								FAIO_itemHandler.armletRightClickDoubleClick = os.clock()
								return true
							else
								if os.clock() - FAIO_itemHandler.armletRightClickDoubleClick > 0.05 then
									FAIO_itemHandler.armletRightClickToggle = true
									FAIO_itemHandler.armletRightClickToggleTimer = os.clock()
									return true
								end
							end
						else
							FAIO_itemHandler.armletRightClickToggle = true
							FAIO_itemHandler.armletRightClickToggleTimer = os.clock()
							return true
						end
					end
				end
			else
				if os.clock() - FAIO_itemHandler.armletRightClickToggleTimer > 0.6 then
					if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION then
						FAIO_itemHandler.armletRightClickToggle = false
						return true
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionItemArmlet) and Menu.IsEnabled(FAIO_options.optionItemArmletIllusion) then
		local armlet = NPC.GetItem(myHero, "item_armlet", true)
		if armlet and not Ability.GetToggleState(armlet) then
			local manta = NPC.GetItem(myHero, "item_manta", true)
			local ckUlt = NPC.GetAbility(myHero, "chaos_knight_phantasm")
			local terrorImg = NPC.GetAbility(myHero, "terrorblade_conjure_image")
			if manta or ckUlt or terrorImg then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
					if orders.ability == manta or orders.ability == terrorImg then
						Ability.Toggle(armlet, false)
						FAIO_itemHandler.armletDelayer = os.clock() + 0.25
						return true
					elseif orders.ability == ckUlt then
						Ability.Toggle(armlet, false)
						FAIO_itemHandler.armletDelayer = os.clock() + 0.75
						return true
					end
				end
			end
			local lsUlt = NPC.GetAbility(myHero, "life_stealer_infest")
			if lsUlt then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET then
					if orders.ability == lsUlt then
						if orders.target and Entity.IsHero(orders.target) and Entity.IsSameTeam(myHero, orders.target) then
							Ability.Toggle(armlet, false)
							FAIO_itemHandler.armletDelayer = os.clock() + (math.max(((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(orders.target)):Length2D() - 150), 0) / NPC.GetMoveSpeed(myHero)) + 0.25
							return true
						end
					end
				end
			end
		end
		if armlet and Ability.GetToggleState(armlet) then
			local lsConsume = NPC.GetAbility(myHero, "life_stealer_consume")
			if lsConsume and not Ability.IsHidden(lsConsume) then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
					if orders.ability == lsConsume then
						FAIO_itemHandler.armletDelayer = os.clock() + 1.5
						return true
					end
				end
			end
		end
	end

end

function FAIO_itemHandler.noItemCastFor(sec)

	FAIO_itemHandler.itemDelay = sec
	FAIO_itemHandler.lastItemTick = os.clock()

end

function FAIO_itemHandler.ItemSleepReady(sleep)

	if (os.clock() - FAIO_itemHandler.lastItemCast) >= sleep then
		return true
	end
	return false

end

function FAIO_itemHandler.itemUsage(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	if not Menu.IsEnabled(FAIO_options.optionItemEnable) then return end
	if (os.clock() - FAIO_itemHandler.lastItemTick) < FAIO_itemHandler.itemDelay then return end
	if FAIO_itemHandler.ItemCastStop then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	if Menu.GetValue(FAIO_options.optionItemStyle) == 0 then 
		FAIO_itemHandler.itemUsageNoOrder(myHero, enemy)
	elseif Menu.GetValue(FAIO_options.optionItemStyle) == 1 then
		FAIO_itemHandler.itemUsageOrder(myHero, enemy)
	elseif Menu.GetValue(FAIO_options.optionItemStyle) == 2 then
		FAIO_itemHandler.itemUsageSmartOrder(myHero, enemy)
	end

end

function FAIO_itemHandler.itemUsageNoOrder(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)

	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	local hex = NPC.GetItem(myHero, "item_sheepstick", true)
	local blood = NPC.GetItem(myHero, "item_bloodthorn", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local orchid = NPC.GetItem(myHero, "item_orchid", true)
	local refresher = NPC.GetItem(myHero, "item_refresher", true)
	local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
	local abyssal = NPC.GetItem(myHero, "item_abyssal_blade", true)
	local halberd = NPC.GetItem(myHero, "item_heavens_halberd", true)
	local shivas = NPC.GetItem(myHero, "item_shivas_guard", true)
	local urn = NPC.GetItem(myHero, "item_urn_of_shadows", true)
	local manta = NPC.GetItem(myHero, "item_manta", true)
	local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
	local mjollnir = NPC.GetItem(myHero, "item_mjollnir", true)
	local medallion = NPC.GetItem(myHero, "item_medallion_of_courage", true)
	local crest = NPC.GetItem(myHero, "item_solar_crest", true)
	local spiritVessel = NPC.GetItem(myHero, "item_spirit_vessel", true)
	local nullifier = NPC.GetItem(myHero, "item_nullifier", true)
	local diffusal = NPC.GetItem(myHero, "item_diffusal_blade", true)

	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then
		
		if FAIO_itemHandler.ItemSleepReady(0.05) and soulring and Ability.IsReady(soulring) and Menu.IsEnabled(FAIO_options.optionItemSoulring) then
			Ability.CastNoTarget(soulring)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if NPC.IsLinkensProtected(enemy) then
			if FAIO_itemHandler.ItemSleepReady(0.05) and FAIO_itemHandler.LinkensBreakerNew(myHero) ~= nil then
				Ability.CastTarget(NPC.GetItem(myHero, FAIO_itemHandler.LinkensBreakerNew(myHero), true), enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and abyssal and NPC.IsEntityInRange(myHero, enemy, 140) and Ability.IsCastable(abyssal, myMana) and Menu.GetValue(FAIO_options.optionItemAbyssal) > 0 then 
			Ability.CastTarget(abyssal, enemy)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and shivas and NPC.IsEntityInRange(myHero, enemy, 900 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(shivas, myMana) and Menu.GetValue(FAIO_options.optionItemShivas) > 0 then 
			Ability.CastNoTarget(shivas)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and mjollnir and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(mjollnir, myMana) and Menu.GetValue(FAIO_options.optionItemMjollnir) > 0 then 
			Ability.CastTarget(mjollnir, myHero)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and manta and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(manta, myMana) and Menu.GetValue(FAIO_options.optionItemManta) > 0 then 
			Ability.CastNoTarget(manta)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then

			if FAIO_itemHandler.ItemSleepReady(0.05) and orchid and NPC.IsEntityInRange(myHero, enemy, 900 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(orchid, myMana) and Menu.GetValue(FAIO_options.optionItemOrchid) > 0 then 
				Ability.CastTarget(orchid, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and blood and NPC.IsEntityInRange(myHero, enemy, 900 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(blood, myMana) and Menu.GetValue(FAIO_options.optionItemBlood) > 0 then 
				Ability.CastTarget(blood, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and veil and NPC.IsEntityInRange(myHero, enemy, 1000 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(veil, myMana) and Menu.GetValue(FAIO_options.optionItemVeil) > 0 then 
				Ability.CastPosition(veil, Entity.GetAbsOrigin(enemy))
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and hex and NPC.IsEntityInRange(myHero, enemy, 800 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(hex, myMana) and Menu.GetValue(FAIO_options.optionItemHex) > 0 then 
				Ability.CastTarget(hex, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and nullifier and NPC.IsEntityInRange(myHero, enemy, 600 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(nullifier, myMana) and Menu.GetValue(FAIO_options.optionItemNull) > 0 then 
				Ability.CastTarget(nullifier, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and diffusal and NPC.IsEntityInRange(myHero, enemy, 600 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(diffusal, myMana) and Menu.GetValue(FAIO_options.optionItemDiffusal) > 0 then 
				Ability.CastTarget(diffusal, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and eBlade and NPC.IsEntityInRange(myHero, enemy, 800 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(eBlade, myMana) and Menu.GetValue(FAIO_options.optionItemeBlade) > 0 then 
				Ability.CastTarget(eBlade, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end
	
			if FAIO_itemHandler.ItemSleepReady(0.05) and atos and NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(atos, myMana) and Menu.GetValue(FAIO_options.optionItemAtos) > 0 then 
				Ability.CastTarget(atos, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and halberd and NPC.IsEntityInRange(myHero, enemy, 600 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(halberd, myMana) and Menu.GetValue(FAIO_options.optionItemHalberd) > 0 then
				Ability.CastTarget(halberd, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and urn and NPC.IsEntityInRange(myHero, enemy, 950 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(urn, myMana) and Item.GetCurrentCharges(urn) >= 3 and Entity.GetHealth(enemy) >= 250 and Menu.GetValue(FAIO_options.optionItemUrn) > 0 then
				Ability.CastTarget(urn, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and spiritVessel and NPC.IsEntityInRange(myHero, enemy, 950 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(spiritVessel, myMana) and Item.GetCurrentCharges(spiritVessel) >= 2 and Entity.GetHealth(enemy) >= 250 and Menu.GetValue(FAIO_options.optionItemSpirit) > 0 then
				Ability.CastTarget(spiritVessel, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and medallion and NPC.IsEntityInRange(myHero, enemy, 1000 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(medallion, myMana) and Menu.GetValue(FAIO_options.optionItemMedallion) > 0 then 
				Ability.CastTarget(medallion, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and crest and NPC.IsEntityInRange(myHero, enemy, 1000 + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(crest, myMana) and Menu.GetValue(FAIO_options.optionItemCrest) > 0 then 
				Ability.CastTarget(crest, enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end

			if FAIO_itemHandler.ItemSleepReady(0.05) and dagon and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(dagon) + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(dagon, myMana) and Menu.GetValue(FAIO_options.optionItemDagon) > 0 and not NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
				if eBlade then
					if Ability.SecondsSinceLastUse(eBlade) > -1 and Ability.SecondsSinceLastUse(eBlade) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1275) + 0.25 then
						return
					else
						Ability.CastTarget(dagon, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						return
					end
				else
					if NPC.HasAbility(myHero, "skywrath_mage_ancient_seal") then
						if Ability.IsReady(NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")) then
							return
						else
							if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")) <= 0.15 then
								return
							else
								Ability.CastTarget(dagon, enemy)
								FAIO_itemHandler.lastItemCast = os.clock()
								return
							end
						end
					elseif NPC.HasAbility(myHero, "witch_doctor_maledict") then
						if Ability.IsReady(NPC.GetAbility(myHero, "witch_doctor_maledict")) then
							return
						else
							if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "witch_doctor_maledict")) <= 0.15 then
								return
							else
								Ability.CastTarget(dagon, enemy)
								FAIO_itemHandler.lastItemCast = os.clock()
								return
							end
						end
					elseif NPC.HasAbility(myHero, "pugna_decrepify") then
						if Ability.IsReady(NPC.GetAbility(myHero, "pugna_decrepify")) then
							return
						else
							if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "pugna_decrepify")) <= 0.15 then
								return
							else
								Ability.CastTarget(dagon, enemy)
								FAIO_itemHandler.lastItemCast = os.clock()
								return
							end
						end
					else
						Ability.CastTarget(dagon, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						return
					end
				end
			end

			if Menu.GetValue(FAIO_options.optionItemDagon) == -1 then

				if FAIO_itemHandler.ItemSleepReady(0.05) and dagon and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(dagon) + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(dagon, myMana) then
					local dagonDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (Ability.GetLevelSpecialValueFor(dagon, "damage") + (Ability.GetLevelSpecialValueFor(dagon, "damage") * (Hero.GetIntellectTotal(myHero) / 14 / 100)))
					local eBladeAMP = 0
						if NPC.HasModifier(enemy, "modifier_item_ethereal_blade_ethereal") then
							eBladeAMP = 0.4
						end
					local necroUltDMG = 0
						if NPC.HasAbility(myHero, "necrolyte_reapers_scythe") then
							if Ability.IsCastable(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), myMana - Ability.GetManaCost(dagon)) then
								local necroUlt = (Entity.GetMaxHealth(enemy) - Entity.GetHealth(enemy)) * Ability.GetLevelSpecialValueForFloat(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), "damage_per_health")
								necroUltDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + eBladeAMP) * (necroUlt + necroUlt * (Hero.GetIntellectTotal(myHero) / 14 / 100))
							end
						end
					local dagonTrueDMG = (1 + eBladeAMP) * dagonDMG + necroUltDMG
					if Entity.GetHealth(enemy) <= dagonTrueDMG and not NPC.IsLinkensProtected(enemy) then
						if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
							Ability.CastTarget(dagon, enemy)
							FAIO_itemHandler.lastItemCast = os.clock()
							return
						end
					end
				end
			end
		end
	end
end

function FAIO_itemHandler.itemUsageOrder(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)

	local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
	local mjollnir = NPC.GetItem(myHero, "item_mjollnir", true)
	local manta = NPC.GetItem(myHero, "item_manta", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then
		
		if FAIO_itemHandler.ItemSleepReady(0.05) and soulring and Ability.IsReady(soulring) and Menu.IsEnabled(FAIO_options.optionItemSoulring) then
			Ability.CastNoTarget(soulring)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if NPC.IsLinkensProtected(enemy) then
			if FAIO_itemHandler.ItemSleepReady(0.05) and FAIO_itemHandler.LinkensBreakerNew(myHero) ~= nil then
				Ability.CastTarget(NPC.GetItem(myHero, FAIO_itemHandler.LinkensBreakerNew(myHero), true), enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end
		end

		if Menu.GetValue(FAIO_options.optionItemDagon) == -1 then

			if FAIO_itemHandler.ItemSleepReady(0.05) and dagon and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(dagon) + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(dagon, myMana) then
				local dagonDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (Ability.GetLevelSpecialValueFor(dagon, "damage") + (Ability.GetLevelSpecialValueFor(dagon, "damage") * (Hero.GetIntellectTotal(myHero) / 14 / 100)))
				local eBladeAMP = 0
					if NPC.HasModifier(enemy, "modifier_item_ethereal_blade_ethereal") then
						eBladeAMP = 0.4
					end
				local necroUltDMG = 0
					if NPC.HasAbility(myHero, "necrolyte_reapers_scythe") then
						if Ability.IsCastable(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), myMana - Ability.GetManaCost(dagon)) then
							local necroUlt = (Entity.GetMaxHealth(enemy) - Entity.GetHealth(enemy)) * Ability.GetLevelSpecialValueForFloat(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), "damage_per_health")
							necroUltDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + eBladeAMP) * (necroUlt + necroUlt * (Hero.GetIntellectTotal(myHero) / 14 / 100))
						end
					end
				local dagonTrueDMG = (1 + eBladeAMP) * dagonDMG + necroUltDMG
				if Entity.GetHealth(enemy) <= dagonTrueDMG and not NPC.IsLinkensProtected(enemy) then
					if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
						Ability.CastTarget(dagon, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						return
					end
				end
			end
		end

		local orderItem
		local customOrder = 0
		local itemActivation

		for k, v in ipairs(FAIO_itemHandler.ItemCastOrder) do

			local skipItem = 0

			if NPC.HasModifier(enemy, "modifier_black_king_bar_immune") then
				if v[2] == "item_veil_of_discord" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or
					v[2] == "item_ethereal_blade" or v[2] == "item_orchid" or v[2] == "item_rod_of_atos" or
					v[2] == "item_heavens_halberd" or v[2] == "item_urn_of_shadows" or v[2] == "item_dagon"
					or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" 
					or v[2] == "item_dagon_5" or v[2] == "item_medallion_of_courage" or v[2] == "item_solar_crest"
					or v[2] == "item_spirit_vessel" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
				end
			end

			if NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
				if v[2] ~= "item_nullifier" then
					skipItem = v[1]
				end
			end

			if NPC.HasModifier(myHero, "modifier_item_ethereal_blade") and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_ethereal_blade", true)) > -1 and
				Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_ethereal_blade", true)) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1275) + 0.25 then
				if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" 
					or v[2] == "item_dagon_5" then
					skipItem = v[1]
				end
			end

			if NPC.HasAbility(myHero, "skywrath_mage_ancient_seal") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasAbility(myHero, "witch_doctor_maledict") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "witch_doctor_maledict")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasAbility(myHero, "pugna_decrepify") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "pugna_decrepify")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasItem(myHero, v[2], true) then
				if v[2] == "item_spirit_vessel" or v[2] == "item_urn_of_shadows" then
					if Item.GetCurrentCharges(NPC.GetItem(myHero, v[2], true)) <= 2 then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasItem(myHero, v[2], true) then
				if Ability.IsCastable(NPC.GetItem(myHero, v[2], true), myMana) and (v[1] - skipItem) > customOrder then
					orderItem = NPC.GetItem(myHero, v[2], true)
					customOrder = v[1]
					itemActivation = v[3]
				end
			end	
		end
		
			if FAIO_itemHandler.ItemSleepReady(0.05) and customOrder > 0 then
				if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(orderItem)) then
					if itemActivation == "target" then
						Ability.CastTarget(orderItem, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
					if itemActivation == "no target" then
						Ability.CastNoTarget(orderItem)
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
					if itemActivation == "position" then
						Ability.CastPosition(orderItem, Entity.GetAbsOrigin(enemy))
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
				end
			end

		if FAIO_itemHandler.ItemSleepReady(0.05) and mjollnir and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(mjollnir, myMana) and Menu.GetValue(FAIO_options.optionItemMjollnir) > 0 then
			Ability.CastTarget(mjollnir, myHero)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and manta and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(manta, myMana) and Menu.GetValue(FAIO_options.optionItemManta) > 0 then
			Ability.CastNoTarget(manta)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end
	end
end

function FAIO_itemHandler.itemUsageSmartOrder(myHero, enemy, activation)

	if not myHero then return end
	if not enemy then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	local alternateActivation
	if activation == nil then
		alternateActivation = false
	else alternateActivation = activation
	end
	
	local myMana = NPC.GetMana(myHero)

	local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
	local mjollnir = NPC.GetItem(myHero, "item_mjollnir", true)
	local manta = NPC.GetItem(myHero, "item_manta", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if (Menu.IsKeyDown(FAIO_options.optionComboKey) or alternateActivation) then
		
		if FAIO_itemHandler.ItemSleepReady(0.05) and soulring and Ability.IsReady(soulring) and Menu.IsEnabled(FAIO_options.optionItemSoulring) then
			Ability.CastNoTarget(soulring)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if NPC.IsLinkensProtected(enemy) then
			if FAIO_itemHandler.ItemSleepReady(0.05) and FAIO_itemHandler.LinkensBreakerNew(myHero) ~= nil then
				Ability.CastTarget(NPC.GetItem(myHero, FAIO_itemHandler.LinkensBreakerNew(myHero), true), enemy)
				FAIO_itemHandler.lastItemCast = os.clock()
				return
			end
		end

		if Menu.GetValue(FAIO_options.optionItemDagon) == -1 then

			if FAIO_itemHandler.ItemSleepReady(0.05) and dagon and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(dagon) + NPC.GetCastRangeBonus(myHero)) and Ability.IsCastable(dagon, myMana) then
				local dagonDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (Ability.GetLevelSpecialValueFor(dagon, "damage") + (Ability.GetLevelSpecialValueFor(dagon, "damage") * (Hero.GetIntellectTotal(myHero) / 14 / 100)))
				local eBladeAMP = 0
					if NPC.HasModifier(enemy, "modifier_item_ethereal_blade_ethereal") then
						eBladeAMP = 0.4
					end
				local necroUltDMG = 0
					if NPC.HasAbility(myHero, "necrolyte_reapers_scythe") then
						if Ability.IsCastable(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), myMana - Ability.GetManaCost(dagon)) then
							local necroUlt = (Entity.GetMaxHealth(enemy) - Entity.GetHealth(enemy)) * Ability.GetLevelSpecialValueForFloat(NPC.GetAbility(myHero, "necrolyte_reapers_scythe"), "damage_per_health")
							necroUltDMG = (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + eBladeAMP) * (necroUlt + necroUlt * (Hero.GetIntellectTotal(myHero) / 14 / 100))
						end
					end
				local dagonTrueDMG = (1 + eBladeAMP) * dagonDMG + necroUltDMG
				if Entity.GetHealth(enemy) <= dagonTrueDMG and not NPC.IsLinkensProtected(enemy) then
					if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
						Ability.CastTarget(dagon, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						return
					end
				end
			end
		end

		local orderItem
		local customOrder = 0
		local itemActivation

		for k, v in ipairs(FAIO_itemHandler.ItemCastOrder) do

			local skipItem = 0

			if NPC.HasModifier(enemy, "modifier_black_king_bar_immune") then
				if v[2] == "item_veil_of_discord" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or
					v[2] == "item_ethereal_blade" or v[2] == "item_orchid" or v[2] == "item_rod_of_atos" or
					v[2] == "item_heavens_halberd" or v[2] == "item_urn_of_shadows" or v[2] == "item_dagon"
					or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" 
					or v[2] == "item_dagon_5" or v[2] == "item_medallion_of_courage" or v[2] == "item_solar_crest"
					or v[2] == "item_spirit_vessel" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
				end
			end

			if NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
				if v[2] ~= "item_nullifier" then
					skipItem = v[1]
				end
			end

			if NPC.HasItem(myHero, v[2], true) then
				if v[2] == "item_spirit_vessel" or v[2] == "item_urn_of_shadows" then
					if Item.GetCurrentCharges(NPC.GetItem(myHero, v[2], true)) <= 2 then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasModifier(enemy, "modifier_bashed") then
				if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or v[2] == "item_orchid" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
					skipItem = v[1]
				end
			end

			if NPC.HasModifier(enemy, "modifier_stunned") then
				local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_stunned"))
				if GameRules.GetGameTime() <= dieTime - 0.1 then
					if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or v[2] == "item_orchid" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasModifier(enemy, "modifier_sheepstick_debuff") then
				local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_sheepstick_debuff"))
				if Menu.IsEnabled(FAIO_options.optionItemStack) then
					if GameRules.GetGameTime() <= dieTime - 0.1 then
						if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
							skipItem = v[1]
						end
					end
				else
					if GameRules.GetGameTime() <= dieTime - 0.1 then
						if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or v[2] == "item_orchid" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
							skipItem = v[1]
						end
					end
				end
			end

			if NPC.HasItem(myHero, "item_sheepstick", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_sheepstick",true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_sheepstick",true)) < 0.5 then
				if Menu.IsEnabled(FAIO_options.optionItemStack) then
					if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
					end
				else
					if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or v[2] == "item_orchid" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
					end
				end
			end

			if NPC.IsSilenced(enemy) then
				if NPC.HasModifier(enemy, "modifier_bloodthorn_debuff") then
					local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_bloodthorn_debuff"))
					if GameRules.GetGameTime() <= dieTime - 0.1 then
						if v[2] == "item_bloodthorn" or v[2] == "item_orchid" then
							skipItem = v[1]
						end
					end
				elseif NPC.HasModifier(enemy, "modifier_orchid_malevolence_debuff") then
					local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_orchid_malevolence_debuff"))
					if GameRules.GetGameTime() <= dieTime - 0.1 then
						if v[2] == "item_bloodthorn" or v[2] == "item_orchid" then
							skipItem = v[1]
						end
					end
				elseif NPC.HasModifier(enemy, "modifier_silence") then
					local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_silence"))
					if GameRules.GetGameTime() <= dieTime - 0.1 then
						if v[2] == "item_bloodthorn" or v[2] == "item_orchid" then
							skipItem = v[1]
						end
					end
				end
			end

			if NPC.HasModifier(myHero, "modifier_item_nullifier") and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_nullifier", true)) > -1 and
				Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_nullifier", true)) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1200) + 0.25 then
				if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_bloodthorn" or v[2] == "item_orchid" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
					skipItem = v[1]
				end
			end

			if NPC.HasModifier(enemy, "modifier_item_nullifier_mute") then
				local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_item_nullifier_mute"))
				if GameRules.GetGameTime() <= dieTime - 0.1 then
					if  v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasModifier(enemy, "modifier_item_diffusal_blade_slow") then
				local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_item_diffusal_blade_slow"))
				if GameRules.GetGameTime() <= dieTime - 0.1 then
					if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasItem(myHero, "item_diffusal_blade", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_diffusal_blade", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_diffusal_blade", true)) < 0.5 then
				if v[2] == "item_abyssal_blade" or v[2] == "item_sheepstick" or v[2] == "item_heavens_halberd" or v[2] == "item_nullifier" or v[2] == "item_diffusal_blade" then
					skipItem = v[1]
				end
			end

			if NPC.HasModifier(myHero, "modifier_item_ethereal_blade") and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_ethereal_blade", true)) > -1 and
				Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_ethereal_blade", true)) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1275) + 0.25 then
				if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" 
					or v[2] == "item_dagon_5" then
					skipItem = v[1]
				end
			end

			if NPC.HasModifier(enemy, "modifier_item_veil_of_discord_debuff") then
				if v[2] == "item_veil_of_discord" then
					skipItem = v[1]
				end
			end		

			if NPC.HasAbility(myHero, "skywrath_mage_ancient_seal") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasAbility(myHero, "witch_doctor_maledict") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "witch_doctor_maledict")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasAbility(myHero, "pugna_decrepify") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "pugna_decrepify")) <= 0.15 then
					if v[2] == "item_dagon" or v[2] == "item_dagon_2" or v[2] == "item_dagon_3" or v[2] == "item_dagon_4" or v[2] == "item_dagon_5" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasItem(enemy, "item_aeon_disk", true) then
				if Ability.SecondsSinceLastUse(NPC.GetItem(enemy, "item_aeon_disk", true)) < 0 then
					if Entity.GetHealth(enemy) >= 0.85 * Entity.GetMaxHealth(enemy) then
						if v[2] == "item_nullifier" then
							skipItem = v[1]
						end
					end
				end
				if Ability.SecondsSinceLastUse(NPC.GetItem(enemy, "item_aeon_disk", true)) <= 2.55 then
					if not NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then
						if v[2] == "item_nullifier" then
							skipItem = v[1]
						end
					end
				end
			end

			if FAIO_itemHandler.myUnitName == "npc_dota_hero_tinker" then
				if NPC.IsLinkensProtected(enemy) then
					if v[2] == "item_sheepstick" then
						skipItem = v[1]
					end
				end
			end

			if NPC.HasModifier(enemy, "modifier_pudge_meat_hook") then
				if v[2] == "item_rod_of_atos" then
					skipItem = v[1]
				end
			end

			if NPC.HasItem(myHero, v[2], true) then
				if Ability.IsCastable(NPC.GetItem(myHero, v[2], true), myMana) and (v[1] - skipItem) > customOrder then
					orderItem = NPC.GetItem(myHero, v[2], true)
					customOrder = v[1]
					itemActivation = v[3]
				end
			end	
		end
		
			if FAIO_itemHandler.ItemSleepReady(0.05) and customOrder > 0 then
				if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(orderItem)) then
					if itemActivation == "target" then
						Ability.CastTarget(orderItem, enemy)
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
					if itemActivation == "no target" then
						Ability.CastNoTarget(orderItem)
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
					if itemActivation == "position" then
						Ability.CastPosition(orderItem, Entity.GetAbsOrigin(enemy))
						FAIO_itemHandler.lastItemCast = os.clock()
						customOrder = 0
						return
					end
				end
			end

		if FAIO_itemHandler.ItemSleepReady(0.05) and mjollnir and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(mjollnir, myMana) and Menu.GetValue(FAIO_options.optionItemMjollnir) > 0 then
			Ability.CastTarget(mjollnir, myHero)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end

		if FAIO_itemHandler.ItemSleepReady(0.05) and manta and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Ability.IsCastable(manta, myMana) and Menu.GetValue(FAIO_options.optionItemManta) > 0 then
			Ability.CastNoTarget(manta)
			FAIO_itemHandler.lastItemCast = os.clock()
			return
		end
	end
end

-- hurricane
function FAIO_itemHandler.ItemAutoHurricaneUsage(myHero, enemy)

	if not myHero then return end

	local myMana = NPC.GetMana(myHero)

	local orbSkill = nil
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

		if orbSkillTable[FAIO_itemHandler.myUnitName] ~= nil then
			orbSkill = NPC.GetAbility(myHero, orbSkillTable[FAIO_itemHandler.myUnitName])
		end

		if orbSkill and Ability.GetLevel(orbSkill) < 1 then
			orbSkill = nil
		end

		if orbSkill then
			if NPC.HasModifier(myHero, "modifier_item_hurricane_pike_range") then
				if Ability.GetAutoCastState(orbSkill) == false and os.clock() - FAIO_itemHandler.lastTick > 0.5 then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO, nil, Vector(), orbSkill, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
					FAIO_itemHandler.lastTick = os.clock()
					return
				end
			end
		end


	local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)
		if not hurricanePike then return end
		if not Ability.IsCastable(hurricanePike, myMana) then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	if NPC.HasModifier(myHero, "modifier_item_blade_mail_reflect") then return end
	if NPC.HasItem(myHero, "item_blade_mail", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_blade_mail", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_blade_mail", true)) < 0.25 then return end

	if os.clock() - FAIO_itemHandler.lastDefItemPop < 0.25 then return end

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if myHPperc <= Menu.GetValue(FAIO_options.optionItemHurricaneHP) then
		for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 400, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
				if NPC.IsAttacking(v) then
					if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
						if NPC.FindFacingNPC(v) == myHero then
							if enemy then
								if NPC.IsEntityInRange(myHero, enemy, 400) then
									Ability.CastTarget(hurricanePike, enemy)
									FAIO_itemHandler.lastDefItemPop = os.clock()
									break
									return
								else
									if NPC.IsEntityInRange(myHero, v, 400) then
										Ability.CastTarget(hurricanePike, v)
										FAIO_itemHandler.lastDefItemPop = os.clock()
										break
										return
									end
								end
							else
								if NPC.IsEntityInRange(myHero, v, 400) then
									Ability.CastTarget(hurricanePike, v)
									FAIO_itemHandler.lastDefItemPop = os.clock()
									break
									return
								end
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
								if enemy then
									if NPC.IsEntityInRange(myHero, enemy, 400) then
										Ability.CastTarget(hurricanePike, enemy)
										FAIO_itemHandler.lastDefItemPop = os.clock()
										break
										return
									end
								else
									if NPC.IsEntityInRange(myHero, v, 400) then
										Ability.CastTarget(hurricanePike, v)
										FAIO_itemHandler.lastDefItemPop = os.clock()
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

end

-- blade mail
function FAIO_itemHandler.ItemAutoBMUsage(myHero)

	if not myHero then return end

	local myMana = NPC.GetMana(myHero)

	local bladeMail = NPC.GetItem(myHero, "item_blade_mail", true)
		if not bladeMail then return end
		if not Ability.IsCastable(bladeMail, myMana) then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	if NPC.HasModifier(myHero, "modifier_item_hurricane_pike_range") then return end
	if NPC.HasItem(myHero, "item_hurricane_pike", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_hurricane_pike", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_hurricane_pike", true)) < 0.25 then return end

	if os.clock() - FAIO_itemHandler.lastDefItemPop < 0.25 then return end

	for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
			if NPC.IsAttacking(v) then
				if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
					if NPC.FindFacingNPC(v) == myHero then
						Ability.CastNoTarget(bladeMail)
						FAIO_itemHandler.lastDefItemPop = os.clock()
						break
						return
					end
				end
			end
			for ability, info in pairs(FAIO_data.RawDamageAbilityEstimation) do
				if NPC.HasAbility(v, ability) and Ability.IsInAbilityPhase(NPC.GetAbility(v, ability)) then
					local abilityRange = math.max(Ability.GetCastRange(NPC.GetAbility(v, ability)), info[2])
					local abilityRadius = info[3]
					if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
						if next(FAIO_dodgeIT.dodgeItTable) == nil then
							Ability.CastNoTarget(bladeMail)
							FAIO_itemHandler.lastDefItemPop = os.clock()
							break
							return
						end
					end
				end
			end
		end	
	end
	return
	
end


-- armlet
function FAIO_itemHandler.getAbilityDamageInstances(myHero)

	if not myHero then return end

	for i, v in ipairs(Entity.GetHeroesInRadius(myHero, 2000, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsNPC(v) and Entity.IsHero(v) and not Entity.IsDormant(v) then
			for ability, info in pairs(FAIO_data.RawDamageAbilityEstimation) do
				if NPC.HasAbility(v, ability) and Ability.IsInAbilityPhase(NPC.GetAbility(v, ability)) then
					local abilityStyle = info[1]
					local abilityRange = math.max(Ability.GetCastRange(NPC.GetAbility(v, ability)), info[2])
					local abilityRadius = info[3]
					local abilityDamage = math.max(Ability.GetDamage(NPC.GetAbility(v, ability)), Ability.GetLevel(NPC.GetAbility(v, ability)) * info[4] * 1.1)
					local abilityDelay = Ability.GetCastPoint(NPC.GetAbility(v, ability)) + info[6]
					local projectileInfo = info[5]
					local curTime = FAIO_itemHandler.utilityRoundNumber(GameRules.GetGameTime(), 3)
					if projectileInfo < 1 then
						if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
							if #FAIO_itemHandler.armletDamageInstanceTable < 1 then
								table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = ability, time = FAIO_itemHandler.utilityRoundNumber(curTime + abilityDelay, 3), casttime = abilityDelay, type = "ability", damage = abilityDamage, isProjectile = false })
							else
								local inserted = false
								for k, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
									if info.instanceindex == ability then
										inserted = true
									end
								end
								if not inserted then
									table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = ability, time = FAIO_itemHandler.utilityRoundNumber(curTime + abilityDelay, 3), casttime = abilityDelay, type = "ability", damage = abilityDamage, isProjectile = false })
								end
							end
						end
					else
						if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
							local myProjectedPosition = Entity.GetAbsOrigin(myHero)
							local projectileTiming = ((Entity.GetAbsOrigin(v) - myProjectedPosition):Length2D() - NPC.GetHullRadius(myHero)) / projectileInfo
								if ability == "beastmaster_wild_axes" then
									projectileTiming = math.min(projectileTiming, 1)
								end
							if #FAIO_itemHandler.armletDamageInstanceTable < 1 then
								table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = ability, time = FAIO_itemHandler.utilityRoundNumber(curTime + abilityDelay + projectileTiming - 0.035, 3), casttime = abilityDelay, type = "ability", damage = abilityDamage, projectileorigin = Entity.GetAbsOrigin(v), projectilestarttime = GameRules.GetGameTime() + abilityDelay - 0.035, projectilespeed = projectileInfo, isProjectile = true })
							else
								local inserted = false
								for k, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
									if info.instanceindex == ability then
										inserted = true
									end
								end
								if not inserted then
									table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = ability, time = FAIO_itemHandler.utilityRoundNumber(curTime + abilityDelay + projectileTiming - 0.035, 3), casttime = abilityDelay, type = "ability", damage = abilityDamage, projectileorigin = Entity.GetAbsOrigin(v), projectilestarttime = GameRules.GetGameTime() + abilityDelay - 0.035, projectilespeed = projectileInfo, isProjectile = true })
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

function FAIO_itemHandler.armletProcessInstanceTable(myHero)

	if not myHero then
		FAIO_itemHandler.armletDamageInstanceTable = {}
		return
	end

	if #FAIO_itemHandler.armletDamageInstanceTable < 1 then return end
	if #FAIO_itemHandler.armletDamageInstanceTable > 1 then
		table.sort(FAIO_itemHandler.armletDamageInstanceTable, function(a, b)
       			return a.time < b.time
    		end)
	end

	for i, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
		if info then	
			if info.isProjectile == true then
				local originPos = info.projectileorigin
				local myHullSize = NPC.GetHullRadius(myHero)
				local projectileStart = info.projectilestarttime
				local projectileSpeed = info.projectilespeed
				local timeElapsed = math.max((GameRules.GetGameTime() - projectileStart), 0)
				local projectilePos = originPos + (Entity.GetAbsOrigin(myHero) - originPos):Normalized():Scaled(timeElapsed*projectileSpeed)
				local myDisToOrigin = (Entity.GetAbsOrigin(myHero) - originPos):Length2D() - myHullSize
				local projectilDisToOrigin = (projectilePos - originPos):Length2D()
				if projectilDisToOrigin < myDisToOrigin and timeElapsed > 0 then
					local myDisToProjectile = (Entity.GetAbsOrigin(myHero) - projectilePos):Length2D() - myHullSize
					if myDisToProjectile > 1 then
						local remainingTravelTime = math.max(myDisToProjectile / projectileSpeed, 0)
						local processImpactTime = GameRules.GetGameTime() + remainingTravelTime
						if math.abs(info.time - processImpactTime) > 0.01 then
							local insert = table.remove(FAIO_itemHandler.armletDamageInstanceTable, i)
							insert.time = FAIO_itemHandler.utilityRoundNumber(processImpactTime, 3)
							table.insert(FAIO_itemHandler.armletDamageInstanceTable, insert)
							break
							return
						end
					end
				end
			end
			if GameRules.GetGameTime() > info.time then
				local backSwingCheck = 0
					if info.backswingend ~= nil then
						backSwingCheck = info.backswingend - info.time
					end
				if GameRules.GetGameTime() > info.time + math.max(backSwingCheck, 0) + 0.25 then
					table.remove(FAIO_itemHandler.armletDamageInstanceTable, i)
					break
					return
				end
			end
		end
	end
	
	return	

end

function FAIO_itemHandler.getDotDamageTicks(myHero)

	if not myHero then return end

	for dotMod, tickRate in pairs(FAIO_data.armletDotTickTable) do
		if NPC.HasModifier(myHero, dotMod) then
			local creationTime = FAIO_itemHandler.utilityRoundNumber(Modifier.GetCreationTime(NPC.GetModifier(myHero, dotMod)), 3) + 0.035
			local nextTick = creationTime + math.max(math.ceil((GameRules.GetGameTime() - creationTime) / tickRate), 1) * tickRate
			if #FAIO_itemHandler.armletDamageInstanceTable < 1 then
				table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = dotMod, time = nextTick, casttime = tickRate, type = "dot", damage = 50, isProjectile = false })
			else
				local inserted = false
				for k, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
					if info and info.instanceindex == dotMod and info.time == nextTick then
						inserted = true
					end
				end
				if not inserted then
					table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = dotMod, time = nextTick, casttime = tickRate, type = "dot", damage = 50, isProjectile = false })
				end
			end
		else
			for i, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
				if info.instanceindex == dotMod then
					table.remove(FAIO_itemHandler.armletDamageInstanceTable, i)
				end
			end	

		end
	end

	for i, v in ipairs(Entity.GetHeroesInRadius(myHero, 1351, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsNPC(v) and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
			for mod, info in pairs(FAIO_data.armletDotTickTableAOE) do
				if NPC.HasModifier(v, mod) then
					local effectRadius = info[1]
					local tickRate = info[2]
					if NPC.IsEntityInRange(myHero, v, effectRadius) then
						local creationTime = FAIO_itemHandler.utilityRoundNumber(Modifier.GetCreationTime(NPC.GetModifier(v, mod)), 2) + 0.035
						local nextTick = creationTime + math.ceil((GameRules.GetGameTime() - creationTime) / tickRate) * tickRate
						if #FAIO_itemHandler.armletDamageInstanceTable < 1 then
							table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = mod, time = nextTick, casttime = tickRate, type = "dot", damage = 50, isProjectile = false })
						else
							local inserted = false
							for k, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
								if info.instanceindex == mod then
									inserted = true
								end
							end
							if not inserted then
								table.insert(FAIO_itemHandler.armletDamageInstanceTable, { instanceindex = mod, time = nextTick, casttime = tickRate, type = "dot", damage = 50, isProjectile = false })
							end
						end
					else
						for i, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
							if info.instanceindex == mod then
								table.remove(FAIO_itemHandler.armletDamageInstanceTable, i)
							end
						end	
					end
				else
					for i, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
						if info.instanceindex == mod then
							table.remove(FAIO_itemHandler.armletDamageInstanceTable, i)
						end
					end
				end
			end
		end
	end

	return 

end

function FAIO_itemHandler.getAdjustedMaxTrueDamage(unit, target)

	if not unit then return 0 end
	if not target then return 0 end

	if Entity.IsDormant(unit) then return 0 end
	if Entity.IsDormant(target) then return 0 end

	local maxDamage = NPC.GetTrueMaximumDamage(unit)
	local maxTrueDamage = NPC.GetDamageMultiplierVersus(unit, target) * maxDamage * NPC.GetArmorDamageMultiplier(target)

	local bonusDamage = 0
	if NPC.HasModifier(unit, "modifier_storm_spirit_overload") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		local overload = NPC.GetAbility(unit, "storm_spirit_overload")
		local bonus = 0
		if overload and Ability.GetLevel(overload) > 0 then
			bonus = Ability.GetDamage(overload)
		end
		local bonusTrue = (1 - NPC.GetMagicalArmorValue(target)) * bonus + bonus * (Hero.GetIntellectTotal(unit) / 14 / 100)
		bonusDamage = bonusDamage + bonusTrue
	end

	if NPC.HasAbility(unit, "clinkz_searing_arrows") then
		local orb = NPC.GetAbility(unit, "clinkz_searing_arrows")
		if orb and Ability.IsCastable(orb, NPC.GetMana(unit)) and Ability.GetLevel(orb) > 0 then
			local bonus = 20 + 10 * Ability.GetLevel(orb)
				if NPC.HasAbility(unit, "special_bonus_unique_clinkz_1") then
					if Ability.GetLevel(NPC.GetAbility(unit, "special_bonus_unique_clinkz_1")) > 0 then
						bonus = bonus + 30
					end
				end
			local bonusTrue = NPC.GetDamageMultiplierVersus(unit, target) * bonus * NPC.GetArmorDamageMultiplier(target)
			bonusDamage = bonusDamage + bonusTrue
		end
	end

	if NPC.HasAbility(unit, "obsidian_destroyer_arcane_orb") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		local orb = NPC.GetAbility(unit, "obsidian_destroyer_arcane_orb")
		if orb and Ability.IsCastable(orb, NPC.GetMana(unit)) and Ability.GetLevel(orb) > 0 then
			local bonus = (0.05 + (0.01 * Ability.GetLevel(orb))) * NPC.GetMana(unit)
			local bonusTrue = bonus
			bonusDamage = bonusDamage + bonusTrue
		end
	end

	if NPC.HasAbility(unit, "silencer_glaives_of_wisdom") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		local orb = NPC.GetAbility(unit, "silencer_glaives_of_wisdom")
		if orb and Ability.IsCastable(orb, NPC.GetMana(unit)) and Ability.GetLevel(orb) > 0 then
			local bonus = 0.15 * Ability.GetLevel(orb) * Hero.GetIntellectTotal(unit)
				if NPC.HasAbility(unit, "special_bonus_unique_silencer_3") then
					if Ability.GetLevel(NPC.GetAbility(unit, "special_bonus_unique_silencer_3")) > 0 then
						bonus = (0.2 + 0.15 * Ability.GetLevel(orb)) * Hero.GetIntellectTotal(unit)
					end
				end
			local bonusTrue = bonus
			bonusDamage = bonusDamage + bonusTrue
		end
	end

	if NPC.HasAbility(unit, "kunkka_tidebringer") then
		local orb = NPC.GetAbility(unit, "kunkka_tidebringer")
		if orb and Ability.IsCastable(orb, NPC.GetMana(unit)) and Ability.GetLevel(orb) > 0 then
			local bonus = Ability.GetLevelSpecialValueFor(orb, "damage_bonus")
			local bonusTrue = NPC.GetDamageMultiplierVersus(unit, target) * bonus * NPC.GetArmorDamageMultiplier(target)
			bonusDamage = bonusDamage + bonusTrue
		end
	end

	if NPC.HasAbility(unit, "enchantress_impetus") then
		local orb = NPC.GetAbility(unit, "enchantress_impetus")
		if orb and Ability.IsCastable(orb, NPC.GetMana(unit)) and Ability.GetLevel(orb) > 0 then
			local distance = (Entity.GetAbsOrigin(unit) - Entity.GetAbsOrigin(target)):Length2D() * 1.35
				if distance > 1750 then
					distance = 1750
				end
			local distanceDamage = Ability.GetLevelSpecialValueForFloat(orb, "distance_damage_pct")
				if NPC.HasAbility(unit, "special_bonus_unique_enchantress_4") then
					if Ability.GetLevel(NPC.GetAbility(unit, "special_bonus_unique_enchantress_4")) > 0 then
						distanceDamage = distanceDamage + 8
					end
				end
			local bonus = distance * (distanceDamage / 100)
			local bonusTrue = bonus
			bonusDamage = bonusDamage + bonusTrue
		end
	end

	if Entity.IsSameTeam(unit, target) then
		bonusDamage = 0
	end

	if NPC.IsStructure(target) then
		bonusDamage = 0
	end
	
	return math.ceil(maxTrueDamage + bonusDamage)

end

function FAIO_itemHandler.armletShouldBeToggledOff(myHero)

	if not myHero then return true end

	if FAIO_itemHandler.isArmletActive == false then return false end
	if FAIO_itemHandler.armletCurrentHPGain < 250 then return false end

	if Menu.IsEnabled(FAIO_options.optionItemArmletManuallyOverride) then
		if FAIO_itemHandler.isArmletManuallyToggled == true then 
			return false 
		end
	end

	local hpTreshold = Menu.GetValue(FAIO_options.optionItemArmletHPTreshold)
	local curTime = GameRules.GetGameTime()

	if #FAIO_itemHandler.armletDamageInstanceTable < 1 then
		if Menu.IsEnabled(FAIO_options.optionItemArmletCombo) then
			if Menu.IsKeyDown(FAIO_options.optionComboKey) then
				return false
			end
		end
		if Menu.IsEnabled(FAIO_options.optionItemArmletRightClick) then
			if FAIO_itemHandler.armletRightClickToggle then
				return false
			end
		end
		local gettingFaced = false
		for i, v in ipairs(Entity.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsNPC(v) and not Entity.IsDormant(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" then
				if NPC.FindFacingNPC(v) == myHero then
					if NPC.IsRanged(v) then
						if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 145) then
							gettingFaced = true
						end
					else
						if NPC.IsEntityInRange(myHero, v, 285) then
							gettingFaced = true
						end
					end
				end
			end
		end
		if gettingFaced then
			if Entity.GetHealth(myHero) > hpTreshold then
				return false
			end
		end
		return true
	else
		local nextDamageInstance = 9999
			for i, v in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
				if v and v.time - GameRules.GetGameTime() > 0.0 then
					if i < nextDamageInstance then
						nextDamageInstance = i
					end
				end
			end
		if nextDamageInstance > 999 then
			if Menu.IsEnabled(FAIO_options.optionItemArmletCombo) then
				if Menu.IsKeyDown(FAIO_options.optionComboKey) then
					if Entity.GetHealth(myHero) > hpTreshold then
						return false
					end
				end
			end
			if Menu.IsEnabled(FAIO_options.optionItemArmletRightClick) then
				if FAIO_itemHandler.armletRightClickToggle then
					if Entity.GetHealth(myHero) > hpTreshold then
						return false
					end
				end
			end
			local gettingFaced = false
			for i, v in ipairs(Entity.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
				if v and Entity.IsNPC(v) and not Entity.IsDormant(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" then
					if NPC.FindFacingNPC(v) == myHero then
						if NPC.IsRanged(v) then
							if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 145) then
								gettingFaced = true
							end
						else
							if NPC.IsEntityInRange(myHero, v, 285) then
								gettingFaced = true
							end
						end
					end
				end
			end
			if gettingFaced then
				if Entity.GetHealth(myHero) > hpTreshold then
					return false
				end
			end
			
			local inBackSwing = true
				for k, l in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
					if l.backswingstart ~= nil and l.backswingend ~= nil then
						if GameRules.GetGameTime() < l.backswingstart or GameRules.GetGameTime() > l.backswingend - 0.15 then
							inBackSwing = false
							break
						end
					end
				end

			if not inBackSwing then
				return false
			end

			local lastDamageInstanceTime = FAIO_itemHandler.armletDamageInstanceTable[#FAIO_itemHandler.armletDamageInstanceTable]["time"]
			if GameRules.GetGameTime() > lastDamageInstanceTime + 0.075 then
				return true
			end
		else
			local safeToggle = false
			local emergencyToggle = false
			for i, instance in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
				local instanceTiming = instance.time
				local instanceDamage = instance.damage + math.ceil((instanceTiming - curTime) / 0.11) * 6	
				local toggleTreshold = math.max(instanceDamage, hpTreshold)
				if instanceDamage > Entity.GetHealth(myHero) then
					if i > 1 then
						if GameRules.GetGameTime() - FAIO_itemHandler.armletDamageInstanceTable[i-1]["time"] > 0.075 then
							emergencyToggle = true
							break
						end
					else
						emergencyToggle = true
						break
					end
				else
					if Entity.GetHealth(myHero) <= toggleTreshold then
						if instanceTiming - GameRules.GetGameTime() > 0.42 then
							local inBackSwing = true
								for k, l in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
									if l.backswingstart ~= nil and l.backswingend ~= nil then
										if GameRules.GetGameTime() < l.backswingstart or GameRules.GetGameTime() > l.backswingend - 0.15 then
											if l.casttime < 0.25 then
												inBackSwing = false
												break
											end
										end
									end
								end
							if inBackSwing then
								if i > 1 then
									if GameRules.GetGameTime() - FAIO_itemHandler.armletDamageInstanceTable[i-1]["time"] > 0.075 then
										safeToggle = true
										break
									end
								else
									safeToggle = true
									break
								end	
							end
						end
					else
						local adjustedHP = math.max((Entity.GetHealth(myHero) - FAIO_itemHandler.armletCurrentHPGain), 1)
						if adjustedHP > toggleTreshold and (not Menu.IsKeyDown(FAIO_options.optionComboKey) or FAIO_itemHandler.armletRightClickToggle) then
							safeToggle = true
						end
					end
				end	
			end

			if emergencyToggle then
				return true
			end

			if safeToggle then
				return true
			end
		end
	end

	return false
end
				
function FAIO_itemHandler.armletShouldBeToggledOn(myHero)

	if not myHero then return false end

	if FAIO_itemHandler.isArmletActive == true then return false end

	if Menu.IsEnabled(FAIO_options.optionItemArmletManuallyOverride) then
		if FAIO_itemHandler.isArmletManuallyToggled == true then 
			return false 
		end
	end

	if NPC.HasModifier(myHero, "modifier_ice_blast") then
		return false
	end

	local hpTreshold = Menu.GetValue(FAIO_options.optionItemArmletHPTreshold)
	local myHP = Entity.GetHealth(myHero)

	if Menu.IsEnabled(FAIO_options.optionItemArmletCombo) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) then
			if FAIO_itemHandler.LockedTarget ~= nil then
				return true
			end
		end
	end

	if myHP < hpTreshold then
		for i, v in ipairs(Entity.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsNPC(v) and not Entity.IsDormant(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" then
				if NPC.FindFacingNPC(v) == myHero then
					if NPC.IsRanged(v) then
						if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 145) then
							return true
						end
					else
						if NPC.IsEntityInRange(myHero, v, 285) then
							return true
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionItemArmletRightClick) then
		if FAIO_itemHandler.armletRightClickToggle then
			return true
		end
	end

	for i, info in ipairs(FAIO_itemHandler.armletDamageInstanceTable) do
		if info then
			local nextInstance = info.time
			local nextDamage = info.damage
			local triggerTreshold = math.max(hpTreshold, nextDamage)
			if nextInstance > GameRules.GetGameTime() then
				if nextInstance - GameRules.GetGameTime() <= 1.0 then
					if myHP <= triggerTreshold then	
						return true
					end
				end
			end
		end
	end

	return false
end

function FAIO_itemHandler.armletHandler(myHero)

	if not myHero then return end

	local armlet = NPC.GetItem(myHero, "item_armlet", true)
		if not armlet then return end

	FAIO_itemHandler.armletProcessInstanceTable(myHero)
	FAIO_itemHandler.getDotDamageTicks(myHero)
	FAIO_itemHandler.getAbilityDamageInstances(myHero)

	if Ability.GetToggleState(armlet) then
		if os.clock() - FAIO_itemHandler.armletToggleTimePingAdjuster <= (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)) / 2 + 0.05 then
			FAIO_itemHandler.isArmletActive = FAIO_itemHandler.isArmletActive
		else
			FAIO_itemHandler.isArmletActive = true
		end
	else
		if os.clock() - FAIO_itemHandler.armletToggleTimePingAdjuster <= (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)) / 2 + 0.05 then
			FAIO_itemHandler.isArmletActive = FAIO_itemHandler.isArmletActive
		else
			FAIO_itemHandler.isArmletActive = false
		end
		if FAIO_itemHandler.isArmletManuallyToggled == true and GameRules.GetGameTime() - FAIO_itemHandler.isArmletManuallyToggledTime >= 0.1 then
			FAIO_itemHandler.isArmletManuallyToggled = false
		end
	end

	local armletModifier = NPC.GetModifier(myHero, "modifier_item_armlet_unholy_strength")
	local maxHPGain = 464
	if armletModifier ~= nil then
		local armletStartTime = Modifier.GetCreationTime(armletModifier)
		if GameRules.GetGameTime() - armletStartTime > 0.6 then
			FAIO_itemHandler.armletCurrentHPGain = maxHPGain
		else
			if GameRules.GetGameTime() - armletStartTime > 0 then
				FAIO_itemHandler.armletCurrentHPGain = math.floor((GameRules.GetGameTime() - armletStartTime) * (maxHPGain/0.6))
			end
		end
	else
		FAIO_itemHandler.armletCurrentHPGain = 0
	end

	if os.clock() < FAIO_itemHandler.armletDelayer then return end

	if Menu.IsEnabled(FAIO_options.optionItemArmletManuallyOverride) then
		if FAIO_itemHandler.isArmletManuallyToggled then 
			return 
		end
	end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	if os.clock() < FAIO_itemHandler.armletToggleTime then return end

	if FAIO_itemHandler.armletShouldBeToggledOn(myHero) then
		Ability.Toggle(armlet)
		FAIO_itemHandler.isArmletActive = true
		FAIO_itemHandler.armletToggleTime = os.clock() + 0.65 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		FAIO_itemHandler.armletToggleTimePingAdjuster = os.clock()
		return
	end

	if FAIO_itemHandler.armletShouldBeToggledOff(myHero) then
		if os.clock() - FAIO_itemHandler.armletToggleTime > 0.04 then
			Ability.Toggle(armlet)
			FAIO_itemHandler.isArmletActive = false
			FAIO_itemHandler.armletToggleTime = os.clock() + 0.01
			FAIO_itemHandler.armletToggleTimePingAdjuster = os.clock()
			return
		end
	end

end

-- linkens breaker functions
function FAIO_itemHandler.LinkensBreakerNew(myHero)

	if not myHero then return end

	if not Menu.IsEnabled(FAIO_options.optionLinkensEnable) then return end

	local myMana = NPC.GetMana(myHero)

 	local prioItem
	local prioOrder = 0

	for k, v in ipairs(FAIO_itemHandler.LinkensBreakerItemOrder) do
	
		if NPC.HasItem(myHero, v[2], true) then
			if Ability.IsCastable(NPC.GetItem(myHero, v[2], true), myMana) and v[1] > prioOrder then
					prioItem = v[2]
					prioOrder = v[1]
				
			end
		end	
	
	end
	return prioItem	
end
	
-- utility item usage functions
function FAIO_itemHandler.utilityItemUsage(myHero)

	if not myHero then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	local stick = NPC.GetItem(myHero, "item_magic_stick", true)
	local wand = NPC.GetItem(myHero, "item_magic_wand", true)
	local mekansm = NPC.GetItem(myHero, "item_mekansm", true)
	local greaves = NPC.GetItem(myHero, "item_guardian_greaves", true)
	local arcane = NPC.GetItem(myHero, "item_arcane_boots", true)
	local midas = NPC.GetItem(myHero, "item_hand_of_midas", true)
	local cheese = NPC.GetItem(myHero, "item_cheese", true)
	local faerie = NPC.GetItem(myHero, "item_faerie_fire", true)
	local bottle = NPC.GetItem(myHero, "item_bottle", true)

	local myMana = NPC.GetMana(myHero)

	if (stick or wand or cheese or faerie) and Menu.IsEnabled(FAIO_options.optionUtilityStick) then
		FAIO_itemHandler.utilityItemStick(myHero, stick, wand, cheese, faerie)
	end
	if mekansm and Menu.IsEnabled(FAIO_options.optionUtilityMek) then
		FAIO_itemHandler.utilityItemMek(myHero, mekansm, myMana)
	end
	if greaves and Menu.IsEnabled(FAIO_options.optionUtilityGreaves) then
		FAIO_itemHandler.utilityItemGreaves(myHero, greaves)
	end
	if arcane and Menu.IsEnabled(FAIO_options.optionUtilityArcane) then
		FAIO_itemHandler.utilityItemArcane(myHero, arcane)
	end
	if midas and Menu.IsEnabled(FAIO_options.optionUtilityMidas) then
		FAIO_itemHandler.utilityItemMidas(myHero, midas)
	end
	if bottle and Menu.IsEnabled(FAIO_options.optionUtilityBottle) then
		FAIO_itemHandler.utilityItemBottle(myHero, bottle)
	end

end

function FAIO_itemHandler.utilityItemStick(myHero, stick, wand, cheese, faerie)

	if not myHero then return end
	if (Entity.GetAbsOrigin(myHero) - FAIO_itemHandler.GetMyFountainPos(myHero)):Length2D() < 1500 then return end
	
	local myHealthPerc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100
	
	if Entity.IsAlive(myHero) and not NPC.HasModifier(myHero, "modifier_ice_blast") then
		if stick and myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsReady(stick) then
			if Item.GetCurrentCharges(stick) >= 1 then 
				Ability.CastNoTarget(stick)
				return
			end
		end
		if wand and myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsReady(wand) then 
			if Item.GetCurrentCharges(wand) >= 1 then 
				Ability.CastNoTarget(wand)
				return
			end
		end
		if cheese and myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsReady(cheese) then 
			Ability.CastNoTarget(cheese)
			return
		end
		if faerie and myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsReady(faerie) then 
			Ability.CastNoTarget(faerie)
			return
		end
	end
end

function FAIO_itemHandler.utilityItemBottle(myHero, bottle)

	if not myHero then return end
	if not bottle then return end
		if Item.GetCurrentCharges(bottle) < 2 then return end

	if Ability.SecondsSinceLastUse(bottle) > -1 and Ability.SecondsSinceLastUse(bottle) < 0.5 then return end
	if os.clock() < FAIO_itemHandler.lastTick then return end

	for i = 1, Abilities.Count() do 
		local abilities = Abilities.Get(i)
		if Entity.GetOwner(abilities) == myHero then
			if Ability.SecondsSinceLastUse(abilities) > -1 and Ability.SecondsSinceLastUse(abilities) < 0.5 then 
				return
			end
		end
	end

	if NPC.HasModifier(myHero, "modifier_bottle_regeneration") then return end
	if not NPC.HasModifier(myHero, "modifier_item_empty_bottle") then return end

	local hpGap = Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)
	local manaGap = NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)

	for i, v in ipairs(Entity.GetUnitsInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsNPC(v) and Entity.IsAlive(v) and not Entity.IsDormant(v) then
			if Entity.IsHero(v) then
				if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 250) then
					return
				end
			else
				if NPC.GetUnitName(v) == "npc_dota_roshan" then
					if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 375) then
						return
					end
				end
			end	
		end
	end
			
	if hpGap < 0.75 then
		Ability.CastNoTarget(bottle)
		return
	end

	if manaGap < 0.75 then
		Ability.CastNoTarget(bottle)
		return
	end

	return

end

function FAIO_itemHandler.utilityItemMek(myHero, mekansm, myMana)

	if not myHero then return end
	if not mekansm then return end

	if (Entity.GetAbsOrigin(myHero) - FAIO_itemHandler.GetMyFountainPos(myHero)):Length2D() < 1500 then return end

	local myHealthPerc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if Ability.IsCastable(mekansm, myMana) then
		if Entity.IsAlive(myHero) and not NPC.HasModifier(myHero, "modifier_ice_blast") then	
			if (myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth)) and Ability.IsCastable(mekansm, myMana) then 
				Ability.CastNoTarget(mekansm) 
				return
			end
		end

		for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
			if teamMates then
				if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) and not NPC.HasModifier(teamMates, "modifier_ice_blast") then	
					if (Entity.GetHealth(teamMates) / Entity.GetMaxHealth(teamMates)) * 100 <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsCastable(mekansm, myMana) then
						for _, v in ipairs(Entity.GetHeroesInRadius(teamMates, 1000, Enum.TeamType.TEAM_ENEMY)) do
							if v and Entity.IsHero(v) and not Entity.IsDormant(v) then
								if NPC.FindFacingNPC(v) == teamMates then
									Ability.CastNoTarget(mekansm) 
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

function FAIO_itemHandler.utilityItemGreaves(myHero, greaves)

	if not myHero then return end
	if not greaves then return end

	if (Entity.GetAbsOrigin(myHero) - FAIO_itemHandler.GetMyFountainPos(myHero)):Length2D() < 1500 then return end

	local myHealthPerc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if Ability.IsReady(greaves) then
		if Entity.IsAlive(myHero) and not NPC.HasModifier(myHero, "modifier_ice_blast") then	
			if greaves and (myHealthPerc <= Menu.GetValue(FAIO_options.optionUtilityHealth)) and Ability.IsReady(greaves) then 
				Ability.CastNoTarget(greaves) 
				return
			end
		end

		for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
			if teamMates then
				if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) and not NPC.HasModifier(teamMates, "modifier_ice_blast") then	
					if greaves and (Entity.GetHealth(teamMates) / Entity.GetMaxHealth(teamMates)) * 100 <= Menu.GetValue(FAIO_options.optionUtilityHealth) and Ability.IsReady(greaves) then
						for _, v in ipairs(Entity.GetHeroesInRadius(teamMates, 1000, Enum.TeamType.TEAM_ENEMY)) do
							if v and Entity.IsHero(v) and not Entity.IsDormant(v) then
								if NPC.FindFacingNPC(v) == teamMates then
									Ability.CastNoTarget(greaves) 
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

function FAIO_itemHandler.utilityItemArcane(myHero, arcane)

	if not myHero then return end
	if not arcane then return end

	if (Entity.GetAbsOrigin(myHero) - FAIO_itemHandler.GetMyFountainPos(myHero)):Length2D() < 3000 then return end

	local myManaMissing = NPC.GetMaxMana(myHero) - NPC.GetMana(myHero)

	if Ability.IsReady(arcane) then
		if Entity.IsAlive(myHero) then
			if arcane and myManaMissing >= 200 then 
				Ability.CastNoTarget(arcane)
				return 
			end
		end


		for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
			if teamMates then
				if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) then
					if arcane and (NPC.GetMana(teamMates) / NPC.GetMaxMana(teamMates)) * 100 <= 40 and Ability.IsReady(arcane) then 
						Ability.CastNoTarget(arcane)
						break
						return
					end
				end 
			end
		end
	end
end

function FAIO_itemHandler.utilityItemMidas(myHero, midas)

	if not myHero then return end
	if not midas then return end
	if not Ability.IsReady(midas) then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	if NPC.HasModifier(myHero, "modifier_spirit_breaker_charge_of_darkness") then return end

	local targetCreep
	local maxXP = 0

	for _, creeps in ipairs(NPC.GetUnitsInRadius(myHero, 600, Enum.TeamType.TEAM_ENEMY)) do
		if creeps and not Entity.IsHero(creeps) then
			local bounty = NPC.GetBountyXP(creeps)
			if FAIO_itemHandler.IsCreepAncient(creeps) == false then
				if (NPC.IsLaneCreep(creeps) or NPC.IsCreep(creeps)) and not NPC.IsDormant(creeps) then
					if bounty > maxXP then
						targetCreep = creeps
						maxXP = bounty
					end	
				end
			end
		end
	end

	if targetCreep ~= nil and maxXP > 0 then
		Ability.CastTarget(midas, targetCreep)
		return
	end

end

function FAIO_itemHandler.useDefensiveItems(myHero, enemy)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionDefensiveItems) then return end

	if (Entity.GetAbsOrigin(myHero) - FAIO_itemHandler.GetMyFountainPos(myHero)):Length2D() < 1500 then return end

	if os.clock() - FAIO_itemHandler.lastDefItemPop < 0.25 then return end

	if FAIO_itemHandler.ItemCastStop then return end

	if FAIO_itemHandler.heroCanCastItems(myHero) == false then return end
	if FAIO_itemHandler.IsHeroInvisible(myHero) == true then return end

	local myMana = NPC.GetMana(myHero)

	local glimmerCape = NPC.GetItem(myHero, "item_glimmer_cape", true)
	local lotusOrb = NPC.GetItem(myHero, "item_lotus_orb", true)
	local crimsonGuard = NPC.GetItem(myHero, "item_crimson_guard", true)
	local pipe = NPC.GetItem(myHero, "item_pipe", true)
	local solarCrest = NPC.GetItem(myHero, "item_solar_crest", true)
	local BKB = NPC.GetItem(myHero, "item_black_king_bar", true)
	local satanic = NPC.GetItem(myHero, "item_satanic", true)
	local medallion = NPC.GetItem(myHero, "item_medallion_of_courage", true)
	local ghost = NPC.GetItem(myHero, "item_ghost", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)

	local channellingTable = {
		"bane_fiends_grip",
		"crystal_maiden_freezing_field",
		"enigma_black_hole",
		"pudge_dismember",
		"pugna_life_drain",
		"sandking_epicenter",
		"shadow_shaman_shackles",
		"warlock_upheaval",
		"witch_doctor_death_ward"
				}

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsGlimmer) then
		if glimmerCape and Ability.IsCastable(glimmerCape, myMana) then
			if FAIO_itemHandler.IsNPCinDanger(myHero, myHero) then
				Ability.CastTarget(glimmerCape, myHero)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
			if NPC.IsChannellingAbility(myHero) then
				for _, ability in ipairs(channellingTable) do
					if NPC.HasAbility(myHero, ability) and Ability.IsChannelling(NPC.GetAbility(myHero, ability)) then
						Ability.CastTarget(glimmerCape, myHero)
						FAIO_itemHandler.lastDefItemPop = os.clock()
						return
					end
				end
			end
			if NPC.HasModifier(myHero, "modifier_teleporting") then
				local myFountain = FAIO_itemHandler.GetMyFountainPos(myHero)
				if not NPC.IsPositionInRange(myHero, myFountain, 2500, 0) then
					Ability.CastTarget(glimmerCape, myHero)
					FAIO_itemHandler.lastDefItemPop = os.clock()
					return
				end
			end
			if Menu.IsEnabled(FAIO_options.optionDefensiveItemsAlly) then
				local teamMatesAround = NPC.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_FRIEND)
				for _, ally in ipairs(teamMatesAround) do
					if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
						if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
							Ability.CastTarget(glimmerCape, ally)
							FAIO_itemHandler.lastDefItemPop = os.clock()
							break
							return
						end
						if NPC.IsChannellingAbility(ally) then
							for _, ability in ipairs(channellingTable) do
								if NPC.HasAbility(ally, ability) and Ability.IsChannelling(NPC.GetAbility(ally, ability)) then
									Ability.CastTarget(glimmerCape, ally)
									FAIO_itemHandler.lastDefItemPop = os.clock()
									return
								end
							end
						end
					end
				end
			end
		end
	end

	if FAIO_itemHandler.isHeroChannelling(myHero) == true then return end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsGhost) then
		if ghost and Ability.IsReady(ghost) then
			if Entity.GetHealth(myHero) <= Menu.GetValue(FAIO_options.optionDefensiveItemsThreshold)/100 * Entity.GetMaxHealth(myHero) then
				for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
					if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
						if NPC.FindFacingNPC(v) == myHero then
							if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
								if NPC.IsAttacking(v) then
									Ability.CastNoTarget(ghost)
									FAIO_itemHandler.lastDefItemPop = os.clock()
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
				
	if Menu.IsEnabled(FAIO_options.optionDefensiveItemslotusOrb) then
		if lotusOrb and Ability.IsCastable(lotusOrb, myMana) then
			if FAIO_itemHandler.IsNPCinDanger(myHero, myHero) then
				Ability.CastTarget(lotusOrb, myHero)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
			if Menu.IsEnabled(FAIO_options.optionDefensiveItemsAlly) then
				local teamMatesAround = NPC.GetHeroesInRadius(myHero, 875, Enum.TeamType.TEAM_FRIEND)
				for _, ally in ipairs(teamMatesAround) do
					if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
						if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
							Ability.CastTarget(lotusOrb, ally)
							FAIO_itemHandler.lastDefItemPop = os.clock()
							break
							return
						end
					end
				end
			end
		end
	end
	
	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsCrimson) then
		if crimsonGuard and Ability.IsCastable(crimsonGuard, myMana) then
			if FAIO_itemHandler.IsNPCinDanger(myHero, myHero) then
				Ability.CastNoTarget(crimsonGuard)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
			local teamMatesAround = NPC.GetHeroesInRadius(myHero, 875, Enum.TeamType.TEAM_FRIEND)
			for _, ally in ipairs(teamMatesAround) do
				if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
					if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
						Ability.CastNoTarget(crimsonGuard)
						FAIO_itemHandler.lastDefItemPop = os.clock()
						break
						return
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsCrest) then
		if solarCrest and Ability.IsCastable(solarCrest, myMana) then
			if Menu.IsEnabled(FAIO_options.optionDefensiveItemsAlly) then
				local teamMatesAround = NPC.GetHeroesInRadius(myHero, 975, Enum.TeamType.TEAM_FRIEND)
				for _, ally in ipairs(teamMatesAround) do
					if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
						if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
							Ability.CastTarget(solarCrest, ally)
							FAIO_itemHandler.lastDefItemPop = os.clock()
							break
							return
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsMedallion) then
		if medallion and Ability.IsCastable(medallion, myMana) then
			if Menu.IsEnabled(FAIO_options.optionDefensiveItemsAlly) then
				local teamMatesAround = NPC.GetHeroesInRadius(myHero, 975, Enum.TeamType.TEAM_FRIEND)
				for _, ally in ipairs(teamMatesAround) do
					if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
						if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
							Ability.CastTarget(medallion, ally)
							FAIO_itemHandler.lastDefItemPop = os.clock()
							break
							return
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsPipe) then
		if pipe and Ability.IsCastable(pipe, myMana) then
			if FAIO_itemHandler.IsNPCinDanger(myHero, myHero) then
				Ability.CastNoTarget(pipe)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
			local teamMatesAround = NPC.GetHeroesInRadius(myHero, 875, Enum.TeamType.TEAM_FRIEND)
			for _, ally in ipairs(teamMatesAround) do
				if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
					if FAIO_itemHandler.IsNPCinDanger(myHero, ally) then
						Ability.CastNoTarget(pipe)
						FAIO_itemHandler.lastDefItemPop = os.clock()
						break
						return
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsBKB) then
		if BKB and Ability.IsReady(BKB) then
			if FAIO_itemHandler.shouldCastBKB(myHero) == true then
				Ability.CastNoTarget(BKB)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
		end
	end
	
	if Menu.IsEnabled(FAIO_options.optionDefensiveItemsSatanic) then
		if satanic and Ability.IsCastable(satanic, myMana) then			
			if FAIO_itemHandler.shouldCastSatanic(myHero, enemy) == true then
				Ability.CastNoTarget(satanic)
				FAIO_itemHandler.lastDefItemPop = os.clock()
				return
			end
		end
	end
end

return FAIO_itemHandler