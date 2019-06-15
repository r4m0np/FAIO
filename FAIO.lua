--[[
##################################################################
FAIO - foos All-In-One script package for hake.me
Version: alpha.00.00.001a
Author: foo0oo
Release Date:
Last Update:
##################################################################
--]]


local FAIO = {}

Log.Write("FAIO - loaded Version: alpha.00.00.001a")

FAIO.system = require("FAIO/Core/FAIO_system")

local FAIO_data = require("FAIO/Core/FAIO_data")

local FAIO_options = require("FAIO/Core/FAIO_options")

local FAIO_skillHandler = require("FAIO/Core/FAIO_skillHandler")
	setmetatable(FAIO_skillHandler, {__index = FAIO})

local FAIO_utility_functions = require("FAIO/Utility/FAIO_utility_functions")
	setmetatable(FAIO_utility_functions, {__index = FAIO})
	
local FAIO_dodgeIT = require("FAIO/Utility/FAIO_dodgeIT")
	setmetatable(FAIO_dodgeIT, {__index = FAIO})

local FAIO_lastHitter = require("FAIO/Utility/FAIO_lastHitter")
	setmetatable(FAIO_lastHitter, {__index = FAIO})

local FAIO_itemHandler = require("FAIO/Utility/FAIO_itemHandler")
	setmetatable(FAIO_itemHandler, {__index = FAIO})

local FAIO_killsteal = require("FAIO/Utility/FAIO_killsteal")
	setmetatable(FAIO_killsteal, {__index = FAIO})

local FAIO_ward = require("FAIO/Utility/FAIO_ward")

local FAIO_creepControl = require("FAIO/Core/FAIO_creepControl")
	setmetatable(FAIO_creepControl, {__index = FAIO})

local FAIO_heroScript = {}

function FAIO.initHeroScript()

	if not FAIO.myHero then return end
	local heroName = FAIO.myUnitName

	if FAIO.heroSupported(FAIO.myHero) then

		local heroNameShort = heroName:gsub("npc_dota_hero_", "")

		FAIO_heroScript = require("FAIO/Heroes/FAIO_" .. heroNameShort)
		setmetatable(FAIO_heroScript, {__index = FAIO})

	end

	return

end

	-- global Variables
FAIO.IconPath = "resource/flash3/images/small_boost_icons/"
FAIO.font = Renderer.LoadFont("Tahoma", 22, Enum.FontWeight.EXTRABOLD)
FAIO.invokerDisplayspellIconPath = "resource/flash3/images/spellicons/"
FAIO.skywrathFont = Renderer.LoadFont("Tahoma", 12, Enum.FontWeight.EXTRABOLD)
FAIO.arcWardenfont = Renderer.LoadFont("Arial", 18, Enum.FontWeight.EXTRABOLD)
FAIO.heroIconPath = "resource/flash3/images/heroes/"
FAIO.itemIconPath = "resource/flash3/images/items/"

FAIO.reloaded = true
FAIO.myHero = nil




FAIO.LockedTarget = nil
FAIO.myUnitName = nil
FAIO.lastCastTime = 0
FAIO.lastCastTime2 = 0
FAIO.lastCastTime3 = 0
FAIO.lastTick = 0
FAIO.delay = 0
FAIO.ControlledUnitCastTime = 0
FAIO.ControlledUnitPauseTime = 0
FAIO.lastAttackTime = 0
FAIO.lastAttackTime2 = 0
FAIO.LastTarget = nil
FAIO.lastMovePos = Vector()
FAIO.LastTickManta1 = 0
FAIO.LastTickManta2 = 0
FAIO.ArcWardenEntity = nil
FAIO.ArcWardenEntityAnimationStart = 0
FAIO.ArcWardenEntityAnimationEnd = 0
FAIO.arcWardenPanelX = 0
FAIO.arcWardenPanelY = 0
FAIO.ArcTempestLockedTarget = nil
FAIO.ArcTempestLockedTargetParticle = 0
FAIO.ArcTempestLockedTargetParticleHero = nil
FAIO.arcWardenMagneticCastTime = 0
FAIO.arcWardenPushMode = false
FAIO.arcWardenPusher = false
FAIO.arcWardenPushModeLine = false
FAIO.arcWardenStatus = 0
FAIO.ArcTempestLockedTargetPos = Vector()
FAIO.ArcTempestLockedTargetPosTimer = 0
FAIO.TempestInAttackBackswing = false
FAIO.TempestOrbwalkerDelay = 0
FAIO.ArcWardenEntityProjectileCreate = 0
FAIO.GenericUpValue = false
FAIO.lastPosition = Vector(0, 0, 0)
FAIO.PuckOrbCastTime = 0
FAIO.Toggler = false
FAIO.TogglerTime = 0
FAIO.PreInvoke = false
FAIO.InvokerComboSelector = 0
FAIO.InvokerLastCastedSkill = nil
FAIO.InvokerLastCastedSkillTime = 0
FAIO.InvokerLastChangedInstance = 0
FAIO.InvokerCaptureManualInstances = 0
FAIO.getInvokerGhostWalkKey = nil
FAIO.invokerChannellingKillstealTimer = 0
FAIO.invokerCaptureGhostwalkActivation = 0
FAIO.invokerDisplayNeedsInit = true
FAIO.invokerPanelNeedsInit = true
FAIO.InvokerCanComboStart = false
FAIO.getInvokerSettings = nil
FAIO.AttackProjectileCreate = 0
FAIO.AttackAnimationCreate = 0
FAIO.AttackParticleCreate = 0
FAIO.InAttackBackswing = false
FAIO.OrbwalkerDelay = 0
FAIO.TPParticleIndex = nil
FAIO.TPParticleTime = 0
FAIO.TPParticleUnit = nil
FAIO.TPParticlePosition = Vector()
FAIO.GlimpseParticleIndex = nil
FAIO.GlimpseParticleTime = 0
FAIO.GlimpseParticleUnit = nil
FAIO.GlimpseParticlePosition = Vector()
FAIO.GlimpseParticleIndexStart = nil
FAIO.GlimpseParticlePositionStart = Vector()
FAIO.particleNextTime = 0
FAIO.currentParticle = 0
FAIO.currentParticleTarget = nil
FAIO.skywrathDMGwithoutUlt = 0
FAIO.skywrathDMGwithUlt = 0
FAIO.skywrathComboSelect = false
FAIO.clockwerkHookUpValue = false
FAIO.PADaggerIcon = nil
FAIO.enemyCanBeShackled = false

FAIO.VisageInstStunLockTarget = nil
FAIO.VisagePanicTarget = nil
FAIO.morphlingComboSelect = false
FAIO.morphlingTotalDMG = 0
FAIO.morphlingTotalDMGwoWave = 0
FAIO.MorphBalanceTimer = 0
FAIO.MorphBalanceSelectedHP = 0
FAIO.MorphBalanceSelected = 0
FAIO.MorphBalanceToggler = true
FAIO.SFParticleUpdateTime = 0

FAIO.necroDMGwithoutUlt = 0
FAIO.necroDMGwithUlt = 0
FAIO.necroComboSelect = false
FAIO.magnusLastPos = Vector()
FAIO.SFcurrentParticle1 = 0
FAIO.SFcurrentParticle2 = 0
FAIO.SFcurrentParticle3 = 0

FAIO.kunkkaXMarkPosition = Vector()
FAIO.kunkkaGhostshipTimer = 0
FAIO.kunkkaXMarkCastTime = 0
FAIO.TinkerStatus = 0
FAIO.TinkerPusher = false
FAIO.TinkerPorted = false
FAIO.TinkerJungle = false
FAIO.TinkerMarched = 0
FAIO.TinkerGlimmerCastTime = 0
FAIO.TinkerPanicRearmBlink = 0
FAIO.TinkerPanelX = 0
FAIO.TinkerPanelY = 0
FAIO.TinkerPushMode = false
FAIO.TinkerPushCreeps = 3
FAIO.TinkerPushEnemies = 0
FAIO.TinkerPushAllies = 0
FAIO.TinkerPushJungle = true
FAIO.TinkerPushSave = true
FAIO.TinkerPushDefend = true


	-- global Tables

FAIO.rotationTable = {}
FAIO.PuckOrbHitSim = {}
FAIO.enemyHeroTable = {}
FAIO.InvokerKSparticleProcess = {{nil, nil, 0, nil, Vector()}}
FAIO.PreInvokeSkills = {}
FAIO.preemptiveBKB = {}
FAIO.invokerCachedIcons = {}
FAIO.creepAttackPointData = {}
FAIO.VisageFamiliarAttackCounter = {}
FAIO.heroIconHandler = {}
FAIO.itemIconHandler = {}
FAIO.ControllableEntityTable = {}
FAIO.ControllableAttackTiming = {}
FAIO.TinkerJungleFarmPos = {}
FAIO.JungleTrackTable = {}
FAIO.ShrinePositionTable = {}

function FAIO.ResetGlobalVariables()

	FAIO.reloaded = true
	FAIO.myHero = nil
	FAIO.LockedTarget = nil
	FAIO.myUnitName = nil
	FAIO.lastCastTime = 0
	FAIO.lastCastTime2 = 0
	FAIO.lastCastTime3 = 0
	FAIO.lastTick = 0
	FAIO.delay = 0
	FAIO.ControlledUnitCastTime = 0
	FAIO.ControlledUnitPauseTime = 0
	FAIO.lastAttackTime = 0
	FAIO.lastAttackTime2 = 0
	FAIO.LastTarget = nil
	FAIO.lastMovePos = Vector()
	FAIO.LastTickManta1 = 0
	FAIO.LastTickManta2 = 0
	FAIO.ArcWardenEntity = nil
	FAIO.ArcWardenEntityAnimationStart = 0
	FAIO.ArcWardenEntityAnimationEnd = 0
	FAIO.arcWardenPanelX = 0
	FAIO.arcWardenPanelY = 0
	FAIO.ArcTempestLockedTarget = nil
	FAIO.ArcTempestLockedTargetParticle = 0
	FAIO.ArcTempestLockedTargetParticleHero = nil
	FAIO.arcWardenMagneticCastTime = 0
	FAIO.arcWardenPushMode = false
	FAIO.arcWardenPusher = false
	FAIO.arcWardenPushModeLine = false
	FAIO.arcWardenStatus = 0
	FAIO.ArcTempestLockedTargetPos = Vector()
	FAIO.ArcTempestLockedTargetPosTimer = 0
	FAIO.TempestInAttackBackswing = false
	FAIO.TempestOrbwalkerDelay = 0
	FAIO.ArcWardenEntityProjectileCreate = 0
	FAIO.GenericUpValue = false
	FAIO.lastPosition = Vector(0, 0, 0)
	FAIO.PuckOrbCastTime = 0
	FAIO.Toggler = false
	FAIO.TogglerTime = 0
	FAIO.PreInvoke = false
	FAIO.InvokerComboSelector = 0
	FAIO.InvokerLastCastedSkill = nil
	FAIO.InvokerLastCastedSkillTime = 0
	FAIO.InvokerLastChangedInstance = 0
	FAIO.InvokerCaptureManualInstances = 0
	FAIO.invokerChannellingKillstealTimer = 0
	FAIO.invokerCaptureGhostwalkActivation = 0
	FAIO.getInvokerGhostWalkKey = nil
	FAIO.invokerDisplayNeedsInit = true
	FAIO.getInvokerSettings = nil
	FAIO.InvokerCanComboStart = false
	FAIO.AttackProjectileCreate = 0
	FAIO.AttackAnimationCreate = 0
	FAIO.AttackParticleCreate = 0
	FAIO.InAttackBackswing = false
	FAIO.OrbwalkerDelay = 0
	FAIO.TPParticleIndex = nil
	FAIO.TPParticleTime = 0
	FAIO.TPParticleUnit = nil
	FAIO.TPParticlePosition = Vector()
	FAIO.GlimpseParticleIndex = nil
	FAIO.GlimpseParticleTime = 0
	FAIO.GlimpseParticleUnit = nil
	FAIO.GlimpseParticlePosition = Vector()
	FAIO.GlimpseParticleIndexStart = nil
	FAIO.GlimpseParticlePositionStart = Vector()
	FAIO.particleNextTime = 0
	FAIO.currentParticle = 0
	FAIO.currentParticleTarget = nil
	FAIO.skywrathDMGwithoutUlt = 0
	FAIO.skywrathDMGwithUlt = 0
	FAIO.skywrathComboSelect = false
	FAIO.clockwerkHookUpValue = false
	FAIO.PADaggerIcon = nil
	FAIO.enemyCanBeShackled = false
	FAIO.VisageInstStunLockTarget = nil
	FAIO.VisagePanicTarget = nil
	FAIO.morphlingComboSelect = false
	FAIO.morphlingTotalDMG = 0
	FAIO.morphlingTotalDMGwoWave = 0
	FAIO.MorphBalanceTimer = 0
	FAIO.MorphBalanceSelectedHP = 0
	FAIO.MorphBalanceSelected = 0
	FAIO.MorphBalanceToggler = true
	FAIO.necroDMGwithoutUlt = 0
	FAIO.necroDMGwithUlt = 0
	FAIO.necroComboSelect = false
	FAIO.magnusLastPos = Vector()
	FAIO.SFcurrentParticle1 = 0
	FAIO.SFcurrentParticle2 = 0
	FAIO.SFcurrentParticle3 = 0
	FAIO.SFParticleUpdateTime = 0
	FAIO.kunkkaXMarkPosition = Vector()
	FAIO.kunkkaGhostshipTimer = 0
	FAIO.kunkkaXMarkCastTime = 0
	FAIO.TinkerStatus = 0
	FAIO.TinkerPusher = false
	FAIO.TinkerPorted = false
	FAIO.TinkerJungle = false
	FAIO.TinkerMarched = 0
	FAIO.TinkerGlimmerCastTime = 0
	FAIO.TinkerPanicRearmBlink = 0
	FAIO.TinkerPanelX = 0
	FAIO.TinkerPanelY = 0
	FAIO.TinkerPushMode = false
	FAIO.TinkerPushCreeps = 3
	FAIO.TinkerPushEnemies = 0
	FAIO.TinkerPushAllies = 0
	FAIO.TinkerPushJungle = true
	FAIO.TinkerPushSave = true
	FAIO.TinkerPushDefend = true
	FAIO.TinkerJungleFarmPos = {}
	FAIO.JungleTrackTable = {}
	FAIO.ShrinePositionTable = {}
	FAIO.creepAttackPointData = {}
	FAIO.rotationTable = {}
	FAIO.PuckOrbHitSim = {}
	FAIO.enemyHeroTable = {}
	FAIO.InvokerKSparticleProcess = {{nil, nil, 0, nil, Vector()}}
	FAIO.PreInvokeSkills = {}
	FAIO.invokerCachedIcons = {}
	FAIO.VisageFamiliarAttackCounter = {}
	FAIO.heroIconHandler = {}
	FAIO.itemIconHandler = {}
	FAIO.ControllableEntityTable = {}
	FAIO.ControllableAttackTiming = {}

end

function FAIO.resetModules()

	for i, v in pairs(package.loaded) do
		if string.find(i, "FAIO/") ~= nil then
			package.loaded[i] = nil
		end
		package.loaded["Menu"] = nil
	end

	FAIO_heroScript = {}

	FAIO.reloaded = false

end

function FAIO.OnGameStart()
	
	FAIO.ResetGlobalVariables()
	FAIO.resetModules()

end

function FAIO.OnGameEnd()
	
	FAIO.ResetGlobalVariables()
	FAIO.resetModules()

end
	
-- main callback
function FAIO.OnUpdate()

	if FAIO.reloaded then
		FAIO.resetModules()
	end

	if not Menu.IsEnabled(FAIO_options.optionEnable) then return end

	if not Engine.IsInGame() then
		if FAIO_myHero ~= nil then
			FAIO.ResetGlobalVariables()
			FAIO.resetModules()
		end
	end
	
	if GameRules.GetGameState() < 4 then return end
	if GameRules.GetGameState() > 5 then return end

	local myHero = Heroes.GetLocal()
		if not myHero then return end
		FAIO.myHero = myHero
		if not Entity.IsAlive(myHero) then return end
		if FAIO.myUnitName == nil then
			FAIO.myUnitName = NPC.GetUnitName(myHero)
		end

	FAIO.humanizerMouseDelayInit()

	if next(FAIO_heroScript) == nil then
		FAIO.initHeroScript()
	end

	if Menu.IsEnabled(FAIO_options.optionHeroMorphReplicate) then
		local replicateMod = NPC.GetModifier(myHero, "modifier_morphling_replicate")
		if replicateMod then
			local checkAbility = NPC.GetAbilityByIndex(myHero, 0)
				if checkAbility == nil then
					checkAbility = NPC.GetAbilityByIndex(myHero, 1)
				end
			if checkAbility then
				local abilityName = Ability.GetName(checkAbility)
				local abilityNameShort = string.sub(abilityName, 1, string.find(abilityName, "_") - 1)
				local heroName = "npc_dota_hero_" .. abilityNameShort
				if heroName == "npc_dota_hero_skywrath" then
					heroName = "npc_dota_hero_skywrath_mage"
				elseif heroName == "npc_dota_hero_ember" then
					heroName = "npc_dota_hero_ember_spirit"
				elseif heroName == "npc_dota_hero_templar" then
					heroName = "npc_dota_hero_templar_assassin"
				elseif heroName == "npc_dota_hero_phantom" then
					if abilityName == "phantom_assassin_stifling_dagger" or abilityName == "phantom_assassin_phantom_strike" then
						heroName = "npc_dota_hero_phantom_assassin"
					end
				elseif heroName == "npc_dota_hero_obsidian" then
					heroName = "npc_dota_hero_obsidian_destroyer"
				elseif heroName == "npc_dota_hero_dark" then
					if abilityName == "dark_willow_bramble_maze" or abilityName == "dark_willow_shadow_realm" then
						heroName = "npc_dota_hero_dark_willow"
					end
				elseif heroName == "npc_dota_hero_arc" then
					heroName = "npc_dota_hero_arc_warden"
				elseif heroName == "npc_dota_hero_invoker" then
					heroName = "npc_dota_hero_morphling"
				elseif heroName == "npc_dota_hero_legion" then
					heroName = "npc_dota_hero_legion_commander"
				end
				if FAIO_utility_functions.utilityIsInTable(FAIO_data.heroList, heroName) then
					FAIO.myUnitName = heroName
				end
			end
		else
			if NPC.GetUnitName(myHero) ~= FAIO.myUnitName then
				FAIO.myUnitName = NPC.GetUnitName(myHero)
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroMorphReplicateBack) then
		local replicateBack = NPC.GetAbility(myHero, "morphling_morph_replicate")
		if replicateBack and not Ability.IsHidden(replicateBack) and Ability.IsReady(replicateBack) then
			if FAIO.heroCanCastSpells(myHero) == true then
				if Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) < Menu.GetValue(FAIO_options.optionHeroMorphReplicateBackHP) / 100 then
					Ability.CastNoTarget(replicateBack)
					return
				end
			end
		end
	end

	FAIO_itemHandler.init()
	

	local isHeroSupported = FAIO.heroSupported(myHero)

	local enemy = FAIO.getComboTarget(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then
		if Menu.GetValue(FAIO_options.optionTargetStyle) < 1 then
			if FAIO.LockedTarget == nil then
				if enemy then
					FAIO.LockedTarget = enemy
				else
					FAIO.LockedTarget = nil
				end
			end
		else
			if enemy then
				FAIO.LockedTarget = enemy
			else
				FAIO.LockedTarget = nil
			end
		end
	else
		FAIO.LockedTarget = nil
	end

	if FAIO.LockedTarget ~= nil then
		if not Entity.IsAlive(FAIO.LockedTarget) then
			FAIO.LockedTarget = nil
		elseif Entity.IsDormant(FAIO.LockedTarget) then
			FAIO.LockedTarget = nil
		elseif not NPC.IsEntityInRange(myHero, FAIO.LockedTarget, 3000) then
			FAIO.LockedTarget = nil
		end
	end

	if Menu.IsEnabled(FAIO_options.optionLockTargetIndicator) then
		FAIO.TargetIndicator(myHero)
	end

	local comboTarget
		if FAIO.LockedTarget ~= nil then
			comboTarget = FAIO.LockedTarget
		else
			if not Menu.IsKeyDown(FAIO_options.optionComboKey) then
				comboTarget = enemy
			end
		end
	
--[[
		
	if comboTarget then
		if isHeroSupported then
			if FAIO.myUnitName == "npc_dota_hero_axe" then
				FAIO_axe.combo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_rattletrap" then
				FAIO.clockwerkCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_skywrath_mage" then
				FAIO.skywrathCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_tiny" then
				FAIO.tinyCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_windrunner" then
				FAIO.WindRunnerCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_ember_spirit" then
				FAIO.EmberCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_ursa" then
				FAIO.UrsaCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_templar_assassin" then
				FAIO.TACombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_slardar" then
				FAIO.SlardarCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_queenofpain" then
				FAIO.QoPCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_sven" then
				FAIO.SvenCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_visage" then
				FAIO.VisageCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_puck" then
				FAIO.PuckCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_antimage" then
				FAIO.AntiMageCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_obsidian_destroyer" then
				FAIO.ODCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_silencer" then
				FAIO.SilencerCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_dark_willow" then
				FAIO.WillowCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_dazzle" then
				FAIO.DazzleHelper(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_centaur" then
				FAIO.centaurCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_ogre_magi" then
				FAIO.OgreCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_ancient_apparition" then
				FAIO.AACombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_nyx_assassin" then
				FAIO.NyxCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_night_stalker" then
				FAIO.NSCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_chaos_knight" then
				FAIO.CKCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_witch_doctor" then
				FAIO.WDCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_shadow_shaman" then
				FAIO.SSCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_death_prophet" then
				FAIO.DPCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_crystal_maiden" then
				FAIO.CMCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_lion" then
				FAIO.LionCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_pugna" then
				FAIO.PugnaCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_undying" then
				FAIO.UndyingCombo(myHero, comboTarget)
			elseif FAIO.myUnitName == "npc_dota_hero_vengefulspirit" then
				FAIO.VSCombo(myHero, comboTarget)
			end
		else
			if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(comboTarget) then	
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", comboTarget, nil)	
				FAIO_itemHandler.itemUsage(myHero, comboTarget)
			end
		end
	end
--]]

-- MAKE SURE ENEMY IN HERO SCRIPTS


	if next(FAIO_heroScript) ~= nil then
		FAIO_heroScript.combo(myHero, comboTarget)
	else	
		if comboTarget then
			if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(comboTarget) then	
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", comboTarget, nil)	
				FAIO_itemHandler.itemUsage(myHero, comboTarget)
			end
		end
	end





	if NPC.GetUnitName(myHero) == "npc_dota_hero_invoker" then
		FAIO.InvokerCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_arc_warden" then
		FAIO.ArcWardenCombo(myHero, comboTarget)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_furion" then
		FAIO.ProphetHelper(myHero, comboTarget)
	end
	
	if FAIO.myUnitName == "npc_dota_hero_clinkz" then
		FAIO.ClinkzCombo(myHero, comboTarget)
		if Menu.IsEnabled(FAIO_options.optionHeroClinkzUlt) then
			FAIO.ClinkzAutoUlt(myHero)
		end
	end

	if FAIO.myUnitName == "npc_dota_hero_phantom_assassin" then
		FAIO.PACombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_legion_commander" then
		FAIO.LegionCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_morphling" then
		FAIO.MorphCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_necrolyte" then
		FAIO.NecroCombo(myHero, comboTarget)
	end
	
	if FAIO.myUnitName == "npc_dota_hero_magnataur" then
		FAIO.magnusCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_nevermore" then
		FAIO.SFCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_tinker" then
		FAIO.TinkerCombo(myHero, comboTarget)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_axe" then
		if Menu.IsEnabled(FAIO_options.optionHeroAxeForceBlink) then
			FAIO.ForceBlink(myHero, comboTarget, Menu.GetValue(FAIO_options.optionHeroAxeForceBlinkRange))
		end
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_centaur" then
		if Menu.IsEnabled(FAIO_options.optionHeroCentaurForceBlink) then
			FAIO.ForceBlink(myHero, comboTarget, Menu.GetValue(FAIO_options.optionHeroCentaurForceBlinkRange))
		end
	end

	if FAIO.myUnitName == "npc_dota_hero_shredder" then
		FAIO.TimberCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_kunkka" then
		FAIO.KunkkaShipCombo(myHero, enemy)
	end
	
	if FAIO.myUnitName == "npc_dota_hero_zuus" then
		FAIO.ZuusCombo(myHero, comboTarget)
	end

	if FAIO.myUnitName == "npc_dota_hero_huskar" then
		FAIO.huskarCombo(myHero, comboTarget)
	end

--	if FAIO.myUnitName == "npc_dota_hero_pudge" then
--		FAIO.PudgeCombo(myHero, comboTarget)
--	end

	FAIO_lastHitter.lastHitter(myHero)
	FAIO.GetControllableEntities(myHero)
	FAIO.GenericJungleTracker(myHero)

	if Menu.IsEnabled(FAIO_options.optionDodgeItEnable) then	
		FAIO_dodgeIT.dodgerSelectItemorSkill(myHero)
		FAIO_dodgeIT.dodgerSkillAvailable(myHero)
		FAIO_dodgeIT.dodger(myHero)
	end
	
	if Menu.IsEnabled(FAIO_options.optionUtilityEnable) then
		FAIO_itemHandler.utilityItemUsage(myHero)
	end

	
	if NPC.GetUnitName(myHero) == "npc_dota_hero_invoker" then
		if Menu.IsEnabled(FAIO_options.optionKillStealInvoker) then
			FAIO.AutoSunstrikeKillStealNew(myHero)
		end
	else
		FAIO_killsteal.autoNuke(myHero)
	end

	if Menu.IsEnabled(FAIO_options.optionDefensiveItems) then
		FAIO_itemHandler.useDefensiveItems(myHero, comboTarget)
	end
	
	if Menu.IsEnabled(FAIO_options.optionWardAwareness) then
		FAIO_ward.wardProcessing(myHero)
	end

	if Menu.IsEnabled(FAIO_options.optionItemArmlet) then
		FAIO_itemHandler.armletHandler(myHero)
	end

	if Menu.IsEnabled(FAIO_options.optionItemHurricane) then
		FAIO_itemHandler.ItemAutoHurricaneUsage(myHero, comboTarget)
	end

	if Menu.IsEnabled(FAIO_options.optionItemBlademail) then
		FAIO_itemHandler.ItemAutoBMUsage(myHero)
	end

	if Menu.IsEnabled(FAIO_options.optionCreepControl) then
		FAIO_creepControl.comboHandler(myHero, comboTarget)
	end

	if FAIO.LockedTarget == nil then
		if Menu.IsEnabled(FAIO_options.optionMoveToCursor) then
			if Menu.IsKeyDown(FAIO_options.optionComboKey) then
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos())
				return
			end
		end	
	end

--	for i = 1, NPCs.Count() do
--	local npc = NPCs.Get(i)
--	Log.Write(tostring(NPC.GetUnitName(npc)) .. " " .. tostring(Entity.GetOwner(npc)) .. " " .. tostring(Entity.OwnedBy(npc, myHero)))
--	end

--	local modifiers = NPC.GetModifiers(myHero)
--	for _, modifier in ipairs(modifiers) do
--	local modifierName = Modifier.GetName(modifier)
--	Log.Write(modifierName)
--	end

--	for i = 1, Abilities.Count() do
--	local abilities = Abilities.Get(i)
--	local abilityNames = Ability.GetName(abilities)
--	Log.Write(abilityNames)
--	end

end

function FAIO.getComboTarget(myHero)

	if not myHero then return end

	local targetingRange = Menu.GetValue(FAIO_options.optionTargetRange)
	local mousePos = Input.GetWorldCursorPos()

	local enemyTable = Heroes.InRadius(mousePos, targetingRange, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		if #enemyTable < 1 then return end

	local nearestTarget = nil
	local distance = 99999

	for i, v in ipairs(enemyTable) do
		if v and Entity.IsHero(v) then
			if FAIO.targetChecker(v) ~= nil then
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

function FAIO.OnEntityDestroy(ent)

	if not ent then return end

	FAIO_lastHitter.OnEntityDestroy(ent)

	if Entity.IsNPC(ent) and NPC.IsNeutral(ent) then
		local minute = math.floor((GameRules.GetGameTime() - GameRules.GetGameStartTime()) / 60)
		local entityPos = Entity.GetAbsOrigin(ent)
			entityPos:SetZ(0)

		for key, info in ipairs(FAIO.JungleTrackTable) do
			local pos = info[1]		
			if (pos - entityPos):Length2D() < 1000 then
				local class = info[4]
				local checkTable = {}
					if class == "small" then
						checkTable = FAIO_data.NeutralMainNPCsmall
					elseif class == "medium" then
						checkTable = FAIO_data.NeutralMainNPCmedium
					else
						checkTable = FAIO_data.NeutralMainNPChard
					end
				if next(checkTable) ~= nil then
					local checkValue = false
						for i, v in ipairs(checkTable) do
							if NPC.GetUnitName(ent) == v then
								checkValue = true
								break
							end
						end
					
					if checkValue then	
						if info[2] == true and (pos - entityPos):Length2D() < 1000 then
							FAIO.JungleTrackTable[key][2] = false
							FAIO.JungleTrackTable[key][3] = minute
							break
						end
					end
				end
			end
		end
	end

	FAIO_ward.OnEntityDestroy(ent)

end

function FAIO.OnParticleCreate(particle)

	if not particle then return end
	if not Heroes.GetLocal() then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_ENEMY))

	if particle.name == "teleport_start" then
		if particle.entityForModifiers ~= nil and particle.entityForModifiers ~= Heroes.GetLocal() then
			if not Entity.IsSameTeam(Heroes.GetLocal(), particle.entityForModifiers) then
				FAIO.TPParticleIndex = particle.index
				FAIO.TPParticleTime = GameRules.GetGameTime()
				FAIO.TPParticleUnit = particle.entityForModifiers
			end
		end
	end

	if particle.name == "furion_sprout" then
		if particle.entityForModifiers ~= nil and Entity.IsSameTeam(Heroes.GetLocal(), particle.entityForModifiers) then
			FAIO.InvokerKSparticleProcess[1][1] = particle.index
			FAIO.InvokerKSparticleProcess[1][2] = particle.name
			FAIO.InvokerKSparticleProcess[1][3] = GameRules.GetGameTime()
			FAIO.InvokerKSparticleProcess[1][4] = particle.entityForModifiers
		end
	end

	if particle.name == "rattletrap_cog_deploy" then
		if particle.entity ~= nil and Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) then
			FAIO.InvokerKSparticleProcess[1][1] = particle.index
			FAIO.InvokerKSparticleProcess[1][2] = particle.name
			FAIO.InvokerKSparticleProcess[1][3] = GameRules.GetGameTime()
			FAIO.InvokerKSparticleProcess[1][4] = particle.entity
			FAIO.InvokerKSparticleProcess[1][5] = Entity.GetAbsOrigin(particle.entity)
		end
	end

	if particle.name == "disruptor_glimpse_targetend" then
		FAIO.GlimpseParticleIndex = particle.index
		FAIO.GlimpseParticleTime = GameRules.GetGameTime()
	end

	if particle.name == "disruptor_glimpse_targetstart" then
		FAIO.GlimpseParticleIndexStart = particle.index
	end
	
end

function FAIO.OnParticleUpdate(particle)

	if not particle then return end
	if not Heroes.GetLocal() then return end

	if particle.position:__tostring() == Vector(1.0, 1.0, 1.0):__tostring() then return end
	if particle.position:__tostring() == Vector(0.0, 0.0, 0.0):__tostring() then return end
	if particle.position:Length() < 75 then return end

	if particle.index  == FAIO.TPParticleIndex then
		if particle.controlPoint == 0 then
			FAIO.TPParticlePosition = particle.position
		end
	end

	if particle.index  == FAIO.InvokerKSparticleProcess[1][1] then
		if particle.position:__tostring() ~= Vector(0.0, 150.0, 0.0):__tostring() then
			FAIO.InvokerKSparticleProcess[1][5] = particle.position
		end
	end

	if particle.index  == FAIO.GlimpseParticleIndex then
		if particle.position:Length2D() > 100 then
			FAIO.GlimpseParticlePosition = particle.position
		end
	end

end

function FAIO.OnParticleUpdateEntity(particle)

	if not particle then return end

	if not Heroes.GetLocal() then return end	
	if not particle.position then return end
	if particle.controlPoint > 0 then return end

	if particle.index  == FAIO.GlimpseParticleIndexStart then
		if particle.entity ~= nil and not Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) then
			if particle.position:__tostring() ~= Vector(0.0, 0.0, 0.0):__tostring() then
				FAIO.GlimpseParticlePositionStart = particle.position
				FAIO.GlimpseParticleUnit = particle.entity
			end
		end
	end

end

function FAIO.OnUnitAnimation(animation)

	if not animation then return end
	if not Heroes.GetLocal() then return end

	if Menu.IsEnabled(FAIO_options.optionDodgeItEnable) then
		FAIO_dodgeIT.dodgeProcessing(Heroes.GetLocal(), animation.unit, animation.activity, animation.castpoint)
	end

	if animation.unit then
		if Entity.IsNPC(animation.unit) and not Entity.IsSameTeam(Heroes.GetLocal(), animation.unit) and not Entity.IsHero(animation.unit) and not Entity.IsDormant(animation.unit) and NPC.IsEntityInRange(Heroes.GetLocal(), animation.unit, 1000) then
			local name = NPC.GetUnitName(animation.unit)
			if FAIO.creepAttackPointData[name] == nil then
				FAIO.creepAttackPointData[name] = animation.castpoint
			else
				if animation.castpoint < FAIO.creepAttackPointData[name] then
					FAIO.creepAttackPointData[name] = animation.castpoint
				end
			end
		end
	end

	FAIO_lastHitter.OnUnitAnimation(animation)
	FAIO_itemHandler.OnUnitAnimation(animation)
	
	if NPC.GetUnitName(Heroes.GetLocal()) ~= NPC.GetUnitName(animation.unit) then return end

	if FAIO.ArcWardenEntity ~= nil then
		if animation.unit == FAIO.ArcWardenEntity and animation.type == 1 then
			FAIO.ArcWardenEntityAnimationStart = GameRules.GetGameTime() - 0.035
			FAIO.ArcWardenEntityAnimationEnd = GameRules.GetGameTime() + animation.castpoint + 0.035
		end
	end

	if Heroes.GetLocal() ~= animation.unit then return end

	if animation.type == 1 then
		FAIO.AttackAnimationCreate = os.clock()
		FAIO.AttackParticleCreate = os.clock() + animation.castpoint
	end

end

function FAIO.OnProjectile(projectile)

	if not projectile then return end

	local myHero = Heroes.GetLocal()
		if not myHero then return end

	

	FAIO_lastHitter.OnProjectile(projectile)
	FAIO_itemHandler.OnProjectile(projectile)

	if projectile.source and Entity.GetClassName(projectile.source) == "C_DOTA_Unit_VisageFamiliar" then

		local familiarAttackTime = NPC.GetAttackTime(projectile.source)
		if FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)] == nil then
			FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)] = { GameRules.GetGameTime(), 1 }
		else
			if FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)][1] + familiarAttackTime * 1.5 > GameRules.GetGameTime() then
				FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)][1] = GameRules.GetGameTime()
				FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)][2] = FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)][2] + 1
			else
				FAIO.VisageFamiliarAttackCounter[Entity.GetIndex(projectile.source)] = { GameRules.GetGameTime(), 1 }
			end
		end
	end

	if FAIO.ArcWardenEntity ~= nil then
		if projectile.source == FAIO.ArcWardenEntity and projectile.isAttack then
			FAIO.ArcWardenEntityProjectileCreate = GameRules.GetGameTime() - 0.035
		end
	end

	if projectile.source ~= Heroes.GetLocal() then return end
	if not projectile.isAttack then return end

	FAIO.AttackProjectileCreate = os.clock()

end

function FAIO.OnLinearProjectileCreate(projectile)
	
	if not projectile or not projectile.source then return end
	
	if projectile.name ~= "puck_illusory_orb" then return end
	
	FAIO.PuckOrbHitSim = {{projectile.origin, projectile.velocity}}

	
end

function FAIO.OnParticleDestroy(particle)

	if not particle then return end
	if not Heroes.GetLocal() then return end

	if particle.index  == FAIO.TPParticleIndex then
		FAIO.TPParticlePosition = Vector()
		FAIO.TPParticleTime = 0
		FAIO.TPParticleUnit = nil
	end

end

function FAIO.OnDraw()

	local myHero = Heroes.GetLocal()
        	if not myHero then return end
		if not Entity.IsAlive(myHero) then return end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_morphling" then
		if Menu.IsEnabled(FAIO_options.optionHeroMorphlingKill) then
			FAIO.drawMorphlingKillIndicator(myHero)
		end
		if Menu.IsEnabled(FAIO_options.optionHeroMorphDrawBoard) then
			FAIO.MorphDrawBalanceBoard(myHero)
		end
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_arc_warden" then
		FAIO.drawArcWardenPanel(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_furion" then
		if Menu.IsEnabled(FAIO_options.optionProphetDrawToggle) then
			FAIO.DrawProphetHelperSwitch()
		end
		if Menu.IsEnabled(FAIO_options.optionProphetDrawKS) or Menu.IsEnabled(FAIO_options.optionProphetDrawKSminimap) then
			FAIO.DrawProphetAwareness(myHero)
		end
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_invoker" then
		FAIO.InvokerDraw(myHero)
		FAIO.InvokerDrawShort(myHero)
		FAIO.invokerDisplayDrawDisplay(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_phantom_assassin" then
		FAIO.DrawPADaggerSwitch(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_skywrath_mage" then
		FAIO.skywrathComboDrawDamage(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_necrolyte" then
		FAIO.necroComboDrawDamage(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_nevermore" then
		FAIO.SFComboDrawRequiemDamage(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_rattletrap" then
		FAIO.clockwerkDrawHookIndicator(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_windrunner" then
		FAIO.windrunnerDrawShackleIndicator(myHero)
	end

	if NPC.GetUnitName(myHero) == "npc_dota_hero_tinker" then
		FAIO.drawTinkerPanel(myHero)
	end

	if Menu.IsEnabled(FAIO_options.optionWardAwareness) then
		FAIO_ward.drawWard(myHero)
	end

	FAIO_lastHitter.lastHitterDrawing(myHero)

end

function FAIO.OnPrepareUnitOrders(orders)

	if not orders then return true end
	if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_TRAIN_ABILITY then return true end

	local myHero = Heroes.GetLocal()
    		if not myHero then return true end
    
	if Menu.IsEnabled(FAIO_options.optionHeroInvokerInstanceHelper) then
		if NPC.GetUnitName(myHero) == "npc_dota_hero_invoker" then
			FAIO.invokerProcessInstances(myHero, orders.order)
			return true
		end
	end
	
	if NPC.GetUnitName(myHero) == "npc_dota_hero_invoker" then
		local quas = NPC.GetAbility(myHero, "invoker_quas")
		local wex = NPC.GetAbility(myHero, "invoker_wex")
		local exort = NPC.GetAbility(myHero, "invoker_exort")
		if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
			if orders.ability == quas or orders.ability == wex or orders.ability == exort then
				FAIO.InvokerCaptureManualInstances = os.clock()
				return true
			end
		end
	end

	
	if Menu.IsEnabled(FAIO_options.optionLinkensManual) then
		if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET then
			if orders.target ~= nil and Entity.IsHero(orders.target) and not Entity.IsSameTeam(myHero, orders.target) then
				if NPC.IsLinkensProtected(orders.target) then
					if FAIO.LinkensBreakerNew(myHero) ~= nil then
						Ability.CastTarget(NPC.GetItem(myHero, FAIO.LinkensBreakerNew(myHero), true), orders.target)
						return true
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionItemVeilManual) then
		local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
		if veil and Ability.IsReady(veil) then
			if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET then
				if orders.ability ~= nil and Ability.IsReady(orders.ability) and not Ability.IsChannelling(orders.ability) then
					if not Ability.IsPassive(orders.ability) and Ability.GetCastPoint(orders.ability) > 0.05 then
						if orders.target ~= nil and not Entity.IsDormant(orders.target) and Entity.IsAlive(orders.target) and not NPC.IsIllusion(orders.target) then
							Ability.CastPosition(veil, Entity.GetAbsOrigin(orders.target))
							if not NPC.HasItem(myHero, "item_soul_ring", true) then
								return true
							end
						end
					end
				end
			elseif orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION then
				if orders.ability ~= nil and Ability.IsReady(orders.ability) and not Ability.IsChannelling(orders.ability) then
					if not Ability.IsPassive(orders.ability) and Ability.GetCastPoint(orders.ability) > 0.05 then
						local mousePos = Input.GetWorldCursorPos()
						local checkTarget = nil
							for _, v in ipairs(Heroes.InRadius(mousePos, 600, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)) do
								if v and Entity.IsHero(v) and not Entity.IsDormant(v) and Entity.IsAlive(v) and not NPC.IsIllusion(v) then
									checkTarget = v
									break
								end
							end

						if checkTarget ~= nil then
							Ability.CastPosition(veil, Entity.GetAbsOrigin(checkTarget))
							if not NPC.HasItem(myHero, "item_soul_ring", true) then
								return true
							end
						end
					end
				end
			end						
		end
	end

	if Menu.IsEnabled(FAIO_options.optionItemSoulringManual) then
		local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
		if soulring and Ability.IsReady(soulring) then
			if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION or orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET or
			orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
				if orders.ability ~= nil and Ability.IsReady(orders.ability) and not Ability.IsChannelling(orders.ability) then
					if not Ability.IsPassive(orders.ability) and Ability.GetManaCost(orders.ability) > 50 and Ability.GetCastPoint(orders.ability) > 0.05 then
						Ability.CastNoTarget(soulring)
						return true
					end
				end
			end
		end
	end
				
	if Menu.IsEnabled(FAIO_options.optionHeroMagnusAutoEmpower) then
		if NPC.GetUnitName(myHero) == "npc_dota_hero_magnataur" then
			if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET then
				if orders.target and Entity.IsNPC(orders.target) and not Entity.IsSameTeam(myHero, orders.target) then
					FAIO.magnusAutoEmpower(myHero)
					return true
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionItemArmlet) then
		local armlet = NPC.GetItem(myHero, "item_armlet", true)
		if armlet and not NPC.HasModifier(myHero, "modifier_item_armlet_unholy_strength") then
			if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TOGGLE then
				if orders.ability == armlet and not FAIO.isArmletManuallyToggled then
					FAIO.isArmletManuallyToggled = true
					FAIO.isArmletManuallyToggledTime = GameRules.GetGameTime()
					return true
				end
			end
		end
	end

	FAIO_itemHandler.OnPrepareUnitOrders(orders)

	if Menu.IsEnabled(FAIO_options.optionCreepControl) then
		FAIO_creepControl.OnPrepareUnitOrders(orders)
	end

	if FAIO.myUnitName == "npc_dota_hero_kunkka" and FAIO.kunkkaGhostshipTimer > os.clock() and FAIO.kunkkaXMarkCastTime > os.clock() then
		local Q = NPC.GetAbilityByIndex(myHero, 0)
		local Xreturn = NPC.GetAbility(myHero, "kunkka_return")
		local Ship = NPC.GetAbility(myHero, "kunkka_ghostship")
		if FAIO.kunkkaXMarkCastTime - os.clock() < 1 and FAIO.kunkkaXMarkCastTime - os.clock() > 0 and Ability.IsReady(Ship) then
			return false
		elseif FAIO.kunkkaGhostshipTimer - os.clock() < 2.25 and FAIO.kunkkaGhostshipTimer - os.clock() > 1.75 and Ability.IsReady(Q) then
			return false
		elseif FAIO.kunkkaGhostshipTimer - os.clock() < 0.80 and FAIO.kunkkaGhostshipTimer - os.clock() > 0.30 and not Ability.IsHidden(Xreturn) then
			return false
		elseif Q and Ability.IsInAbilityPhase(Q) then
			return false
		elseif Xreturn and Ability.IsInAbilityPhase(Xreturn) then
			return false
		elseif Ship and Ability.IsInAbilityPhase(Ship) then
			return false
		end
	end

	if FAIO.myUnitName == "npc_dota_hero_pudge" then
		FAIO_heroScript.OnPrepareUnitOrders(orders)
	end

	if FAIO.myUnitName == "npc_dota_hero_tinker" then
		if Menu.IsEnabled(FAIO_options.optionHeroTinkerPushReset) then
			if FAIO.TinkerPusher then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION then
					FAIO.TinkerPusher = false
					if FAIO.TinkerPorted or FAIO.TinkerMarched > 0 then
						if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION then
							FAIO.TinkerPorted = false
							FAIO.TinkerJungle = false
							FAIO.TinkerMarched = 0
							FAIO.TinkerJungleFarmPos = {}
							return true
						end
					else
						return true
					end
				end
			else
				if FAIO.TinkerPorted or FAIO.TinkerMarched > 0 then
					if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION then
						FAIO.TinkerPorted = false
						FAIO.TinkerJungle = false
						FAIO.TinkerMarched = 0
						FAIO.TinkerJungleFarmPos = {}
						return true
					end
				end
			end
		end
		
		if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscFailUlt) then
			local ult = NPC.GetAbility(myHero, "tinker_rearm")
			if ult then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
					if orders.ability and orders.ability == ult then
						if Ability.IsChannelling(ult) then
							return false
						end
						if Ability.SecondsSinceLastUse(ult) > -1 and Ability.SecondsSinceLastUse(ult) < 0.5 then
							return false
						end
					end
				end
			end
		end

		if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscFailRockets) then
			local rockets = NPC.GetAbilityByIndex(myHero, 1)
			if rockets then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
					if orders.ability and orders.ability == rockets then
						if #Entity.GetHeroesInRadius(myHero, 2499, Enum.TeamType.TEAM_ENEMY) < 1 then
							return false
						end
					end
				end
			end
		end

		if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscBlink) then
			local ult = NPC.GetAbility(myHero, "tinker_rearm")
			local blink = NPC.GetItem(myHero, "item_blink", true)
			if ult and blink then
				if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
					if orders.ability and orders.ability == ult and Ability.IsCastable(ult, NPC.GetMana(myHero)) then
						local check = false
						for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 750, Enum.TeamType.TEAM_ENEMY)) do
							if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
								if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 30) then
									if NPC.FindFacingNPC(v) == myHero then
										check = true
										break
									end
								end
								for ability, info in pairs(FAIO_data.RawDamageAbilityEstimation) do
									if NPC.HasAbility(v, ability) and Ability.IsInAbilityPhase(NPC.GetAbility(v, ability)) then
										local abilityRange = math.max(Ability.GetCastRange(NPC.GetAbility(v, ability)), info[2])
										local abilityRadius = info[3]
										if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
											check = true
											break
										end
									end
								end	
							end
						end
						if check then
							FAIO.TinkerPanicRearmBlink = os.clock()
							return true
						end
					end
				end
			end
		end					
	end
	
	return true

end

-- last Hitter








-- utility functions
function FAIO.heroSupported(myHero)

	if not myHero then return end
	local supportedHeroList = FAIO_data.heroList

	for _, heroName in pairs(supportedHeroList) do
		if heroName == NPC.GetUnitName(myHero) then
			return true
		end
	end
	return false
end



function FAIO.OnMenuOptionChange(option, old, new)

	if not option then return end

    	FAIO_itemHandler.OnMenuOptionChange(option, old, new)

	if option == FAIO.invokerDisplaySizeOption then
        	FAIO.invokerDisplayInit()
    	end

	if option == FAIO.invokerPanelSizeOption then
		FAIO.invokerPanelInit()
    	end

	if option == FAIO_options.dodgeItOptionTable[1] or 
		option == FAIO_options.dodgeItOptionTable[2] or
		option == FAIO_options.dodgeItOptionTable[3] or
		option == FAIO_options.dodgeItOptionTable[4] or
		option == FAIO_options.dodgeItOptionTable[5] or
		option == FAIO_options.dodgeItOptionTable[6] or
		option == FAIO_options.dodgeItOptionTable[7] then
		FAIO_dodgeIT.dodgeItReadyTable = {}
	end

end

function FAIO.targetChecker(genericEnemyEntity)

	local myHero = Heroes.GetLocal()
		if not myHero then return end

	if genericEnemyEntity and not NPC.IsDormant(genericEnemyEntity) and not NPC.IsIllusion(genericEnemyEntity) and Entity.GetHealth(genericEnemyEntity) > 0 then

		if Menu.IsEnabled(FAIO_options.optionTargetCheckAM) then
			if NPC.GetUnitName(genericEnemyEntity) == "npc_dota_hero_antimage" and NPC.HasItem(genericEnemyEntity, "item_ultimate_scepter", true) and NPC.HasModifier(genericEnemyEntity, "modifier_antimage_spell_shield") and Ability.IsReady(NPC.GetAbility(genericEnemyEntity, "antimage_spell_shield")) then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckLotus) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_item_lotus_orb_active") then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckBlademail) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_item_blade_mail_reflect") and Entity.GetHealth(Heroes.GetLocal()) <= 0.25 * Entity.GetMaxHealth(Heroes.GetLocal()) then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckNyx) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_nyx_assassin_spiked_carapace") then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckUrsa) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_ursa_enrage") then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckAbbadon) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_abaddon_borrowed_time") then
				return
			end
		end
		if Menu.IsEnabled(FAIO_options.optionTargetCheckDazzle) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_dazzle_shallow_grave") and NPC.GetUnitName(myHero) ~= "npc_dota_hero_axe" then
				return
			end
		end
		if NPC.HasModifier(genericEnemyEntity, "modifier_skeleton_king_reincarnation_scepter_active") then
			return
		end
		if NPC.HasModifier(genericEnemyEntity, "modifier_winter_wyvern_winters_curse") then
			return
		end

	return genericEnemyEntity
	end	
end

function FAIO.GetControllableEntities(myHero)

	if not myHero then return end

	for i = 1, NPCs.Count() do 
		local npc = NPCs.Get(i)
		if Entity.IsNPC(npc) and Entity.IsAlive(npc) and Entity.IsSameTeam(myHero, npc) then
			if npc ~= myHero then
				if Entity.GetOwner(npc) == Entity.GetOwner(myHero) or Entity.OwnedBy(myHero, npc) or Entity.OwnedBy(npc, myHero) then
					if npc ~= nil then
						if FAIO.ControllableEntityTable[Entity.GetIndex(npc)] == nil then
							FAIO.ControllableEntityTable[Entity.GetIndex(npc)] = npc
						end
					end
				else
					if FAIO.ControllableEntityTable[Entity.GetIndex(npc)] ~= nil then
						FAIO.ControllableEntityTable[Entity.GetIndex(npc)] = nil
					end
				end	
			else
				if FAIO.ControllableEntityTable[Entity.GetIndex(npc)] ~= nil then
					FAIO.ControllableEntityTable[Entity.GetIndex(npc)] = nil
				end
			end		
		else
			if FAIO.ControllableEntityTable[Entity.GetIndex(npc)] ~= nil then
				FAIO.ControllableEntityTable[Entity.GetIndex(npc)] = nil
			end
		end	
	end

	return

end

function FAIO.GetNecronomiconEntityTable(myHero, caster)

	if not myHero then return end
	if not caster then return end

	local necronomiconTable = {}
	for i, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    		if Entity.IsSameTeam(myHero, npc) and Entity.GetOwner(npc) == caster then
    			if NPC.GetUnitName(npc) ~= nil then
				if NPC.GetUnitName(npc) == string.match(NPC.GetUnitName(npc) , 'npc_dota_necronomicon_archer_.') or NPC.GetUnitName(npc) == string.match(NPC.GetUnitName(npc) , 'npc_dota_necronomicon_warrior_.') then
					if npc ~= nil then
						table.insert(necronomiconTable, npc)
					end
				end
			end
		end
	end
	
	return necronomiconTable

end

function FAIO.GetIllusionEntityTable(myHero, caster)

	if not myHero then return end
	if not caster then return end

	local controllableTable = {}
	if next(controllableTable) == nil then
		for i = 1, NPCs.Count() do 
		local npc = NPCs.Get(i)
			if Entity.IsSameTeam(myHero, npc) then
				if npc ~= myHero then
					if Entity.GetOwner(npc) == Entity.GetOwner(caster) then
						if NPC.HasModifier(npc, "modifier_illusion") then
							if npc ~= nil then
								table.insert(controllableTable, npc)
							else controllableTable = {}
							break
							end
						end
					end
				end
			end
		end
	end
	
	return controllableTable

end

function FAIO.NecronomiconController(necronomiconEntity, target, position)

	if not necronomiconEntity then return end
	if not target and not position then return end

	if target ~= nil then
		if NPC.GetUnitName(necronomiconEntity) == string.match(NPC.GetUnitName(necronomiconEntity) , 'npc_dota_necronomicon_archer_.') then
			if not NPC.IsAttacking(necronomiconEntity) then
				if (os.clock() - FAIO.lastCastTime) >= 0.5 then
					if not NPC.IsEntityInRange(necronomiconEntity, target, 600) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
						FAIO.lastCastTime = os.clock()
						FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
					else			
						if Ability.IsReady(NPC.GetAbilityByIndex(necronomiconEntity, 0)) then
							if NPC.IsHero(target) then
								Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET, target, Vector(0,0,0), NPC.GetAbilityByIndex(necronomiconEntity, 0), Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
								FAIO.lastCastTime = os.clock()
								FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "manaBurn", "DOTA_UNIT_ORDER_CAST_TARGET")
							end
						end
						if not Ability.IsReady(NPC.GetAbilityByIndex(necronomiconEntity, 0)) then
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
							FAIO.lastCastTime = os.clock()
							FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
						end	
					end
				end
			end
		end
		if (os.clock() - FAIO.lastCastTime) >= 0.25 then
			if NPC.GetUnitName(necronomiconEntity) == string.match(NPC.GetUnitName(necronomiconEntity) , 'npc_dota_necronomicon_warrior_.') then
				if not NPC.IsAttacking(necronomiconEntity) then
					if (os.clock() - FAIO.lastCastTime2) >= 0.5 then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
						FAIO.lastCastTime2 = os.clock()
						FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
					end
				end
			end
		end
	end

	if position ~= nil then
		if NPC.GetUnitName(necronomiconEntity) == string.match(NPC.GetUnitName(necronomiconEntity) , 'npc_dota_necronomicon_archer_.') then
			if not NPC.IsAttacking(necronomiconEntity) and not NPC.IsRunning(necronomiconEntity) then
				if (os.clock() - FAIO.lastCastTime) >= 0.5 then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
					FAIO.lastCastTime = os.clock()
					FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "attackMove", "DOTA_UNIT_ORDER_ATTACK_MOVE")
				end
			end
		end
		if NPC.GetUnitName(necronomiconEntity) == string.match(NPC.GetUnitName(necronomiconEntity) , 'npc_dota_necronomicon_warrior_.') then
			if (os.clock() - FAIO.lastCastTime) >= 0.25 then
				if not NPC.IsAttacking(necronomiconEntity) and not NPC.IsRunning(necronomiconEntity) then
					if (os.clock() - FAIO.lastCastTime2) >= 0.5 then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, necronomiconEntity)
						FAIO.lastCastTime2 = os.clock()
						FAIO.Debugger(GameRules.GetGameTime(), necronomiconEntity, "attackMove", "DOTA_UNIT_ORDER_ATTACK_MOVE")
					end
				end
			end
		end	
	end

end

function FAIO.invokerForgedSpiritController(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	for i = 1, NPCs.Count() do 
	local npc = NPCs.Get(i)
		if Entity.IsSameTeam(myHero, npc) then
			if npc ~= myHero and Entity.OwnedBy(npc, myHero) then
				if NPC.GetUnitName(npc) ~= nil then
					if  NPC.GetUnitName(npc) == "npc_dota_invoker_forged_spirit" then
						if npc ~= nil and Entity.IsAlive(npc) then
							FAIO.GenericAttackIssuer2("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, npc)
						end	
					end
				end
			end
		end
	end

end

function FAIO.MantaIlluController(target, position, myHero, tempestDoubleEntity)

	if not myHero then return end
	if next(FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity)) == nil then return end
	if not target and not position then return end
	 
	local mantaIllu1 = FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity)[1]
	local mantaIllu2 = FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity)[2]

	if target ~= nil then
		if mantaIllu1 then
			if os.clock() - FAIO.LastTickManta1 >= 0.5 then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, mantaIllu1)
				FAIO.LastTickManta1 = os.clock()
				FAIO.Debugger(GameRules.GetGameTime(), mantaIllu1, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
			end
		end
		if mantaIllu2 then
			if os.clock() - FAIO.LastTickManta2 >= 0.5 then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, mantaIllu2)
				FAIO.LastTickManta2 = os.clock()
				FAIO.Debugger(GameRules.GetGameTime(), mantaIllu2, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
			end
		end
	end

	if position ~= nil then
		if mantaIllu1 then
			if not NPC.IsAttacking(mantaIllu1) and not NPC.IsRunning(mantaIllu1) then
				if os.clock() - FAIO.LastTickManta1 >= 0.5 then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, mantaIllu1)
					FAIO.LastTickManta1 = os.clock()
					FAIO.Debugger(GameRules.GetGameTime(), mantaIllu1, "attackMove", "DOTA_UNIT_ORDER_ATTACK_MOVE")
				end
			end
		end
		if mantaIllu2 then
			if not NPC.IsAttacking(mantaIllu2) and not NPC.IsRunning(mantaIllu2) then
				if os.clock() - FAIO.LastTickManta2 >= 0.5 then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, mantaIllu2)
					FAIO.LastTickManta2 = os.clock()
					FAIO.Debugger(GameRules.GetGameTime(), mantaIllu2, "attackMove", "DOTA_UNIT_ORDER_ATTACK_MOVE")
				end
			end
		end
	end	
end

function FAIO.GenericMainAttack(myHero, attackType, target, position)
	
	if not myHero then return end
	if not target and not position then return end

	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO_utility_functions.inSkillAnimation(myHero) == true then return end

	if Menu.IsEnabled(FAIO_options.optionOrbwalkEnable) then
		if target ~= nil then
			if NPC.HasModifier(myHero, "modifier_windrunner_focusfire") then
				FAIO.GenericAttackIssuer(attackType, target, position, myHero)
			elseif NPC.HasModifier(myHero, "modifier_item_hurricane_pike_range") then
				FAIO.GenericAttackIssuer(attackType, target, position, myHero)
			else
				FAIO.OrbWalker(myHero, target)
			end
		else
			FAIO.GenericAttackIssuer(attackType, target, position, myHero)
		end
	else
		FAIO.GenericAttackIssuer(attackType, target, position, myHero)
	end

end

function FAIO.GenericAttackIssuer(attackType, target, position, npc)

	if not npc then return end
	if not target and not position then return end
	if os.clock() - FAIO.lastAttackTime2 < 0.75 then return end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET" then
		if target ~= nil then
			if target ~= FAIO.LastTarget then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, target, Vector(0, 0, 0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, false, true)
				FAIO.LastTarget = target
			end
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE" then
		if position ~= nil then
			if not NPC.IsAttacking(npc) or not NPC.IsRunning(npc) then
				if position:__tostring() ~= FAIO.lastMovePos:__tostring() then
					if (position - FAIO.lastMovePos):Length2D() > 100 then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
						FAIO.lastMovePos = position
					end
				end
			end
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION" then
		if position ~= nil then
			if position:__tostring() ~= FAIO.lastMovePos:__tostring() then
				if (position - FAIO.lastMovePos):Length2D() > 100 then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, false, true)
					FAIO.lastMovePos = position
				end
			end
		end
	end

	if target ~= nil then
		if target == FAIO.LastTarget then
			if not NPC.IsAttacking(npc) then
				FAIO.LastTarget = nil
				FAIO.lastAttackTime2 = os.clock()
				return
			end
		end
	end

	if position ~= nil then
		if position:__tostring() == FAIO.LastTarget then
			if not NPC.IsRunning(npc) then
				FAIO.lastMovePos = Vector()
				FAIO.lastAttackTime2 = os.clock()
				return
			end
		end
	end

end

function FAIO.GenericAttackIssuer2(attackType, target, position, npc)

	if not npc or (npc and not Entity.IsAlive(npc)) then return end
	if not target and not position then return end

	if FAIO[tostring(npc)] ~= nil then
		if os.clock() - FAIO[tostring(npc)] < 1.0 then
			return
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET" and (Menu.IsKeyDown(FAIO_options.optionComboKey) or Menu.IsKeyDown(FAIO_options.optionHeroVisageInstStunKey)) then
		if target ~= nil then
			Player.AttackTarget(Players.GetLocal(), npc, target, false)
			FAIO.Debugger(GameRules.GetGameTime(), npc, "attack", "DOTA_UNIT_ORDER_ATTACK_TARGET")
			FAIO[tostring(npc)] = os.clock()
			return
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE" then
		if position ~= nil then
			if #NPC.GetUnitsInRadius(npc, NPC.GetAttackRange(npc)+50, 1) < 1 then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
				FAIO.Debugger(GameRules.GetGameTime(), npc, "attackMove", "DOTA_UNIT_ORDER_ATTACK_MOVE")
				FAIO[tostring(npc)] = os.clock()
				return
			end
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION" then
		if position ~= nil then
			if not NPC.IsRunning(npc) then
				NPC.MoveTo(npc, position, false, false)
				FAIO.Debugger(GameRules.GetGameTime(), npc, "move", "DOTA_UNIT_ORDER_MOVE_TO_POSITION")
				FAIO[tostring(npc)] = os.clock()
				return
			end
		end
	end
end

function FAIO.GenericControllableAttackIssuer(attackType, target, position)

	if next(FAIO.ControllableEntityTable) == nil then return end
	if not target and not position then return end

	local controllableEntity = nil
		for i, v in pairs(FAIO.ControllableEntityTable) do
			if v and Entity.IsNPC(v) and Entity.IsAlive(v) and FAIO.heroCanCastItems(v) == true then
				if FAIO.ControllableAttackTiming[Entity.GetIndex(v)] == nil or os.clock() - FAIO.ControllableAttackTiming[Entity.GetIndex(v)] > 0.5 then
					controllableEntity = v
					break
				end
			end
		end

	if controllableEntity ~= nil then

		if attackType == "ATTACK_TARGET" then
			if target ~= nil then
				Player.AttackTarget(Players.GetLocal(), controllableEntity, target, false)
				FAIO.ControllableAttackTiming[Entity.GetIndex(controllableEntity)] = os.clock()
				return
			end
		end

		if attackType == "MOVE_TO_POSITION" then
			if position ~= nil then
				if not NPC.IsRunning(controllableEntity) then
					NPC.MoveTo(controllableEntity, position, false, false)
					FAIO.ControllableAttackTiming[Entity.GetIndex(controllableEntity)] = os.clock()
					return
				end
			end
		end

	end

	return

end

function FAIO.OrbWalker(myHero, enemy)

-- orbwalker needs rewrite; fail timings; cancel attacks due to orb attacks, MAJOR ISSUE

	if not myHero then return end
	if not enemy then return end

	if NPC.IsChannellingAbility(myHero) then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO_utility_functions.inSkillAnimation(myHero) == true then return end

	local myMana = NPC.GetMana(myHero)

	local attackRange = NPC.GetAttackRange(myHero)

	local increasedAS = NPC.GetIncreasedAttackSpeed(myHero)
	local attackTime = NPC.GetAttackTime(myHero)
	local movementSpeed = NPC.GetMoveSpeed(myHero)

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

	local turnTime180degrees = (0.03 * math.pi) / NPC.GetTurnRate(myHero)

	local orbWalkSkill
	for i, v in pairs(FAIO_data.orbAttackTable) do
		if i == NPC.GetUnitName(myHero) then
			orbWalkSkill = NPC.GetAbility(myHero, v)
			break
		end
	end

	if orbWalkSkill then
		if Ability.GetName(orbWalkSkill) == "viper_poison_attack" then
			if NPC.HasModifier(enemy, "modifier_viper_poison_attack_slow") then
				local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_viper_poison_attack_slow"))
				if dieTime - GameRules.GetGameTime() > 1.0 then
					orbWalkSkill = nil
				end
			end
		end
	end

	if Entity.IsSameTeam(myHero, enemy) then
		orbWalkSkill = nil
	end

	if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		orbWalkSkill = nil
	end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then
		orbWalkSkill = nil
	end

	if NPC.IsRanged(myHero) then
		if FAIO.AttackProjectileCreate > 0 then
			if os.clock() > FAIO.AttackProjectileCreate and os.clock() < FAIO.AttackProjectileCreate + attackBackSwing + idleTime then
				FAIO.InAttackBackswing = true
			else
				FAIO.InAttackBackswing = false
			end
		end
	else
		if FAIO.AttackParticleCreate > 0 then
			if NPC.HasItem(myHero, "item_echo_sabre", true) then
				if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_echo_sabre", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_echo_sabre", true)) < (attackPoint / 1.49) + 0.15 then
					FAIO.InAttackBackswing = false
				else
					if os.clock() > FAIO.AttackAnimationCreate and os.clock() < FAIO.AttackParticleCreate + attackBackSwing + idleTime then
						FAIO.InAttackBackswing = true
					else
						FAIO.InAttackBackswing = false
					end
				end
			else
				if os.clock() > FAIO.AttackAnimationCreate and os.clock() < FAIO.AttackParticleCreate + attackBackSwing + idleTime then
					FAIO.InAttackBackswing = true
				else
					FAIO.InAttackBackswing = false
				end
			end
		end
	end

	if os.clock() > FAIO.AttackAnimationCreate and os.clock() < FAIO.AttackParticleCreate then
		FAIO.InAttackBackswing = false
	end

--	if os.clock() > FAIO.AttackAnimationCreate and os.clock() < FAIO.AttackProjectileCreate then
--		FAIO.InAttackBackswing = false
--	end

	local breakPoint
		if NPC.IsRanged(myHero) then
			breakPoint = attackRange * (Menu.GetValue(FAIO_options.optionOrbwalkDistance) / 100)
		else
			breakPoint = attackRange
		end

	local moveDistance = NPC.GetMoveSpeed(myHero) * (attackBackSwing + idleTime - NPC.GetTimeToFace(myHero, enemy)) * (1 - (Menu.GetValue(FAIO_options.optionOrbwalkOffset) / 100))
		if NPC.IsRanged(myHero) then
			if (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() > breakPoint and (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() <= breakPoint + moveDistance then
				moveDistance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - breakPoint
			end
		end

	local kiteDistance = 0
		if (2 * turnTime180degrees) < (attackBackSwing + idleTime) * (1 - (Menu.GetValue(FAIO_options.optionOrbwalkOffset) / 100)) then
			kiteDistance = ((attackBackSwing + idleTime) * (1 - (Menu.GetValue(FAIO_options.optionOrbwalkOffset) / 100)) - (2 * turnTime180degrees)) * NPC.GetMoveSpeed(myHero)
		end

	local styleSelector = 0
		if Menu.GetValue(FAIO_options.optionOrbwalkStyle) == 0 then
			styleSelector = 1
		else
			if Menu.GetValue(FAIO_options.optionOrbwalkMouseStyle) == 1 then
				styleSelector = 2
			else
				if NPC.IsRanged(myHero) then			
					styleSelector = 2
				else
					styleSelector = 1
				end
			end
		end
	
	if styleSelector < 2 then
		if not FAIO.InAttackBackswing then
			if orbWalkSkill and Ability.IsCastable(orbWalkSkill, myMana) then
				if os.clock() - FAIO.OrbwalkerDelay > 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastTarget(orbWalkSkill, enemy)
					FAIO.OrbwalkerDelay = os.clock()
					return
				end
			else
				if os.clock() - FAIO.OrbwalkerDelay > 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) and os.clock() - FAIO.AttackAnimationCreate > attackPoint + 0.1 then
					Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
					FAIO.OrbwalkerDelay = os.clock()
					return
				end
			end
		else
			if (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() > breakPoint then
			--	if os.clock() - FAIO.OrbwalkerDelay > attackBackSwing + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					if moveDistance > 50 then
						local targetVector = Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(moveDistance)
						NPC.MoveTo(myHero, targetVector, false, false)
						FAIO.OrbwalkerDelay = os.clock()
						return
					end
		--		end
	
			end
			if Menu.IsEnabled(FAIO_options.optionOrbwalkKiting) then
				if NPC.IsRanged(myHero) then
					if (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() < breakPoint - 50 then
						if os.clock() - FAIO.OrbwalkerDelay > attackBackSwing + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
							if kiteDistance > 50 then
								local targetVector = Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(kiteDistance)
								NPC.MoveTo(myHero, targetVector, false, false)
								FAIO.OrbwalkerDelay = os.clock()
								return
							end
						end
					end
				end
			end
		end
	else
		local mousePos = Input.GetWorldCursorPos()
		local breakPoint2
			if NPC.IsRanged(myHero) then
				breakPoint2 = attackRange * (Menu.GetValue(FAIO_options.optionOrbwalkDistanceMouse) / 100)
			else
				breakPoint2 = attackRange
			end
		local moveDistance2 = NPC.GetMoveSpeed(myHero) * (attackBackSwing + idleTime - NPC.GetTimeToFace(myHero, enemy) - FAIO.TimeToFacePosition(myHero, mousePos)) * (1 - (Menu.GetValue(FAIO_options.optionOrbwalkOffset) / 100))
		
		if not FAIO.InAttackBackswing then
			if orbWalkSkill and Ability.IsCastable(orbWalkSkill, myMana) then
				if os.clock() - FAIO.OrbwalkerDelay > 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastTarget(orbWalkSkill, enemy)
					FAIO.OrbwalkerDelay = os.clock()
					return
				end
			else
				if os.clock() - FAIO.OrbwalkerDelay > 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) and os.clock() - FAIO.AttackAnimationCreate > attackPoint + 0.1 then
					Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
					FAIO.OrbwalkerDelay = os.clock()
					return
				end
			end
		else
			if os.clock() - FAIO.OrbwalkerDelay > attackBackSwing + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
				local myDisToMouse = (Entity.GetAbsOrigin(myHero) - mousePos):Length2D()
				if moveDistance2 > 50 and myDisToMouse > Menu.GetValue(FAIO_options.optionOrbwalkMouseHold) then
					local targetVector = Entity.GetAbsOrigin(myHero) + (mousePos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(moveDistance2)
					if not NPC.IsPositionInRange(enemy, targetVector, breakPoint2, 0) then
						NPC.MoveTo(myHero, targetVector, false, false)
						FAIO.OrbwalkerDelay = os.clock()
						return
					end
				end
			end
		end
	end

end

function FAIO.TimeToFacePosition(myHero, pos)

	if not myHero then return 0 end
	if not pos then return 0 end

	local myPos = Entity.GetAbsOrigin(myHero)
	local myRotation = Entity.GetRotation(myHero):GetForward():Normalized()

	local baseVec = (pos - myPos):Normalized()

	local tempProcessing = math.min(baseVec:Dot2D(myRotation) / (baseVec:Length2D() * myRotation:Length2D()), 1)	

	local checkAngleRad = math.acos(tempProcessing)
	local checkAngle = (180 / math.pi) * checkAngleRad

	local myTurnRate = NPC.GetTurnRate(myHero)

	local turnTime = FAIO_utility_functions.utilityRoundNumber(((0.033 * math.pi / myTurnRate) / 180) * checkAngle, 3)

	return turntime or 0

end

function FAIO.GetLongestCooldown(myHero, skill1, skill2, skill3, skill4, skill5)

	if not myHero then return end

	local skill1 = skill1
	local skill2 = skill2
	local skill3 = skill3
	local skill4 = skill4
	local skill5 = skill5


	local tempTable = {}

	if skill1 then
		table.insert(tempTable, math.ceil(Ability.GetCooldownTimeLeft(skill1)))
	end
	if skill2 then
		table.insert(tempTable, math.ceil(Ability.GetCooldownTimeLeft(skill2)))
	end
	if skill3 then
		table.insert(tempTable, math.ceil(Ability.GetCooldownTimeLeft(skill3)))
	end
	if skill4 then
		table.insert(tempTable, math.ceil(Ability.GetCooldownTimeLeft(skill4)))
	end
	if skill5 then
		table.insert(tempTable, math.ceil(Ability.GetCooldownTimeLeft(skill5)))
	end

	table.sort(tempTable, function(a, b)
        	return a > b
    			end)

	return tempTable[1]

end

function FAIO.GenericLanePusher(npc)

	if not npc or (npc and not Entity.IsAlive(npc)) then return end

	local myFaction = FAIO_utility_functions.GetMyFaction(npc)
	local myFountainPos = FAIO_utility_functions.GetMyFountainPos(npc)
	local enemyFountainPos = FAIO_utility_functions.GetEnemyFountainPos(npc)

	local leftCornerPos = Vector(-5750, 6050, 384)
	local rightCornerPos = Vector(6000, -5800, 384)
	local midPos = Vector(-600, -300, 128)

	local radiantTop2 = Vector(-6150, -800, 384)
	local radiantBot2 = Vector(-800, -6250, 384)
	local radiantMid2 = Vector(-2800, -2250, 256)
	
	local direTop2 = Vector(800, 6000, 384)
	local direBot2 = Vector(6200, 400, 384)
	local direMid2 = Vector(2800, 2100, 256)


	local myBotTower2
		if myFaction == "radiant"
			then myBotTower2 = radiantBot2
		else myBotTower2 = direBot2
		end

	local myTopTower2
		if myFaction == "radiant"
			then myTopTower2 = radiantTop2
		else myTopTower2 = direTop2
		end

	local myMidTower2
		if myFaction == "radiant"
			then myMidTower2 = radiantMid2
		else myMidTower2 = direMid2
		end


	local myPos = Entity.GetAbsOrigin(npc)

	local homeSide
	if myPos:__sub(myFountainPos):Length2D() < myPos:__sub(enemyFountainPos):Length2D() then
		homeSide = true
	else homeSide = false
	end
	
	if not homeSide then
		return enemyFountainPos
	end

	if homeSide then
		if myPos:__sub(leftCornerPos):Length2D() <= 800 then
			return enemyFountainPos
		elseif myPos:__sub(rightCornerPos):Length2D() <= 800 then
			return enemyFountainPos
		elseif myPos:__sub(midPos):Length2D() <= 800 then
			return enemyFountainPos
		end
	end

	if homeSide then
		if myPos:__sub(leftCornerPos):Length2D() > 800 and myPos:__sub(rightCornerPos):Length2D() > 800 and myPos:__sub(midPos):Length2D() > 800 then
			
			if myPos:__sub(leftCornerPos):Length2D() < myPos:__sub(rightCornerPos):Length2D() and myPos:__sub(leftCornerPos):Length2D() < myPos:__sub(midPos):Length2D() then
				return leftCornerPos
			elseif myPos:__sub(leftCornerPos):Length2D() < myPos:__sub(rightCornerPos):Length2D() and myPos:__sub(myTopTower2):Length2D() < myPos:__sub(midPos):Length2D() and myPos:__sub(myMidTower2):Length2D() > myPos:__sub(myTopTower2):Length2D() then
				return leftCornerPos
			elseif myPos:__sub(rightCornerPos):Length2D() < myPos:__sub(leftCornerPos):Length2D() and myPos:__sub(rightCornerPos):Length2D() < myPos:__sub(midPos):Length2D() then
				return rightCornerPos
			elseif myPos:__sub(rightCornerPos):Length2D() < myPos:__sub(leftCornerPos):Length2D() and myPos:__sub(myBotTower2):Length2D() < myPos:__sub(midPos):Length2D() and myPos:__sub(myMidTower2):Length2D() > myPos:__sub(myBotTower2):Length2D() then
				return rightCornerPos
			elseif myPos:__sub(midPos):Length2D() < myPos:__sub(leftCornerPos):Length2D() and myPos:__sub(midPos):Length2D() < myPos:__sub(rightCornerPos):Length2D() and myPos:__sub(myMidTower2):Length2D() < myPos:__sub(myTopTower2):Length2D() then
				return enemyFountainPos
			elseif myPos:__sub(midPos):Length2D() < myPos:__sub(leftCornerPos):Length2D() and myPos:__sub(midPos):Length2D() < myPos:__sub(rightCornerPos):Length2D() and myPos:__sub(myMidTower2):Length2D() < myPos:__sub(myBotTower2):Length2D() then
				return enemyFountainPos
			else return enemyFountainPos
			end
		end
	end
end

function FAIO.ForceBlink(myHero, enemy, range)

	if not myHero then return end
	
	local blink = NPC.GetItem(myHero, "item_blink", true)
		if not blink then return end
		if blink and not Ability.IsReady(blink) then return end

	if not enemy or (enemy and not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), range, 0)) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) then
			if NPC.IsPositionInRange(myHero, Input.GetWorldCursorPos(), 1100, 0) then
				Ability.CastPosition(blink, Input.GetWorldCursorPos())
				return
			else
-- sleep ready dep
			--	if FAIO.SleepReady(0.1) then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Input.GetWorldCursorPos(), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
					FAIO.lastTick = os.clock()
					return
			--	end
			end	
		end
	end
end

function FAIO:WorldToMiniMap(pos, screenWidth, screenHeight)
	local screenH = screenHeight
	local screenW = screenWidth 
	local MapLeft = -8000
	local MapTop = 7350
	local MapRight = 7500
	local MapBottom = -7200
	local mapWidth = math.abs(MapLeft - MapRight)
	local mapHeight = math.abs(MapBottom - MapTop)
	

	local x = pos:GetX() - MapLeft
	local y = pos:GetY() - MapBottom

	local dx, dy, px, py
	if self.Round(screenW / screenH, 1) >= 1.7 then

		dx = 272 / 1920 * screenW
		dy = 261 / 1080 * screenH
		px = 11 / 1920 * screenW
		py = 11 / 1080 * screenH
	elseif self.Round(screenW / screenH, 1) >= 1.5 then

		dx = 267 / 1680 * screenW
		dy = 252 / 1050 * screenH
		px = 10 / 1680 * screenW
		py = 11 / 1050 * screenH
	else
		dx = 255 / 1280 * screenW
		dy = 229 / 1024 * screenH
		px = 6 / 1280 * screenW
		py = 9 / 1024 * screenH
	end
	local minimapMapScaleX = dx / mapWidth
	local minimapMapScaleY = dy / mapHeight

	local scaledX = math.min(math.max(x * minimapMapScaleX, 0), dx)
	local scaledY = math.min(math.max(y * minimapMapScaleY, 0), dy)

	local screenX = px + scaledX
	local screenY = screenH - scaledY - py

	return Vector(math.floor(screenX - 20 + Menu.GetValue(FAIO_options.optionWorldToMinimapOffsetX)), math.floor(screenY - 12 + Menu.GetValue(FAIO_options.optionWorldToMinimapOffsetY)), 0)
end

function FAIO.Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function FAIO.TargetDisableTimer(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local stunRootList = {
		"modifier_stunned",
		"modifier_bashed",
		"modifier_alchemist_unstable_concoction", 
		"modifier_ancientapparition_coldfeet_freeze", 
		"modifier_axe_berserkers_call",
		"modifier_bane_fiends_grip",
		"modifier_bane_nightmare",
		"modifier_bloodseeker_rupture",
		"modifier_rattletrap_hookshot", 
		"modifier_earthshaker_fissure_stun", 
		"modifier_earth_spirit_boulder_smash",
		"modifier_enigma_black_hole_pull",
		"modifier_faceless_void_chronosphere_freeze",
		"modifier_jakiro_ice_path_stun", 
		"modifier_keeper_of_the_light_mana_leak_stun", 
		"modifier_kunkka_torrent", 
		"modifier_legion_commander_duel", 
		"modifier_lion_impale", 
		"modifier_magnataur_reverse_polarity", 
		"modifier_medusa_stone_gaze_stone", 
		"modifier_morphling_adaptive_strike", 
		"modifier_naga_siren_ensnare", 
		"modifier_nyx_assassin_impale", 
		"modifier_pudge_dismember", 
		"modifier_sandking_impale", 
		"modifier_shadow_shaman_shackles", 
		"modifier_techies_stasis_trap_stunned", 
		"modifier_tidehunter_ravage", 
		"modifier_treant_natures_guise",
		"modifier_windrunner_shackle_shot",
		"modifier_rooted", 
		"modifier_crystal_maiden_frostbite", 
		"modifier_ember_spirit_searing_chains", 
		"modifier_meepo_earthbind",
		"modifier_lone_druid_spirit_bear_entangle_effect",
		"modifier_slark_pounce_leash",
		"modifier_storm_spirit_electric_vortex_pull",
		"modifier_treant_overgrowth", 
		"modifier_abyssal_underlord_pit_of_malice_ensare", 
		"modifier_item_rod_of_atos_debuff",
		"modifier_eul_cyclone",
		"modifier_obsidian_destroyer_astral_imprisonment_prison",
		"modifier_shadow_demon_disruption"
			}
	
	local searchMod
	for _, modifier in ipairs(stunRootList) do
		if NPC.HasModifier(enemy, modifier) then
			searchMod = NPC.GetModifier(enemy, modifier)
			break
		end
	end

	if searchMod then
		if NPC.HasModifier(enemy, Modifier.GetName(searchMod)) then
			if Modifier.GetName(searchMod) == "modifier_enigma_black_hole_pull" then
				return Modifier.GetCreationTime(searchMod) + 4
			elseif Modifier.GetName(searchMod) == "modifier_faceless_void_chronosphere_freeze" then
				return Modifier.GetCreationTime(searchMod) + (3.5 + FAIO.GetTeammateAbilityLevel(myHero, "faceless_void_chronosphere") * 0.5)
			else
				return Modifier.GetDieTime(searchMod)
			end
		else
			return 0
		end
	else
		return 0
	end

end

function FAIO.GetTeammateAbilityLevel(myHero, ability)

	if not myHero then return end
	if not ability then return 0 end

	for _, teamMate in ipairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
		if NPC.HasAbility(teamMate, ability) then
			if NPC.GetAbility(teamMate, ability) then
				return Ability.GetLevel(NPC.GetAbility(teamMate, ability))
			end
		end
	end
	return 0

end

function FAIO.TargetIsInvulnarable(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local curTime = GameRules.GetGameTime()

	local invuList = {
		"modifier_eul_cyclone",
		"modifier_invoker_tornado",
		"modifier_obsidian_destroyer_astral_imprisonment_prison",
		"modifier_shadow_demon_disruption"
			}
	
	local searchMod
	for _, modifier in ipairs(invuList) do
		if NPC.HasModifier(enemy, modifier) then
			searchMod = NPC.GetModifier(enemy, modifier)
			break
		end
	end

	if searchMod then
		if NPC.HasModifier(enemy, Modifier.GetName(searchMod)) then
			return Modifier.GetDieTime(searchMod)
		else
			return 0
		end
	else
		return 0
	end

end

function FAIO.EnemyHPTracker(myHero)

	if not myHero then return end

	if Heroes.Count() == 0 then
		FAIO.enemyHeroTable = {}
		return
	end	

	for i = 1, Heroes.Count() do
		local allHeroes = Heroes.Get(i)
	
		if allHeroes == nil then
			FAIO.enemyHeroTable = {}
			return
		else
			if Entity.IsHero(allHeroes) and not Entity.IsSameTeam(myHero, allHeroes) then
				if not NPC.IsIllusion(allHeroes) then
					if FAIO.enemyHeroTable[allHeroes] == nil then
						FAIO.enemyHeroTable[allHeroes] = { 99999, 99999, 0 }
					end
				end
			end
		end
	end

	for hero, data in pairs(FAIO.enemyHeroTable) do
		if hero and not Entity.IsNPC(hero) then
			FAIO.enemyHeroTable[hero] = nil
		end
		if hero and Entity.IsNPC(hero) and Entity.IsAlive(hero) and not Entity.IsDormant(hero) and GameRules.GetGameTime() - data[3] > 1 then
			local heroHP = Entity.GetHealth(hero)
			local heroHPreg = NPC.GetHealthRegen(hero)
			local timeStamp = GameRules.GetGameTime()
			FAIO.enemyHeroTable[hero] = { heroHP, heroHPreg, timeStamp }
		end
	end

end

function FAIO.getEnemyBeShackledWithNPC(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)
	local shackleShot = NPC.GetAbility(myHero, "windrunner_shackleshot")
		if not shackleShot then return end
		if not Ability.IsCastable(shackleShot, myMana) then return end

	local shackleSearchRange = 575
	local shackleCastRange = 785

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroWindrunnerPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.15 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local directLineVector = enemyPos + (enemyPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(shackleSearchRange)

	local npcs = Entity.GetUnitsInRadius(enemy, shackleSearchRange, Enum.TeamType.TEAM_FRIEND)
		if next(npcs) == nil then return end

		local shackleNPC
		local minAngle = 180
		local minRange = 99999	

		for _, targetNPC in ipairs(npcs) do
			if targetNPC then
				local myDisToEnemy = (Entity.GetAbsOrigin(myHero) - enemyPos):Length2D()
				local myDisToNPC = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(targetNPC)):Length2D()
				local enemyDisToNPC = (enemyPos - Entity.GetAbsOrigin(targetNPC)):Length2D()
				if myDisToEnemy < myDisToNPC then
					if myDisToEnemy < shackleCastRange then
						local vectorEnemyToNPC = Entity.GetAbsOrigin(targetNPC) - enemyPos
						local vectormyHerotoEnemy = enemyPos - Entity.GetAbsOrigin(myHero)
						local tempProcessing = vectormyHerotoEnemy:Dot2D(vectorEnemyToNPC) / (vectormyHerotoEnemy:Length2D() * vectorEnemyToNPC:Length2D())
							if tempProcessing > 1 then
								tempProcessing = 1
							end	
						local searchAngleRad = math.acos(tempProcessing)
						local searchAngle = (180 / math.pi) * searchAngleRad
						if searchAngle < minAngle then
							shackleNPC = enemy
							minAngle = searchAngle
						end
					end
				else
					if myDisToNPC < shackleCastRange then
						local vectorNPCToEnemy = enemyPos - Entity.GetAbsOrigin(targetNPC)
						local vectormyHerotoNPC = Entity.GetAbsOrigin(targetNPC) - Entity.GetAbsOrigin(myHero)
						local tempProcessing = vectormyHerotoNPC:Dot2D(vectorNPCToEnemy) / (vectormyHerotoNPC:Length2D() * vectorNPCToEnemy:Length2D())
							if tempProcessing > 1 then
								tempProcessing = 1
							end	
						local searchAngleRad = math.acos(tempProcessing)
						local searchAngle = (180 / math.pi) * searchAngleRad
						if searchAngle < minAngle and vectorNPCToEnemy:Length2D() < minRange then
							shackleNPC = targetNPC
							minAngle = searchAngle
							minRange = vectorNPCToEnemy:Length2D()
						end
					end
				end
			end
		end

		if shackleNPC and minAngle < 23 then
			return shackleNPC
		end
	
	return

end

function FAIO.getEnemyShackledBestPosition(myHero, enemy, dist)

	if not myHero then return Vector() end
	if not enemy then return Vector() end
	if not dist then return Vector() end

	local myMana = NPC.GetMana(myHero)
	local shackleShot = NPC.GetAbility(myHero, "windrunner_shackleshot")
		if not shackleShot then return Vector() end
		if not Ability.IsCastable(shackleShot, myMana) then return Vector() end

	local shackleSearchRange = 575
	local shackleCastRange = 785

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroWindrunnerPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.15 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local directLineVector = enemyPos + (enemyPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(shackleSearchRange)

	local shacklePos = Vector()
	local minDis = 99999
	local minCreepDis = 99999

	if not FAIO.canEnemyBeShackledWithTree(myHero, enemy) and FAIO.getEnemyBeShackledWithNPC(myHero, enemy) == nil then
		local npcs = Entity.GetUnitsInRadius(enemy, shackleSearchRange, Enum.TeamType.TEAM_FRIEND)
		for _, targetNPC in ipairs(npcs) do
			if targetNPC then
				local myDisToEnemy = (Entity.GetAbsOrigin(myHero) - enemyPos):Length2D()
				local myDisToNPC = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(targetNPC)):Length2D()
				local enemyDisToNPC = (enemyPos - Entity.GetAbsOrigin(targetNPC)):Length2D()
				
				if myDisToEnemy < myDisToNPC then
					local vectorNPCtoEnemy = enemyPos - Entity.GetAbsOrigin(targetNPC)
					local searchVec = Entity.GetAbsOrigin(targetNPC) + vectorNPCtoEnemy:Normalized():Scaled(vectorNPCtoEnemy:Length2D() + 250)
					local myDisToSearchPos = (searchVec - Entity.GetAbsOrigin(myHero)):Length2D()
					if #Trees.InRadius(searchVec, 300, true) < 1 and #Heroes.InRadius(searchVec, 150, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) < 1 then
						if myDisToSearchPos < minDis then
							shacklePos = searchVec
							minDis = myDisToSearchPos
						end
					end
				else
					local vectorEnemyToNPC = Entity.GetAbsOrigin(targetNPC) - enemyPos
					local searchVec = enemyPos + vectorEnemyToNPC:Normalized():Scaled(vectorEnemyToNPC:Length2D() + 250)
					local myDisToSearchPos = (searchVec - Entity.GetAbsOrigin(myHero)):Length2D()
					if #Trees.InRadius(searchVec, 300, true) < 1 and #Heroes.InRadius(searchVec, 150, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) < 1 then
						if myDisToSearchPos < minDis and vectorEnemyToNPC:Length2D() < minCreepDis then
							shacklePos = searchVec
							minDis = myDisToSearchPos
							minCreepDis = vectorEnemyToNPC:Length2D()
						end
					end
				end
			end
		end
		
		if shacklePos:__tostring() == Vector():__tostring() then
			if next(FAIO.getEnemyShackleTrees(myHero, enemy)) ~= nil then
				for _, targetTree in ipairs(FAIO.getEnemyShackleTrees(myHero, enemy)) do
					if targetTree then
						local vectorTreeToEnemy = enemyPos - Entity.GetAbsOrigin(targetTree)
						local searchVec = Entity.GetAbsOrigin(targetTree) + vectorTreeToEnemy:Normalized():Scaled(vectorTreeToEnemy:Length2D() + 350)
						local myDisToSearchPos = (searchVec - Entity.GetAbsOrigin(myHero)):Length2D()
						if #Trees.InRadius(searchVec, 300, true) < 1 and #Heroes.InRadius(searchVec, 300, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) < 1 then
							if myDisToSearchPos < minDis then
								shacklePos = searchVec
								minDis = myDisToSearchPos
							end
						end
					end
				end
			end	
		end
	end
	
	if shacklePos:__tostring() ~= Vector():__tostring() and minDis < dist then
		return shacklePos
	end

	return Vector()

end

function FAIO.getEnemyShackleTrees(myHero, enemy)

	if not myHero then return {} end
	if not enemy then return {} end

	local shackleSearchRange = 575

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroWindrunnerPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.15 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local trees = Trees.InRadius(enemyPos, shackleSearchRange, true)
		if next(trees) == nil then return {} end

	local returnTrees = {}
	for _, targetTree in ipairs(trees) do		
		if targetTree then
			table.insert(returnTrees, targetTree)
		end
	end

	if next(returnTrees) ~= nil then
		return returnTrees
	end
	return {}

end
			
function FAIO.canEnemyBeShackledWithTree(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)
	local shackleShot = NPC.GetAbility(myHero, "windrunner_shackleshot")
		if not shackleShot then return false end
		if not Ability.IsCastable(shackleShot, myMana) then return false end

	local shackleSearchRange = 575
	local shackleCastRange = 785

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroWindrunnerPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.15 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local directLineVector = enemyPos + (enemyPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(shackleSearchRange)

	local trees = Trees.InRadius(directLineVector, shackleSearchRange, true)
		if next(trees) == nil then return false end

		local shackleTree
		local minAngle = 180
		
		for _, targetTree in ipairs(trees) do		
			if targetTree then
				local myDisToEnemy = (Entity.GetAbsOrigin(myHero) - enemyPos):Length2D()
				local enemyDisToTree = (enemyPos - Entity.GetAbsOrigin(targetTree)):Length2D()
				if myDisToEnemy < shackleCastRange then
					if enemyDisToTree < shackleSearchRange then
						if targetTree ~= nil then
							local vectorEnemyToTree = Entity.GetAbsOrigin(targetTree) - enemyPos
							local vectormyHerotoEnemy = enemyPos - Entity.GetAbsOrigin(myHero)
							local tempProcessing = vectormyHerotoEnemy:Dot2D(vectorEnemyToTree) / (vectormyHerotoEnemy:Length2D() * vectorEnemyToTree:Length2D())
							if tempProcessing > 1 then
								tempProcessing = 1
							end
							local searchAngleRad = math.acos(tempProcessing)
							local searchAngle = (180 / math.pi) * searchAngleRad
							if searchAngle < minAngle then
								shackleTree = targetTree
								minAngle = searchAngle
							end
						end
					end
				end
			end
		end

		if shackleTree and minAngle < 23 then
			return true
		end
	
	return false

end

function FAIO.TimberIsTreeInRangeForChain(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return end
		if not Ability.IsCastable(timberChain, myMana) then return end

	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroTimberPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local remainingDis = chainCastRange - (enemyPos - Entity.GetAbsOrigin(myHero)):Length2D()
	local directLineVector = enemyPos + (enemyPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(remainingDis)

	local trees = Trees.InRadius(directLineVector, remainingDis, true)
		if next(trees) == nil then return end

		local chainTree
		local minDis = 99999
		
		for _, targetTree in ipairs(trees) do		
			if targetTree then
				local myDisToTree = (Entity.GetAbsOrigin(targetTree) - Entity.GetAbsOrigin(myHero)):Length2D()
				if myDisToTree < chainCastRange then
					local vectormyHeroToTree = Entity.GetAbsOrigin(targetTree) - Entity.GetAbsOrigin(myHero)
					if FAIO.TimberAmIhittingWithChain(myHero, enemy, Entity.GetAbsOrigin(targetTree)) == true and myDisToTree < minDis then
						chainTree = targetTree
						minDis = myDisToTree
					end
				end
			end
		end


		if chainTree then
			return chainTree
		end
	
	return 

end

function FAIO.TimberAmIhittingWithChain(myHero, enemy, pos)

	if not myHero then return false end
	if not enemy then return false end
	if not pos then return false end

	local myPos = Entity.GetAbsOrigin(myHero)
	local chainDistance = (pos - myPos):Length2D()
	local chainVector = myPos - pos

	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroTimberPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local checkNum = tonumber(math.floor(chainDistance/150) + 1)
	for i = checkNum, 1, -1 do 
        	chainVector:Normalize()
        	chainVector:Scale(150 * (i-1))
        	local checkPos = pos + chainVector
		if (checkPos - enemyPos):Length2D() < 200 then
            		return true
		end
	end

	return false

end

function FAIO.TimberGetEnemyChainTrees(myHero, enemy)

	if not myHero then return {} end
	if not enemy then return {} end

	local myMana = NPC.GetMana(myHero)

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return {} end
		if not Ability.IsCastable(timberChain, myMana) then return {} end
	
	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	
	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroTimberPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local remainingDis = chainCastRange - (enemyPos - Entity.GetAbsOrigin(myHero)):Length2D()

	local trees = Trees.InRadius(enemyPos, remainingDis, true)
		if next(trees) == nil then return {} end

	local returnTrees = {}
	for _, targetTree in ipairs(trees) do		
		if targetTree then
			table.insert(returnTrees, targetTree)
		end
	end

	if next(returnTrees) ~= nil then
		return returnTrees
	end
	return {}

end

function FAIO.GetClosestPoint(A,  B,  P, segmentClamp)
	
	A:SetZ(0)
	B:SetZ(0)
	P:SetZ(0)

	local Ax = A:GetX()
	local Ay = A:GetY()
	local Bx = B:GetX()
	local By = B:GetY()
	local Px = P:GetX()
	local Py = P:GetY()

	local AP = P - A
	local AB = B - A

	local APx = AP:GetX()
	local APy = AP:GetY()

	local ABx = AB:GetX()
	local ABy = AB:GetY()

	local ab2 = ABx*ABx + ABy*ABy
	local ap_ab = APx*ABx + APy*ABy

	local t = ap_ab / ab2
 
	if (segmentClamp or true) then
		if (t < 0.0) then
			t = 0.0
		elseif (t > 1.0) then
			t = 1.0
		end
	end
 
	local Closest = Vector(Ax + ABx*t, Ay + ABy * t, 0)
 
	return Closest
end

function FAIO.TimberGetBestChainPos(myHero, enemy, dist)

	if not myHero then return Vector() end
	if not enemy then return Vector() end

	local myMana = NPC.GetMana(myHero)

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return Vector() end
		if not Ability.IsCastable(timberChain, myMana) then return Vector() end

	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	
	local enemyPos = Entity.GetAbsOrigin(enemy)
	if Menu.IsEnabled(FAIO_options.optionHeroTimberPredict) then
		enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
	end

	local remainingDis = chainCastRange - (enemyPos - Entity.GetAbsOrigin(myHero)):Length2D()

	local chainPos = Vector()
	local minDis = 99999

	if FAIO.TimberIsTreeInRangeForChain(myHero, enemy) == nil then
		if next(FAIO.TimberGetEnemyChainTrees(myHero, enemy)) ~= nil then
			for _, targetTree in ipairs(FAIO.TimberGetEnemyChainTrees(myHero, enemy)) do
				if targetTree then
					local vectorTreeToEnemy = enemyPos - Entity.GetAbsOrigin(targetTree)
					local vectorTreeTomyHero = Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(targetTree)
					local searchVec = enemyPos + vectorTreeToEnemy:Normalized():Scaled(chainCastRange)
					local closestPointToSearchVec = FAIO.GetClosestPoint(enemyPos, searchVec, Entity.GetAbsOrigin(myHero), true)
					local disClosestPointToSearchVec = (closestPointToSearchVec - Entity.GetAbsOrigin(myHero)):Length2D()
					if #Trees.InRadius(closestPointToSearchVec, 300, true) < 1 then
						if (closestPointToSearchVec - Entity.GetAbsOrigin(targetTree)):Length2D() < chainCastRange then
							if disClosestPointToSearchVec < minDis then
								chainPos = closestPointToSearchVec
								minDis = disClosestPointToSearchVec
							end
						end
					end
				end
			end
		end
	end
		
	
	if chainPos:__tostring() ~= Vector():__tostring() and minDis < dist then
		return chainPos
	end

	return Vector()

end

function FAIO.TimberPanicIsTreeInChainWay(myHero, pos)

	if not myHero then return false end
	if not pos then return false end

	local myPos = Entity.GetAbsOrigin(myHero)
	local chainDistance = (pos - myPos):Length2D()
	local chainVector = myPos - pos

	local checkNum = tonumber(math.floor(chainDistance/50))
	for i = checkNum, 1, -1 do 
        	chainVector:Normalize()
        	chainVector:Scale(50 * (i))
        	local checkPos = pos + chainVector
		if #Trees.InRadius(checkPos, 50, true) < 1 then
            		return true
		end
	end

	return false

end

function FAIO.TimberGetEscapeChainTrees(myHero)

	if not myHero then return {} end

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return {} end
	
	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	
	local myPos = Entity.GetAbsOrigin(myHero)

	local trees = Trees.InRadius(myPos, chainCastRange, true)
		if next(trees) == nil then return {} end

	local returnTrees = {}
	for _, targetTree in ipairs(trees) do		
		if targetTree then
			local disTreeTomyHero = (Entity.GetAbsOrigin(targetTree) - Entity.GetAbsOrigin(myHero)):Length2D()
			if FAIO.TimberPanicIsTreeInChainWay(myHero, Entity.GetAbsOrigin(targetTree)) == true then
				table.insert(returnTrees, { disTreeTomyHero, targetTree })
			end
		end
	end

	if next(returnTrees) ~= nil then
		table.sort(returnTrees, function(a, b)
        		return a[1] > b[1]
    		end)

		return returnTrees
	end
	return {}

end

function FAIO.TimberGetEscapeChainTreesFountain(myHero)

	if not myHero then return {} end

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return {} end
	
	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	
	local myPos = Entity.GetAbsOrigin(myHero)

	local trees = Trees.InRadius(myPos, chainCastRange, true)
		if next(trees) == nil then return {} end

	local returnTrees = {}
	for _, targetTree in ipairs(trees) do		
		if targetTree then
			local myFountainPos = FAIO_utility_functions.GetMyFountainPos(myHero)
			local disTreeToFountain = (Entity.GetAbsOrigin(targetTree) - myFountainPos):Length2D()
			local dismyHeroToFountain = (myPos - myFountainPos):Length2D()
			if disTreeToFountain < dismyHeroToFountain then
				if FAIO.TimberPanicIsTreeInChainWay(myHero, Entity.GetAbsOrigin(targetTree)) == true then
					table.insert(returnTrees, { disTreeToFountain, targetTree })
				end
			end
		end
	end

	if next(returnTrees) ~= nil then
		table.sort(returnTrees, function(a, b)
        		return a[1] < b[1]
    		end)

		return returnTrees
	end
	return {}

end

function FAIO.TimberGetTreesFastMoveCursor(myHero)

	if not myHero then return {} end

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return {} end
	
	local chainCastRange = Ability.GetCastRange(timberChain) + 45
	
	local myPos = Entity.GetAbsOrigin(myHero)

	local trees = Trees.InRadius(myPos, chainCastRange, true)
		if next(trees) == nil then return {} end

	local returnTrees = {}
	for _, targetTree in ipairs(trees) do		
		if targetTree then
		local cursorPos = Input.GetWorldCursorPos()
		local disTreeToCursor = (Entity.GetAbsOrigin(targetTree) - cursorPos):Length2D()
		local disTreeTomyHero = (Entity.GetAbsOrigin(targetTree) - myPos):Length2D()
		local dismyHeroToCursor = (myPos - cursorPos):Length2D()
			if disTreeToCursor < dismyHeroToCursor then
				if disTreeTomyHero > 500 then
					if FAIO.TimberPanicIsTreeInChainWay(myHero, Entity.GetAbsOrigin(targetTree)) == true then
						table.insert(returnTrees, { disTreeToCursor, targetTree })
					end
				end
			end
		end
	end

	if next(returnTrees) ~= nil then
		table.sort(returnTrees, function(a, b)
        		return a[1] < b[1]
    		end)

		return returnTrees
	end
	return {}

end

function FAIO.TargetIndicator(myHero)

	if not myHero then return end

	local curtime = GameRules.GetGameTime()	

	if Menu.GetValue(FAIO_options.optionLockTargetParticle) < 2 then
		if FAIO.LockedTarget ~= nil then
			if curtime > FAIO.particleNextTime then
				if FAIO.currentParticle > 0 then
					Particle.Destroy(FAIO.currentParticle)
					FAIO.currentParticle = 0
				end
	
				if Menu.GetValue(FAIO_options.optionLockTargetParticle) == 0 then
					local sparkParticle = Particle.Create("particles/items_fx/aegis_resspawn_flash.vpcf")
					FAIO.currentParticle = sparkParticle
			
					Particle.SetControlPoint(sparkParticle, 0, Entity.GetAbsOrigin(FAIO.LockedTarget))
				else
					local bloodParticle = Particle.Create("particles/items2_fx/soul_ring_blood.vpcf")
					FAIO.currentParticle = bloodParticle
					Particle.SetControlPoint(bloodParticle, 0, Entity.GetAbsOrigin(FAIO.LockedTarget))
				end

	      		FAIO.particleNextTime = curtime + 0.35
			end
		end
	else
		if (not FAIO.LockedTarget or FAIO.LockedTarget ~= FAIO.currentParticleTarget) and FAIO.currentParticle > 0 then
			Particle.Destroy(FAIO.currentParticle)			
			FAIO.currentParticle = 0
			FAIO.currentParticleTarget = FAIO.LockedTarget
		else
			if FAIO.currentParticle == 0 and FAIO.LockedTarget then
				local towerParticle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, FAIO.LockedTarget)	
				FAIO.currentParticle = towerParticle
				FAIO.currentParticleTarget = FAIO.LockedTarget			
			end
			if FAIO.currentParticle > 0 then
				Particle.SetControlPoint(FAIO.currentParticle, 2, Entity.GetOrigin(myHero))
				Particle.SetControlPoint(FAIO.currentParticle, 6, Vector(1, 0, 0))
				Particle.SetControlPoint(FAIO.currentParticle, 7, Entity.GetOrigin(FAIO.currentParticleTarget))
			end
		end
	end

end

-- dodgeIT


-- ward awareness


-- item usage functions


function FAIO.IsNPCinDanger(myHero, npc)

	if not myHero then return false end
	if not npc or NPC.IsIllusion(npc) or not Entity.IsAlive(npc) then return false end

	if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end
	if NPC.HasModifier(npc, "modifier_item_lotus_orb_active") then return false end

	if NPC.HasModifier(npc, "modifier_dazzle_shallow_grave") then return false end
	if FAIO.IsHeroInvisible(npc) == true then return false end
	if NPC.HasModifier(npc, "modifier_fountain_aura_buff") then return false end

	if #Entity.GetHeroesInRadius(npc, 1500, Enum.TeamType.TEAM_ENEMY) < 1 then return false end
	if #Entity.GetHeroesInRadius(myHero, 1500, Enum.TeamType.TEAM_ENEMY) < 1 then return false end
	if (Entity.GetAbsOrigin(myHero) - FAIO_utility_functions.GetMyFountainPos(myHero)):Length2D() < 1500 then return end

	if NPC.GetUnitName(npc) == "npc_dota_hero_monkey_king" then
		if NPC.GetAbilityByIndex(npc, 1) ~= nil then
			if Ability.SecondsSinceLastUse(NPC.GetAbilityByIndex(npc, 1)) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbilityByIndex(npc, 1)) < 2 then
				return false
			end
		end
	end

	if NPC.GetUnitName(npc) == "npc_dota_hero_nyx_assassin" then
		if NPC.GetAbility(npc, "nyx_assassin_burrow") ~= nil and Ability.GetLevel(NPC.GetAbility(npc, "nyx_assassin_burrow")) > 0 then
			if Ability.IsInAbilityPhase(NPC.GetAbility(npc, "nyx_assassin_burrow")) then
				return false
			elseif not Ability.IsHidden(NPC.GetAbility(npc, "nyx_assassin_unburrow")) then
				return false
			end
		end
	end

	if NPC.GetUnitName(npc) == "npc_dota_hero_sand_king" then
		if NPC.GetAbility(npc, "sandking_burrowstrike") ~= nil then
			local burrow = NPC.GetAbility(npc, "sandking_burrowstrike")
			if Ability.SecondsSinceLastUse(burrow) > -1 and Ability.SecondsSinceLastUse(burrow) < 1 then
				return false
			end
		end
	end

	if NPC.GetUnitName(npc) == "npc_dota_hero_earth_spirit" then
		if NPC.GetAbility(npc, "earth_spirit_rolling_boulder") ~= nil then
			local boulder = NPC.GetAbility(npc, "earth_spirit_rolling_boulder")
			if Ability.SecondsSinceLastUse(boulder) > -1 and Ability.SecondsSinceLastUse(boulder) < 2 then
				return false
			end
		end
	end
	
	local momSilenced = false
	if NPC.HasItem(npc, "item_mask_of_madness", true) then
		local mom = NPC.GetItem(npc, "item_mask_of_madness", true)
		if Ability.SecondsSinceLastUse(mom) > -1 and Ability.SecondsSinceLastUse(mom) < 8 then
			momSilenced = true
		end
	end

	if NPC.HasModifier(npc, "modifier_nyx_assassin_burrow") then return false end
	if NPC.HasModifier(npc, "modifier_monkey_king_tree_dance_activity") then return false end

	if FAIO.TargetGotDisableModifier(myHero, npc) == true or (NPC.IsSilenced(npc) and not momSilenced) or
		NPC.HasModifier(npc, "modifier_item_nullifier_mute") or NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then

		if Entity.GetHealth(npc) / Entity.GetMaxHealth(npc) <= (Menu.GetValue(FAIO_options.optionDefensiveItemsThresholdDisable) / 100) then
			for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
				if v and Entity.IsHero(v) and not Entity.IsDormant(v) then
					if NPC.FindFacingNPC(v) == npc or NPC.IsEntityInRange(npc, v, NPC.GetAttackRange(v) + 150) then
						return true
					end
				end
			end
		end
	end

	if Entity.GetHealth(npc) <= Menu.GetValue(FAIO_options.optionDefensiveItemsThreshold)/100 * Entity.GetMaxHealth(npc) then
		for _, v in ipairs(Entity.GetHeroesInRadius(npc, 1000, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not Entity.IsDormant(v) then
				if NPC.FindFacingNPC(v) == npc then
					return true
				end
			end
		end
	end

	return false

end

function FAIO.IsHeroInvisible(myHero)

	if not myHero then return false end
	if not Entity.IsAlive(myHero) then return false end

	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return true end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return true end
	if NPC.HasAbility(myHero, "invoker_ghost_walk") then
		if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 1 then 
			return true
		end
	end

	if NPC.HasItem(myHero, "item_invis_sword", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_invis_sword", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_invis_sword", true)) < 1 then 
			return true
		end
	end
	if NPC.HasItem(myHero, "item_silver_edge", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_silver_edge", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_silver_edge", true)) < 1 then 
			return true
		end
	end

	return false
		
end

function FAIO.TargetGotDisableModifier(myHero, npc)

	if not myHero then return false end
	if not npc then return false end

	local stunRootList = {
		"modifier_stunned",
		"modifier_bashed",
		"modifier_alchemist_unstable_concoction", 
		"modifier_ancientapparition_coldfeet_freeze", 
		"modifier_axe_berserkers_call",
		"modifier_bane_fiends_grip",
		"modifier_bane_nightmare",
		"modifier_bloodseeker_rupture",
		"modifier_rattletrap_hookshot", 
		"modifier_earthshaker_fissure_stun", 
		"modifier_earth_spirit_boulder_smash",
		"modifier_enigma_black_hole_pull",
		"modifier_faceless_void_chronosphere_freeze",
		"modifier_jakiro_ice_path_stun", 
		"modifier_keeper_of_the_light_mana_leak_stun", 
		"modifier_kunkka_torrent", 
		"modifier_legion_commander_duel", 
		"modifier_lion_impale", 
		"modifier_magnataur_reverse_polarity", 
		"modifier_medusa_stone_gaze_stone", 
		"modifier_morphling_adaptive_strike", 
		"modifier_naga_siren_ensnare", 
		"modifier_nyx_assassin_impale", 
		"modifier_pudge_dismember", 
		"modifier_sandking_impale", 
		"modifier_shadow_shaman_shackles", 
		"modifier_techies_stasis_trap_stunned", 
		"modifier_tidehunter_ravage", 
		"modifier_treant_natures_guise",
		"modifier_windrunner_shackle_shot",
		"modifier_rooted", 
		"modifier_crystal_maiden_frostbite", 
		"modifier_ember_spirit_searing_chains", 
		"modifier_meepo_earthbind",
		"modifier_lone_druid_spirit_bear_entangle_effect",
		"modifier_slark_pounce_leash",
		"modifier_storm_spirit_electric_vortex_pull",
		"modifier_treant_overgrowth", 
		"modifier_abyssal_underlord_pit_of_malice_ensare", 
		"modifier_item_rod_of_atos_debuff",
			}
	
	local searchMod
	for _, modifier in ipairs(stunRootList) do
		if NPC.HasModifier(npc, modifier) then
			searchMod = NPC.GetModifier(npc, modifier)
			break
		end
	end

	local timeleft = 0
	if searchMod then
		if NPC.HasModifier(npc, Modifier.GetName(searchMod)) then
			if Modifier.GetName(searchMod) == "modifier_enigma_black_hole_pull" then
				timeleft = Modifier.GetCreationTime(searchMod) + 4
			elseif Modifier.GetName(searchMod) == "modifier_faceless_void_chronosphere_freeze" then
				timeleft = Modifier.GetCreationTime(searchMod) + 4.5
			else
				timeleft = Modifier.GetDieTime(searchMod)
			end
		else
			timeleft = 0
		end
	else
		timeleft = 0
	end

	if timeleft > 0.75 then
		return true
	end

	return false

end

function FAIO.heroCanCastSpells(myHero, enemy)

	if not myHero then return false end
	if not Entity.IsAlive(myHero) then return false end

	if NPC.IsSilenced(myHero) then return false end 
	if NPC.IsStunned(myHero) then return false end
	if NPC.HasModifier(myHero, "modifier_bashed") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end	
	if NPC.HasModifier(myHero, "modifier_eul_cyclone") then return false end
	if NPC.HasModifier(myHero, "modifier_obsidian_destroyer_astral_imprisonment_prison") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_demon_disruption") then return false end	
	if NPC.HasModifier(myHero, "modifier_invoker_tornado") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED) then return false end
	if NPC.HasModifier(myHero, "modifier_legion_commander_duel") then return false end
	if NPC.HasModifier(myHero, "modifier_axe_berserkers_call") then return false end
	if NPC.HasModifier(myHero, "modifier_winter_wyvern_winters_curse") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_fiends_grip") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_nightmare") then return false end
	if NPC.HasModifier(myHero, "modifier_faceless_void_chronosphere_freeze") then return false end
	if NPC.HasModifier(myHero, "modifier_enigma_black_hole_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_magnataur_reverse_polarity") then return false end
	if NPC.HasModifier(myHero, "modifier_pudge_dismember") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_shaman_shackles") then return false end
	if NPC.HasModifier(myHero, "modifier_techies_stasis_trap_stunned") then return false end
	if NPC.HasModifier(myHero, "modifier_storm_spirit_electric_vortex_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_tidehunter_ravage") then return false end
	if NPC.HasModifier(myHero, "modifier_windrunner_shackle_shot") then return false end
	if NPC.HasModifier(myHero, "modifier_item_nullifier_mute") then return false end

	if enemy then
		if NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") then return false end
	end

	return true	

end

function FAIO.heroCanCastItems(myHero)

	if not myHero then return false end
	if not Entity.IsAlive(myHero) then return false end

	if NPC.IsStunned(myHero) then return false end
	if NPC.HasModifier(myHero, "modifier_bashed") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end	
	if NPC.HasModifier(myHero, "modifier_eul_cyclone") then return false end
	if NPC.HasModifier(myHero, "modifier_obsidian_destroyer_astral_imprisonment_prison") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_demon_disruption") then return false end	
	if NPC.HasModifier(myHero, "modifier_invoker_tornado") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED) then return false end
	if NPC.HasModifier(myHero, "modifier_legion_commander_duel") then return false end
	if NPC.HasModifier(myHero, "modifier_axe_berserkers_call") then return false end
	if NPC.HasModifier(myHero, "modifier_winter_wyvern_winters_curse") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_fiends_grip") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_nightmare") then return false end
	if NPC.HasModifier(myHero, "modifier_faceless_void_chronosphere_freeze") then return false end
	if NPC.HasModifier(myHero, "modifier_enigma_black_hole_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_magnataur_reverse_polarity") then return false end
	if NPC.HasModifier(myHero, "modifier_pudge_dismember") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_shaman_shackles") then return false end
	if NPC.HasModifier(myHero, "modifier_techies_stasis_trap_stunned") then return false end
	if NPC.HasModifier(myHero, "modifier_storm_spirit_electric_vortex_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_tidehunter_ravage") then return false end
	if NPC.HasModifier(myHero, "modifier_windrunner_shackle_shot") then return false end
	if NPC.HasModifier(myHero, "modifier_item_nullifier_mute") then return false end

	return true	

end

function FAIO.isHeroChannelling(myHero)

	if not myHero then return true end

	if NPC.IsChannellingAbility(myHero) then return true end
	if NPC.HasModifier(myHero, "modifier_teleporting") then return true end

	return false

end

function FAIO.shouldCastBKB(myHero)

	if not myHero then return end

	local dangerousRangeTable = {
		alchemist_unstable_concoction_throw = 775,
		beastmaster_primal_roar = 600,
		centaur_hoof_stomp = 315,
		chaos_knight_chaos_bolt = 500,
		crystal_maiden_frostbite = 525,
		dragon_knight_dragon_tail = 400,
		drow_ranger_wave_of_silence = 900,
		earth_spirit_boulder_smash = 300,
		earthshaker_fissure = 1400,
		ember_spirit_searing_chains = 400,
		invoker_tornado = 1000,
		jakiro_ice_path = 1200,
		lion_impale = 500,
		lion_voodoo = 500,
		naga_siren_ensnare = 650,
		nyx_assassin_impale = 700,
		puck_dream_coil = 750,
		rubick_telekinesis = 625,
		sandking_burrowstrike = 650,
		shadow_shaman_shackles = 400,
		shadow_shaman_voodoo = 500,
		skeleton_king_hellfire_blast = 525,
		slardar_slithereen_crush = 400,
		storm_spirit_electric_vortex = 400,
		sven_storm_bolt = 600,
		tidehunter_ravage = 1025,
		tiny_avalanche = 600,
		vengefulspirit_magic_missile = 500,
		warlock_rain_of_chaos = 1200,
		windrunner_shackleshot = 800,
		slark_pounce = 700,
		ogre_magi_fireblast = 475,
		meepo_poof = 400
			}

	local enemyTable = {}
	local enemiesAround = Entity.GetHeroesInRadius(myHero, Menu.GetValue(FAIO_options.optionDefensiveItemsBKBRadius), Enum.TeamType.TEAM_ENEMY)
		for _, enemy in ipairs(enemiesAround) do
			if enemy then
				if not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) and not NPC.IsStunned(enemy) and not NPC.IsSilenced(enemy) then
					table.insert(enemyTable, enemy)
				end
			end
		end

	if next(enemyTable) == nil then return false end

	local tempTable = {}
	for i = 1, #FAIO_data.preemptiveBKBtable do
		if Menu.IsEnabled(FAIO.preemptiveBKB[i]) then
			table.insert(tempTable, FAIO_data.preemptiveBKBtable[i])
		end
	end

	if next(tempTable) == nil then return false end

	local searchAbility
	for _, enemy in ipairs(enemyTable) do
		for _, ability in ipairs(tempTable) do
			if NPC.HasAbility(enemy, ability) then
				if NPC.GetAbility(enemy, ability) ~= nil and Ability.IsReady(NPC.GetAbility(enemy, ability)) then
					if Ability.GetLevel(NPC.GetAbility(enemy, ability)) > 0 and Ability.GetCooldownTimeLeft(NPC.GetAbility(enemy, ability)) < 1 and not Ability.IsHidden(NPC.GetAbility(enemy, ability)) then
						if dangerousRangeTable[ability] > (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() then
							searchAbility = ability
							break
						end
					end
				end
			end
		end
	end

	if searchAbility ~= nil and #enemyTable >= Menu.GetValue(FAIO_options.optionDefensiveItemsBKBEnemies) then
		return true
	end

	return false

end

function FAIO.shouldCastSatanic(myHero, enemy)

	if not myHero then return end
	if not enemy then return false end
	if Entity.GetHealth(myHero) > Entity.GetMaxHealth(myHero) * 0.3 then return false end

	if enemy then
		if NPC.IsAttacking(myHero) and Entity.GetHealth(enemy) >= Entity.GetMaxHealth(enemy) * 0.25 then
			return true
		end
	end

	return false

end

-- hero functions





function FAIO.PugnaCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroPugna) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)
	local E = NPC.GetAbilityByIndex(myHero, 2)
	local ult = NPC.GetAbility(myHero, "pugna_life_drain")
		if ult and Ability.SecondsSinceLastUse(ult) > -1 and Ability.SecondsSinceLastUse(ult) < 0.15 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING)) then
			return
		end

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 700) then
				if Menu.IsEnabled(FAIO_options.optionHeroPugnaBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroPugnaBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroPugnaBlinkRange))))
					return
				end
			end

			if os.clock() > FAIO.lastTick and not NPC.IsChannellingAbility(myHero) then

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					Ability.CastTarget(W, enemy)
					FAIO.lastTick = os.clock() + 0.2
					return
				end
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q) + 300) then
					local pred = 1.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local predPos = FAIO_utility_functions.castPrediction(myHero, enemy, pred)
					if not NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(Q), 0) then
						local myPos = Entity.GetAbsOrigin(myHero)
						local dist = (myPos - predPos):Length2D()
						local saveCastPos = predPos
						for k = 1, math.floor(dist/25) do
							local searchPos = predPos + (myPos - predPos):Normalized():Scaled(k*25)
							if NPC.IsPositionInRange(myHero, searchPos, Ability.GetCastRange(Q), 0) then
								saveCastPos = searchPos
								break
							end
						end
						if NPC.IsPositionInRange(myHero, saveCastPos, Ability.GetCastRange(Q), 0) then	
							Ability.CastPosition(Q, saveCastPos)
							FAIO.lastTick = os.clock() + 0.2
							return
						end
					else
						Ability.CastPosition(Q, predPos)
						FAIO.lastTick = os.clock() + 0.2
						return
					end

				end

				if Menu.IsEnabled(FAIO_options.optionHeroPugnaWard) then
					if #Entity.GetHeroesInRadius(myHero, 1200, Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroPugnaWardCount) then
						if E and Ability.IsCastable(E, myMana) and NPC.IsEntityInRange(myHero, enemy, 700) then
							Ability.CastPosition(E, Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(100))
							FAIO.lastTick = os.clock() + 0.2
							return
						end
					end
				end

				if Menu.IsEnabled(FAIO_options.optionHeroPugnaInvis) then
					local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)
					local blade = NPC.GetItem(myHero, "item_invis_sword", true)
					local silver = NPC.GetItem(myHero, "item_silver_edge", true)
					if ult and Ability.IsCastable(ult, myMana - 90) and not FAIO.IsHeroInvisible(myHero) then
						if glimmer and Ability.IsCastable(glimmer, myMana) then
							Ability.CastTarget(glimmer, myHero)
							return
						end

						if blade and Ability.IsCastable(blade, myMana) then
							Ability.CastNoTarget(blade)
							return
						end

						if silver and Ability.IsCastable(silver, myMana) then
							Ability.CastNoTarget(silver)
							return
						end
					end
				end

				if ult and Ability.IsCastable(ult, myMana) then
					local castRangeAdjustment = Ability.GetCastRange(ult)
					local dagon = NPC.GetItem(myHero, "item_dagon", true)
						if not dagon then
							for i = 2, 5 do
								dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
								if dagon then 
									break 
								end
							end
						end

						if dagon then
							if Ability.GetCastRange(dagon) < Ability.GetCastRange(ult) then
								castRangeAdjustment = Ability.GetCastRange(dagon)
							end
						end

					if not Ability.IsChannelling(ult) then
						if NPC.IsEntityInRange(myHero, enemy, castRangeAdjustment) then
							Ability.CastTarget(ult, enemy)
							FAIO.lastTick = os.clock() + 0.2
							return
						else
							if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then
								FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
								return
							end
						end	
					end
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.NSCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroNS) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 500) then
				if Menu.IsEnabled(FAIO_options.optionHeroNSBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q)) then
					Ability.CastTarget(Q, enemy)
					FAIO.lastTick = os.clock() + 0.3
					return
				end

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					Ability.CastTarget(W, enemy)
					FAIO.lastTick = os.clock() + 0.3
					return
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.UndyingCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroUndying) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)
	local ult = NPC.GetAbility(myHero, "undying_flesh_golem")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroUndyingSoulKS) then
		FAIO.UndyingSoulKS(myHero, myMana, W)
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 500) then
				if Menu.IsEnabled(FAIO_options.optionHeroUndyingBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q)) then
					local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 620, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 310)
					if bestPos ~= nil then
						Ability.CastPosition(Q, bestPos)
						FAIO.lastTick = os.clock() + 0.45
						return
					end
				end

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					local saving = false
					local savingUnit = nil
						if Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) < Menu.GetValue(FAIO_options.optionHeroUndyingSoulTreshold) / 100 then
							saving = true
							savingUnit = myHero
						elseif #Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(W), Enum.TeamType.TEAM_FRIEND) > 0 then
							for _, ally in ipairs(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(W), Enum.TeamType.TEAM_FRIEND)) do
								if ally and Entity.IsAlive(ally) and not NPC.IsIllusion(ally) then
									if Entity.GetHealth(ally) / Entity.GetMaxHealth(ally) < Menu.GetValue(FAIO_options.optionHeroUndyingSoulTreshold) / 100 then
										saving = true
										savingUnit = ally
									end
								end
							end
						end

					if not saving then
						if #Entity.GetUnitsInRadius(myHero, 1290, Enum.TeamType.TEAM_BOTH) >= Menu.GetValue(FAIO_options.optionHeroUndyingSoulCount) then
							Ability.CastTarget(W, enemy)
							FAIO.lastTick = os.clock() + 0.45
							return
						end
					else
						if savingUnit ~= nil then
							Ability.CastTarget(W, savingUnit)
							FAIO.lastTick = os.clock() + 0.45
							return
						end
					end	
				end
				
				if Menu.IsEnabled(FAIO_options.optionHeroUndyingUlt) then
					if #Entity.GetHeroesInRadius(myHero, 700, Enum.TeamType.TEAM_BOTH) >= Menu.GetValue(FAIO_options.optionHeroUndyingUltCount) then
						if ult and Ability.IsCastable(ult, myMana) and NPC.IsEntityInRange(myHero, enemy, 700) then
							Ability.CastNoTarget(ult)
							FAIO.lastTick = os.clock() + 0.15
							return
						end
					end
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

	if Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) < Menu.GetValue(FAIO_options.optionHeroUndyingSoulTreshold) / 100 then
		if W and Ability.IsCastable(W, myMana) then
			Ability.CastTarget(W, myHero)
			FAIO.lastTick = os.clock() + 0.45
			return
		end
	end

	if #Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(W), Enum.TeamType.TEAM_FRIEND) > 0 then
		for _, ally in ipairs(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(W), Enum.TeamType.TEAM_FRIEND)) do
			if ally and Entity.IsAlive(ally) and not NPC.IsIllusion(ally) then
				if Entity.GetHealth(ally) / Entity.GetMaxHealth(ally) < Menu.GetValue(FAIO_options.optionHeroUndyingSoulTreshold) / 100 then
					Ability.CastTarget(W, ally)
					FAIO.lastTick = os.clock() + 0.45
					return
				end
			end
		end
	end

	return

end

function FAIO.UndyingSoulKS(myHero, myMana, soulrip)

	if not myHero then return end
	if not soulrip then return end
		if not Ability.IsReady(soulrip) then return end
		if not Ability.IsCastable(soulrip, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local damagePerUnit = Ability.GetLevelSpecialValueFor(soulrip, "damage_per_unit")
	local maxUnits = Ability.GetLevelSpecialValueFor(soulrip, "max_units")
	local radius = Ability.GetLevelSpecialValueFor(soulrip, "radius")

	local unitsAround = 0
		for _, v in ipairs(Entity.GetUnitsInRadius(myHero, radius - 25, Enum.TeamType.TEAM_BOTH)) do
			if v and Entity.IsNPC(v) and Entity.IsAlive(v) then
				if Entity.IsSameTeam(myHero, v) then
					unitsAround = unitsAround + 1
				else
					if not NPC.HasState(v, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
						unitsAround = unitsAround + 1
					end
				end
			end
		end

	local adjustedUnitsAround = math.min(unitsAround, maxUnits)

	local damage = adjustedUnitsAround * damagePerUnit

	for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(soulrip), Enum.TeamType.TEAM_ENEMY)) do
		if targets then
			local target = FAIO.targetChecker(targets)
			if target then
				if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") then
					local targetHP = Entity.GetHealth(target) + NPC.GetHealthRegen(target)
					local soulripTrueDamage = (1 - NPC.GetMagicalArmorValue(target)) * (damage + damage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
					if targetHP < soulripTrueDamage then
						Ability.CastTarget(soulrip, target)
						break
						return
					end
				end
			end
		end
	end

	return

end

function FAIO.CKCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroCK) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)
	local ult = NPC.GetAbility(myHero, "chaos_knight_phantasm")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 500) then
				if Menu.IsEnabled(FAIO_options.optionHeroCKBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q)) then
					Ability.CastTarget(Q, enemy)
					FAIO.lastTick = os.clock() + 0.4
					return
				end

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					Ability.CastTarget(W, enemy)
					FAIO.lastTick = os.clock() + 0.3
					return
				end

				if Menu.IsEnabled(FAIO_options.optionHeroCKUlt) then
					if ult and Ability.IsCastable(ult, myMana) and NPC.IsEntityInRange(myHero, enemy, Menu.GetValue(FAIO_options.optionHeroCKUltTrigger)) then
						Ability.CastNoTarget(ult)
						FAIO.lastTick = os.clock() + 0.4
						return
					end
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		FAIO.GenericControllableAttackIssuer("ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.NyxCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroNyx) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true and not NPC.HasModifier(myHero, "modifier_nyx_assassin_vendetta") then
			if not NPC.IsEntityInRange(myHero, enemy, 500) then
				if Menu.IsEnabled(FAIO_options.optionHeroNyxBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q) - 50) then
					local pred = 0.4 + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1600) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local predPos = FAIO_utility_functions.castLinearPrediction(myHero, enemy, pred)
					local predPosAdjusted = Entity.GetAbsOrigin(myHero) + (predPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(200)
					Ability.CastPosition(Q, predPosAdjusted)
					FAIO.lastTick = os.clock() + 0.4
					return
				end

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					Ability.CastTarget(W, enemy)
					FAIO.lastTick = os.clock() + 0.4
					return
				end
			end
		end

		if not NPC.HasModifier(myHero, "modifier_nyx_assassin_burrow") then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			return
		end
	end

end

function FAIO.LionCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroLion) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local W = NPC.GetAbilityByIndex(myHero, 1)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 800) then
				if Menu.IsEnabled(FAIO_options.optionHeroLionBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroLionBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroLionBlinkRange))))
					FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			end	

			if os.clock() > FAIO.lastTick then

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) and not NPC.IsStunned(enemy) then
					local specialBonus = NPC.GetAbility(myHero, "special_bonus_unique_lion_4")
					local specialCheck = false
						if specialBonus and Ability.GetLevel(specialBonus) > 0 then
							specialCheck = true
						end
					if not specialCheck then
						Ability.CastTarget(W, enemy)
						FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
						return
					else
						local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 620, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 310)
						if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, Ability.GetCastRange(W), 0) then
							Ability.CastPosition(W, bestPos)
							FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
							return
						end
					end
				end
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q) - 50) then
					local pred = 0.3 + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1600) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					local predPos = FAIO_utility_functions.castLinearPrediction(myHero, enemy, pred)
					local predPosAdjusted = Entity.GetAbsOrigin(myHero) + (predPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(200)

					local hexMod = NPC.GetModifier(enemy, "modifier_lion_voodoo")
					local dieTime = 0
						if hexMod then
							dieTime = Modifier.GetDieTime(hexMod)
						end

					if dieTime > 0 then
						local timingOffset = ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() - 125) / 1600
						if dieTime - GameRules.GetGameTime() <= 0.35 + timingOffset then
							Ability.CastPosition(Q, predPosAdjusted)
							FAIO.lastTick = os.clock() + 0.3
							return
						end
					else
						Ability.CastPosition(Q, predPosAdjusted)
						FAIO.lastTick = os.clock() + 0.3
						return
					end
				end	
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.WDCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroWD) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local E = NPC.GetAbilityByIndex(myHero, 2)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 999) then
				if Menu.IsEnabled(FAIO_options.optionHeroWDBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroWDBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroWDBlinkRange))))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q)) then
					Ability.CastTarget(Q, enemy)
					FAIO.lastTick = os.clock() + 0.35
					return
				end

				if E and Ability.IsCastable(E, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(E)) then
					local pred = 0.4 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(E, FAIO_utility_functions.castPrediction(myHero, enemy, pred))
					FAIO.lastTick = os.clock() + 0.35
					return
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.SSCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSS) then return end
	if not  NPC.IsEntityInRange(myHero, enemy, 3000) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
	local W = NPC.GetAbilityByIndex(myHero, 1)
 	local E = NPC.GetAbilityByIndex(myHero, 2)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
 		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 999) then
				if Menu.IsEnabled(FAIO_options.optionHeroSSBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroSSBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroSSBlinkRange))))
					return
				end
			end	

			if os.clock() > FAIO.lastTick then

				if W and Ability.IsCastable(W, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(W)) then
					Ability.CastTarget(W, enemy)
					FAIO.lastTick = os.clock() + 0.05
					return
				end
		
				if Q and Ability.IsCastable(Q, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Q)) then
					Ability.CastTarget(Q, enemy)
					FAIO.lastTick = os.clock() + 0.3
					return
				end

				if E and Ability.IsCastable(E, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(E)) then
					local hexMod = NPC.GetModifier(enemy, "modifier_shadow_shaman_voodoo")
					local dieTime = 0
						if hexMod then
							dieTime = Modifier.GetDieTime(hexMod)
						end
					if dieTime > 0 then
						if dieTime - GameRules.GetGameTime() <= 0.45 then
							Ability.CastTarget(E, enemy)
							FAIO.lastTick = os.clock() + 0.3
							return
						end
					else
						Ability.CastTarget(E, enemy)
						FAIO.lastTick = os.clock() + 0.3
						return
					end
				end
			end
		end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

end

function FAIO.clockwerkCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroClock) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end
	
	local BatteryAssault = NPC.GetAbilityByIndex(myHero, 0)
	local PowerCogs = NPC.GetAbilityByIndex(myHero, 1)
	local RocketFlair = NPC.GetAbilityByIndex(myHero, 2)
	local HookShot = NPC.GetAbility(myHero, "rattletrap_hookshot")

	local Blademail = NPC.GetItem(myHero, "item_blade_mail", true)
	local myMana = NPC.GetMana(myHero)
	
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local cogsTargeter
	if NPC.IsRunning(enemy) then
		cogsTargeter = 100
	else
		cogsTargeter = 200
	end

	if FAIO.clockwerkHookshotChecker(myHero, myMana, enemy, HookShot) == true then
		FAIO.clockwerkHookUpValue = true
	else
		FAIO.clockwerkHookUpValue = false
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, cogsTargeter) then
			if HookShot and Ability.IsCastable(HookShot, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(HookShot)) and FAIO.clockwerkHookUpValue == true then
				local hookshotPrediction = Ability.GetCastPoint(HookShot) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / Ability.GetLevelSpecialValueFor(HookShot, "speed")) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(HookShot, FAIO_utility_functions.castLinearPrediction(myHero, enemy, hookshotPrediction))
				FAIO.lastTick = os.clock()
				return
			end
		else
			if PowerCogs and Ability.IsCastable(PowerCogs, myMana) then 
				Ability.CastNoTarget(PowerCogs)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.2) and BatteryAssault and Ability.IsCastable(BatteryAssault, myMana) then 
				Ability.CastNoTarget(BatteryAssault)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.3) and Blademail and Ability.IsCastable(Blademail, myMana) then 
				Ability.CastNoTarget(Blademail)
				return
			end			
			if FAIO.SleepReady(0.3) and RocketFlair and Ability.IsCastable(RocketFlair, myMana) then 
				Ability.CastPosition(RocketFlair, Entity.GetAbsOrigin(enemy))
				return 
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
end

function FAIO.clockwerkHookshotChecker(myHero, myMana, enemy, HookShot)

	if not myHero then return false end
	if not enemy then return false end

	if not HookShot then return false end
		if not Ability.IsReady(HookShot) or not Ability.IsCastable(HookShot, myMana) then return false end

	local latchRadius = 135
	local distance = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() - 125
		if distance < 75 then return false end
		if distance + 150 > Ability.GetCastRange(HookShot) then return false end

	if #Entity.GetUnitsInRadius(myHero, 125, Enum.TeamType.TEAM_BOTH) > 0 then return false end

	for i = 2, math.floor(distance / latchRadius) do
		local checkVec = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized()
		local checkPos = Entity.GetAbsOrigin(myHero) + checkVec:Scaled(i*latchRadius)
		if #NPCs.InRadius(checkPos, latchRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH) > 0 then
			return false
		end
	end

	return true
			
end

function FAIO.clockwerkDrawHookIndicator(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroClockDrawIndicator) then return end
	
	if FAIO.clockwerkHookUpValue == false then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	if visible then
		Renderer.SetDrawColor(50,205,50,255)
		Renderer.DrawText(FAIO.font, x-40, y-80, "hookable", 0)
	end
		
end

function FAIO.huskarCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroHuskar) then return end

	local burningspear = NPC.GetAbilityByIndex(myHero, 1)
	local innerVitality = NPC.GetAbilityByIndex(myHero, 0)
	local lifeBreak = NPC.GetAbility(myHero, "huskar_life_break")

	local myMana = NPC.GetMana(myHero)

	local Blademail = NPC.GetItem(myHero, "item_blade_mail", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local attackRange = NPC.GetAttackRange(myHero)
	local lifeBreakRange = Ability.GetCastRange(lifeBreak)

	if enemy and Menu.IsKeyDown(FAIO_options.optionHeroHuskarHarassKey) then
		if burningspear and Ability.GetLevel(burningspear) > 0 then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			Engine.ExecuteCommand("dota_range_display " .. attackRange)
		end
	else
		Engine.ExecuteCommand("dota_range_display 0")
	end

	if enemy and Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, lifeBreakRange) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1650) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(500)))
					return
				end
			end
		else
			if innerVitality and Ability.IsCastable(innerVitality, myMana) then
				if Menu.GetValue(FAIO_options.optionHeroHuskarInnerVit) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroHuskarInnerVit) < 2 then
						Ability.CastTarget(innerVitality, myHero)
						FAIO.lastTick = os.clock()
						return 
					else
						if Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * (Menu.GetValue(FAIO_options.optionHeroHuskarHPThreshold) / 100) then
							Ability.CastTarget(innerVitality, myHero)
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end 
			if FAIO.SleepReady(0.2) and lifeBreak and Ability.IsCastable(lifeBreak, myMana) and Menu.IsEnabled(FAIO_options.optionHeroHuskarUlt) then 
				Ability.CastTarget(lifeBreak, enemy)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.2) and Blademail and Ability.IsCastable(Blademail, myMana) then 
				Ability.CastNoTarget(Blademail)
				return
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

	if Menu.IsEnabled(FAIO_options.optionHeroHuskarAutoVit) then
		FAIO.huskarAutoBerserkersBlood(myHero, myMana, innerVitality)
	end

end

function FAIO.huskarAutoBerserkersBlood(myHero, myMana, innerVitality)

	if not myHero then return end
	if not innerVitality then return end
		if not Ability.IsCastable(innerVitality, myMana) then return end

	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local myHealth = Entity.GetHealth(myHero)

	if myHealth <= Entity.GetMaxHealth(myHero) * (Menu.GetValue(FAIO_options.optionHeroHuskarHPThreshold) / 100) then
		Ability.CastTarget(innerVitality, myHero)
		return
	end

	if Menu.IsEnabled(FAIO_options.optionHeroHuskarAutoVitAlly) then
		local teamMatesAround = NPC.GetHeroesInRadius(myHero, 790, Enum.TeamType.TEAM_FRIEND)
		if next(teamMatesAround) ~= nil then
			for _, ally in ipairs(teamMatesAround) do
				if ally and Entity.IsHero(ally) and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
					if FAIO.IsNPCinDanger(myHero, ally) then
						Ability.CastTarget(innerVitality, ally)
						break
						return
					end
				end
			end
		end
	end

end

function FAIO.skywrathCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSky) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local arcaneBolt = NPC.GetAbilityByIndex(myHero, 0)
    	local concussiveShot = NPC.GetAbilityByIndex(myHero, 1)
    	local ancientSeal = NPC.GetAbilityByIndex(myHero, 2)
    	local mysticFlare = NPC.GetAbility(myHero, "skywrath_mage_mystic_flare")
	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	
	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.skywrathComboTotalDamage(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot, mysticFlare)
	FAIO.skywrathComboKillableWithoutUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot)

	if Menu.IsKeyDown(FAIO_options.optionHeroSkyHarassKey) then
		FAIO.skywrathComboHarass(myHero, myMana, arcaneBolt)
		Engine.ExecuteCommand("dota_range_display 875")
	else
		Engine.ExecuteCommand("dota_range_display 0")
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 999) then
				if Menu.IsEnabled(FAIO_options.optionHeroSkyBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroSkyBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroSkyBlinkRange))))
					return
				end
			end

			if Menu.GetValue(FAIO_options.optionHeroSkyStyle) < 1 then
				FAIO.skywrathComboWithUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot, mysticFlare)
			else
				if FAIO.skywrathComboSelect == true then
					FAIO.skywrathComboWithoutUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot)
				else
					FAIO.skywrathComboWithUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot, mysticFlare)
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

end

function FAIO.skywrathComboWithoutUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot)

	if not myHero then return end
	if not enemy then return end

	if concussiveShot and Ability.IsCastable(concussiveShot, myMana) and NPC.IsEntityInRange(myHero, enemy, 1550) then
		Ability.CastNoTarget(concussiveShot)
		FAIO.lastTick = os.clock()
		return
	end

	if FAIO.SleepReady(0.15) and arcaneBolt and Ability.IsCastable(arcaneBolt, myMana) and NPC.IsEntityInRange(myHero, enemy, 850) then
		Ability.CastTarget(arcaneBolt, enemy)
		FAIO.lastTick = os.clock()
		return
	end

	if FAIO.SleepReady(0.15) and ancientSeal and Ability.IsCastable(ancientSeal, myMana) and NPC.IsEntityInRange(myHero, enemy, 685) then
		Ability.CastTarget(ancientSeal, enemy)
		FAIO.lastTick = os.clock()
		return
	end

end

function FAIO.skywrathComboWithUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot, mysticFlare)

	if not myHero then return end
	if not enemy then return end

	local aghanimsBuffed = false
		if NPC.HasItem(myHero, "item_ultimate_scepter", true) or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
			aghanimsBuffed = true
		end

	if concussiveShot and Ability.IsCastable(concussiveShot, myMana) and NPC.IsEntityInRange(myHero, enemy, 1550) then
		Ability.CastNoTarget(concussiveShot)
		FAIO.lastTick = os.clock()
		return
	end

	if FAIO.SleepReady(0.15) and arcaneBolt and Ability.IsCastable(arcaneBolt, myMana) and NPC.IsEntityInRange(myHero, enemy, 850) then
		Ability.CastTarget(arcaneBolt, enemy)
		FAIO.lastTick = os.clock()
		return
	end

	if FAIO.SleepReady(0.15) and ancientSeal and Ability.IsCastable(ancientSeal, myMana) and NPC.IsEntityInRange(myHero, enemy, 685) then
		Ability.CastTarget(ancientSeal, enemy)
		FAIO.lastTick = os.clock()
		return
	end

	if FAIO.SleepReady(0.15) and mysticFlare and Ability.IsCastable(mysticFlare, myMana) then
		if FAIO.TargetDisableTimer(myHero, enemy) > 1.5 then
			if not aghanimsBuffed then
				Ability.CastPosition(mysticFlare, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(95))
				return
			else
				Ability.CastPosition(mysticFlare, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(175))
				return
			end
		elseif NPC.HasItem(myHero, "item_rod_of_atos", true) then
			if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_rod_of_atos", true)) > ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1500) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_rod_of_atos", true)) < (((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1500) + 2) then
				if not aghanimsBuffed then
					Ability.CastPosition(mysticFlare, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(95))
					return
				else
					Ability.CastPosition(mysticFlare, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(175))
					return
				end
			end
		elseif NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			if not aghanimsBuffed then
				local flarePrediction = Ability.GetCastPoint(mysticFlare) + 0.2 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(mysticFlare, FAIO_utility_functions.castPrediction(myHero, enemy, flarePrediction))
			else
				Ability.CastPosition(mysticFlare, FAIO.skywrathComboPredictDoubleUltWhileHexed(myHero, enemy))
				return
			end
		else
			if not aghanimsBuffed then
				local flarePrediction = Ability.GetCastPoint(mysticFlare) + 0.2 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(mysticFlare, FAIO_utility_functions.castPrediction(myHero, enemy, flarePrediction))
			else
				Ability.CastPosition(mysticFlare, FAIO.skywrathComboPredictDoubleUltWhileHexed(myHero, enemy))
				return
			end
		end
	end

end

function FAIO.skywrathComboKillableWithoutUlt(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot)

	if not myHero then return end
	if not enemy then return end

	if Ability.SecondsSinceLastUse(ancientSeal) > -1 and Ability.SecondsSinceLastUse(ancientSeal) < Ability.GetCooldownLength(arcaneBolt) + 0.5 then return end
	if Ability.SecondsSinceLastUse(concussiveShot) > -1 and Ability.SecondsSinceLastUse(concussiveShot) < Ability.GetCooldownLength(arcaneBolt) + 0.5 then return end
	if Ability.SecondsSinceLastUse(arcaneBolt) > -1 and Ability.SecondsSinceLastUse(arcaneBolt) < Ability.GetCooldownLength(arcaneBolt) + 0.5 then return end

	local totalDamage = 0
	local veilAmp = 0
	local silenceAmp = 0
	local ebladeAmp = 0
	local reqMana = 0

	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if veil and Ability.IsCastable(veil, myMana) then
		veilAmp = 0.25
		reqMana = reqMana + Ability.GetManaCost(veil)
	end	

	if ancientSeal and Ability.IsCastable(ancientSeal, myMana) then
		silenceAmp = (Ability.GetLevel(ancientSeal) * 5 + 30) / 100
		reqMana = reqMana + Ability.GetManaCost(ancientSeal)
	end

	if eBlade and Ability.IsCastable(eBlade, myMana) then
		local ebladedamage = Hero.GetIntellectTotal(myHero) * 2 + 75
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (ebladedamage + ebladedamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		ebladeAmp = 0.4
		reqMana = reqMana + Ability.GetManaCost(eBlade)
	end	

	if dagon and Ability.IsCastable(dagon, Ability.GetManaCost(dagon)) then
		local dagondmg = Ability.GetLevelSpecialValueFor(dagon, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (dagondmg + dagondmg * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqMana = reqMana + Ability.GetManaCost(dagon)
	end
                
	if arcaneBolt and Ability.IsCastable(arcaneBolt, myMana) then
		local boltdamage = Ability.GetLevelSpecialValueFor(arcaneBolt, "bolt_damage") + Hero.GetIntellectTotal(myHero) * 1.6
		if Ability.GetLevel(arcaneBolt) < 3 then
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (boltdamage + boltdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
			reqMana = reqMana + Ability.GetManaCost(arcaneBolt)                    
		else
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (boltdamage + boltdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100)) * 2
			reqMana = reqMana + Ability.GetManaCost(arcaneBolt) * 2
		end
	end

	if concussiveShot and Ability.IsCastable(concussiveShot, myMana) then
		local slowdamage = Ability.GetLevelSpecialValueFor(concussiveShot, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (slowdamage + slowdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqMana = reqMana + Ability.GetManaCost(concussiveShot)
	end

	if reqMana < NPC.GetMana(myHero) and Entity.GetHealth(enemy) < totalDamage and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		FAIO.skywrathComboSelect = true
	else		
		FAIO.skywrathComboSelect = false
	end

end

function FAIO.skywrathComboTotalDamage(myHero, myMana, enemy, ancientSeal, arcaneBolt, concussiveShot, mysticFlare)

	if not myHero then return end
	if not enemy then return end
	if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end 

	local totalDamage = 0
	local totalDamageUlt = 0
	local veilAmp = 0
	local silenceAmp = 0
	local ebladeAmp = 0
	local reqMana = 0
	local reqManaUlt = 0

	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if veil and Ability.IsCastable(veil, myMana) then
		veilAmp = 0.25
		reqMana = reqMana + Ability.GetManaCost(veil)
	end	

	if ancientSeal and Ability.IsCastable(ancientSeal, myMana) then
		silenceAmp = (Ability.GetLevel(ancientSeal) * 5 + 30) / 100
		reqMana = reqMana + Ability.GetManaCost(ancientSeal)
	end

	if eBlade and Ability.IsCastable(eBlade, myMana) then
		local ebladedamage = Hero.GetIntellectTotal(myHero) * 2 + 75
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (ebladedamage + ebladedamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		ebladeAmp = 0.4
		reqMana = reqMana + Ability.GetManaCost(eBlade)
	end	

	if dagon and Ability.IsCastable(dagon, Ability.GetManaCost(dagon)) then
		local dagondmg = Ability.GetLevelSpecialValueFor(dagon, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (dagondmg + dagondmg * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqMana = reqMana + Ability.GetManaCost(dagon)
	end
                
	if arcaneBolt and Ability.IsCastable(arcaneBolt, myMana) then
		local boltdamage = Ability.GetLevelSpecialValueFor(arcaneBolt, "bolt_damage") + Hero.GetIntellectTotal(myHero) * 1.6
		if Ability.GetLevel(arcaneBolt) < 3 then
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (boltdamage + boltdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
			reqMana = reqMana + Ability.GetManaCost(arcaneBolt)                    
		else
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (boltdamage + boltdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100)) * 2
			reqMana = reqMana + Ability.GetManaCost(arcaneBolt) * 2
		end
	end

	if concussiveShot and Ability.IsCastable(concussiveShot, myMana) then
		local slowdamage = Ability.GetLevelSpecialValueFor(concussiveShot, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (slowdamage + slowdamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqMana = reqMana + Ability.GetManaCost(concussiveShot)
	end

	if mysticFlare and Ability.IsCastable(mysticFlare, myMana) then
		local mysticDamage
		if atos and Ability.IsCastable(atos, myMana) then
			mysticDamage = Ability.GetLevelSpecialValueFor(mysticFlare, "damage") * 2 / 2.4
		end
		if not atos or (atos and not Ability.IsCastable(atos, myMana)) then
			mysticDamage = Ability.GetLevelSpecialValueFor(mysticFlare, "damage") * 1 / 2.4
		end
		totalDamageUlt = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (mysticDamage + mysticDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqManaUlt = reqMana + Ability.GetManaCost(mysticFlare)
	else
		totalDamageUlt = totalDamage
	end

	if reqManaUlt > NPC.GetMana(myHero) and reqMana < NPC.GetMana(myHero) then
		totalDamageUlt = totalDamage
	end

	if reqMana < NPC.GetMana(myHero) then
		FAIO.skywrathDMGwithoutUlt = totalDamage
		FAIO.skywrathDMGwithUlt = totalDamageUlt
	end

end

function FAIO.skywrathComboDrawDamage(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroSkyDrawDMG) then return end
	
	if FAIO.skywrathDMGwithoutUlt == 0 then return end
	if FAIO.skywrathDMGwithUlt == 0 then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	if FAIO.skywrathDMGwithoutUlt > 0 and FAIO.skywrathDMGwithUlt > 0 then
		if visible then
			if Entity.GetHealth(enemy) > FAIO.skywrathDMGwithoutUlt then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
				Renderer.DrawText(FAIO.skywrathFont, x-50, y-90, "DMG w/o Ult: " .. math.floor(FAIO.skywrathDMGwithoutUlt), 0)
			if Entity.GetHealth(enemy) > FAIO.skywrathDMGwithUlt then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
				Renderer.DrawText(FAIO.skywrathFont, x-50, y-75, "DMG w/ Ult: " .. math.floor(FAIO.skywrathDMGwithUlt), 0)
		end
	end		

end

function FAIO.skywrathComboHarass(myHero, myMana, arcaneBolt)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroSkyHarass) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not arcaneBolt then return end
		if not Ability.IsCastable(arcaneBolt, myMana) then return end

	for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, 875, Enum.TeamType.TEAM_ENEMY)) do
		if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then 
			if Entity.IsAlive(hero) then
        			Ability.CastTarget(arcaneBolt, hero)
				break
        			return
			end
      		end		
	end	

end

function FAIO.skywrathComboPredictDoubleUltWhileHexed(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local enemyRotation = Entity.GetRotation(enemy)
    	local enemyOrigin = NPC.GetAbsOrigin(enemy)
		enemyOrigin:SetZ(0)

	if enemyRotation and enemyOrigin then
			if not NPC.IsRunning(enemy) then
				return enemyOrigin + enemyRotation:GetForward():Normalized():Scaled(175)
			else return enemyOrigin:__add(enemyRotation:GetForward():Normalized():Scaled(FAIO_utility_functions.GetMoveSpeed(enemy) * (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING) + 0.15) + 175))
			end
	end
end

function FAIO.magnusCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroMagnus) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local shockwave = NPC.GetAbilityByIndex(myHero, 0)
    	local empower = NPC.GetAbilityByIndex(myHero, 1)
    	local skewer = NPC.GetAbilityByIndex(myHero, 2)
	local reversePolarity = NPC.GetAbility(myHero, "magnataur_reverse_polarity")

	local myMana = NPC.GetMana(myHero)
	local blink = NPC.GetItem(myHero, "item_blink", true)
	local refresher = NPC.GetItem(myHero, "item_refresher", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.magnusAutoUlt(myHero, myMana, skewer, reversePolarity, shockwave, blink, refresher)
	FAIO.magnusSkewerCombo(myHero, myMana, enemy, skewer, blink)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true and not Menu.IsKeyDown(FAIO_options.optionHeroMagnuscomboKeyAltSkewer) and not Menu.IsKeyDown(FAIO_options.optionHeroMagnuscomboKeyAltRP) then
		if not NPC.IsEntityInRange(myHero, enemy, 600) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end
			if Menu.IsEnabled(FAIO_options.optionHeroMagnusInitiateSkewer) then
				if not blink or (blink and not Ability.IsReady(blink)) then
					if skewer and Ability.IsCastable(skewer, myMana) then
						if NPC.IsEntityInRange(myHero, enemy, Ability.GetLevelSpecialValueFor(skewer, "range")) then
							Ability.CastPosition(skewer, Entity.GetAbsOrigin(enemy))
							return
						end
					end
				end
			end
		end

		if not NPC.HasModifier(myHero, "modifier_magnataur_empower") then
			FAIO.magnusAutoEmpower(myHero)
			return
		end
		if shockwave and Ability.IsCastable(shockwave, myMana) and Menu.IsEnabled(FAIO_options.optionHeroMagnusShockwaveInCombo) then
			if NPC.IsEntityInRange(myHero, enemy, 800) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				local shockwavePrediction = Ability.GetCastPoint(shockwave) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1050) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(shockwave, FAIO_utility_functions.castLinearPrediction(myHero, enemy, shockwavePrediction))
				return
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Menu.IsKeyDown(FAIO_options.optionHeroMagnuscomboKeyAltSkewer) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if blink and not NPC.IsEntityInRange(myHero, enemy, 125) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1120) then
					if Menu.GetValue(FAIO_options.optionHeroMagnusJump) == 0 then
						FAIO.magnusLastPos = Entity.GetAbsOrigin(myHero)
						local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D()
							if distance > 1100 then
								distance = 1100
							end
						Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(distance + 55))
						return
					else
						FAIO.magnusLastPos = Entity.GetAbsOrigin(myHero)
						local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 280, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 140)
						if bestPos ~= nil then
							local distance = (bestPos - Entity.GetAbsOrigin(myHero)):Length2D()
								if distance > 1100 then
									distance = 1100
								end
							Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (bestPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(distance + 55))
							return
						end
					end
				end
			end
		else
			if skewer and Ability.IsCastable(skewer, myMana) then
				if Menu.GetValue(FAIO_options.optionHeroMagnusReturn) == 0 then
					if blink and Ability.SecondsSinceLastUse(blink) > -1 and Ability.SecondsSinceLastUse(blink) < 0.25 then
						Ability.CastPosition(skewer, FAIO.magnusLastPos)
						return
					else
						local pos = Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.floor(Ability.GetLevelSpecialValueFor(skewer, "range")*0.9))
						Ability.CastPosition(skewer, pos)
						return
					end
				else
					local pos = Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.floor(Ability.GetLevelSpecialValueFor(skewer, "range")*0.9))
					Ability.CastPosition(skewer, pos)
					return
				end
			end
		end

		if not NPC.HasModifier(myHero, "modifier_magnataur_empower") then
			FAIO.magnusAutoEmpower(myHero)
			return
		end
		if shockwave and Ability.IsCastable(shockwave, myMana) and Menu.IsEnabled(FAIO_options.optionHeroMagnusShockwaveInCombo) then
			if NPC.IsEntityInRange(myHero, enemy, 800) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				local shockwavePrediction = Ability.GetCastPoint(shockwave) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1050) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(shockwave, FAIO_utility_functions.castLinearPrediction(myHero, enemy, shockwavePrediction))
				return
			end
		end

	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
					
	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Menu.IsKeyDown(FAIO_options.optionHeroMagnuscomboKeyAltRP) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		local gapCloser = blink
			if gapCloser and not Ability.IsReady(gapCloser) then
				if Ability.SecondsSinceLastUse(gapCloser) > 1.5 then
					if Menu.IsEnabled(FAIO_options.optionHeroMagnusInitiateSkewer) then
						gapCloser = skewer
					end
				end
			end
			if not gapCloser then
				if Menu.IsEnabled(FAIO_options.optionHeroMagnusInitiateSkewer) then
					gapCloser = skewer
				end
			end
		local gapCloserRange = 1150
			if gapCloser then
				if Ability.GetName(gapCloser) == "magnataur_skewer" then
					gapCloserRange = Ability.GetLevelSpecialValueFor(gapCloser, "range") - 25
				end
			end

		if not NPC.IsEntityInRange(myHero, enemy, 400) then
			if gapCloser and Ability.IsCastable(gapCloser, myMana) then
				local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 820, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 410)
				if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, gapCloserRange, 0) then
					if Ability.IsCastable(reversePolarity, myMana) and not Ability.IsInAbilityPhase(reversePolarity) then
						if not NPC.HasModifier(myHero, "modifier_magnataur_empower") then
							FAIO.magnusAutoEmpower(myHero)
							return
						end
						if Ability.IsReady(gapCloser) and Ability.IsCastable(gapCloser, myMana) then
							FAIO.magnusLastPos = Entity.GetAbsOrigin(myHero)
							Ability.CastPosition(gapCloser, bestPos)
							return
						end
					end
				end
			end
		else
			if reversePolarity and Ability.IsCastable(reversePolarity, myMana) then
				if Menu.GetValue(FAIO_options.optionHeroMagnusReturn) == 0 then
					if not FAIO.AmIFacingPos(myHero, FAIO.magnusLastPos, 15) and gapCloser and Ability.GetName(gapCloser) == "item_blink" and Menu.IsEnabled(FAIO_options.optionHeroMagnusSkewerInCombo) then
						NPC.MoveTo(myHero, Entity.GetAbsOrigin(myHero) + (FAIO.magnusLastPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(5), false, false)
						return
					else
						Ability.CastNoTarget(reversePolarity)
						return
					end
				end
				if Menu.GetValue(FAIO_options.optionHeroMagnusReturn) == 1 then
					if not FAIO.AmIFacingPos(myHero, Input.GetWorldCursorPos(), 15) and gapCloser and Ability.GetName(gapCloser) == "item_blink" and Menu.IsEnabled(FAIO_options.optionHeroMagnusSkewerInCombo) then
						NPC.MoveTo(myHero, Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(5), false, false)
						return
					else
						Ability.CastNoTarget(reversePolarity)
						return
					end
				end
			end
			if reversePolarity and not Ability.IsReady(reversePolarity) then
				if gapCloser and Ability.GetName(gapCloser) == "item_blink" and Menu.IsEnabled(FAIO_options.optionHeroMagnusSkewerInCombo) then
					if Ability.SecondsSinceLastUse(reversePolarity) > -1 and Ability.SecondsSinceLastUse(reversePolarity) < 1.5 then
						if skewer and Ability.IsCastable(skewer, myMana) and not Ability.IsReady(reversePolarity) and (not refresher or (refresher and Ability.IsReady(refresher))) then
							if Menu.GetValue(FAIO_options.optionHeroMagnusReturn) == 0 then
								Ability.CastPosition(skewer, FAIO.magnusLastPos)
								return
							else
								local pos = Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(math.floor(Ability.GetLevelSpecialValueFor(skewer, "range")*0.9))
								Ability.CastPosition(skewer, pos)
								return
							end
						end
					end
				end
				if shockwave and Ability.IsCastable(shockwave, myMana) and Menu.IsEnabled(FAIO_options.optionHeroMagnusShockwaveInCombo) then
					Ability.CastPosition(shockwave, Entity.GetAbsOrigin(enemy))
					return
				end
				if Menu.IsEnabled(FAIO_options.optionHeroMagnusComboRefresher) then
					if refresher and Ability.IsCastable(refresher, myMana) and myMana > (Ability.GetManaCost(reversePolarity) + Ability.GetManaCost(refresher)) then
						local stunTime = Ability.GetLevelSpecialValueForFloat(reversePolarity, "hero_stun_duration")
						if Ability.SecondsSinceLastUse(reversePolarity) > (stunTime - 0.5) and Ability.SecondsSinceLastUse(reversePolarity) < stunTime then
							Ability.CastNoTarget(refresher)
							Ability.CastNoTarget(reversePolarity)
							return
						end
					end
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	

	


end

function FAIO.magnusSkewerCombo(myHero, myMana, enemy, skewer, blink)

	if not myHero then return end
	if not enemy then return end

	if not Menu.IsEnabled(FAIO_options.optionHeroMagnusSkewerCombo) then return end

	if not blink then return end

	if not skewer then return end
		if not Ability.IsCastable(skewer, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end

	if Menu.IsKeyDown(FAIO_options.optionHeroMagnusSkewerComboKey) and Entity.GetHealth(enemy) > 0 then
		if NPC.IsEntityInRange(myHero, enemy, 1100) then
			if blink and Ability.IsReady(blink) then
				FAIO.magnusLastPos = Entity.GetAbsOrigin(myHero)
				local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D()
					if distance > 1100 then
						distance = 1100
					end
				Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(distance + 95))
				return
			end
			if Ability.SecondsSinceLastUse(blink) > -1 and Ability.SecondsSinceLastUse(blink) < 0.25 then
				Ability.CastPosition(skewer, FAIO.magnusLastPos)
				return
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

end
			
function FAIO.magnusAutoEmpower(myHero)

	if not myHero then return end
	local myMana = NPC.GetMana(myHero)

	local empower = NPC.GetAbilityByIndex(myHero, 1)
		if not empower then return end
		if not Ability.IsCastable(empower, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if NPC.HasModifier(myHero, "modifier_magnataur_empower") then return end

	Ability.CastTarget(empower, myHero)
	return
	
end

function FAIO.magnusAutoUlt(myHero, myMana, skewer, reversePolarity, shockwave, blink, refresher)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroMagnusAutoUlt) then return end

	if not reversePolarity then return end

	local shivas = NPC.GetItem(myHero, "item_shivas_guard", true)

	local gapCloser = blink
		if gapCloser and not Ability.IsReady(gapCloser) then
			if Ability.SecondsSinceLastUse(gapCloser) > 1.5 then
				if Menu.IsEnabled(FAIO_options.optionHeroMagnusAutoUltSkewer) then
					gapCloser = skewer
				end
			end
		end
		if not gapCloser then
			if Menu.IsEnabled(FAIO_options.optionHeroMagnusAutoUltSkewer) then
				gapCloser = skewer
			end
		end
		
	if not gapCloser then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end

	local reverseRadius = 410

	local gapCloserRange = 1150
		if Ability.GetName(gapCloser) == "magnataur_skewer" then
			gapCloserRange = Ability.GetLevelSpecialValueFor(gapCloser, "range") - 25
		end

	local tempTableHittableTargets = {}
	for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, gapCloserRange + reverseRadius, Enum.TeamType.TEAM_ENEMY)) do
		if targets then
			local target = FAIO.targetChecker(targets)
			if target then
				if #Entity.GetHeroesInRadius(target, reverseRadius, Enum.TeamType.TEAM_FRIEND) > -1 then
					table.insert(tempTableHittableTargets, target)
				end
			end
		end
	end

	if #tempTableHittableTargets >= 1 then
		local bestPos = FAIO_utility_functions.getBestPosition(tempTableHittableTargets, reverseRadius)
		if bestPos ~= nil and #Heroes.InRadius(bestPos, reverseRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroMagnusAutoUltCount) then
			if NPC.IsPositionInRange(myHero, bestPos, gapCloserRange, 0) then
				if Ability.IsCastable(reversePolarity, myMana) and not Ability.IsInAbilityPhase(reversePolarity) then
					if not NPC.HasModifier(myHero, "modifier_magnataur_empower") then
						FAIO.magnusAutoEmpower(myHero)
						return
					end
					if Ability.IsReady(gapCloser) and Ability.IsCastable(gapCloser, myMana) then
						FAIO.magnusLastPos = Entity.GetAbsOrigin(myHero)
						Ability.CastPosition(gapCloser, bestPos)
						return
					end
					if not FAIO.AmIFacingPos(myHero, FAIO.magnusLastPos, 15) and Ability.GetName(gapCloser) == "item_blink" then
						NPC.MoveTo(myHero, Entity.GetAbsOrigin(myHero) + (FAIO.magnusLastPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(5), false, false)
						return
					else
						Ability.CastNoTarget(reversePolarity)
						return
					end
				else
					if Ability.GetName(gapCloser) == "item_blink" then
						if Ability.SecondsSinceLastUse(reversePolarity) > -1 and Ability.SecondsSinceLastUse(reversePolarity) < 1.5 then
							if shivas and Ability.IsCastable(shivas, myMana) then
								Ability.CastNoTarget(shivas)
								return
							end
							if skewer and Ability.IsCastable(skewer, myMana) and not Ability.IsReady(reversePolarity) and (not refresher or (refresher and Ability.IsReady(refresher))) then
								Ability.CastPosition(skewer, FAIO.magnusLastPos)
								return
							end
							if shockwave and Ability.IsCastable(shockwave, myMana) then
								Ability.CastPosition(shockwave, Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(50), true)
								return
							end
							FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE", nil, Entity.GetAbsOrigin(myHero))
							return
						end
					else
						if Ability.SecondsSinceLastUse(reversePolarity) > -1 and Ability.SecondsSinceLastUse(reversePolarity) < 1.5 then
							if shivas and Ability.IsCastable(shivas, myMana) then
								Ability.CastNoTarget(shivas)
								return
							end
							if shockwave and Ability.IsCastable(shockwave, myMana) and not Ability.IsReady(skewer) then
								Ability.CastPosition(shockwave, Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(50), true)
								return
							end
							FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE", nil, Entity.GetAbsOrigin(myHero))
							return
						end
					end
					if Menu.IsEnabled(FAIO_options.optionHeroMagnusAutoUltRefresher) then
						if refresher and Ability.IsCastable(refresher, myMana) and myMana > (Ability.GetManaCost(reversePolarity) + Ability.GetManaCost(refresher)) then
							local stunTime = Ability.GetLevelSpecialValueForFloat(reversePolarity, "hero_stun_duration")
							if Ability.SecondsSinceLastUse(reversePolarity) > (stunTime - 0.5) and Ability.SecondsSinceLastUse(reversePolarity) < stunTime then
								Ability.CastNoTarget(refresher)
								Ability.CastNoTarget(reversePolarity)
								return
							end
						end
					end
				end
			end
		end
	end

end

function FAIO.AmIFacingPos(myHero, pos, allowedDeviation)

	if not myHero then return false end

	local myPos = Entity.GetAbsOrigin(myHero)
	local myRotation = Entity.GetRotation(myHero):GetForward():Normalized()

	local baseVec = (pos - myPos):Normalized()

	local tempProcessing = baseVec:Dot2D(myRotation) / (baseVec:Length2D() * myRotation:Length2D())
		if tempProcessing > 1 then
			tempProcessing = 1
		end	

	local checkAngleRad = math.acos(tempProcessing)
	local checkAngle = (180 / math.pi) * checkAngleRad

	if checkAngle < allowedDeviation then
		return true
	end

	return false

end

function FAIO.DazzleHelper(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroDazzle) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local poisonTouch = NPC.GetAbilityByIndex(myHero, 0)
    	local grave = NPC.GetAbilityByIndex(myHero, 1)
    	local shadowWave = NPC.GetAbilityByIndex(myHero, 2)
	local weave = NPC.GetAbility(myHero, "dazzle_weave")

	local myMana = NPC.GetMana(myHero)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.DazzleHelperAutoGrave(myHero, myMana, grave)
	FAIO.DazzleHelperAutoWeave(myHero, myMana, weave)
	FAIO.DazzleHelperAutoHeal(myHero, myMana, shadowWave)
	FAIO.DazzleHelperHealKillsteal(myHero, myMana, shadowWave)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then

		if not NPC.IsEntityInRange(myHero, enemy, 999) then
			if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1550) then
				Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(400)))
				return
			end
		end

		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if poisonTouch and Ability.IsCastable(poisonTouch, myMana) then
				Ability.CastTarget(poisonTouch, enemy)
				return
			end
		end

	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

end

function FAIO.DazzleHelperHealKillsteal(myHero, myMana, shadowWave)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroDazzleHealKS) then return end

	if not shadowWave then return end
		if not Ability.IsCastable(shadowWave, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local bounces = 2 + Ability.GetLevel(shadowWave)
	local bounceDamage = Ability.GetLevelSpecialValueFor(shadowWave, "damage")
		if NPC.HasAbility(myHero, "special_bonus_unique_dazzle_2") then
			if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_dazzle_2")) > 0 then
				bounceDamage = bounceDamage + 60
			end
		end

	local waveRange = Ability.GetCastRange(shadowWave) + NPC.GetCastRangeBonus(myHero) - 10

	for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, waveRange, Enum.TeamType.TEAM_ENEMY)) do
		if targets then
			local target = FAIO.targetChecker(targets)
			if target then
				if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") then
					local targetHP = Entity.GetHealth(target) + NPC.GetHealthRegen(target)
					local unitsAround = #Entity.GetUnitsInRadius(target, 175, Enum.TeamType.TEAM_ENEMY)
						if unitsAround > bounces then
							unitsAround = bounces
						end
					local waveDamage = unitsAround * bounceDamage
					local waveTrueDamage = (1 - NPC.GetMagicalArmorValue(target)) * (waveDamage + waveDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
					if targetHP < waveTrueDamage then
						for _, v in ipairs(Entity.GetUnitsInRadius(target, 175, Enum.TeamType.TEAM_ENEMY)) do
							if v then
								if NPC.IsEntityInRange(myHero, v, waveRange) then
									Ability.CastTarget(shadowWave, v)
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

function FAIO.DazzleHelperAutoHeal(myHero, myMana, shadowWave)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroDazzleAutoHeal) then return end

	if not shadowWave then return end
		if not Ability.IsCastable(shadowWave, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100
	local waveRange = Ability.GetCastRange(shadowWave) + NPC.GetCastRangeBonus(myHero) - 10

	if FAIO.TargetIsInvulnarable(myHero, myHero) <= 0 then
		if myHPperc <= Menu.GetValue(FAIO_options.optionHeroDazzleAutoHealHP) then
			Ability.CastTarget(shadowWave, myHero)
			return
		end
	end

	for _, ally in ipairs(Entity.GetHeroesInRadius(myHero, waveRange, Enum.TeamType.TEAM_FRIEND)) do
		if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) and FAIO.TargetIsInvulnarable(myHero, ally) <= 0 and FAIO.TargetIsInvulnarable(myHero, myHero) <= 0 then
			local allyHPperc = (Entity.GetHealth(ally) / Entity.GetMaxHealth(ally)) * 100
			if allyHPperc <= Menu.GetValue(FAIO_options.optionHeroDazzleAutoHealHP) then
				Ability.CastTarget(shadowWave, ally)
				break
				return
			end
		end
	end

end

function FAIO.DazzleHelperAutoWeave(myHero, myMana, weave)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroDazzleAutoWeave) then return end

	if not weave then return end
		if not Ability.IsCastable(weave, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local weaveRange = Ability.GetCastRange(weave) + NPC.GetCastRangeBonus(myHero) - 10
	local weaveRadius = 550

	local tempTableHittableTargets = {}
	for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, 2000, Enum.TeamType.TEAM_ENEMY)) do
		if targets then
			local target = FAIO.targetChecker(targets)
			if target then
				if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					if NPC.IsEntityInRange(myHero, target, weaveRange + weaveRadius) then
						if #Entity.GetHeroesInRadius(target, weaveRadius, Enum.TeamType.TEAM_FRIEND) > -1 then
							table.insert(tempTableHittableTargets, target)
						end
					end
				end
			end
		end
	end

	if #tempTableHittableTargets >= 1 then
		local bestPos = FAIO_utility_functions.getBestPosition(tempTableHittableTargets, weaveRadius)
		if bestPos ~= nil and #Heroes.InRadius(bestPos, weaveRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroDazzleAutoWeaveCount) then
			if NPC.IsPositionInRange(myHero, bestPos, weaveRange, 0) then
				Ability.CastPosition(weave, bestPos)
				return
			end
		end
	end

end

function FAIO.DazzleHelperAutoGrave(myHero, myMana, grave)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroDazzleAutoGrave) then return end

	if not grave then return end
		if not Ability.IsCastable(grave, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100
	local graveRange = Ability.GetCastRange(grave) + NPC.GetCastRangeBonus(myHero) - 10

	if FAIO.TargetIsInvulnarable(myHero, myHero) <= 0 then
		if myHPperc <= Menu.GetValue(FAIO_options.optionHeroDazzleHP) then
			if FAIO.IsAttackedByDangerousSpell(myHero, myHero, 1000) == true then
				Ability.CastTarget(grave, myHero)
				return
			else
				for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
					if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
						if NPC.IsAttacking(v) then
							if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
								if NPC.FindFacingNPC(v) == myHero then
									Ability.CastTarget(grave, myHero)
									break
									return
								end
							end
						else
							if myHPperc <= 7 then
								if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
									if NPC.FindFacingNPC(v) == myHero then
										Ability.CastTarget(grave, myHero)
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

	for _, ally in ipairs(Entity.GetHeroesInRadius(myHero, graveRange, Enum.TeamType.TEAM_FRIEND)) do
		if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) and FAIO.TargetIsInvulnarable(myHero, ally) <= 0 and FAIO.TargetIsInvulnarable(myHero, myHero) <= 0 then
			local allyHPperc = (Entity.GetHealth(ally) / Entity.GetMaxHealth(ally)) * 100
			if allyHPperc <= Menu.GetValue(FAIO_options.optionHeroDazzleHP) then
				if FAIO.IsAttackedByDangerousSpell(myHero, ally, 800) == true then
					Ability.CastTarget(grave, ally)
					break
					return
				else
					for _, v in ipairs(Entity.GetHeroesInRadius(ally, 800, Enum.TeamType.TEAM_ENEMY)) do
						if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
							if NPC.IsAttacking(v) then
								if NPC.IsEntityInRange(ally, v, NPC.GetAttackRange(v) + 140) then
									if NPC.FindFacingNPC(v) == ally then
										Ability.CastTarget(grave, ally)
										break
										return
									end
								end
							else
								if allyHPperc <= 7 then
									if NPC.IsEntityInRange(ally, v, NPC.GetAttackRange(v) + 140) then
										if NPC.FindFacingNPC(v) == ally then
											Ability.CastTarget(grave, ally)
											break
											return
										end
									end
								end
							end	
						end
					end
				end
			else
				if NPC.HasModifier(ally, "modifier_necrolyte_reapers_scythe") then
					if allyHPperc < 60 then
						Ability.CastTarget(grave, ally)
						break
						return
					end
				end
			end
		end
	end

end

function FAIO.IsAttackedByDangerousSpell(myHero, target, searchRange)

	if not myHero then return false end
	if not target then return false end
	if FAIO.TargetIsInvulnarable(myHero, target) > 0 then return false end

	for _, enemy in ipairs(Entity.GetHeroesInRadius(target, searchRange, Enum.TeamType.TEAM_ENEMY)) do
		if enemy and Entity.IsHero(enemy) and not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) then
			if NPC.FindFacingNPC(enemy) == target then
				for _, info in ipairs(FAIO_data.AbilityList) do
					if info[1] == NPC.GetUnitName(enemy) then
						if info[3] == "nuke" or info[3] == "disable" then
							if NPC.HasAbility(enemy, info[2]) then
								if Ability.IsInAbilityPhase(NPC.GetAbility(enemy, info[2])) then
									local castRange = Ability.GetCastRange(NPC.GetAbility(enemy, info[2])) + NPC.GetCastRangeBonus(enemy) + 25
									if NPC.IsEntityInRange(enemy, target, castRange) then
										return true
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return false

end

function FAIO.SFCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSF) then return end

	local razeShort = NPC.GetAbilityByIndex(myHero, 0)
    	local razeMid = NPC.GetAbilityByIndex(myHero, 1)
    	local razeLong = NPC.GetAbilityByIndex(myHero, 2)
	local requiem = NPC.GetAbility(myHero, "nevermore_requiem")
	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local eul = NPC.GetItem(myHero, "item_cyclone", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.SFComboDrawRazeCircles(myHero)

	if enemy then
		if eul and requiem and Ability.IsCastable(requiem, myMana) then
			if Menu.IsKeyDown(FAIO_options.optionHeroSFEulCombo) and Entity.GetHealth(enemy) > 0 then
				if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					local possibleRange = 0.80 * NPC.GetMoveSpeed(myHero)
					if not NPC.IsEntityInRange(myHero, enemy, possibleRange) then
						if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1175 + 0.75 * possibleRange) then
							Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(0.75 * possibleRange)))
							return
						else
							FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
							return
						end
					else
						if NPC.IsLinkensProtected(enemy) then
							if FAIO_itemHandler.ItemSleepReady(0.05) and FAIO.LinkensBreakerNew(myHero) ~= nil then
								Ability.CastTarget(NPC.GetItem(myHero, FAIO.LinkensBreakerNew(myHero), true), enemy)
								return
							end
						end

						if Ability.IsCastable(eul, myMana) then
							Ability.CastTarget(eul, enemy)
							return
						end
						if NPC.HasModifier(enemy, "modifier_eul_cyclone") then
							if not NPC.IsEntityInRange(myHero, enemy, 20) then
								FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
								return
							else
								local cycloneDieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_eul_cyclone"))
								if cycloneDieTime - GameRules.GetGameTime() <= 1.66 then
									Ability.CastNoTarget(requiem)
									return
								end
							end
						end
					end	
				end
			end
		end
	end

	if enemy then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
				if not NPC.IsEntityInRange(myHero, enemy, 999) then
					if Menu.IsEnabled(FAIO_options.optionHeroSFBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroSFBlinkRange)) then
						Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroSFBlinkRange))))
						return
					end
				end

				if Menu.IsEnabled(FAIO_options.optionHeroSFComboRaze) then
					if razeShort and Ability.IsCastable(razeShort, myMana) then
						local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(200)
						local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)			
						local predictedPos = FAIO_utility_functions.castPrediction(myHero, enemy, razePrediction)
						local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
						if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
							if os.clock() - FAIO.lastTick >= 0.55 then
								Ability.CastNoTarget(razeShort)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
					if razeMid and Ability.IsCastable(razeMid, myMana) then
						local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(450)
						local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)			
						local predictedPos = FAIO_utility_functions.castPrediction(myHero, enemy, razePrediction)
						local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
						if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
							if os.clock() - FAIO.lastTick >= 0.55 then
								Ability.CastNoTarget(razeMid)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
					if razeLong and Ability.IsCastable(razeLong, myMana) then
						local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(700)
						local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)			
						local predictedPos = FAIO_utility_functions.castPrediction(myHero, enemy, razePrediction)
						local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
						if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
							if os.clock() - FAIO.lastTick >= 0.55 then
								Ability.CastNoTarget(razeLong)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				end
			end
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
		end
	end

end

function FAIO.SFComboDrawRazeCircles(myHero)

	if not myHero then return end

	local curtime = GameRules.GetGameTime()	

	if Menu.IsEnabled(FAIO_options.optionHeroSFDrawRazeCircle) then
		
		if FAIO.SFcurrentParticle1 == 0 then
			local circle1 = Particle.Create("particles/econ/generic/generic_progress_meter/generic_progress_circle_b.vpcf")
			FAIO.SFcurrentParticle1 = circle1
			Particle.SetControlPoint(circle1, 1, Vector(250, 1, 1))
			Particle.SetControlPoint(circle1, 15, Vector(0, 255, 0))
			Particle.SetControlPoint(circle1, 16, Vector(1, 0, 0))
		end
		if FAIO.SFcurrentParticle2 == 0 then
			local circle2 = Particle.Create("particles/econ/generic/generic_progress_meter/generic_progress_circle_b.vpcf")
			FAIO.SFcurrentParticle2 = circle2
			Particle.SetControlPoint(circle2, 1, Vector(250, 1, 1))
			Particle.SetControlPoint(circle2, 15, Vector(255, 255, 0))
			Particle.SetControlPoint(circle2, 16, Vector(1, 0, 0))
		end
		if FAIO.SFcurrentParticle3 == 0 then
			local circle3 = Particle.Create("particles/econ/generic/generic_progress_meter/generic_progress_circle_b.vpcf")
			FAIO.SFcurrentParticle3 = circle3
			Particle.SetControlPoint(circle3, 1, Vector(250, 1, 1))
			Particle.SetControlPoint(circle3, 15, Vector(255, 100, 0))
			Particle.SetControlPoint(circle3, 16, Vector(1, 0, 0))
		end

		if os.clock() - FAIO.SFParticleUpdateTime >= 0.033 then
			Particle.SetControlPoint(FAIO.SFcurrentParticle1, 0, (Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(200)))
			Particle.SetControlPoint(FAIO.SFcurrentParticle2, 0, (Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(450)))
			Particle.SetControlPoint(FAIO.SFcurrentParticle3, 0, (Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(700)))
			FAIO.SFParticleUpdateTime = os.clock()
		end
			
	else
		if FAIO.SFcurrentParticle1 > 0 then
			Particle.Destroy(FAIO.SFcurrentParticle1)
			Particle.Destroy(FAIO.SFcurrentParticle2)
			Particle.Destroy(FAIO.SFcurrentParticle3)
			FAIO.SFcurrentParticle1 = 0
			FAIO.SFcurrentParticle2 = 0
			FAIO.SFcurrentParticle3 = 0
		end
	end

end

function FAIO.SFComboDrawRequiemDamage(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroSFDrawReqDMG) then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	local requiem = NPC.GetAbility(myHero, "nevermore_requiem")
	local myMana = NPC.GetMana(myHero)

	local stackCounter = 0
		if NPC.HasModifier(myHero, "modifier_nevermore_necromastery") then
			stackCounter = Modifier.GetStackCount(NPC.GetModifier(myHero, "modifier_nevermore_necromastery"))
		end

	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)

	local requiemDamage = Ability.GetDamage(requiem) * (math.floor(stackCounter/2))
		if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
			requiemDamage = requiemDamage + Ability.GetLevelSpecialValueForFloat(requiem, "requiem_damage_pct_scepter") * (math.floor(stackCounter/2))
		end
	local requiemTrueDamage = (1 - NPC.GetMagicalArmorValue(enemy)) * (requiemDamage + requiemDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))

	local remainingHP = math.floor(Entity.GetHealth(enemy) - requiemTrueDamage)
		if remainingHP < 0 then
			remainingHP = 0
		end

	if requiem and Ability.IsCastable(requiem, myMana) then
		if visible then
			if Entity.GetHealth(enemy) > requiemTrueDamage then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
			Renderer.DrawText(FAIO.skywrathFont, x-60, y-70, "Full requiem hit:   " .. math.floor(requiemTrueDamage) .. "  (" .. remainingHP .. ")", 0)
		end
	end	

end

function FAIO.WillowCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroWillow) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local maze = NPC.GetAbilityByIndex(myHero, 0)
    	local shadowRealm = NPC.GetAbilityByIndex(myHero, 1)
	local cursedCrown = NPC.GetAbilityByIndex(myHero, 2)
    	local bedlam = NPC.GetAbility(myHero, "dark_willow_bedlam")

	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local euls = NPC.GetItem(myHero, "item_cyclone", true)
	local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local comboRange = 800
		if cursedCrown then
			comboRange = Ability.GetCastRange(cursedCrown)
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 900) then
				if Menu.IsEnabled(FAIO_options.optionHeroWillowBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroWillowBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroWillowBlinkRange))))
					return
				end
			else
				if cursedCrown and Ability.IsCastable(cursedCrown, myMana) then
					Ability.CastTarget(cursedCrown, enemy)
					FAIO.lastTick = os.clock()
					return
				end
				if FAIO.SleepReady(0.1) and shadowRealm and Ability.IsCastable(shadowRealm, myMana) then
					Ability.CastNoTarget(shadowRealm)
					FAIO.lastTick = os.clock()
					return
				end
				if euls then
					if FAIO.SleepReady(0.1) and Ability.IsCastable(euls, myMana) then
						Ability.CastTarget(euls, enemy)
						FAIO.lastTick = os.clock()
						return
					end
					if Ability.SecondsSinceLastUse(euls) > -1 and Ability.SecondsSinceLastUse(euls) < 0.5 then
						if maze and Ability.IsCastable(maze, myMana) then
							local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 850, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 425)
							if bestPos ~= nil then
								Ability.CastPosition(maze, bestPos)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
					if bedlam and Ability.IsCastable(bedlam, myMana) then
						if NPC.IsEntityInRange(myHero, enemy, 150) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
							Ability.CastNoTarget(bedlam)
							FAIO.lastTick = os.clock()
							return
						end
					end
				else
					if atos then
						if FAIO.SleepReady(0.1) and Ability.IsCastable(atos, myMana) then
							Ability.CastTarget(atos, enemy)
							FAIO.lastTick = os.clock()
							return
						end
						if FAIO.SleepReady(0.1) and bedlam and Ability.IsCastable(bedlam, myMana) then
							if NPC.IsEntityInRange(myHero, enemy, 150) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
								Ability.CastNoTarget(bedlam)
								FAIO.lastTick = os.clock()
								return
							end
						end
						if NPC.HasModifier(enemy, "modifier_rod_of_atos_debuff") then
							local dieTime = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_rod_of_atos_debuff"))
							if dieTime - GameRules.GetGameTime() < 0.1 then
								if FAIO.SleepReady(0.1) and maze and Ability.IsCastable(maze, myMana) then
									local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 850, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 425)
									if bestPos ~= nil then
										Ability.CastPosition(maze, bestPos)
										FAIO.lastTick = os.clock()
										return
									end
								end
							end
						else
							if Ability.SecondsSinceLastUse(atos) > ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1500) + 0.15 then
								if FAIO.SleepReady(0.1) and maze and Ability.IsCastable(maze, myMana) then
									local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 850, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 425)
									if bestPos ~= nil then
										Ability.CastPosition(maze, bestPos)
										FAIO.lastTick = os.clock()
										return
									end
								end
							end
						end
					else
						if maze and Ability.IsCastable(maze, myMana) then
							local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 850, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 425)
							if bestPos ~= nil then
								Ability.CastPosition(maze, bestPos)
								FAIO.lastTick = os.clock()
								return
							end
						end
						if bedlam and Ability.IsCastable(bedlam, myMana) then
							if NPC.IsEntityInRange(myHero, enemy, 250) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
								Ability.CastNoTarget(bedlam)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
						
				end
			end
		end
		if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) or NPC.HasModifier(enemy, "modifier_rod_of_atos_debuff") or NPC.HasModifier(myHero, "modifier_dark_willow_bedlam") then
			if not NPC.HasModifier(myHero, "modifier_dark_willow_shadow_realm_buff") then
				if not NPC.IsEntityInRange(myHero, enemy, 150) then
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
					return
				end
			else
				local creaTime = Modifier.GetCreationTime(NPC.GetModifier(myHero, "modifier_dark_willow_shadow_realm_buff"))
				if GameRules.GetGameTime() - creaTime >= 3 then
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
					return
				else
					if not NPC.IsEntityInRange(myHero, enemy, 150) then
						FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
						return
					end
				end
			end	
		else
			if NPC.HasModifier(myHero, "modifier_dark_willow_shadow_realm_buff") then
				local creaTime = Modifier.GetCreationTime(NPC.GetModifier(myHero, "modifier_dark_willow_shadow_realm_buff"))
				if GameRules.GetGameTime() - creaTime >= 3 then
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
					return
				else
					if not NPC.IsEntityInRange(myHero, enemy, 150) then
						FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy))
						return
					end
				end
			else	
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
				return
			end
		end
	end

end

function FAIO.SilencerCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSilencer) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local arcaneCurse = NPC.GetAbilityByIndex(myHero, 0)
    	local glaives = NPC.GetAbilityByIndex(myHero, 1)
	local lastWord = NPC.GetAbilityByIndex(myHero, 2)
    	local globalSilence = NPC.GetAbility(myHero, "silencer_global_silence")

	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)

	local myAttackRange = NPC.GetAttackRange(myHero)

	FAIO.SilencerAutoInterruptChan(myHero, myMana, globalSilence)
	FAIO_itemHandler.itemUsage(myHero, enemy)
	
	if Menu.IsKeyDown(FAIO_options.optionHeroSilencerHarassKey) then
		FAIO.SilencerAutoHarass(myHero, myMana, myAttackRange, glaives)
		Engine.ExecuteCommand("dota_range_display " .. myAttackRange)
	else
		Engine.ExecuteCommand("dota_range_display 0")
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 900) then
				if Menu.IsEnabled(FAIO_options.optionHeroSilencerBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroSilencerBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroSilencerBlinkRange))))
					return
				end
			else
				if lastWord and Ability.IsCastable(lastWord, myMana) then
					Ability.CastTarget(lastWord, enemy)
					FAIO.lastTick = os.clock()
					return
				end
				if FAIO.SleepReady(0.1) and arcaneCurse and Ability.IsCastable(arcaneCurse, myMana) then
					local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 840, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 420)
					if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, 999, 0) then
						Ability.CastPosition(arcaneCurse, bestPos)
						FAIO.lastTick = os.clock()
						return
					else
						Ability.CastPosition(arcaneCurse, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				end
			end				
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return
	end
		
end

function FAIO.SilencerAutoHarass(myHero, myMana, myAttackRange, glaives)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroSilencerHarass) then return end

	if not glaives then return end
		if Ability.GetLevel(glaives) < 1 then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, myAttackRange, Enum.TeamType.TEAM_ENEMY)) do
		if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then 
			if Entity.IsAlive(hero) then
        			Ability.CastTarget(glaives, hero)
				break
        			return
			end
      		end		
	end

end

function FAIO.SilencerAutoHurricane(myHero, myMana, enemy, hurricanePike)

	if not myHero then return end
	if not enemy then return end

	if not Menu.IsEnabled(FAIO_options.optionHeroSilencerHurricane) then return end

	if not hurricanePike then return end
		if not Ability.IsCastable(hurricanePike, myMana) then return end

	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if myHPperc <= Menu.GetValue(FAIO_options.optionHeroSilencerHurricaneHP) then
		for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
				if NPC.FindFacingNPC(v) == myHero then
					if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
						if NPC.IsAttacking(v) then
							Ability.CastTarget(hurricanePike, enemy)
							break
							return
						end
					end
				end
			end	
		end
	end

end

function FAIO.SilencerAutoInterruptChan(myHero, myMana, globalSilence)

	if not myHero then return end

	if not Menu.IsEnabled(FAIO_options.optionHeroSilencerGlobal) then return end

	if not globalSilence then return end
		if not Ability.IsCastable(globalSilence, myMana) then return end

	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	for i = 1, Heroes.Count() do
		local enemy = Heroes.Get(i)
		if enemy and Entity.IsHero(enemy) and not Entity.IsSameTeam(myHero, enemy) and not Entity.IsDormant(enemy) and NPC.GetUnitName(enemy) == "npc_dota_hero_enigma" and not NPC.IsIllusion(enemy) then
			if Entity.IsAlive(enemy) then
				local blackHole = NPC.GetAbility(enemy, "enigma_black_hole")
				if blackHole and Ability.IsChannelling(blackHole) then
					Ability.CastNoTarget(globalSilence)
					return
				end
			end
		end
	end

end

function FAIO.ODCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroOD) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local arcaneOrb = NPC.GetAbilityByIndex(myHero, 0)
    	local astralPrison = NPC.GetAbilityByIndex(myHero, 1)
    	local sanityEclipse = NPC.GetAbility(myHero, "obsidian_destroyer_sanity_eclipse")
	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)

	local myAttackRange = NPC.GetAttackRange(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.ODKillsteal(myHero, myMana, myAttackRange, arcaneOrb, astralPrison, sanityEclipse)
	FAIO.ODAutoPrisonAutoDisable(myHero, myMana, astralPrison)
	FAIO.ODAutoPrisonSave(myHero, myMana, astralPrison)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, 999) then
				if Menu.IsEnabled(FAIO_options.optionHeroODBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroODBlinkRange)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroODBlinkRange))))
					return
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return
	end

end

function FAIO.ODAutoPrisonSave(myHero, myMana, astralPrison)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroODAutoPrisonSave) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not astralPrison then return end
		if not Ability.IsCastable(astralPrison, myMana) then return end

	local prisonCastRange = Ability.GetCastRange(astralPrison) - 25

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if Menu.IsEnabled(FAIO_options.optionHeroODAutoPrisonSaveSelf) then
		if myHPperc <= Menu.GetValue(FAIO_options.optionHeroODAutoPrisonHP) then
			for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
				if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
					if NPC.FindFacingNPC(v) == myHero then
						if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
							if NPC.IsAttacking(v) then
								Ability.CastTarget(astralPrison, myHero)
								break
								return
							end
						end
					end
				end	
			end
		end
	end
	
	if Menu.IsEnabled(FAIO_options.optionHeroODAutoPrisonSaveAlly) then
		local teamMatesAround = NPC.GetHeroesInRadius(myHero, prisonCastRange, Enum.TeamType.TEAM_FRIEND)
		if next(teamMatesAround) ~= nil then
			for _, ally in ipairs(teamMatesAround) do
				if ally and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
					if not FAIO.isHeroChannelling(ally) and not FAIO.IsHeroInvisible(ally) then
						if FAIO.IsNPCinDanger(myHero, ally) or (((Entity.GetHealth(ally) / Entity.GetMaxHealth(ally)) * 100) < Menu.GetValue(FAIO_options.optionHeroODAutoPrisonHP)) then
							Ability.CastTarget(astralPrison, ally)
							break
							return
						end
					end
				end
			end
		end
	end

end

function FAIO.ODAutoPrisonAutoDisable(myHero, myMana, astralPrison)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroODAutoPrisonDefend) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not astralPrison then return end
		if not Ability.IsCastable(astralPrison, myMana) then return end

	local prisonCastRange = Ability.GetCastRange(astralPrison) - 25

	for _, heroes in ipairs(NPC.GetHeroesInRadius(myHero, prisonCastRange, Enum.TeamType.TEAM_ENEMY)) do
		if heroes and not NPC.IsDormant(heroes) and Entity.IsAlive(heroes) then
			local enemyDagger = NPC.GetItem(heroes, "item_blink", true)
			if enemyDagger and Ability.GetCooldownTimeLeft(enemyDagger) >= 9 and Ability.SecondsSinceLastUse(enemyDagger) > -1 and Ability.SecondsSinceLastUse(enemyDagger) <= 1 then
				if not NPC.HasState(heroes, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(heroes) then
					Ability.CastTarget(astralPrison, heroes)
					break
					return
				end
			end
		end
	end

end

function FAIO.ODAutoHurricane(myHero, myMana, enemy, hurricanePike)

	if not myHero then return end
	if not enemy then return end

	if not Menu.IsEnabled(FAIO_options.optionHeroODHurricane) then return end

	if not hurricanePike then return end
		if not Ability.IsCastable(hurricanePike, myMana) then return end

	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local myHPperc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100

	if myHPperc <= Menu.GetValue(FAIO_options.optionHeroODHurricaneHP) then
		for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
				if NPC.FindFacingNPC(v) == myHero then
					if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
						if NPC.IsAttacking(v) then
							Ability.CastTarget(hurricanePike, enemy)
							break
							return
						end
					end
				end
			end	
		end
	end

end

function FAIO.ODKillsteal(myHero, myMana, myAttackRange, arcaneOrb, astralPrison, sanityEclipse)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroODKillsteal) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not (arcaneOrb and astralPrison and sanityEclipse) then return end

	if Menu.IsEnabled(FAIO_options.optionHeroODKillstealEclipse) then
		if sanityEclipse and Ability.IsCastable(sanityEclipse, myMana) then
			local tempTableHittableTargets = {}
			local tempTableKillableTargets = {}
			local sanityEclipseRadius = Ability.GetLevelSpecialValueFor(sanityEclipse, "radius")
			for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, 1200, Enum.TeamType.TEAM_ENEMY)) do
				if targets then
					local target = FAIO.targetChecker(targets)
					if target then
						if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
							if NPC.IsEntityInRange(myHero, target, 690 + sanityEclipseRadius - 25) then
								if #Entity.GetHeroesInRadius(target, sanityEclipseRadius - 25, Enum.TeamType.TEAM_FRIEND) > -1 then
									table.insert(tempTableHittableTargets, target)
								end
							end
						end
					end
				end
			end

			if #tempTableHittableTargets >= 1 then
				local bestPos = FAIO_utility_functions.getBestPosition(tempTableHittableTargets, (sanityEclipseRadius - 25))
				if bestPos ~= nil and #Heroes.InRadius(bestPos, (sanityEclipseRadius - 25), Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroODKillstealEclipseHittable) then
					for _, v in ipairs(Heroes.InRadius(bestPos, (sanityEclipseRadius - 25), Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)) do
						local targetHP = Entity.GetHealth(v) + NPC.GetHealthRegen(v)
						local sanityEclipseDamage = (Hero.GetIntellectTotal(myHero) - Hero.GetIntellectTotal(v)) * Ability.GetLevelSpecialValueFor(sanityEclipse, "damage_multiplier")
						local sanityEclipseTrueDamage = (1 - NPC.GetMagicalArmorValue(v)) * (sanityEclipseDamage + sanityEclipseDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))		
						if targetHP < sanityEclipseTrueDamage then
							table.insert(tempTableKillableTargets, v)
						end
					end
				end
			end

			if #tempTableKillableTargets >= Menu.GetValue(FAIO_options.optionHeroODKillstealEclipseKillable) then
				local bestPos = FAIO_utility_functions.getBestPosition(tempTableHittableTargets, (sanityEclipseRadius - 25))
				if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, 690, 0) then
					Ability.CastPosition(sanityEclipse, bestPos)
					return
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroODKillstealPrison) then
		if astralPrison and Ability.IsCastable(astralPrison, myMana) then
			local prisonCastRange = Ability.GetCastRange(astralPrison)
			for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, prisonCastRange, Enum.TeamType.TEAM_ENEMY)) do
				if targets then
					local target = FAIO.targetChecker(targets)
					if target then
						if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(target) and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") then
							local targetHP = Entity.GetHealth(target) + 5 * math.ceil(NPC.GetHealthRegen(target))
							local prisonDamage = Ability.GetLevelSpecialValueFor(astralPrison, "damage")
							local prisonTrueDamage = (1 - NPC.GetMagicalArmorValue(target)) * (prisonDamage + prisonDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100)) - 5
							if targetHP < prisonTrueDamage then
								Ability.CastTarget(astralPrison, target)
								break
								return
							end
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroODKillstealOrb) then
		if arcaneOrb and Ability.IsCastable(arcaneOrb, myMana) and Ability.GetLevel(arcaneOrb) > 0 then
			for _, targets in ipairs(Entity.GetHeroesInRadius(myHero, myAttackRange, Enum.TeamType.TEAM_ENEMY)) do
				if targets then
					local target = FAIO.targetChecker(targets)
					if target then
						if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(target) and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
							local targetHP = Entity.GetHealth(target) + NPC.GetHealthRegen(target)
							local orbExtraDamage = (0.05 + (0.01 * Ability.GetLevel(arcaneOrb))) * NPC.GetMana(myHero)
							local rightClickDamage = NPC.GetDamageMultiplierVersus(myHero, target) * ((NPC.GetMinDamage(myHero) + NPC.GetBonusDamage(myHero)) * NPC.GetArmorDamageMultiplier(target))
							local overallDamage = rightClickDamage + orbExtraDamage
							if targetHP < overallDamage then
								Ability.CastTarget(arcaneOrb, target)
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

function FAIO.NecroCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroNecro) then return end

	local deathPulse = NPC.GetAbilityByIndex(myHero, 0)
    	local ghostShroud = NPC.GetAbilityByIndex(myHero, 1)
    	local reapersScythe = NPC.GetAbility(myHero, "necrolyte_reapers_scythe")
	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)
	
	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.necroComboTotalDamage(myHero, myMana, enemy, deathPulse, reapersScythe)
	FAIO.necroComboSelector(myHero, myMana, enemy, deathPulse, reapersScythe)
	FAIO.necroAutoScythe(myHero, myMana, reapersScythe)
	FAIO.necroAutoPulse(myHero, myMana, deathPulse)
	FAIO.necroAutoFarmShroud(myHero, myMana, deathPulse, ghostShroud)
	FAIO.necroAutoPulseShroudPanic(myHero, myMana, deathPulse, ghostShroud)

	if enemy then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
				if not NPC.IsEntityInRange(myHero, enemy, 999) then
					if Menu.IsEnabled(FAIO_options.optionHeroNecroBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroNecroBlinkRange)) then
						Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroNecroBlinkRange))))
						return
					end
				end

				if not FAIO.necroComboSelect then
					FAIO.necroComboWithoutUlt(myHero, myMana, enemy, deathPulse)
				else
					FAIO.necroComboWithUlt(myHero, myMana, enemy, deathPulse, reapersScythe)
				end

			end
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		end
	end

end

function FAIO.necroAutoPulseShroudPanic(myHero, myMana, deathPulse, ghostShroud)

	if not Menu.IsEnabled(FAIO_options.optionHeroNecroShroudPanic) then return end
	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local myHP = Entity.GetHealth(myHero)
	local myHPperc = (myHP / Entity.GetMaxHealth(myHero)) * 100

	if myHPperc <= Menu.GetValue(FAIO_options.optionHeroNecroShroudPanicHP) then
		if ghostShroud and Ability.IsCastable(ghostShroud, myMana) then
			Ability.CastNoTarget(ghostShroud)
			return
		end
		if deathPulse and Ability.IsCastable(deathPulse, myMana) then
			Ability.CastNoTarget(deathPulse)
			return
		end
	end

end

function FAIO.necroAutoFarmShroud(myHero, myMana, deathPulse, ghostShroud)

	if not Menu.IsEnabled(FAIO_options.optionHeroNecroShroudFarm) then return end
	if not myHero then return end
	if not deathPulse then return end
		if Ability.GetLevel(deathPulse) < 1 then return end

	if not ghostShroud then return end
		if Ability.GetLevel(ghostShroud) < 1 then return end
		if not Ability.IsCastable(ghostShroud, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local deathPulseModifier = NPC.GetModifier(myHero, "modifier_necrolyte_death_pulse_counter")
	local deathPulseCounter = 0
		if deathPulseModifier then
			deathPulseCounter = Modifier.GetStackCount(deathPulseModifier)
		end

	if deathPulseCounter <= Menu.GetValue(FAIO_options.optionHeroNecroShroudFarmCount) then return end
	if Menu.IsEnabled(FAIO_options.optionHeroNecroShroudFarmSave) then
		if #Entity.GetHeroesInRadius(myHero, 600, Enum.TeamType.TEAM_ENEMY) > 0 then
			return
		end
	end
	local manaPerc = (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) * 100
	local healthPerc = (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) * 100
	local treshold = Menu.GetValue(FAIO_options.optionHeroNecroShroudFarmTreshold)
	if manaPerc <= treshold or healthPerc <= treshold then
		Ability.CastNoTarget(ghostShroud)
		return
	end

end

function FAIO.necroAutoPulse(myHero, myMana, deathPulse)

	if not Menu.IsEnabled(FAIO_options.optionHeroNecroPulse) then return end
	if not myHero then return end
	if not deathPulse then return end
		if Ability.GetLevel(deathPulse) < 1 then return end
		if not Ability.IsCastable(deathPulse, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	if Menu.IsEnabled(FAIO_options.optionHeroNecroPulseCreeps) then
		local tempTable = {}
		for _, creep in ipairs(NPC.GetUnitsInRadius(myHero, 450, Enum.TeamType.TEAM_ENEMY)) do
			if creep and Entity.IsNPC(creep) and not Entity.IsDormant(creep) and not NPC.IsWaitingToSpawn(creep) and NPC.GetUnitName(creep) ~= "npc_dota_neutral_caster" then
				local pulseDamage = Ability.GetDamage(deathPulse)
				local pulseTrueDamage = (1 - NPC.GetMagicalArmorValue(creep)) * (pulseDamage + pulseDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
				local creepHP = Entity.GetHealth(creep)
				if NPC.IsLaneCreep(creep) then
					local attackerCount = 0
						if FAIO_lastHitter.lastHitGetAttackerCount(myHero, creep) ~= nil and FAIO_lastHitter.lastHitGetAttackerCount(myHero, creep) > 0 then
							attackerCount = FAIO_lastHitter.lastHitGetAttackerCount(myHero, creep)
						end
					if creepHP + (attackerCount * 15) < pulseTrueDamage then
						table.insert(tempTable, creep)
					end
				else
					if creepHP < pulseTrueDamage then
						table.insert(tempTable, creep)
					end
				end
			end
		end

		if #tempTable >= Menu.GetValue(FAIO_options.optionHeroNecroPulseCreepsCount) then
			if (myMana / NPC.GetMaxMana(myHero)) >= (Menu.GetValue(FAIO_options.optionHeroNecroPulseCreepsMana) / 100) then
				Ability.CastNoTarget(deathPulse)
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroNecroPulseHeroes) then
		for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, 450, Enum.TeamType.TEAM_ENEMY)) do
			local target = FAIO.targetChecker(hero)
			if target then
				if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					if (myMana / NPC.GetMaxMana(myHero)) >= (Menu.GetValue(FAIO_options.optionHeroNecroPulseHeroesMana) / 100) then
						Ability.CastNoTarget(deathPulse)
						break
						return
					end
				end
			end
		end
	end
					
end

function FAIO.necroAutoScythe(myHero, myMana, reapersScythe)

	if not Menu.IsEnabled(FAIO_options.optionHeroNecroScythe) then return end
	if not myHero then return end
	if not reapersScythe then return end
		if Ability.GetLevel(reapersScythe) < 1 then return end
		if not Ability.IsCastable(reapersScythe, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, 575, Enum.TeamType.TEAM_ENEMY)) do
		if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then 
			if Entity.IsAlive(hero) and not NPC.HasModifier(hero, "modifier_templar_assassin_refraction_absorb") then
				local scytheDamage = (Entity.GetMaxHealth(hero) - Entity.GetHealth(hero)) * Ability.GetLevelSpecialValueForFloat(reapersScythe, "damage_per_health")
        			local scytheTrueDamage = (1 - NPC.GetMagicalArmorValue(hero)) * (scytheDamage + scytheDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
				if Entity.GetHealth(hero) < scytheTrueDamage then
					Ability.CastTarget(reapersScythe, hero)
					break
        				return
				end
			end
      		end		
	end

end

function FAIO.necroComboSelector(myHero, myMana, enemy, deathPulse, reapersScythe)

	if not myHero then return end
	if not enemy then return end
	if os.clock() - FAIO.lastTick < 0.55 + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 400) then return end


	if not deathPulse then return end

	if Ability.SecondsSinceLastUse(deathPulse) > -1 and Ability.SecondsSinceLastUse(deathPulse) < 0.55 + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 400) then return end

	if not reapersScythe then
		FAIO.necroComboSelect = false
		return
	end

	if Ability.GetLevel(reapersScythe) < 1 then
		FAIO.necroComboSelect = false
		return
	end

	if not Ability.IsCastable(reapersScythe, myMana) then
		FAIO.necroComboSelect = false
		return
	end

	if Menu.GetValue(FAIO_options.optionHeroNecroComboScythe) == 0 then
		FAIO.necroComboSelect = false
		return
	else
		if Entity.GetHealth(enemy) > FAIO.necroDMGwithoutUlt then
			FAIO.necroComboSelect = true
			return
		else
			FAIO.necroComboSelect = false
			return
		end
	end	

end

function FAIO.necroComboWithoutUlt(myHero, myMana, enemy, deathPulse)

	if not myHero then return end
	if not enemy then return end

	if deathPulse and Ability.IsCastable(deathPulse, myMana) and NPC.IsEntityInRange(myHero, enemy, 450) then
		Ability.CastNoTarget(deathPulse)
		FAIO.lastTick = os.clock()
		return
	end

end

function FAIO.necroComboWithUlt(myHero, myMana, enemy, deathPulse, reapersScythe)

	if not myHero then return end
	if not enemy then return end

	if deathPulse and Ability.IsCastable(deathPulse, myMana) and NPC.IsEntityInRange(myHero, enemy, 450) then
		Ability.CastNoTarget(deathPulse)
		FAIO.lastTick = os.clock()
		return
	end

	if reapersScythe and Ability.IsCastable(reapersScythe, myMana) and NPC.IsEntityInRange(myHero, enemy, 550) then
		if Menu.GetValue(FAIO_options.optionHeroNecroComboScythe) == 1 then
			if not Ability.IsReady(deathPulse) then
				Ability.CastTarget(reapersScythe, enemy)
				FAIO.lastTick = os.clock()
				return
			end
		elseif Menu.GetValue(FAIO_options.optionHeroNecroComboScythe) == 2 then
			local scytheDamage = (Entity.GetMaxHealth(enemy) - Entity.GetHealth(enemy)) * Ability.GetLevelSpecialValueForFloat(reapersScythe, "damage_per_health")
        		local scytheTrueDamage = (1 - NPC.GetMagicalArmorValue(enemy)) * (scytheDamage + scytheDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
			local rightClickDamage = NPC.GetDamageMultiplierVersus(myHero, enemy) * ((NPC.GetMinDamage(myHero) + NPC.GetBonusDamage(myHero)) * NPC.GetArmorDamageMultiplier(enemy))
			local pulseExtraDamage = 0
				if deathPulse and Ability.SecondsSinceLastUse(deathPulse) > -1 and Ability.SecondsSinceLastUse(deathPulse) < (((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 400) + 0.05) then
					pulseExtraDamage = (1 - NPC.GetMagicalArmorValue(enemy)) * (Ability.GetDamage(deathPulse) + Ability.GetDamage(deathPulse) * (Hero.GetIntellectTotal(myHero) / 14 / 100))
				end
			if Entity.GetHealth(enemy) < (scytheTrueDamage + rightClickDamage + pulseExtraDamage) then
				Ability.CastTarget(reapersScythe, enemy)
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

end

function FAIO.necroComboTotalDamage(myHero, myMana, enemy, deathPulse, reapersScythe)

	if not myHero then return end
	if not enemy then return end
	if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end 

	local totalDamage = 0
	local totalDamageUlt = 0
	local veilAmp = 0
	local ebladeAmp = 0
	local reqMana = 0
	local reqManaUlt = 0

	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end

	if veil and Ability.IsCastable(veil, myMana) then
		veilAmp = 0.25
		reqMana = reqMana + Ability.GetManaCost(veil)
	end

	if eBlade and Ability.IsCastable(eBlade, myMana) then
		local ebladedamage = Hero.GetIntellectTotal(myHero) * 2 + 75
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + veilAmp) * (ebladedamage + ebladedamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		ebladeAmp = 0.4
		reqMana = reqMana + Ability.GetManaCost(eBlade)
	end	

	if dagon and Ability.IsCastable(dagon, Ability.GetManaCost(dagon)) then
		local dagondmg = Ability.GetLevelSpecialValueFor(dagon, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + veilAmp) * (1 + ebladeAmp) * (dagondmg + dagondmg * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		reqMana = reqMana + Ability.GetManaCost(dagon)
	end

	if deathPulse and Ability.IsCastable(deathPulse, myMana) then
		if NPC.HasItem(myHero, "item_blink", true) and Ability.IsReady(NPC.GetItem(myHero, "item_blink", true)) then
			local pulseDamage = Ability.GetDamage(deathPulse)
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + veilAmp) * (1 + ebladeAmp) * (pulseDamage + pulseDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
			reqMana = reqMana + Ability.GetManaCost(deathPulse)
		else
			if NPC.IsEntityInRange(myHero, enemy, 475) then
				local pulseDamage = Ability.GetDamage(deathPulse)
				totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + veilAmp) * (1 + ebladeAmp) * (pulseDamage + pulseDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
				reqMana = reqMana + Ability.GetManaCost(deathPulse)
			end
		end
	end

	local rightClickDamage = 0
		if not NPC.HasItem(myHero, "item_ethereal_blade", true) then
			rightClickDamage = NPC.GetDamageMultiplierVersus(myHero, enemy) * ((NPC.GetMinDamage(myHero) + NPC.GetBonusDamage(myHero)) * NPC.GetArmorDamageMultiplier(enemy))
		end

	totalDamage = totalDamage + rightClickDamage

	local scytheOverallTrueDamage = 0
	local totalDamageUlt = totalDamage
	local reqManaUlt = reqMana
	if reapersScythe and Ability.IsCastable(reapersScythe, myMana) then
		local scytheDamage = (Entity.GetMaxHealth(enemy) - (Entity.GetHealth(enemy) - totalDamage)) * Ability.GetLevelSpecialValueForFloat(reapersScythe, "damage_per_health")
		local scytheTrueDamage = (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + veilAmp) * (1 + ebladeAmp) * (scytheDamage + scytheDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
		scytheOverallTrueDamage = scytheTrueDamage + rightClickDamage
		totalDamageUlt = totalDamage + scytheOverallTrueDamage
		reqManaUlt = reqManaUlt + Ability.GetManaCost(reapersScythe)
	end

	if reqManaUlt > NPC.GetMana(myHero) and reqMana < NPC.GetMana(myHero) then
		totalDamageUlt = totalDamage
	end

	if reqMana < NPC.GetMana(myHero) then
		FAIO.necroDMGwithoutUlt = totalDamage
		FAIO.necroDMGwithUlt = totalDamageUlt
	end

end

function FAIO.necroComboDrawDamage(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroNecroDrawDMG) then return end
	
	if FAIO.necroDMGwithoutUlt == 0 then return end
	if FAIO.necroDMGwithUlt == 0 then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	if FAIO.necroDMGwithoutUlt > 0 and FAIO.necroDMGwithUlt > 0 then
		if visible then
			if Entity.GetHealth(enemy) > FAIO.necroDMGwithoutUlt then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
				Renderer.DrawText(FAIO.skywrathFont, x-50, y-90, "DMG w/o Ult: " .. math.floor(FAIO.necroDMGwithoutUlt), 0)
			if Entity.GetHealth(enemy) > FAIO.necroDMGwithUlt then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
				Renderer.DrawText(FAIO.skywrathFont, x-50, y-75, "DMG w/ Ult: " .. math.floor(FAIO.necroDMGwithUlt), 0)
		end
	end
		

end

function FAIO.PACombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroPA) then return end

	local dagger = NPC.GetAbilityByIndex(myHero, 0)
	local phantomStrike = NPC.GetAbilityByIndex(myHero, 1)

	local myMana = NPC.GetMana(myHero)

	local daggerRange = 0
		if dagger then
			daggerRange = Ability.GetCastRange(dagger)
		end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if enemy and NPC.IsEntityInRange(myHero, enemy, 3000) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
				if FAIO.SleepReady(0.1) and dagger and Ability.IsCastable(dagger, myMana) then
					if NPC.IsEntityInRange(myHero, enemy, daggerRange - 5) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
						Ability.CastTarget(dagger, enemy)
						FAIO.lastTick = os.clock()
						return
					end
				end
				if FAIO.SleepReady(0.1) and phantomStrike and Ability.IsCastable(phantomStrike, myMana) then
					if NPC.IsEntityInRange(myHero, enemy, 999) then
						Ability.CastTarget(phantomStrike, enemy)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end

		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
		end
	end
	
	local minHP = 99999
	local minHPenemy

	if Menu.IsEnabled(FAIO_options.optionHeroPADagger) and FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then
		if FAIO.Toggler then
			if NPC.GetMana(myHero) > (NPC.GetMaxMana(myHero) * (Menu.GetValue(FAIO_options.optionHeroPADaggerThreshold) / 100)) then
				if dagger and Ability.IsCastable(dagger, myMana) then
					local daggerEnemies = NPC.GetHeroesInRadius(myHero, daggerRange - 1, Enum.TeamType.TEAM_ENEMY)
					for _, daggerEnemy in ipairs(daggerEnemies) do
						if daggerEnemy and FAIO.targetChecker(daggerEnemy) ~= nil and not NPC.HasState(daggerEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
							local enemyHP = Entity.GetHealth(daggerEnemy)
							if enemyHP < minHP then
								minHP = enemyHP
								minHPenemy = daggerEnemy
							end
						end
					end
				end
			end
		end
	end

	if minHPenemy and FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then
		if Menu.IsEnabled(FAIO_options.optionHeroPADagger) then
			if FAIO.Toggler then
				if not NPC.IsChannellingAbility(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(myHero, "modifier_teleporting") then
					if FAIO.SleepReady(0.3) and dagger and Ability.IsCastable(dagger, myMana) then
						Ability.CastTarget(dagger, minHPenemy)
						FAIO.lastTick = os.clock()
						minHP = 99999
						minHPenemy = nil
						return
					end
				end
			end
		end
	end

	return

end

function FAIO.DrawPADaggerSwitch(myHero)

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 0, 255)

	local imageHandle = nil
	if FAIO.PADaggerIcon ~= nil then
		imageHandle = FAIO.PADaggerIcon
	else
		imageHandle = Renderer.LoadImage("resource/flash3/images/spellicons/" .. "phantom_assassin_stifling_dagger" .. ".png")
		FAIO.PADaggerIcon = imageHandle
	end

	if Menu.IsKeyDownOnce(FAIO_options.optionHeroPADaggerToggleKey) then
		FAIO.Toggler = not FAIO.Toggler
		FAIO.TogglerTime = os.clock()
	end

	local pos = Entity.GetAbsOrigin(myHero)
	local posY = NPC.GetHealthBarOffset(myHero)
		pos:SetZ(pos:GetZ() + posY)

	local x, y, visible = Renderer.WorldToScreen(pos)

	if Menu.IsEnabled(FAIO_options.optionHeroPADaggerDraw) then
		if visible then
			if FAIO.Toggler then
				Renderer.SetDrawColor(0, 255, 0, 255)
				Renderer.DrawImage(imageHandle, x-15, y-75, 30, 30)
			end
		end
	end	

	return	

end

function FAIO.AntiMageCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroAntiMage) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local AMblink = NPC.GetAbilityByIndex(myHero, 1)
    	local manaVoid = NPC.GetAbility(myHero, "antimage_mana_void")
    	
	local myMana = NPC.GetMana(myHero)

	local blinkRange = Ability.GetLevelSpecialValueFor(AMblink, "blink_range")

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, 250) then
			if AMblink and Ability.IsCastable(AMblink, myMana) and Menu.IsEnabled(FAIO_options.optionHeroAntiMageBlink) then
				if NPC.IsEntityInRange(myHero, enemy, blinkRange - 105) then
					if NPC.GetTimeToFace(enemy, myHero) <= 0.05 then
						Ability.CastPosition(AMblink, Entity.GetAbsOrigin(enemy))
						return
					else
						Ability.CastPosition(AMblink, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(100))
						return
					end
				end
			end
		end

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	FAIO.MantaIlluController(enemy, nil, myHero, myHero)

	end

	local maxManaDiff = 0
	local maxDMGTarget

	if manaVoid and Ability.IsCastable(manaVoid, myMana) and FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then
		if Menu.IsEnabled(FAIO_options.optionHeroAntiMageVoid) then
			local voidEnemies = NPC.GetHeroesInRadius(myHero, 599, Enum.TeamType.TEAM_ENEMY)
			for _, voidEnemy in ipairs(voidEnemies) do
				if voidEnemy and not NPC.IsLinkensProtected(voidEnemy) then
					local enemyManaDiff = NPC.GetMaxMana(voidEnemy) - NPC.GetMana(voidEnemy)
					if #voidEnemies <= 1 then
						if not NPC.HasState(voidEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
							maxManaDiff = 0
							maxDMGTarget = voidEnemy
							break
							return
						end
					else
						if enemyManaDiff > maxManaDiff and not NPC.HasState(voidEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
							maxManaDiff = enemyManaDiff
							maxDMGTarget = voidEnemy
						end
					end
				end
			end
		end
	end

	if maxDMGTarget ~= nil then
		if FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then
			local enemyHP = Entity.GetHealth(maxDMGTarget) + NPC.GetHealthRegen(maxDMGTarget)
			local enemiesInVoidRadius = NPC.GetHeroesInRadius(maxDMGTarget, 450, Enum.TeamType.TEAM_FRIEND)
			local enemyManaDiff = NPC.GetMaxMana(maxDMGTarget) - NPC.GetMana(maxDMGTarget)
			local voidDamage = enemyManaDiff * Ability.GetLevelSpecialValueForFloat(manaVoid, "mana_void_damage_per_mana")
			local totalVoidDamage = ((1 - NPC.GetMagicalArmorValue(maxDMGTarget)) * voidDamage) + (voidDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))
			if manaVoid and Ability.IsCastable(manaVoid, myMana) then
				if NPC.IsEntityInRange(myHero, maxDMGTarget, 599) then
					if totalVoidDamage > enemyHP then
						Ability.CastTarget(manaVoid, maxDMGTarget)
						maxManaDiff = 0
						maxDMGTarget = nil
						return
					end
					if #enemiesInVoidRadius >= 1 then
						for _, radiusTargets in ipairs(enemiesInVoidRadius) do
							if radiusTargets then
								local voidDamageRadius = enemyManaDiff * Ability.GetLevelSpecialValueForFloat(manaVoid, "mana_void_damage_per_mana")
								local totalVoidDamageRadius = ((1 - NPC.GetMagicalArmorValue(radiusTargets)) * voidDamageRadius) + (voidDamageRadius * (Hero.GetIntellectTotal(myHero) / 14 / 100))
								if totalVoidDamageRadius > Entity.GetHealth(radiusTargets) + NPC.GetHealthRegen(radiusTargets) and not NPC.HasState(radiusTargets, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
									Ability.CastTarget(manaVoid, maxDMGTarget)
									maxManaDiff = 0
									maxDMGTarget = nil
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

function FAIO.tinyCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroTiny) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end
    
    	local avalanche = NPC.GetAbilityByIndex(myHero, 0)
    	local toss = NPC.GetAbilityByIndex(myHero, 1)
    	local myMana = NPC.GetMana(myHero)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, 275) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
					return
				end
			end
		else
			FAIO_itemHandler.itemUsage(myHero, enemy)
			if avalanche and Ability.IsCastable(avalanche, myMana) then 
				Ability.CastPosition(avalanche, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
			end
    			if FAIO.SleepReady(0.2) and toss and Ability.IsCastable(toss, myMana) then 
				Ability.CastTarget(toss, enemy)
				return 
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
end

function FAIO.WindRunnerCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroWindrunner) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local shackleShot = NPC.GetAbilityByIndex(myHero, 0)
	local windRun = NPC.GetAbilityByIndex(myHero, 2)
	local focusFire = NPC.GetAbility(myHero, "windrunner_focusfire")
	local myMana = NPC.GetMana(myHero)
	
	local branch = NPC.GetItem(myHero, "item_branches", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if FAIO.canEnemyBeShackledWithTree(myHero, enemy) == true or FAIO.getEnemyBeShackledWithNPC(myHero, enemy) ~= nil then
		FAIO.enemyCanBeShackled = true
	else
		FAIO.enemyCanBeShackled = false
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if FAIO.getEnemyBeShackledWithNPC(myHero, enemy) ~= nil then
			if shackleShot and Ability.IsCastable(shackleShot, myMana) then
				Ability.CastTarget(shackleShot, FAIO.getEnemyBeShackledWithNPC(myHero, enemy))
				return
			end
		elseif FAIO.canEnemyBeShackledWithTree(myHero, enemy) == true then
			if shackleShot and Ability.IsCastable(shackleShot, myMana) then
				Ability.CastTarget(shackleShot, enemy)
				return
			end
		else
			if FAIO.getEnemyShackledBestPosition(myHero, enemy, 1150):__tostring() ~= Vector():__tostring() then
				if blink and Ability.IsReady(blink) and Menu.IsEnabled(FAIO_options.optionHeroWindrunnerBlinkShackle) then
					Ability.CastPosition(blink, FAIO.getEnemyShackledBestPosition(myHero, enemy, 1150))
					return
				end

			else
				if Menu.IsEnabled(FAIO_options.optionHeroWindrunnerBranchShackle) then
					if branch and NPC.IsEntityInRange(myHero, enemy, 750) then
						if blink and Ability.IsReady(blink) then	
							if shackleShot and Ability.IsCastable(shackleShot, myMana) then
								Ability.CastTarget(shackleShot, enemy)
								return
							end
							if blink and Ability.IsReady(blink) and not Ability.IsReady(shackleShot) then
								Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Rotated(Angle(0,45,0)):Normalized():Scaled(200))
								Ability.CastPosition(branch, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(150))
								return
							end
						end
					end
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

	if NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then

			local shackleMod = NPC.GetModifier(enemy, "modifier_windrunner_shackle_shot")
				if not shackleMod then return end
			local shackleTime = Modifier.GetCreationTime(shackleMod) + Modifier.GetDuration(shackleMod)

			if NPC.HasModifier(enemy, "modifier_windrunner_shackle_shot") and Modifier.GetDuration(shackleMod) >= 1.5 and Menu.IsEnabled(FAIO_options.optionHeroWindrunnerUlt) then
				if focusFire and Ability.IsCastable(focusFire, myMana) then
					Ability.CastTarget(focusFire, enemy)
					return
				end
				if Menu.GetValue(FAIO_options.optionHeroWindrunnerWind) > 0 then
					if windRun and Ability.IsCastable(windRun, myMana) and #NPC.GetHeroesInRadius(myHero, 600, Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroWindrunnerWind) then
						Ability.CastNoTarget(windRun)
						return
					end
				end
			end
		end
	end
	
end

function FAIO.windrunnerDrawShackleIndicator(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionWindrunnerDrawIndicator) then return end
	
	if FAIO.enemyCanBeShackled == false then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	if visible then
		Renderer.SetDrawColor(50,205,50,255)
		Renderer.DrawText(FAIO.font, x-30, y-80, "shackle", 0)
	end
		
end

function FAIO.TimberCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroTimber) then return end
	
	if (os.clock() - FAIO.lastTick) < FAIO.delay then return end

	local whirlingDeath = NPC.GetAbilityByIndex(myHero, 0)
	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
	local chakram = NPC.GetAbility(myHero, "shredder_chakram")
	local chakramReturn = NPC.GetAbility(myHero, "shredder_return_chakram")
	local chakramAgha = NPC.GetAbility(myHero, "shredder_chakram_2")
	local chakramAghaReturn = NPC.GetAbility(myHero, "shredder_return_chakram_2")

	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)
	
	local myMana = NPC.GetMana(myHero)

	local rangeChecker = 500
	if blink and Ability.IsReady(blink) then
		rangeChecker = 1150
	end

	if Menu.GetValue(FAIO_options.optionHeroTimberWhirling) > 0 and FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then
		if enemy and NPC.IsEntityInRange(myHero, enemy, 270) then
			if whirlingDeath and Ability.IsCastable(whirlingDeath, myMana) then
				if (NPC.HasModifier(myHero, "modifier_shredder_timer_chain") and #Trees.InRadius(enemy, 270, true) > 0) then
					if #Trees.InRadius(myHero, 270, true) > 0 then
						Ability.CastNoTarget(whirlingDeath)
						FAIO.makeDelay(0.1)
						return
					end
				else
					if Menu.GetValue(FAIO_options.optionHeroTimberWhirling) == 2 then
						Ability.CastNoTarget(whirlingDeath)
						FAIO.makeDelay(0.1)
						return
					else
						if Menu.IsKeyDown(FAIO_options.optionComboKey) then
							Ability.CastNoTarget(whirlingDeath)
							FAIO.makeDelay(0.1)
							return
						end
					end
				end
			end
		end
	end

	FAIO_itemHandler.itemUsage(myHero, enemy)
	
	if enemy and Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if FAIO.TimberIsTreeInRangeForChain(myHero, enemy) ~= nil or FAIO.TimberGetBestChainPos(myHero, enemy, rangeChecker):__tostring() ~= Vector():__tostring() then
			if FAIO.TimberIsTreeInRangeForChain(myHero, enemy) ~= nil then
				if timberChain and Ability.IsCastable(timberChain, myMana) then
					Ability.CastPosition(timberChain, Entity.GetAbsOrigin(FAIO.TimberIsTreeInRangeForChain(myHero, enemy)))
					FAIO.lastCastTime3 = GameRules.GetGameTime() + (((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() + 275) / (1200 + Ability.GetLevel(timberChain) * 400))
					FAIO.makeDelay(0.1)
					return
				end
			else
				if blink and Ability.IsReady(blink) and Menu.IsEnabled(FAIO_options.optionHeroTimberBlink) then
					if FAIO.TimberGetBestChainPos(myHero, enemy, rangeChecker):__tostring() ~= Vector():__tostring() then
						Ability.CastPosition(blink, FAIO.TimberGetBestChainPos(myHero, enemy, 1150))
						return
					end
				elseif (not blink or (blink and not Ability.IsReady(blink)) or not Menu.IsEnabled(FAIO_options.optionHeroTimberBlink)) and Ability.IsReady(timberChain) then
					if FAIO.TimberGetBestChainPos(myHero, enemy, rangeChecker):__tostring() ~= Vector():__tostring() then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, FAIO.TimberGetBestChainPos(myHero, enemy, 500), myHero)
						return
					else
						if Ability.IsReady(timberChain) then
							FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
							return
						end
					end
				end
			end
		else
			if Menu.IsEnabled(FAIO_options.optionHeroTimberUlt) and NPC.IsEntityInRange(myHero, enemy, 700) then
				if GameRules.GetGameTime() < FAIO.lastCastTime3 then
					return
				else
					if not Ability.IsHidden(chakram) and not Ability.IsInAbilityPhase(timberChain) then
						if chakram and Ability.IsCastable(chakram, myMana) then
							local chakramPrediction = Ability.GetCastPoint(chakram) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 900) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
							Ability.CastPosition(chakram, FAIO_utility_functions.castLinearPrediction(myHero, enemy, chakramPrediction))
							FAIO.lastCastTime = 1
							FAIO.makeDelay(0.3)
							return
						end
					elseif not Ability.IsHidden(chakramAgha) and Ability.IsHidden(chakram) and not Ability.IsInAbilityPhase(timberChain) then
						if chakramAgha and Ability.IsCastable(chakramAgha, myMana) then
							local chakramPrediction = Ability.GetCastPoint(chakram) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 900) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
							Ability.CastPosition(chakramAgha, FAIO_utility_functions.castLinearPrediction(myHero, enemy, chakramPrediction))
							FAIO.lastCastTime2 = 1
							FAIO.makeDelay(0.3)
							return
						end
					end
				end
			end
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		end
	end

	if enemy then
		if not Ability.IsHidden(chakramReturn) and FAIO.lastCastTime == 1 and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if chakramReturn and Ability.IsCastable(chakramReturn, myMana) and (Ability.SecondsSinceLastUse(chakram) >= 1 and not NPC.HasModifier(enemy, "modifier_shredder_chakram_debuff")) or (NPC.HasModifier(enemy, "modifier_shredder_chakram_debuff") and Ability.SecondsSinceLastUse(chakram) >= (Menu.GetValue(FAIO_options.optionHeroTimberUltTiming) * 0.5)) then
				Ability.CastNoTarget(chakramReturn)
				FAIO.lastCastTime = 0
				FAIO.makeDelay(0.3)
				return
			end
		end
		if not Ability.IsHidden(chakramAghaReturn) and FAIO.lastCastTime2 == 1 and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if chakramAghaReturn and Ability.IsCastable(chakramAghaReturn, myMana) and (Ability.SecondsSinceLastUse(chakramAgha) >= 1 and not NPC.HasModifier(enemy, "modifier_shredder_chakram_debuff")) or (NPC.HasModifier(enemy, "modifier_shredder_chakram_debuff") and Ability.SecondsSinceLastUse(chakramAgha) >= (Menu.GetValue(FAIO_options.optionHeroTimberUltTiming) * 0.5)) then
				Ability.CastNoTarget(chakramAghaReturn)
				FAIO.lastCastTime2 = 0
				FAIO.makeDelay(0.3)
				return
			end
		end
	else
		if not Ability.IsHidden(chakramReturn) and FAIO.lastCastTime == 1 and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if chakramReturn and Ability.IsCastable(chakramReturn, myMana) and Ability.SecondsSinceLastUse(chakram) >= 1 then
				Ability.CastNoTarget(chakramReturn)
				FAIO.lastCastTime = 0
				FAIO.makeDelay(0.1)
				return
			end
		end
		if not Ability.IsHidden(chakramAghaReturn) and FAIO.lastCastTime2 == 1 and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if chakramAghaReturn and Ability.IsCastable(chakramAghaReturn, myMana) and Ability.SecondsSinceLastUse(chakramAgha) >= 1 then
				Ability.CastNoTarget(chakramAghaReturn)
				FAIO.lastCastTime2 = 0
				FAIO.makeDelay(0.1)
				return
			end
		end
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroTimberPanicKey) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if FAIO.TimberPanic(myHero) ~= nil then
			Ability.CastPosition(timberChain, Entity.GetAbsOrigin(FAIO.TimberPanic(myHero)))
			return
		end
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroTimberFastMoveKey) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if FAIO.TimberFastMove(myHero) ~= nil then
			Ability.CastPosition(timberChain, Entity.GetAbsOrigin(FAIO.TimberFastMove(myHero)))
			return
		else
			FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Input.GetWorldCursorPos(), myHero)
			return
		end
	end		

end

function FAIO.TimberFastMove(myHero)

	if not myHero then return end

	local myMana = NPC.GetMana(myHero)
	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return end
		if not Ability.IsCastable(timberChain, myMana) then return end

	local chainCastRange = Ability.GetCastRange(timberChain)

	local cursorPos = Input.GetWorldCursorPos()

	local chainTree
	local minDis = 99999

	if next(FAIO.TimberGetTreesFastMoveCursor(myHero)) ~= nil then
		chainTree = FAIO.TimberGetTreesFastMoveCursor(myHero)[1][2]
	end

	if chainTree ~= nil then
		return chainTree
	end
	return

end

function FAIO.TimberPanic(myHero)

	if not myHero then return end

	local myMana = NPC.GetMana(myHero)

	local timberChain = NPC.GetAbilityByIndex(myHero, 1)
		if not timberChain then return end
		if not Ability.IsCastable(timberChain, myMana) then return end

	local chainCastRange = Ability.GetCastRange(timberChain)

	local chainTree
	local minDis = 99999
	local maxDis = 0

	if Menu.GetValue(FAIO_options.optionHeroTimberPanicDir) < 2 then
		if Menu.GetValue(FAIO_options.optionHeroTimberPanicDir) == 0 then
			if next(FAIO.TimberGetEscapeChainTreesFountain(myHero)) ~= nil then
				chainTree = FAIO.TimberGetEscapeChainTreesFountain(myHero)[1][2]
			end
		else
			if next(FAIO.TimberGetEscapeChainTrees(myHero)) ~= nil then
				chainTree = FAIO.TimberGetEscapeChainTrees(myHero)[1][2]
			end
		end
	else
		local tree = Input.GetNearestTreeToCursor(true)
		if tree ~= nil then
			local dismyHeroToTree = (Entity.GetAbsOrigin(tree) - Entity.GetAbsOrigin(myHero)):Length2D()
			if dismyHeroToTree < chainCastRange then
				chainTree = tree
			else
				if FAIO.TimberFastMove(myHero) ~= nil then
					chainTree = FAIO.TimberFastMove(myHero)
				end
			end
		end
	end

	if chainTree ~= nil then
		return chainTree
	end
	return

end

function FAIO.EmberCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroEmber) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local chains = NPC.GetAbility(myHero, "ember_spirit_searing_chains")
	local fist = NPC.GetAbility(myHero, "ember_spirit_sleight_of_fist")
	local flameGuard = NPC.GetAbility(myHero, "ember_spirit_flame_guard")
	local activeRemnant = NPC.GetAbility(myHero, "ember_spirit_activate_fire_remnant")
	local remnant = NPC.GetAbility(myHero, "ember_spirit_fire_remnant")
	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	local remnantModifier = NPC.GetModifier(myHero, "modifier_ember_spirit_fire_remnant_charge_counter")

	local fistRange = 650
		if fist then
			fistRange = fistRange + Ability.GetLevelSpecialValueFor(fist, "radius")
		end
		
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local myPos = Entity.GetAbsOrigin(myHero)
	if NPC.HasModifier(myHero, "modifier_ember_spirit_sleight_of_fist_caster_invulnerability") then
		if chains and Ability.IsCastable(chains, myMana) then
			if NPC.IsEntityInRange(myHero, enemy, 85) then
				Ability.CastNoTarget(chains)
			end
		end
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, fistRange) then
			if blink and Ability.IsReady(blink) and not NPC.HasModifier(myHero, "modifier_ember_spirit_sleight_of_fist_caster_invulnerability") and NPC.IsEntityInRange(myHero, enemy, 1150 + fistRange) then
				Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(math.abs((Entity.GetAbs(Origin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() - 1150)))))
				return
			end
		else
			
			if fist and Ability.IsCastable(fist, myMana) then
				FAIO.noItemCastFor(0.5)
				if NPC.IsEntityInRange(myHero, enemy, 650) then
					Ability.CastPosition(fist, Entity.GetAbsOrigin(enemy))
				else
					Ability.CastPosition(fist, (Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(690)))
				end
			end

			if flameGuard and Ability.IsCastable(flameGuard, myMana) and not NPC.HasModifier(myHero, "modifier_ember_spirit_sleight_of_fist_caster_invulnerability") and NPC.HasModifier(enemy, "modifier_ember_spirit_searing_chains") then
				Ability.CastNoTarget(flameGuard)
			end
	
			if remnant and Ability.IsReady(remnant) and not NPC.HasModifier(myHero, "modifier_ember_spirit_sleight_of_fist_caster_invulnerability") and NPC.GetMana(myHero) >= Ability.GetManaCost(activeRemnant) and NPC.HasModifier(enemy, "modifier_ember_spirit_searing_chains") then
				local remnantCharges = Modifier.GetStackCount(remnantModifier)
				if Menu.GetValue(FAIO_options.optionHeroEmberUlt) == 0 then
					if remnantCharges == 3 then
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()			
					end
					if remnantCharges == 2 then
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
					end
					if remnantCharges == 1 then
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
					end
				end
				if Menu.GetValue(FAIO_options.optionHeroEmberUlt) == 1 then
					if remnantCharges > 2 and FAIO.SleepReady(3) then
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
					end
					if remnantCharges >= 2 and FAIO.SleepReady(3) then
						Ability.CastPosition(remnant, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
					end
				end
			end
			if activeRemnant and Ability.IsCastable(activeRemnant, myMana) and NPC.HasModifier(myHero, "modifier_ember_spirit_fire_remnant_timer") and NPC.HasModifier(enemy, "modifier_ember_spirit_searing_chains") then
				for i = 1, NPCs.Count() do 
				local npc = NPCs.Get(i)
					if npc and npc ~= myHero and Entity.IsSameTeam(myHero, npc) then
						if Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero) then
							if NPC.GetUnitName(npc) == "npc_dota_ember_spirit_remnant" then
								if NPC.IsEntityInRange(npc, enemy, 350) then
									Ability.CastPosition(activeRemnant, Entity.GetAbsOrigin(npc))
									break
								end
							end
						end
					end
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end	
end

function FAIO.UrsaCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroUrsa) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local earthShock = NPC.GetAbilityByIndex(myHero, 0)
	local overPower = NPC.GetAbilityByIndex(myHero, 1)
	local enrage = NPC.GetAbility(myHero, "ursa_enrage")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local earthShockOffset = 315
		if NPC.IsRunning(enemy) then
			earthShockOffset = 200
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if FAIO.heroCanCastSpells(myHero, enemy) == true then
			if overPower and Ability.IsCastable(overPower, myMana) and NPC.IsEntityInRange(myHero, enemy, 1200) and not NPC.HasModifier(myHero, "modifier_ursa_overpower") then
				Ability.CastNoTarget(overPower)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.2) then
				if not NPC.IsEntityInRange(myHero, enemy, earthShockOffset) then
					if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
						return
					end
				else
					if earthShock and Ability.IsCastable(earthShock, myMana) then
						Ability.CastNoTarget(earthShock)
						FAIO.lastTick = os.clock()
						return
					end
					if Menu.IsEnabled(FAIO_options.optionHeroUrsaEnrageCombo) then
						if enrage and Ability.IsCastable(enrage, myMana) then
							Ability.CastNoTarget(enrage)
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end
		end
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		return
	end

	if Menu.IsEnabled(FAIO_options.optionHeroUrsaEnrage) then
		if enrage and Ability.IsCastable(enrage, myMana) then
			if FAIO.isHeroChannelling(myHero) == false and FAIO.IsHeroInvisible(myHero) == false then		
				if (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)) <= (Menu.GetValue(FAIO_options.optionHeroUrsaEnrageHP) / 100) and #NPC.GetHeroesInRadius(myHero, 650, Enum.TeamType.TEAM_ENEMY) >= Menu.GetValue(FAIO_options.optionHeroUrsaEnrageEnemies) then
					if FAIO.SleepReady(0.25) then
						Ability.CastNoTarget(enrage)
						return
					end
				end
			end
		end
	end
end

function FAIO.TACombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroTA) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local refraction = NPC.GetAbilityByIndex(myHero, 0)
	local meld = NPC.GetAbilityByIndex(myHero, 1)
	local psionicTrap = NPC.GetAbility(myHero, "templar_assassin_psionic_trap")
	local trap = NPC.GetAbility(myHero, "templar_assassin_trap")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local myAttackRange = NPC.GetAttackRange(myHero)
		if NPC.HasItem(myHero, "item_dragon_lance", true) or NPC.HasItem(myHero, "item_hurricane_pike", true) then
			myAttackRange = myAttackRange + 140
		end

	local refractionModifier = NPC.GetModifier(myHero, "modifier_templar_assassin_refraction_damage")
	local meldModifier = NPC.GetModifier(myHero, "modifier_templar_assassin_meld")

	if Menu.IsEnabled(FAIO_options.optionHeroTAHarass) then
		if Menu.IsKeyDown(FAIO_options.optionHeroTAHarassKey) then
			if FAIO.TApsiBladesSpill(myHero, enemy, myAttackRange) ~= nil then
				local spillNPC = FAIO.TApsiBladesSpill(myHero, enemy, myAttackRange)
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", spillNPC, nil)
				return
			else
				if FAIO.TApsiBladesSpillBestPos(myHero, enemy, myAttackRange, Menu.GetValue(FAIO_options.optionHeroTAHarassRange)):__tostring() ~= Vector():__tostring() then
					local movePos = FAIO.TApsiBladesSpillBestPos(myHero, enemy, myAttackRange, Menu.GetValue(FAIO_options.optionHeroTAHarassRange))
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, movePos)
					return
				end
			end
		end
	end		

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if NPC.IsEntityInRange(myHero, enemy, (1200 + myAttackRange/2)) then
			if refraction and Ability.IsCastable(refraction, myMana) then
				Ability.CastNoTarget(refraction)
			end
			if psionicTrap and Ability.IsCastable(psionicTrap, myMana) then
				Ability.CastPosition(psionicTrap, FAIO_utility_functions.castPrediction(myHero, enemy, Ability.GetCastPoint(psionicTrap) + 0.25 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)))
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.3) and trap and Ability.IsReady(trap) and Ability.SecondsSinceLastUse(psionicTrap) > 0 and Ability.SecondsSinceLastUse(psionicTrap) < 1 then
				Ability.CastNoTarget(trap)
				FAIO.lastTick = os.clock()
				return
			end
		end
		if not NPC.IsEntityInRange(myHero, enemy, myAttackRange) then
			if FAIO.SleepReady(0.3) then
				if FAIO.SleepReady(0.1) and blink and Ability.IsReady(blink) and Menu.IsEnabled(FAIO_options.optionHeroTABlink) and NPC.IsEntityInRange(myHero, enemy, (1150 + myAttackRange/2)) then
					Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(myAttackRange/2)))
					return
				end
			end
		else
			if FAIO.SleepReady(0.3) and meld and Ability.IsCastable(meld, myMana) then
				FAIO.noItemCastFor(0.1)
				Ability.CastNoTarget(meld)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.1) and NPC.HasModifier(myHero, "modifier_templar_assassin_meld") then
				Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
				FAIO.lastTick = os.clock()
				return
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
		
end

function FAIO.isEnemyInSpillRange(myHero, spillNPC, enemy, spillRange)

	if not spillNPC then return false end
	if not enemy then return false end

	if Entity.IsSameTeam(myHero, spillNPC) then
		if Entity.GetHealth(spillNPC) > 0.5 * Entity.GetMaxHealth(spillNPC) then
			return false 
		end
	end

	if NPC.IsRunning(spillNPC) then return false end

	local enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.75 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
		enemyPos:SetZ(0)

	local spillNPCpos = Entity.GetAbsOrigin(spillNPC)
		spillNPCpos:SetZ(0)

	local myPos = 	Entity.GetAbsOrigin(myHero)
		myPos:SetZ(0)

	if (spillNPCpos - enemyPos):Length2D() > spillRange then
		return false
	end

	local vecmyHeroTospillNPC = spillNPCpos - myPos
	local vecspillNPCToEnemy = enemyPos - spillNPCpos

	local searchPoint = spillNPCpos + vecmyHeroTospillNPC:Normalized():Scaled(vecspillNPCToEnemy:Length2D())

	if math.floor((enemyPos - searchPoint):Length2D()) <= 37 then
		return true
	end

	return false

end

function FAIO.TApsiBladesSpillBestPos(myHero, enemy, myAttackRange, searchRange)

	if not myHero then return Vector() end
	if not enemy then return Vector() end

	local myMana = NPC.GetMana(myHero)
	local psiBlades = NPC.GetAbility(myHero, "templar_assassin_psi_blades")
		if not psiBlades then return Vector() end
		if Ability.GetLevel(psiBlades) < 1 then return Vector() end

	local spillRange = Ability.GetLevelSpecialValueFor(psiBlades, "attack_spill_range")

	local enemyPos = FAIO_utility_functions.castPrediction(myHero, enemy, 0.75 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))

	local npcs = Entity.GetUnitsInRadius(myHero, myAttackRange+searchRange, Enum.TeamType.TEAM_BOTH)
		if next(npcs) == nil then return Vector() end

		local spillPos = Vector()
		local minRange = 99999
			
		for _, targetNPC in ipairs(npcs) do
			if targetNPC then
				if Entity.IsNPC(targetNPC) and not Entity.IsDormant(targetNPC) and (NPC.IsCreep(targetNPC) or NPC.IsLaneCreep(targetNPC) or NPC.IsNeutral(targetNPC)) and Entity.IsAlive(targetNPC) and not NPC.IsRunning(targetNPC) then
					local myDisToNPC = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(targetNPC)):Length()
					local myDisToEnemy = (Entity.GetAbsOrigin(myHero) - enemyPos):Length()
					local disEnemyToNPC = (enemyPos - Entity.GetAbsOrigin(targetNPC)):Length()
					if disEnemyToNPC < spillRange - 50 and myDisToNPC < myDisToEnemy then
						if ((Entity.IsSameTeam(myHero, targetNPC) and Entity.GetHealth(targetNPC) < 0.5 * Entity.GetMaxHealth(targetNPC)) or not Entity.IsSameTeam(myHero, targetNPC)) then
							local vecEnemyTospillNPC = Entity.GetAbsOrigin(targetNPC) - enemyPos
							local adjustedNPCPos = Entity.GetAbsOrigin(targetNPC) + vecEnemyTospillNPC:Normalized():Scaled(100)
							local searchPos = adjustedNPCPos + vecEnemyTospillNPC:Normalized():Scaled(myAttackRange - 105)
							local closestPoint = FAIO.GetClosestPoint(adjustedNPCPos, searchPos, Entity.GetAbsOrigin(myHero), true)
							local myDisToClostestPoint = (Entity.GetAbsOrigin(myHero) - closestPoint):Length()
							if myDisToClostestPoint < searchRange then
								if myDisToClostestPoint < minRange then
									spillPos = closestPoint
									minRange = myDisToClostestPoint
								end
							end
						end
					end
				end
			end
		end

		if spillPos:__tostring() ~= Vector():__tostring() and minRange > 25 then
			return spillPos
		end

	return Vector()

end

function FAIO.TApsiBladesSpill(myHero, enemy, myAttackRange)

	if not myHero then return end
	if not enemy then return end

	local myMana = NPC.GetMana(myHero)
	local psiBlades = NPC.GetAbility(myHero, "templar_assassin_psi_blades")
		if not psiBlades then return end
		if Ability.GetLevel(psiBlades) < 1 then return end

	local spillRange = Ability.GetLevelSpecialValueFor(psiBlades, "attack_spill_range")

	local npcs = Entity.GetUnitsInRadius(myHero, myAttackRange, Enum.TeamType.TEAM_BOTH)
		if next(npcs) == nil then return end

		local spillNPC
			
		for _, targetNPC in ipairs(npcs) do
			if targetNPC then
				if Entity.IsNPC(targetNPC) and not Entity.IsDormant(targetNPC) and (NPC.IsCreep(targetNPC) or NPC.IsLaneCreep(targetNPC) or NPC.IsNeutral(targetNPC)) and Entity.IsAlive(targetNPC) then
					if FAIO.isEnemyInSpillRange(myHero, targetNPC, enemy, spillRange) == true then
						spillNPC = targetNPC
					end
				end
			end
		end

		if spillNPC then
			return spillNPC
		end
	
	return

end

function FAIO.LegionCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroLegion) then return end

	local odds = NPC.GetAbilityByIndex(myHero, 0)
	local pressTheAttack = NPC.GetAbilityByIndex(myHero, 1)
    	local duel = NPC.GetAbility(myHero, "legion_commander_duel")

	local Blademail = NPC.GetItem(myHero, "item_blade_mail", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroLegionAutoSave) then
		FAIO.LegionSaveAlly(myHero, myMana, pressTheAttack)
	end

	if enemy and Entity.IsAlive(enemy) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) then
			if FAIO.heroCanCastSpells(myHero, enemy) == true then 
				if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk")) then
					if not NPC.IsEntityInRange(myHero, enemy, Menu.GetValue(FAIO_options.optionHeroLegionBlinkRange)) then
						if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1199) then
							if Blademail and Ability.IsCastable(Blademail, myMana) and Ability.IsCastable(duel, myMana) then
								Ability.CastNoTarget(Blademail)
								return
							end
							if pressTheAttack and Ability.IsCastable(pressTheAttack, myMana) then
								Ability.CastTarget(pressTheAttack, myHero)
								FAIO.lastTick = os.clock()
								return
							end
							if FAIO.SleepReady(0.2) then
								Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
								return
							end
						end
					end

					if NPC.IsEntityInRange(myHero, enemy, 200) then
						if Blademail and Ability.IsCastable(Blademail, myMana) and Ability.IsCastable(duel, myMana) then
							Ability.CastNoTarget(Blademail)
							return
						end
						if NPC.IsLinkensProtected(enemy) then
							if FAIO.LinkensBreakerNew(myHero) ~= nil then
								Ability.CastTarget(NPC.GetItem(myHero, FAIO.LinkensBreakerNew(myHero), true), enemy)
								return
							end
						end
						if NPC.IsStunned(enemy) then
							if pressTheAttack and Ability.IsCastable(pressTheAttack, myMana) then
								Ability.CastTarget(pressTheAttack, myHero)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
					if NPC.IsEntityInRange(myHero, enemy, 150) then
						if duel and Ability.IsCastable(duel, myMana) then
							if NPC.HasItem(myHero, "item_armlet", true) and Menu.IsEnabled(FAIO_options.optionItemArmlet) and Menu.IsEnabled(FAIO_options.optionItemArmletCombo) then
								if FAIO_itemHandler.armletCurrentHPGain > 0 then
									Ability.CastTarget(duel, enemy)
									return
								end
							else
								Ability.CastTarget(duel, enemy)
								return
							end
						end
					end
				end
			end
			if duel and Ability.IsReady(duel) and Ability.IsCastable(duel, myMana) and FAIO.heroCanCastSpells(myHero, enemy) == true and not NPC.IsEntityInRange(myHero, enemy, 150) then
				local rotationVec = Entity.GetRotation(enemy):GetForward():Normalized()
				local pos = Entity.GetAbsOrigin(enemy) + rotationVec:Scaled(100)
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, pos)
			else	
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			end
		end
	end

		

end

function FAIO.LegionSaveAlly(myHero, myMana, pressTheAttack)

	if not myHero then return end
	if not pressTheAttack then return end
		if not Ability.IsCastable(pressTheAttack, myMana) then return end

	if FAIO.heroCanCastItems(myHero) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end
	if FAIO.IsHeroInvisible(myHero) == true then return end

	local teamMatesAround = NPC.GetHeroesInRadius(myHero, 690, Enum.TeamType.TEAM_FRIEND)
	if next(teamMatesAround) ~= nil then
		for _, ally in ipairs(teamMatesAround) do
			if ally and Entity.IsHero(ally) and not NPC.IsIllusion(ally) and Entity.IsAlive(ally) then
				if FAIO.IsNPCinDanger(myHero, ally) then
					Ability.CastTarget(pressTheAttack, ally)
					break
					return
				end
			end
		end
	end

end

function FAIO.SlardarCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSlardar) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local sprint = NPC.GetAbilityByIndex(myHero, 0)
	local crush = NPC.GetAbilityByIndex(myHero, 1)
	local haze = NPC.GetAbility(myHero, "slardar_amplify_damage")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local crushRadius = 300
		if NPC.IsRunning(enemy) then
			crushRadius = 200
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, crushRadius) then
			if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk")) then
				if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) then
					if Menu.GetValue(FAIO_options.optionHeroSlardarStyle) == 0 then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
						return
					else
						local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 660, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 330)
						if bestPos ~= nil then
							Ability.CastPosition(blink, bestPos)
							return
						end
					end
				end
			end
			if NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") then
				if FAIO.SleepReady(0.1) then
					Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
					FAIO.lastTick = os.clock()
					return
				end
			end
		else
			
			if NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") then
				if FAIO.SleepReady(0.1) then
					Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
					FAIO.lastTick = os.clock()
					return
				end
			else
				
				if crush and Ability.IsCastable(crush, myMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					Ability.CastNoTarget(crush)
					FAIO.lastTick = os.clock()
					return
				end
				if FAIO.SleepReady(0.3) and NPC.IsLinkensProtected(enemy) then
					if FAIO.LinkensBreakerNew(myHero) ~= nil then
						Ability.CastTarget(NPC.GetItem(myHero, FAIO.LinkensBreakerNew(myHero), true), enemy)
						return
					end
				end
				if FAIO.SleepReady(0.3) and haze and Ability.IsCastable(haze, myMana) and NPC.HasModifier(enemy, "modifier_stunned") then
					Ability.CastTarget(haze, enemy)
					return
				end
				if not NPC.IsStunned(enemy) and not Ability.IsReady(crush) then
					if NPC.GetMoveSpeed(enemy) + 20 > NPC.GetMoveSpeed(myHero) then
						if sprint and Ability.IsCastable(sprint, myMana) then
							Ability.CastNoTarget(sprint)
							return
						end
					end
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
end

function FAIO.ClinkzCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroClinkz) then return end

	local strafe = NPC.GetAbilityByIndex(myHero, 0)
	local searingArrows = NPC.GetAbilityByIndex(myHero, 1)
	local skeletonWalk = NPC.GetAbilityByIndex(myHero, 2)
	local deathPact = NPC.GetAbility(myHero, "clinkz_death_pact")

	local myMana = NPC.GetMana(myHero)
	local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroClinkzHarass) then
		if Menu.IsKeyDown(FAIO_options.optionHeroClinkzHarassKey) then
			FAIO.ClinkzAutoHarass(myHero, myMana, searingArrows)
		end
	end
	
	if enemy then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
			if NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
				if strafe and Ability.IsCastable(strafe, myMana) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					Ability.CastNoTarget(strafe)
					return
				end
			end
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		end
	end					
end



function FAIO.ClinkzAutoHarass(myHero, myMana, searingArrows)

	if not myHero then return end

	if not searingArrows then return end
		if Ability.GetLevel(searingArrows) < 1 then return end
		if not Ability.IsCastable(searingArrows, myMana) then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

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
			Ability.CastTarget(searingArrows, harassTarget)
			return
		else
			if not NPC.IsPositionInRange(myHero, mousePos, 50, 0) then
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
				return
			end
		end
	else
		if not NPC.IsPositionInRange(myHero, mousePos, 50, 0) then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
			return
		end
	end

	return

end

function FAIO.ClinkzAutoUlt(myHero)

	if not myHero then return end

	if not Menu.IsEnabled(FAIO_options.optionHeroClinkz) then return end
	if (os.clock() - FAIO.lastTick) < FAIO.delay then return end

	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	
	local myMana = NPC.GetMana(myHero)

	local deathPact = NPC.GetAbility(myHero, "clinkz_death_pact")
		if not deathPact then return end
		if not Ability.IsCastable(deathPact, myMana) then return end

	local maxHPcreep
	local maxHP = 0
	for _, creeps in ipairs(NPC.GetUnitsInRadius(myHero, 380, Enum.TeamType.TEAM_ENEMY)) do
		if creeps then
			if Entity.IsHero(creeps) then 
				return 
			end
      			if FAIO_utility_functions.IsCreepAncient(creeps) == false and (NPC.IsCreep(creeps) or NPC.IsLaneCreep(creeps)) and Entity.GetMaxHealth(creeps) >= 550 and Entity.GetHealth(creeps) >= maxHP then
           			maxHPcreep = creeps
            			maxHP = Entity.GetMaxHealth(creeps)
        		end
   		end
	end

	if next(NPC.GetUnitsInRadius(myHero, 380, Enum.TeamType.TEAM_ENEMY)) == nil then
		maxHP = 0
	end

	if maxHPcreep then
		if not NPC.HasModifier(myHero, "modifier_clinkz_death_pact") then
			Ability.CastTarget(deathPact, maxHPcreep)
			FAIO.makeDelay(Ability.GetCastPoint(deathPact))
			return
		end
	end

end

function FAIO.QoPCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroQoP) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local shadowStrike = NPC.GetAbilityByIndex(myHero, 0)
	local qopBlink = NPC.GetAbilityByIndex(myHero, 1)
	local screamOfPain = NPC.GetAbilityByIndex(myHero, 2)
	local sonicWave = NPC.GetAbility(myHero, "queenofpain_sonic_wave")

	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.GetValue(FAIO_options.optionHeroQoPAutoUlt) > 0 then
		FAIO.QoPComboUltKS(myHero, sonicWave, aghanims, myMana)
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, 425) then
			if Menu.IsEnabled(FAIO_options.optionHeroQoPblink) then
				if qopBlink and Ability.IsCastable(qopBlink, myMana) and NPC.IsEntityInRange(myHero, enemy, 1500) then
					Ability.CastPosition(qopBlink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(350)))
					FAIO.lastTick = os.clock()
					return
				end
			end		
		else
			if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(shadowStrike) + NPC.GetCastRangeBonus(myHero)) then
				if FAIO.SleepReady(0.1) and shadowStrike and Ability.IsCastable(shadowStrike, myMana) then
					Ability.CastTarget(shadowStrike, enemy)
					FAIO.lastTick = os.clock()
					return
				end
			end
			if FAIO.SleepReady(0.1) and screamOfPain and Ability.IsCastable(screamOfPain, myMana) then
				Ability.CastNoTarget(screamOfPain)
				return
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

end

function FAIO.QoPComboUltKS(myHero, sonicWave, aghanims, myMana)

	if not myHero then return end

	if not sonicWave then return end
		if not Ability.IsCastable(sonicWave, myMana) then return end

	if Menu.GetValue(FAIO_options.optionHeroQoPAutoUlt) == 0	then return end

	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end

	for _, hero in ipairs(Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
		local target = FAIO.targetChecker(hero)
		if target and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") then
			if NPC.GetUnitName(target) == "npc_dota_hero_skeleton_king" then
				local reincarnation = NPC.GetAbility(target, "skeleton_king_reincarnation")
				if reincarnation and Ability.IsReady(reincarnation) then
					break
					return
				end
			end

			local sonicDamage
			if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
				sonicDamage = Ability.GetLevelSpecialValueFor(sonicWave, "damage_scepter")
			else
				sonicDamage = Ability.GetLevelSpecialValueFor(sonicWave, "damage")
			end
			if Menu.GetValue(FAIO_options.optionHeroQoPAutoUlt) == 1 then
				if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
					if Entity.GetHealth(target) <= sonicDamage then
						Ability.CastPosition(sonicWave, (Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(target) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(600)))
						break
						return
					end
				end
			elseif Menu.GetValue(FAIO_options.optionHeroQoPAutoUlt) == 2 then
				if Entity.GetHealth(target) <= sonicDamage then
					Ability.CastPosition(sonicWave, (Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(target) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(600)))
					break
					return
				end
			end
		end
	end

end

function FAIO.SvenCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroSven) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local stormHammer = NPC.GetAbilityByIndex(myHero, 0)
	local warCry = NPC.GetAbilityByIndex(myHero, 2)
	local godsStrength = NPC.GetAbility(myHero, "sven_gods_strength")

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local maskOfMadness = NPC.GetItem(myHero, "item_mask_of_madness", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if not NPC.IsEntityInRange(myHero, enemy, 450) then
			if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk")) then
				if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					if warCry and Ability.IsCastable(warCry, myMana) then
						Ability.CastNoTarget(warCry)
						return
					end
					if godsStrength and Ability.IsCastable(godsStrength, myMana) then
						Ability.CastNoTarget(godsStrength)
						FAIO.lastTick = os.clock()
						return
					end
					if FAIO.SleepReady(0.05) then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
						return
					end
				end
			end
			if NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") and FAIO.heroCanCastSpells(myHero, enemy) == true then
				if FAIO.SleepReady(0.1) then
					Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
					FAIO.lastTick = os.clock()
					return
				end
			end
		else
			if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk")) then
				
				if NPC.IsLinkensProtected(enemy) then
					if FAIO.LinkensBreakerNew(myHero) ~= nil then
						Ability.CastTarget(NPC.GetItem(myHero, FAIO.LinkensBreakerNew(myHero), true), enemy)
						return
					end
				end
				if stormHammer and Ability.IsCastable(stormHammer, myMana) and not (NPC.IsLinkensProtected(enemy) or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					Ability.CastTarget(stormHammer, enemy)
					FAIO.lastTick = os.clock()
					return
				end
				if FAIO.SleepReady(0.3) and warCry and Ability.IsCastable(warCry, myMana) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					Ability.CastNoTarget(warCry)
					return
				end
				if FAIO.SleepReady(0.3) and godsStrength and Ability.IsCastable(godsStrength, myMana) and FAIO.heroCanCastSpells(myHero, enemy) == true then
					Ability.CastNoTarget(godsStrength)
					FAIO.lastTick = os.clock()
					return
				end
				if not (Ability.IsCastable(stormHammer, myMana) and Ability.IsCastable(warCry, myMana) and Ability.IsCastable(godsStrength, myMana)) then
					if FAIO.SleepReady(0.4) and maskOfMadness and Ability.IsCastable(maskOfMadness, myMana) then
						Ability.CastNoTarget(maskOfMadness)
						return
					end
				end
			end
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end

end

function FAIO.VisageCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroVisage) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local graveChill = NPC.GetAbilityByIndex(myHero, 0)
	local soulAssumption = NPC.GetAbilityByIndex(myHero, 1)
	local soulMaxStacks = Ability.GetLevelSpecialValueFor(soulAssumption, "stack_limit")
	local myMana = NPC.GetMana(myHero)

	local graveChillRange = 650
		if graveChill and Ability.GetCastRange(graveChill) > graveChillRange then
			graveChillRange = Ability.GetCastRange(graveChill)
		end

	local soulModifier = NPC.GetModifier(myHero, "modifier_visage_soul_assumption")
	local soulStackCounter 
		if soulModifier then
			soulStackCounter = Modifier.GetStackCount(soulModifier)
		end
	
	local familiars = NPC.GetAbility(myHero, "visage_summon_familiars")
	local familiarsLevel = Ability.GetLevel(familiars)

	if Menu.IsKeyDown(FAIO_options.optionHeroVisageInstStunKey) then
		if FAIO.VisageInstStunLockTarget == nil then
			if enemy and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then
				FAIO.VisageInstStunLockTarget = enemy
			else
				FAIO.VisageInstStunLockTarget = nil
			end
		end
	else
		FAIO.VisageInstStunLockTarget = nil
	end

	local familiarEntityTable = {}
	for i = 1, NPCs.Count() do
	local npc = NPCs.Get(i)
		if familiars then
			if npc and npc ~= myHero and Entity.IsSameTeam(myHero, npc) then
				if (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
					if NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. familiarsLevel then
						if not (NPC.HasModifier(npc, "modifier_visage_summonfamiliars_timer") or NPC.HasModifier(npc, "modifier_rooted")) then
							if Entity.IsAlive(npc) then
								if npc ~= nil then
									table.insert(familiarEntityTable, npc)
								end
							end
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroVisageKS) then
		FAIO.VisageSoulAssumptionKS(myHero, myMana, soulAssumption, soulStackCounter)
	end

	if not Menu.IsKeyDown(FAIO_options.optionHeroVisagePanicKey) then
		FAIO.VisagePanicTarget = nil
	end

	if next(familiarEntityTable) ~= nil then

		for _, familiarAttack in ipairs(familiarEntityTable) do
			if Menu.IsKeyDown(FAIO_options.optionComboKey) then
				if familiarAttack and not NPC.IsEntityInRange(familiarAttack, enemy, NPC.GetAttackRange(familiarAttack)) then
					FAIO.GenericAttackIssuer2("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, familiarAttack)
				end
			end
			if Menu.IsKeyDown(FAIO_options.optionHeroVisageInstStunKey) then
				if familiarAttack and not NPC.IsEntityInRange(familiarAttack, enemy, NPC.GetAttackRange(familiarAttack)) then
					FAIO.GenericAttackIssuer2("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", FAIO.VisageInstStunLockTarget, nil, familiarAttack)
				end
			end
		end

		for _, familiarStun in ipairs(familiarEntityTable) do
			if Menu.IsKeyDown(FAIO_options.optionComboKey) then
				if familiarStun and (os.clock() - FAIO.ControlledUnitCastTime) >= (Ability.GetLevelSpecialValueForFloat(NPC.GetAbilityByIndex(familiarStun, 0), "stun_duration") * (1 - (Hero.GetStrengthTotal(enemy) * 0.0015)) - 0.1 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)) then
					FAIO.VisageFamiliarControl(myHero, enemy, familiarStun, soulAssumption, soulMaxStacks, soulStackCounter, NPC.GetAbilityByIndex(familiarStun, 0), myMana)
					break
				end
			end
			if Menu.IsKeyDown(FAIO_options.optionHeroVisageInstStunKey) then
				if familiarStun and (os.clock() - FAIO.ControlledUnitCastTime) >= (Ability.GetLevelSpecialValueForFloat(NPC.GetAbilityByIndex(familiarStun, 0), "stun_duration") * (1 - (Hero.GetStrengthTotal(enemy) * 0.0015)) - 0.1 - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)) then
					FAIO.VisageFamiliarInstantStun(myHero, FAIO.VisageInstStunLockTarget, familiarStun, NPC.GetAbilityByIndex(familiarStun, 0), myMana)
					break
				end
			end

		end

		for _, familiarSave in ipairs(familiarEntityTable) do
			if Menu.IsEnabled(FAIO_options.optionHeroVisageFamiliarSave) then
				if familiarSave and Entity.GetHealth(familiarSave) < 0.5 * Entity.GetMaxHealth(familiarSave) then
					FAIO.VisageFamiliarAutoSaver(myHero, familiarSave, NPC.GetAbilityByIndex(familiarSave, 0))
					break
					return
				end
			end
		end	

		for _, familiarCancel in ipairs(familiarEntityTable) do
			if Menu.IsEnabled(FAIO_options.optionHeroVisageFamiliarCancel) then
				if familiarCancel and (os.clock() - FAIO.ControlledUnitCastTime) >= (Ability.GetLevelSpecialValueForFloat(NPC.GetAbilityByIndex(familiarCancel, 0), "stun_duration")) then
					FAIO.VisageFamiliarCancelChannelling(myHero, familiarCancel, NPC.GetAbilityByIndex(familiarCancel, 0))
					break
					return
				end
			end
		end	
		
		for _, familiarPanic in pairs(familiarEntityTable) do
			if Menu.IsKeyDown(FAIO_options.optionHeroVisagePanicKey) then
				if familiarPanic then
					FAIO.VisageFamiliarPanicStun(myHero, familiarPanic, NPC.GetAbilityByIndex(familiarPanic, 0))
				end
			end
		end

	end
	

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
		if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if NPC.IsEntityInRange(myHero, enemy, graveChillRange) then
				if graveChill and Ability.IsCastable(graveChill, myMana) then
					Ability.CastTarget(graveChill, enemy)
					FAIO.lastTick = os.clock()
					return
				end
				if FAIO.SleepReady(0.2) and soulAssumption and Ability.IsCastable(soulAssumption, myMana) then
					if soulMaxStacks <= soulStackCounter then
						Ability.CastTarget(soulAssumption, enemy)
						return
					end
				end
			end	
		end
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
end

function FAIO.VisageFamiliarControl(myHero, enemy, familiarEntity, soulAssumption, soulMaxStacks, soulStackCounter, stoneForm, myMana)

	if not familiarEntity then return end
	if not Entity.IsAlive(familiarEntity) then return end

	local familiarAttackCount = 0
		for i, v in pairs(FAIO.VisageFamiliarAttackCounter) do
			if v then
				if i == Entity.GetIndex(familiarEntity) then
					if GameRules.GetGameTime() > v[1] + 1 then
						FAIO.VisageFamiliarAttackCounter[i] = nil
						familiarAttackCount = 0
					else
						familiarAttackCount = v[2]
					end
				end
			end
		end

	local stunRange = 250
		if NPC.IsRunning(enemy) then
			stunRange = 75
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
			if stoneForm and Ability.IsReady(stoneForm) then
				if familiarAttackCount >= Menu.GetValue(FAIO_options.optionHeroVisageDMGStacks) then
					if not NPC.HasModifier(enemy, "modifier_rooted") or not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") then
						if NPC.IsEntityInRange(familiarEntity, enemy, stunRange) then
							FAIO.ControlledUnitCastTime = os.clock()
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, enemy, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
							return
						else
							if os.clock() - FAIO.lastCastTime2 > 0.1 then
								Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(75), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
								FAIO.lastCastTime2 = os.clock()
								return
							end
						end
					end
				end
			end
		if soulAssumption and Ability.IsCastable(soulAssumption, myMana) and NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)-50) then
			if soulMaxStacks <= soulStackCounter then
				Ability.CastTarget(soulAssumption, enemy)
			end
		end
	end
end

function FAIO.VisageFamiliarInstantStun(myHero, enemy, familiarEntity, stoneForm, myMana)

	if not myHero then return end
	if not enemy then return end

	if not familiarEntity then return end
	if not Entity.IsAlive(familiarEntity) then return end

	if not stoneForm then return end
		if not Ability.IsReady(stoneForm) then return end

	local stunRange = 250
		if NPC.IsRunning(enemy) then
			stunRange = 75
		end

	if Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		if stoneForm and Ability.IsReady(stoneForm) then
			if not NPC.HasModifier(enemy, "modifier_rooted") or not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") then
				if not NPC.IsEntityInRange(familiarEntity, enemy, stunRange) then
					if os.clock() - FAIO.lastCastTime2 > 0.1 then
						NPC.MoveTo(familiarEntity, Entity.GetAbsOrigin(enemy) + Entity.GetRotation(enemy):GetForward():Normalized():Scaled(75), false, false)
						FAIO.lastCastTime2 = os.clock()
						return
					end
				else
					FAIO.ControlledUnitCastTime = os.clock()
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, enemy, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
					return
				end
			end
		end
	end

end

function FAIO.VisageFamiliarPanicStun(myHero, familiarEntity, stoneForm)

	if not myHero then return end
	if not familiarEntity then return end

	if not stoneForm then return end

	for _, hero in ipairs(Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
		local target = FAIO.targetChecker(hero)
		if target and Entity.IsAlive(target) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
			if FAIO.VisagePanicTarget == nil or (FAIO.VisagePanicTarget ~= nil and NPC.GetUnitName(target) ~= FAIO.VisagePanicTarget) and not NPC.IsStunned(target) then

				if stoneForm and Ability.IsReady(stoneForm) then
					if not NPC.HasModifier(target, "modifier_rooted") or not NPC.HasModifier(target, "modifier_sheepstick_debuff") then
					local stunRange = 250
						if NPC.IsRunning(target) then
							stunRange = 75
						end
						if not NPC.IsEntityInRange(familiarEntity, target, stunRange) then
							FAIO.GenericAttackIssuer2("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", target, Entity.GetAbsOrigin(target) + Entity.GetRotation(target):GetForward():Normalized():Scaled(75), familiarEntity)
							return
						else
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET, myHero, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
							FAIO.VisagePanicTarget = NPC.GetUnitName(target)
							return
						end
					end
				end
			end
		end
	end

	if not Ability.IsReady(stoneForm) and not NPC.HasModifier(familiarEntity, "modifier_rooted") then
		Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET, myHero, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
	end
	
end

function FAIO.VisageSoulAssumptionKS(myHero, myMana, soulAssumption, soulStackCounter)

	if not myHero then return end

	if not soulAssumption then return end
		if not Ability.IsCastable(soulAssumption, myMana) then return end

	if not soulStackCounter then return end
	if soulStackCounter <= 1 then return end

	local soulAssumptionDMG = (20 + soulStackCounter * 65) * (1 + (Hero.GetIntellectTotal(myHero) / 14 / 100))

	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end

	for _, hero in ipairs(Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(soulAssumption) - 15, Enum.TeamType.TEAM_ENEMY)) do
		local target = FAIO.targetChecker(hero)
		if target and Entity.IsAlive(target) and not NPC.IsLinkensProtected(target) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(target, "modifier_templar_assassin_refraction_absorb") then
			if Entity.GetHealth(target) <= soulAssumptionDMG * (1 - NPC.GetMagicalArmorValue(target)) then
				Ability.CastTarget(soulAssumption, target)
				break
				return
			end
		end
	end

end

function FAIO.VisageFamiliarAutoSaver(myHero, familiarEntity, stoneForm)

	if not myHero then return end
	if not familiarEntity then return end
	if not Entity.IsAlive(familiarEntity) then return end

	if not stoneForm then return end
		if not Ability.IsReady(stoneForm) then return end

	 if Entity.GetHealth(familiarEntity) < Entity.GetMaxHealth(familiarEntity) * 0.33 then
	 	if stoneForm and Ability.IsReady(stoneForm) and not Ability.IsInAbilityPhase(stoneForm) and not NPC.IsStunned(familiarEntity) and not NPC.IsSilenced(familiarEntity) then
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET, myHero, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity, true)
			return
		end
	end	

end

function FAIO.VisageFamiliarCancelChannelling(myHero, familiarEntity, stoneForm)

	if not myHero then return end
	if not familiarEntity then return end
	if not Entity.IsAlive(familiarEntity) then return end

	if not stoneForm then return end
		if not Ability.IsReady(stoneForm) then return end

	local channellingTable = {
		npc_dota_hero_bane = { "bane_fiends_grip", { 5, 5, 5 } },
		npc_dota_hero_crystal_maiden = { "crystal_maiden_freezing_field", { 10, 10, 10} },
		npc_dota_hero_enigma = { "enigma_black_hole", { 4, 4, 4 } },
		npc_dota_hero_oracle = { "oracle_fortunes_end", { 2.5, 2.5, 2.5, 2.5 } },
		npc_dota_hero_pudge = { "pudge_dismember", { 3, 3, 3 } },
		npc_dota_hero_pugna = { "pugna_life_drain", { 10, 10, 10 } },
		npc_dota_hero_sand_king = { "sandking_epicenter", { 2, 2, 2} },
		npc_dota_hero_shadow_shaman = { "shadow_shaman_shackles", { 2.75, 3.5, 4.25, 5 } },
		npc_dota_hero_tinker = { "tinker_rearm", { 3, 1.5, 0.75 } },
		npc_dota_hero_warlock = { "warlock_upheaval", { 16, 16, 16, 16 } },
		npc_dota_hero_witch_doctor = { "witch_doctor_death_ward", { 8, 8, 8} }
				}
	
	local stunRange = 300

	local cancelEnemies = NPC.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)
	for _, cancelEnemy in ipairs(cancelEnemies) do
		if cancelEnemy and not NPC.IsDormant(cancelEnemy) and not NPC.IsIllusion(cancelEnemy) and Entity.IsAlive(cancelEnemy) then
			if not NPC.HasState(cancelEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				for i, v in pairs(channellingTable) do
					if (NPC.GetUnitName(cancelEnemy) == i and Ability.IsChannelling(NPC.GetAbility(cancelEnemy, v[1]))) then
						local channellingStartTime = Ability.GetChannelStartTime(NPC.GetAbility(cancelEnemy, v[1]))
						local channellingEndTime = channellingStartTime + v[2][Ability.GetLevel(NPC.GetAbility(cancelEnemy, v[1]))]
						local disToEnemy = (Entity.GetAbsOrigin(familiarEntity) - Entity.GetAbsOrigin(cancelEnemy)):Length2D() - 250
						local timeToStun = (disToEnemy / 430) + 0.6
						if stoneForm and Ability.IsReady(stoneForm) then
							if GameRules.GetGameTime() < channellingEndTime - timeToStun then
								if not NPC.IsEntityInRange(familiarEntity, cancelEnemy, stunRange) then
									if os.clock() - FAIO.lastCastTime2 > 0.1 then
										NPC.MoveTo(familiarEntity, Entity.GetAbsOrigin(cancelEnemy), false, false)
										FAIO.lastCastTime2 = os.clock()
										return
									end
								else
									FAIO.ControlledUnitCastTime = os.clock()
									Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
									break
									return
								end
							end
						end
					elseif NPC.HasModifier(cancelEnemy, "modifier_teleporting") then
						local teleportCreationTime = Modifier.GetCreationTime(NPC.GetModifier(cancelEnemy, "modifier_teleporting"))
						local teleportEndTime = teleportCreationTime + 3
						local disToEnemy = (Entity.GetAbsOrigin(familiarEntity) - Entity.GetAbsOrigin(cancelEnemy)):Length2D() - 250
						local timeToStun = (disToEnemy / 430) + 0.6
						if stoneForm and Ability.IsReady(stoneForm) then
							if GameRules.GetGameTime() < teleportEndTime - timeToStun then
								if not NPC.IsEntityInRange(familiarEntity, cancelEnemy, stunRange) then
									if os.clock() - FAIO.lastCastTime2 > 0.1 then
										NPC.MoveTo(familiarEntity, Entity.GetAbsOrigin(cancelEnemy), false, false)
										FAIO.lastCastTime2 = os.clock()
										return
									end
								else
									FAIO.ControlledUnitCastTime = os.clock()
									Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, familiarEntity)
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

function FAIO.ArcTempestTargetIndicator(myHero)

	if not myHero then return end

	if FAIO.ArcTempestLockedTarget ~= nil then
		local target = FAIO.ArcTempestLockedTarget
		
		if FAIO.ArcTempestLockedTargetParticle == 0 then
			local tempestParticle = Particle.Create("particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", Enum.ParticleAttachment.PATTACH_OVERHEAD_FOLLOW, target)
			FAIO.ArcTempestLockedTargetParticle = tempestParticle
			FAIO.ArcTempestLockedTargetParticleHero = target
		else
			if FAIO.ArcTempestLockedTargetParticleHero ~= target then
				Particle.Destroy(FAIO.ArcTempestLockedTargetParticle)
				FAIO.ArcTempestLockedTargetParticle = 0
			end
		end
	else
		if FAIO.ArcTempestLockedTargetParticle > 0 then
			Particle.Destroy(FAIO.ArcTempestLockedTargetParticle)
			FAIO.ArcTempestLockedTargetParticle = 0
		end			
	end

end

function FAIO.ArcWardenCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroArcWarden) then return end

	local flux = NPC.GetAbilityByIndex(myHero, 0)
	local magneticField = NPC.GetAbilityByIndex(myHero, 1)
	local sparkWraith = NPC.GetAbilityByIndex(myHero, 2)
	local tempestDouble = NPC.GetAbility(myHero, "arc_warden_tempest_double")

	local arcWardenAttackRange = NPC.GetAttackRange(myHero)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	
	for i = 1, NPCs.Count() do
        local npc = NPCs.Get(i)
		if tempestDouble then
			if npc and npc ~= myHero then
				if NPC.GetUnitName(npc) == "npc_dota_hero_arc_warden" then
					if NPC.HasModifier(npc, "modifier_arc_warden_tempest_double") then
						if npc ~= nil then
							if Entity.IsAlive(npc) then
								FAIO.ArcWardenEntity = npc
								FAIO.TempestDoubleHandler(myHero, enemy, npc, tempestDouble, myMana, arcWardenAttackRange)
							end
						end
					end
				end
			end
		end
	end

	local necronomicon = NPC.GetItem(myHero, "item_necronomicon", true)
	if not necronomicon then
		for i = 2, 3 do
			necronomicon = NPC.GetItem(myHero, "item_necronomicon_" .. i, true)
			if necronomicon then 
				break 
			end
		end
	end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if tempestDouble then
		if Ability.IsCastable(tempestDouble, myMana) then				
			if Menu.IsKeyDownOnce(FAIO_options.optionArcWardenTempestKey) and FAIO.heroCanCastSpells(myHero, enemy) == true then
				local tempestEnemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
				if tempestEnemy and NPC.IsPositionInRange(tempestEnemy, Input.GetWorldCursorPos(), 700, 0) then
					FAIO.ArcTempestLockedTarget = tempestEnemy
					FAIO.arcWardenPusher = false
				else
					FAIO.ArcTempestLockedTarget = nil
					FAIO.arcWardenStatus = 0
				end
				Ability.CastNoTarget(tempestDouble)
				return
			end
		end

		if FAIO.ArcWardenEntity ~= nil and Entity.IsAlive(FAIO.ArcWardenEntity) then
			local tempestEnemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
			if Menu.IsKeyDownOnce(FAIO_options.optionArcWardenTempestKey) then
				if FAIO.ArcTempestLockedTarget == nil then
					if tempestEnemy and NPC.IsPositionInRange(tempestEnemy, Input.GetWorldCursorPos(), 700, 0) then
						FAIO.ArcTempestLockedTarget = tempestEnemy
						FAIO.arcWardenPusher = false
					else
						FAIO.ArcTempestLockedTarget = nil
						FAIO.arcWardenStatus = 0
					end
				else
					if tempestEnemy ~= FAIO.ArcTempestLockedTarget and NPC.IsPositionInRange(tempestEnemy, Input.GetWorldCursorPos(), 700, 0) then
						FAIO.ArcTempestLockedTarget = tempestEnemy
						FAIO.arcWardenPusher = false
					else
						FAIO.ArcTempestLockedTarget = nil
						FAIO.arcWardenStatus = 0
					end
				end	
			end
	
			if FAIO.ArcTempestLockedTarget ~= nil then
				if not Entity.IsAlive(FAIO.ArcTempestLockedTarget) then
					FAIO.ArcTempestLockedTarget = nil
					FAIO.arcWardenStatus = 0
			--	elseif Entity.IsDormant(FAIO.ArcTempestLockedTarget) then
			--		FAIO.ArcTempestLockedTarget = nil
			--		FAIO.arcWardenStatus = 0
			--	elseif not NPC.IsEntityInRange(myHero, FAIO.ArcTempestLockedTarget, 3000) then
			--		FAIO.ArcTempestLockedTarget = nil
			--		FAIO.arcWardenStatus = 0
				end
			end
		else
			if not Ability.IsReady(tempestDouble) then
				FAIO.ArcTempestLockedTarget = nil
				FAIO.arcWardenStatus = 0
			end
		end

		if Menu.IsEnabled(FAIO_options.optionArcWardenTempestParticle) then
			FAIO.ArcTempestTargetIndicator(myHero)
		end
	end

	if Menu.IsKeyDownOnce(FAIO_options.optionArcWardenPushKey) then
		if FAIO.ArcTempestLockedTarget == nil then
			FAIO.arcWardenPusher = not FAIO.arcWardenPusher
		else
			FAIO.ArcTempestLockedTarget = nil
			FAIO.arcWardenPusher = not FAIO.arcWardenPusher
		end
	end

	if not tempestDouble then
		FAIO.arcWardenPusher = false
		FAIO.arcWardenStatus = 0
	else
		if not Ability.IsReady(tempestDouble) then
			if not FAIO.ArcWardenEntity or (FAIO.ArcWardenEntity and not Entity.IsAlive(FAIO.ArcWardenEntity)) then
				FAIO.arcWardenPusher = false
				FAIO.arcWardenStatus = 0
			end
		end
	end

	if not FAIO.arcWardenPusher and FAIO.ArcTempestLockedTarget == nil then
		if FAIO.arcWardenStatus > 1 then
			FAIO.arcWardenStatus = 0
		end
	end

	if FAIO.arcWardenPusher then
		if FAIO.heroCanCastSpells(myHero, enemy) == true then
			if tempestDouble and Ability.IsCastable(tempestDouble, myMana) then
				Ability.CastNoTarget(tempestDouble)
				return
			end
		end
	end

	if enemy and NPC.IsEntityInRange(myHero, enemy, 1600) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
			if FAIO.heroCanCastSpells(myHero, enemy) == true then
				if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk")) then
					if not NPC.IsEntityInRange(myHero, enemy, arcWardenAttackRange + Menu.GetValue(FAIO_options.optionArcWardenBlinkTrigger)) then
						if Menu.IsEnabled(FAIO_options.optionArcWardenMainBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionArcWardenBlinkRange)) then
							Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionArcWardenBlinkRange))))
							return
						end
					end

					if os.clock() > FAIO.lastTick then 
						if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
							if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(flux)) then
								if Menu.IsEnabled(FAIO_options.optionHeroArcWardenFlux) and flux and Ability.IsCastable(flux, myMana) and #NPC.GetHeroesInRadius(enemy, 225, Enum.TeamType.TEAM_FRIEND) < 1 then
									Ability.CastTarget(flux, enemy)
									FAIO.lastTick = os.clock() + 0.2
									return
								end
							end

							if Menu.IsEnabled(FAIO_options.optionHeroArcWardenSpark) and sparkWraith and Ability.IsCastable(sparkWraith, myMana) then
								local sparkPrediction = 2.3 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
								local sparkPos = FAIO_utility_functions.castPrediction(myHero, enemy, sparkPrediction)
								if NPC.IsPositionInRange(myHero, sparkPos, 1999) then
									Ability.CastPosition(sparkWraith, sparkPos)
									FAIO.lastTick = os.clock() + 0.2
									return
								end
							end
						end
						
						if NPC.IsEntityInRange(myHero, enemy, arcWardenAttackRange) then
							if Menu.IsEnabled(FAIO_options.optionHeroArcWardenMagnetic) and magneticField and Ability.IsCastable(magneticField, myMana) and not NPC.HasModifier(myHero, "modifier_arc_warden_magnetic_field_attack_speed") then
								if os.clock() > FAIO.arcWardenMagneticCastTime then
									local pos = Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(150)
									Ability.CastPosition(magneticField, pos)
									FAIO.lastTick = os.clock() + 0.2
									FAIO.arcWardenMagneticCastTime = os.clock() + 0.55
									return
								end
							end

							if necronomicon and Ability.IsCastable(necronomicon, myMana) then
								Ability.CastNoTarget(necronomicon)
								FAIO.lastTick = os.clock() + 0.05
								return
							end
						end

						if NPC.IsEntityInRange(myHero, enemy, arcWardenAttackRange + Menu.GetValue(FAIO_options.optionArcWardenBlinkTrigger) - 50) then
							if Menu.IsEnabled(FAIO_options.optionArcWardenComboUlt) and tempestDouble and Ability.IsCastable(tempestDouble, myMana) then
								Ability.CastNoTarget(tempestDouble)
								FAIO.lastTick = os.clock() + 0.2
								return
							end
						end
					end
				end
			end

			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			for _, necro in ipairs(FAIO.GetNecronomiconEntityTable(myHero, myHero)) do
				FAIO.NecronomiconController(necro, enemy, nil)
			end
			if #FAIO.GetIllusionEntityTable(myHero, myHero) > 0 then
				FAIO.MantaIlluController(enemy, nil, myHero, myHero)
			end

			return
		end
	end

end

function FAIO.TempestInAttackAnimation(myHero)

	if not myHero then return false end
	if FAIO.ArcWardenEntity == nil then return false end
	if not Entity.IsAlive(FAIO.ArcWardenEntity) then return false end

	if FAIO.ArcWardenEntityAnimationStart < 1 then return false end
	if FAIO.ArcWardenEntityAnimationEnd < 1 then return false end

	if GameRules.GetGameTime() > FAIO.ArcWardenEntityAnimationEnd then return false end

	if GameRules.GetGameTime() >= FAIO.ArcWardenEntityAnimationStart then
		if GameRules.GetGameTime() <= FAIO.ArcWardenEntityAnimationEnd then
			return true
		end
	end

	return false

end

function FAIO.TempestTrackLockedTargetLocation(myHero, target)

	if not myHero then return end
	if not target then
		FAIO.ArcTempestLockedTargetPos = Vector()
		FAIO.ArcTempestLockedTargetPosTimer = 0
		return 
	end

	if not Entity.IsDormant(target) then
		if os.clock() > FAIO.ArcTempestLockedTargetPosTimer then
			FAIO.ArcTempestLockedTargetPos = Entity.GetAbsOrigin(target)
			FAIO.ArcTempestLockedTargetPosTimer = os.clock() + 0.5
			return
		end
	end

	return

end

function FAIO.TempestOrbWalker(myHero, tempestDoubleEntity, enemy)

	if not tempestDoubleEntity then return end
	if not enemy then return end

	if NPC.IsChannellingAbility(tempestDoubleEntity) then return end

	local attackRange = NPC.GetAttackRange(tempestDoubleEntity)

	local increasedAS = NPC.GetIncreasedAttackSpeed(tempestDoubleEntity)
	local attackTime = NPC.GetAttackTime(tempestDoubleEntity)
	local movementSpeed = NPC.GetMoveSpeed(tempestDoubleEntity)

	local attackPoint = 0.3 / (1 + (increasedAS/100))
	local attackBackSwing = 0.7 / (1 + (increasedAS/100))

	local idleTime = math.max(attackTime - attackPoint - attackBackSwing, 0)

	if FAIO.ArcWardenEntityProjectileCreate > 0 then
		if GameRules.GetGameTime() > FAIO.ArcWardenEntityAnimationStart and GameRules.GetGameTime() < FAIO.ArcWardenEntityProjectileCreate + attackBackSwing + idleTime then
			FAIO.TempestInAttackBackswing = true
		else
			FAIO.TempestInAttackBackswing = false
		end
	end
	

	if GameRules.GetGameTime() > FAIO.ArcWardenEntityAnimationStart and GameRules.GetGameTime() < FAIO.AttackProjectileCreate then
		FAIO.TempestInAttackBackswing = false
	end

	local breakPoint = attackRange * 0.7

	local moveDistance = NPC.GetMoveSpeed(tempestDoubleEntity) * (attackBackSwing + idleTime - NPC.GetTimeToFace(tempestDoubleEntity, enemy)) * 0.9
		if (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Length2D() > breakPoint and (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Length2D() <= breakPoint + moveDistance then
			moveDistance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Length2D() - breakPoint
		end
	
	if not FAIO.TempestInAttackBackswing then
		if os.clock() - FAIO.TempestOrbwalkerDelay > 0.05 + attackPoint + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) and GameRules.GetGameTime() - FAIO.ArcWardenEntityAnimationStart > attackPoint + 0.1 then
			Player.AttackTarget(Players.GetLocal(), tempestDoubleEntity, enemy, false)
			FAIO.TempestOrbwalkerDelay = os.clock()
			return
		end
	else
		if (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Length2D() > breakPoint then
			if os.clock() - FAIO.TempestOrbwalkerDelay > attackBackSwing + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
				if moveDistance > 50 then
					local targetVector = Entity.GetAbsOrigin(tempestDoubleEntity) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Normalized():Scaled(moveDistance)
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, targetVector, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity, queue, showEffects)
					FAIO.TempestOrbwalkerDelay = os.clock()
					return
				end
			end
		end
	end

end

function FAIO.TempestDoubleHandler(myHero, enemy, tempestDoubleEntity, tempestDouble, myMana, arcWardenAttackRange)
	
	if not tempestDoubleEntity then return end
	if not Entity.IsAlive(tempestDoubleEntity) then return end
	if tempestDoubleEntity == myHero then return end
	if os.clock() - FAIO.ControlledUnitPauseTime < 3.1 then return end

	if FAIO.heroCanCastSpells(tempestDoubleEntity) == false then return end

	local travelBoots1 = NPC.GetItem(tempestDoubleEntity, "item_travel_boots", true)
	local travelBoots2 = NPC.GetItem(tempestDoubleEntity, "item_travel_boots_2", true)
	local wardenMana = NPC.GetMana(tempestDoubleEntity)

	local TPing = nil
		if travelBoots1 and Ability.IsCastable(travelBoots1, wardenMana) then
			TPing = travelBoots1
		elseif travelBoots2 and Ability.IsCastable(travelBoots2, wardenMana) then
			TPing = travelBoots2
		end
		local tempestMod = NPC.GetModifier(tempestDoubleEntity, "modifier_kill")
		if tempestMod then
			local tempestCreaTime = Modifier.GetCreationTime(tempestMod)
			local tempestDieTime = Modifier.GetDieTime(tempestMod)
			if GameRules.GetGameTime() > tempestCreaTime + 0.35 * (tempestDieTime - tempestCreaTime) then
				TPing = nil
			end
		end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then
		if enemy and Entity.GetHealth(enemy) > 0 then
			if FAIO.ArcTempestLockedTarget == nil then
				FAIO.ArcWardenFight(myHero, enemy, tempestDoubleEntity, arcWardenAttackRange)
				FAIO.arcWardenStatus = 1
			end
		end
	else
		if FAIO.arcWardenStatus == 1 and FAIO.ArcTempestLockedTarget == nil then
			FAIO.arcWardenStatus = 0
		end
	end

	if FAIO.ArcTempestLockedTarget ~= nil then
		FAIO.TempestTrackLockedTargetLocation(myHero, FAIO.ArcTempestLockedTarget)
		if not Entity.IsDormant(FAIO.ArcTempestLockedTarget) then
			FAIO.ArcWardenFight(myHero, FAIO.ArcTempestLockedTarget, tempestDoubleEntity, arcWardenAttackRange)
			FAIO.arcWardenStatus = 1
		else
			FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, FAIO.ArcTempestLockedTargetPos, tempestDoubleEntity)
			FAIO.arcWardenStatus = 1
			if NPC.IsPositionInRange(tempestDoubleEntity, FAIO.ArcTempestLockedTargetPos, 100, 0) then
				FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
				FAIO.arcWardenStatus = 5
				FAIO.ArcTempestLockedTargetPos = Entity.GetAbsOrigin(tempestDoubleEntity)
			end
		end	
	end

	if FAIO.arcWardenPusher then
		if TPing then
			if FAIO.ArcWardenPort(myHero) ~= nil and not NPC.IsPositionInRange(tempestDoubleEntity, FAIO.ArcWardenPort(myHero), Menu.GetValue(FAIO_options.optionArcWardenPushTPRange)) then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, FAIO.ArcWardenPort(myHero), TPing, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
				FAIO.arcWardenStatus = 3
				FAIO.ControlledUnitPauseTime = os.clock()
				return
			else
				FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
				FAIO.arcWardenStatus = 2
			end
		else
			if not NPC.HasModifier(tempestDoubleEntity ,"modifier_teleporting") then
				if NPC.HasItem(myHero, "item_travel_boots", true) or NPC.HasItem(myHero, "item_travel_boots_2", true) then
					if not ((travelBoots1 and Ability.IsReady(travelBoots1)) or (travelBoots2 and Ability.IsReady(travelBoots2))) then
						FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
						FAIO.arcWardenStatus = 4
					else
						FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
						FAIO.arcWardenStatus = 2
					end
				else
					FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
					FAIO.arcWardenStatus = 2
				end
			end
		end
	end
			
	if not NPC.HasModifier(tempestDoubleEntity ,"modifier_teleporting") then
		FAIO_itemHandler.utilityItemMidas(tempestDoubleEntity, NPC.GetItem(tempestDoubleEntity, "item_hand_of_midas", true))
	end

end	

function FAIO.ArcWardenFight(myHero, enemy, tempestDoubleEntity, arcWardenAttackRange)

	if not tempestDoubleEntity then return end
	if not enemy then return end
	if not Entity.IsAlive(tempestDoubleEntity) then return end
	if tempestDoubleEntity == myHero then return end

	if FAIO.heroCanCastSpells(tempestDoubleEntity) == false then return end

	local flux = NPC.GetAbilityByIndex(tempestDoubleEntity, 0)
	local magneticField = NPC.GetAbilityByIndex(tempestDoubleEntity, 1)
	local sparkWraith = NPC.GetAbilityByIndex(tempestDoubleEntity, 2)

	local blink = NPC.GetItem(tempestDoubleEntity, "item_blink", true)
	local shadowBlade = NPC.GetItem(tempestDoubleEntity, "item_invis_sword", true)
	local silverEdge = NPC.GetItem(tempestDoubleEntity, "item_silver_edge", true)
	local bkb = NPC.GetItem(tempestDoubleEntity, "item_black_king_bar", true)

	local necronomicon = NPC.GetItem(tempestDoubleEntity, "item_necronomicon", true)
	if not necronomicon then
		for i = 2, 3 do
			necronomicon = NPC.GetItem(tempestDoubleEntity, "item_necronomicon_" .. i, true)
			if necronomicon then 
				break 
			end
		end
	end	 

	local wardenMana = NPC.GetMana(tempestDoubleEntity)

	if shadowBlade and Ability.IsCastable(shadowBlade, wardenMana) then
		Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), shadowBlade, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
		FAIO.noItemCastFor(0.5)
		FAIO.ControlledUnitCastTime = os.clock() + 0.25
		return
	end

	if silverEdge and Ability.IsCastable(silverEdge, wardenMana) then
		Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), silverEdge, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
		FAIO.noItemCastFor(0.5)
		FAIO.ControlledUnitCastTime = os.clock() + 0.25
		return
	end

	FAIO_itemHandler.itemUsageSmartOrder(tempestDoubleEntity, enemy, true)
	FAIO.TempestOrbWalker(myHero, tempestDoubleEntity, enemy)

	if not NPC.IsEntityInRange(tempestDoubleEntity, enemy, arcWardenAttackRange + 250) then
		if blink and Ability.IsReady(blink) then
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(tempestDoubleEntity) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(250)), blink, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
			FAIO.Debugger(GameRules.GetGameTime(), tempestDoubleEntity, "blink", "DOTA_UNIT_ORDER_CAST_POSITION")
		end
	end

	if NPC.IsEntityInRange(tempestDoubleEntity, enemy, arcWardenAttackRange) then
		if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO_utility_functions.GetAvgLatency() and necronomicon and Ability.IsCastable(necronomicon, wardenMana) then
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), necronomicon, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
			FAIO.ControlledUnitCastTime = os.clock()
			FAIO.Debugger(GameRules.GetGameTime(), tempestDoubleEntity, "necrobook", "DOTA_UNIT_ORDER_CAST_NO_TARGET")
		end

		if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO_utility_functions.GetAvgLatency() and bkb and Ability.IsReady(bkb) then
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), bkb, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
			FAIO.ControlledUnitCastTime = os.clock()
			FAIO.Debugger(GameRules.GetGameTime(), tempestDoubleEntity, "bkb", "DOTA_UNIT_ORDER_CAST_NO_TARGET")
		end
	end

	if not (NPC.HasModifier(tempestDoubleEntity, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(tempestDoubleEntity, "modifier_item_silver_edge_windwalk")) then
		if NPC.IsEntityInRange(tempestDoubleEntity, enemy, Ability.GetCastRange(flux)) then
			if NPC.IsLinkensProtected(enemy) and (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(flux) and flux and Ability.IsCastable(flux, wardenMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET, enemy, Vector(0,0,0), flux, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
				FAIO.ControlledUnitCastTime = os.clock()
				return
			end
		
			if Menu.IsEnabled(FAIO_options.optionHeroArcWardenFlux) and (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(flux) and flux and Ability.IsCastable(flux, wardenMana) and #NPC.GetHeroesInRadius(enemy, 225, Enum.TeamType.TEAM_FRIEND) < 1 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET, enemy, Vector(0,0,0), flux, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
				FAIO.ControlledUnitCastTime = os.clock()
				return
			end
		end

		if NPC.IsEntityInRange(tempestDoubleEntity, enemy, arcWardenAttackRange) then
			if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(magneticField) and magneticField and Ability.IsCastable(magneticField, wardenMana) and not NPC.HasModifier(tempestDoubleEntity, "modifier_arc_warden_magnetic_field_attack_speed") and not Ability.IsInAbilityPhase(NPC.GetAbilityByIndex(myHero, 1)) and NPC.IsEntityInRange(tempestDoubleEntity, enemy, NPC.GetAttackRange(tempestDoubleEntity)) then
				if os.clock() > FAIO.arcWardenMagneticCastTime then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, Entity.GetAbsOrigin(tempestDoubleEntity) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(tempestDoubleEntity)):Normalized():Scaled(50), magneticField, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
					FAIO.ControlledUnitCastTime = os.clock()
					FAIO.arcWardenMagneticCastTime = os.clock() + 0.55
					return
				end
			end
		end

		if NPC.IsEntityInRange(tempestDoubleEntity, enemy, 2000) then
			if Menu.IsEnabled(FAIO_options.optionHeroArcWardenSpark) and sparkWraith and (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(sparkWraith) and Ability.IsCastable(sparkWraith, wardenMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				local sparkPrediction = 2.3 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				local sparkPos = FAIO_utility_functions.castPrediction(tempestDoubleEntity, enemy, sparkPrediction)
				if NPC.IsPositionInRange(tempestDoubleEntity, sparkPos, 1999) then
					Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, sparkPos, sparkWraith, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
					FAIO.ControlledUnitCastTime = os.clock()
					return
				end
			end
		end
	end
	
	for _, necro in ipairs(FAIO.GetNecronomiconEntityTable(myHero, tempestDoubleEntity)) do
		FAIO.NecronomiconController(necro, enemy, nil)
	end

	if #FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity) > 0 then
		FAIO.MantaIlluController(enemy, nil, myHero, tempestDoubleEntity)
	end

end
	
function FAIO.ArcWardenPort(myHero)

	local enemyFountainPos = FAIO_utility_functions.GetEnemyFountainPos(myHero)
	local myFountainPos = FAIO_utility_functions.GetMyFountainPos(myHero)

	if FAIO.arcWardenPushMode then
		local targetCreep
		local maxDistance = 99999
		if NPC.HasItem(myHero, "item_travel_boots", true) or NPC.HasItem(myHero, "item_travel_boots_2", true) then
			for i = 1, NPCs.Count() do 
			local npc = NPCs.Get(i)
    				if npc and Entity.IsSameTeam(myHero, npc) and Entity.IsAlive(npc) and NPC.IsLaneCreep(npc) and NPC.IsRanged(npc) and not NPC.IsDormant(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					if npc ~= nil then
						local creepPosition = Entity.GetAbsOrigin(npc)
						local distanceToMouse = (creepPosition - Input.GetWorldCursorPos()):Length2D()
						if distanceToMouse < maxDistance then
							targetCreep = npc
							maxDistance = distanceToMouse
						end
					end
				end
			end
		end

		if targetCreep == nil then
			maxDistance = 99999
		end

		if targetCreep then
			return Entity.GetAbsOrigin(targetCreep)
		end
	else
		local targetCreep
		local pushDistance = 99999
		if NPC.HasItem(myHero, "item_travel_boots", true) or NPC.HasItem(myHero, "item_travel_boots_2", true) then
			for i = 1, NPCs.Count() do 
			local npc = NPCs.Get(i)
    				if npc and Entity.IsSameTeam(myHero, npc) and NPC.IsLaneCreep(npc) and NPC.IsRanged(npc) and not NPC.IsDormant(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					if #NPC.GetUnitsInRadius(npc, 1200, Enum.TeamType.TEAM_ENEMY) >= 3 and #NPC.GetHeroesInRadius(npc, 900, Enum.TeamType.TEAM_ENEMY) <= 1  and #NPC.GetHeroesInRadius(npc, 1000, Enum.TeamType.TEAM_FRIEND) <= 1 then
						if (Entity.GetHealth(npc) / Entity.GetMaxHealth(npc)) >= 0.8 and #NPC.GetUnitsInRadius(npc, 500, Enum.TeamType.TEAM_FRIEND) >= 2 then	
							if npc ~= nil then
								if (Entity.GetAbsOrigin(npc) - Entity.GetAbsOrigin(myHero)):Length2D() > 3000 then
									if not FAIO.arcWardenPushModeLine then
										if (Entity.GetAbsOrigin(npc) - enemyFountainPos):Length2D() < pushDistance then
											targetCreep = npc
											pushDistance = (Entity.GetAbsOrigin(npc) - enemyFountainPos):Length2D()
											break
										end
									else
										if (Entity.GetAbsOrigin(npc) - myFountainPos):Length2D() < pushDistance then
											targetCreep = npc
											pushDistance = (Entity.GetAbsOrigin(npc) - myFountainPos):Length2D()
											break
										end
									end
								end
							end
						end
					end
				end
			end
		end

		if targetCreep == nil then
			pushDistance = 99999
		end

		if targetCreep ~= nil then
			return Entity.GetAbsOrigin(targetCreep)
		end
	end
end

function FAIO.ArcWardenPush(myHero, tempestDoubleEntity, arcWardenAttackRange)
	
	if not tempestDoubleEntity then return end
	if not Entity.IsAlive(tempestDoubleEntity) then return end
	if tempestDoubleEntity == myHero then return end

	local wardenMana = NPC.GetMana(tempestDoubleEntity)
	local mantaStyle = NPC.GetItem(tempestDoubleEntity, "item_manta", true)

	FAIO_itemHandler.utilityItemMidas(tempestDoubleEntity, NPC.GetItem(tempestDoubleEntity, "item_hand_of_midas", true))

	local necronomicon = NPC.GetItem(tempestDoubleEntity, "item_necronomicon", true)
	if not necronomicon then
		for i = 2, 3 do
			necronomicon = NPC.GetItem(tempestDoubleEntity, "item_necronomicon_" .. i, true)
			if necronomicon then 
				break 
			end
		end
	end

	local mjollnir = NPC.GetItem(tempestDoubleEntity, "item_mjollnir", true)

	if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO_utility_functions.GetAvgLatency() and necronomicon and Ability.IsCastable(necronomicon, wardenMana) then
		Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), necronomicon, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
		FAIO.ControlledUnitCastTime = os.clock()
		FAIO.Debugger(GameRules.GetGameTime(), tempestDoubleEntity, "necronomicon", "DOTA_UNIT_ORDER_CAST_NO_TARGET")
	end
	if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO_utility_functions.GetAvgLatency() and mantaStyle and Ability.IsCastable(mantaStyle, wardenMana) then
		Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, target, Vector(0,0,0), mantaStyle, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
		FAIO.ControlledUnitCastTime = os.clock()
		FAIO.Debugger(GameRules.GetGameTime(), tempestDoubleEntity, "mantaStyle", "DOTA_UNIT_ORDER_CAST_NO_TARGET")
	end
	if NPC.HasModifier(tempestDoubleEntity, "modifier_kill") then
		local tempestDieTime = Modifier.GetDieTime(NPC.GetModifier(tempestDoubleEntity, "modifier_kill"))
		if tempestDieTime - GameRules.GetGameTime() < 2.5 then
			if mjollnir and Ability.IsCastable(mjollnir, wardenMana) then
				for _, allyCreep in ipairs(Entity.GetUnitsInRadius(tempestDoubleEntity, 825, Enum.TeamType.TEAM_FRIEND)) do
					if allyCreep and Entity.IsAlive(allyCreep) and NPC.IsLaneCreep(allyCreep) and not NPC.IsRanged(allyCreep) and Entity.GetHealth(allyCreep) > Entity.GetMaxHealth(allyCreep) * 0.6 then
						if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO_utility_functions.GetAvgLatency() then
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET, allyCreep, Vector(0,0,0), mjollnir, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
							FAIO.ControlledUnitCastTime = os.clock()
						end
					end
				end
			end
		end
	end

	local targetHero
	local enemyHeroHealth = 99999
	local targetCreep
	local enemyCreepHealth = 99999
	for i, heroes in ipairs(NPC.GetHeroesInRadius(tempestDoubleEntity, 799, Enum.TeamType.TEAM_ENEMY)) do
		if heroes then
        		if Entity.IsAlive(heroes) and not Entity.IsDormant(heroes) and not NPC.HasState(heroes, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsIllusion(heroes) then
				if Entity.GetHealth(heroes) < enemyHeroHealth then
					targetHero = heroes
					enemyHeroHealth = Entity.GetHealth(heroes)
				end
			end
		end
	end
	if #NPC.GetHeroesInRadius(tempestDoubleEntity, 799, Enum.TeamType.TEAM_ENEMY) < 1 then
		for i = 1, NPCs.Count() do 
		local creeps = NPCs.Get(i)
			if creeps and Entity.IsNPC(creeps) and not Entity.IsSameTeam(myHero, creeps) then
				if NPC.IsEntityInRange(tempestDoubleEntity, creeps, 799) then
					if Entity.IsAlive(creeps) and not Entity.IsDormant(creeps) and NPC.IsKillable(creeps) and not NPC.IsWaitingToSpawn(creeps) and NPC.GetUnitName(creeps) ~= "npc_dota_neutral_caster" then
						if Entity.GetHealth(creeps) < enemyCreepHealth then
							if creeps ~= nil then
								targetCreep = creeps
								enemyCreepHealth = Entity.GetHealth(creeps)
							end
						end
					end
				end
			end
		end
	end
	
	if #NPC.GetUnitsInRadius(tempestDoubleEntity, 800, Enum.TeamType.TEAM_ENEMY) < 1 then
		targetHero = nil
		enemyHeroHealth = 99999
		targetCreep = nil
		enemyCreepHealth = 99999
	end
	
	if targetHero then
		FAIO.ArcWardenFight(myHero, targetHero, tempestDoubleEntity, arcWardenAttackRange)
		if not NPC.IsLinkensProtected(targetHero) then
			FAIO_itemHandler.itemUsageSmartOrder(tempestDoubleEntity, targetHero, true)
		end
	end

	if targetCreep then

		if not FAIO.TempestInAttackAnimation(myHero) then
			FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", targetCreep, nil, tempestDoubleEntity)
		end

		if #NPC.GetUnitsInRadius(tempestDoubleEntity, 625, Enum.TeamType.TEAM_ENEMY) >= 3 then
			if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(NPC.GetAbilityByIndex(tempestDoubleEntity, 1)) and NPC.GetAbilityByIndex(tempestDoubleEntity, 1) and Ability.IsCastable(NPC.GetAbilityByIndex(tempestDoubleEntity, 1), wardenMana) then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, Entity.GetAbsOrigin(tempestDoubleEntity) + Entity.GetRotation(tempestDoubleEntity):GetForward():Normalized():Scaled(75), NPC.GetAbilityByIndex(tempestDoubleEntity, 1), Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
				FAIO.ControlledUnitCastTime = os.clock()
				return
			end
		end
		if NPC.IsEntityInRange(tempestDoubleEntity, targetCreep, 1900) then
			if (os.clock() - FAIO.ControlledUnitCastTime) > FAIO.CastAnimationDelay(NPC.GetAbilityByIndex(tempestDoubleEntity, 2)) and NPC.GetAbilityByIndex(tempestDoubleEntity, 2) and Ability.IsCastable(NPC.GetAbilityByIndex(tempestDoubleEntity, 2), wardenMana) and not NPC.IsStructure(targetCreep) then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, target, Entity.GetAbsOrigin(targetCreep), NPC.GetAbilityByIndex(tempestDoubleEntity, 2), Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, tempestDoubleEntity)
				FAIO.ControlledUnitCastTime = os.clock()
				return
			end
		end
		for _, necro in ipairs(FAIO.GetNecronomiconEntityTable(myHero, tempestDoubleEntity)) do
			FAIO.NecronomiconController(necro, nil, FAIO.GenericLanePusher(tempestDoubleEntity))
		end
		if #FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity) > 0 then
			FAIO.MantaIlluController(nil, FAIO.GenericLanePusher(tempestDoubleEntity), myHero, tempestDoubleEntity)
		end		
	end

	if not targetHero and not targetCreep then

		if not FAIO.TempestInAttackAnimation(myHero) then
			FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE", nil, FAIO.GenericLanePusher(tempestDoubleEntity), tempestDoubleEntity)
		end

		for _, necro in ipairs(FAIO.GetNecronomiconEntityTable(myHero, tempestDoubleEntity)) do
			FAIO.NecronomiconController(necro, nil, FAIO.GenericLanePusher(tempestDoubleEntity))
		end

		if #FAIO.GetIllusionEntityTable(myHero, tempestDoubleEntity) > 0 then
			FAIO.MantaIlluController(nil, FAIO.GenericLanePusher(tempestDoubleEntity), myHero, tempestDoubleEntity)
		end
	end
end

function FAIO.drawArcWardenPanel(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroArcWarden) then return end
	
	if Menu.IsKeyDownOnce(FAIO_options.optionHeroArcWardenPanelKey) then
		FAIO.Toggler = not FAIO.Toggler
	end
	
	if FAIO.Toggler then return end

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	if FAIO.arcWardenPanelX ~= Config.ReadInt("arcWarden", "panelX", w/2) then
		FAIO.arcWardenPanelX = Config.ReadInt("arcWarden", "panelX", w/2)
	end
	if FAIO.arcWardenPanelY ~= Config.ReadInt("arcWarden", "panelY", h/2) then
		FAIO.arcWardenPanelY = Config.ReadInt("arcWarden", "panelY", h/2)
	end

	if Menu.IsEnabled(FAIO_options.optionHeroArcWardenPanelMove) then
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_UP) then
			FAIO.arcWardenPanelY = FAIO.arcWardenPanelY - 10
			Config.WriteInt("arcWarden", "panelY", FAIO.arcWardenPanelY)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_DOWN) then
			FAIO.arcWardenPanelY = FAIO.arcWardenPanelY + 10
			Config.WriteInt("arcWarden", "panelY", FAIO.arcWardenPanelY)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_LEFT) then
			FAIO.arcWardenPanelX = FAIO.arcWardenPanelX - 10
			Config.WriteInt("arcWarden", "panelX", FAIO.arcWardenPanelX)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_RIGHT) then
			FAIO.arcWardenPanelX = FAIO.arcWardenPanelX + 10
			Config.WriteInt("arcWarden", "panelX", FAIO.arcWardenPanelX)
		end
	end

	local startX = FAIO.arcWardenPanelX
	local startY = FAIO.arcWardenPanelY

	local width = 120
	local height = 277

	 -- black background
	Renderer.SetDrawColor(0, 0, 0, 125)
	Renderer.DrawFilledRect(startX, startY, width, height)


	-- black border
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY, width, height)

	Renderer.SetDrawColor(255, 0, 0, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 10, "OPTIONS", 1)
	Renderer.SetDrawColor(0, 0, 0, 45)
	Renderer.DrawFilledRect(startX+1, startY+1, width-2, 20-2)

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 30, "TP Push", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startY+21, width-2, 20-2)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY+40, width/2, 20)
	Renderer.DrawOutlineRect(startX + width/2, startY+40, width/2, 20)

	local hoveringOverAuto = Input.IsCursorInRect(startX, startY+40, width/2, 20)
	local hoveringOverCursor = Input.IsCursorInRect(startX + width/2, startY+40, width/2, 20)

	if hoveringOverAuto and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if FAIO.arcWardenPushMode then
			FAIO.arcWardenPushMode = not FAIO.arcWardenPushMode
		end
	end

	if hoveringOverCursor and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if not FAIO.arcWardenPushMode then
			FAIO.arcWardenPushMode = not FAIO.arcWardenPushMode
		end
	end
	
	if not FAIO.arcWardenPushMode then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 40, "auto", 0)
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 40, "cursor", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 40, "auto", 0)
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 40, "cursor", 0)
	end

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 70, "line select", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startY+61, width-2, 20-2)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY+80, width/2, 20)
	Renderer.DrawOutlineRect(startX + width/2, startY+80, width/2, 20)

	local hoveringOverFurthest = Input.IsCursorInRect(startX, startY+80, width/2, 20)
	local hoveringOverLeast = Input.IsCursorInRect(startX + width/2, startY+80, width/2, 20)

	if hoveringOverFurthest and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if FAIO.arcWardenPushModeLine then
			FAIO.arcWardenPushModeLine = not FAIO.arcWardenPushModeLine
		end
	end

	if hoveringOverLeast and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if not FAIO.arcWardenPushModeLine then
			FAIO.arcWardenPushModeLine = not FAIO.arcWardenPushModeLine
		end
	end
	
	if FAIO.arcWardenPushMode then
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 80, "min", 0)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 80, "max", 0)
	else
		if not FAIO.arcWardenPushModeLine then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 80, "min", 0)
			Renderer.SetDrawColor(255, 255, 255, 75)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 80, "max", 0)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 80, "min", 0)
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 80, "max", 0)
		end
	end

	local startXinfo = startX
	local startYinfo = startY + 110

	Renderer.SetDrawColor(255, 0, 0, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 10, "INFORMATION", 1)
	Renderer.SetDrawColor(0, 0, 0, 45)
	Renderer.DrawFilledRect(startXinfo+1, startYinfo+1, width-2, 20-2)

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 30, "Clone action", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startYinfo+21, width-2, 20-2)

	if FAIO.ArcWardenEntity == nil then
		Renderer.SetDrawColor(255, 100, 0, 255)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/2, startYinfo + 40, "not spawned", 0)
	else	
		if FAIO.arcWardenStatus == 0 then
			if not Entity.IsAlive(FAIO.ArcWardenEntity) then
				Renderer.SetDrawColor(255, 100, 0, 255)
				Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/2, startYinfo + 40, "dead", 0)
			else
				Renderer.SetDrawColor(255, 100, 0, 255)
				Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/2, startYinfo + 40, "idle", 0)
			end
		elseif FAIO.arcWardenStatus == 1 and FAIO.ArcTempestLockedTarget ~= nil then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "comboing", 0)
			local heroName = NPC.GetUnitName(FAIO.ArcTempestLockedTarget)
			local heroNameShort = string.gsub(heroName, "npc_dota_hero_", "")
			local imageHandle
				if FAIO.heroIconHandler[heroNameShort] ~= nil then
					imageHandle = FAIO.heroIconHandler[heroNameShort]
				else
					imageHandle = Renderer.LoadImage(FAIO.heroIconPath .. heroNameShort .. ".png")
					FAIO.heroIconHandler[heroNameShort] = imageHandle
				end
			Renderer.SetDrawColor(255, 255, 255, 255)
			Renderer.DrawImage(imageHandle, startX + width/2 - 35, startYinfo + 58, 67, 48)
		elseif FAIO.arcWardenStatus == 1 and FAIO.ArcTempestLockedTarget == nil and FAIO.LockedTarget ~= nil then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "main comboing", 0)
			local heroName = NPC.GetUnitName(FAIO.LockedTarget)
			local heroNameShort = string.gsub(heroName, "npc_dota_hero_", "")
			local imageHandle
				if FAIO.heroIconHandler[heroNameShort] ~= nil then
					imageHandle = FAIO.heroIconHandler[heroNameShort]
				else
					imageHandle = Renderer.LoadImage(FAIO.heroIconPath .. heroNameShort .. ".png")
					FAIO.heroIconHandler[heroNameShort] = imageHandle
				end
			Renderer.SetDrawColor(255, 255, 255, 255)
			Renderer.DrawImage(imageHandle, startX + width/2 - 35, startYinfo + 58, 67, 48)
		elseif FAIO.arcWardenStatus == 2 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "pushing", 0)
		elseif FAIO.arcWardenStatus == 3 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "tping", 0)
		elseif FAIO.arcWardenStatus == 4 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "TP pushing", 0)
		elseif FAIO.arcWardenStatus == 5 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "hunting", 0)
		end
	end
					
	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 120, "Clone CDs", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startYinfo+111, width-2, 20-2)

	if FAIO.ArcWardenEntity == nil then return end

	local travelBoots1 = NPC.GetItem(FAIO.ArcWardenEntity, "item_travel_boots", true)
	local travelBoots2 = NPC.GetItem(FAIO.ArcWardenEntity, "item_travel_boots_2", true)
	local midas = NPC.GetItem(FAIO.ArcWardenEntity, "item_hand_of_midas", true)
	local necronomicon = NPC.GetItem(FAIO.ArcWardenEntity, "item_necronomicon", true)
	if not necronomicon then
		for i = 2, 3 do
			necronomicon = NPC.GetItem(FAIO.ArcWardenEntity, "item_necronomicon_" .. i, true)
			if necronomicon then 
				break 
			end
		end
	end

	local tempTable = {}
	if travelBoots1 then
		table.insert(tempTable, travelBoots1)
	end
	if travelBoots2 then
		table.insert(tempTable, travelBoots2)
	end
	if midas then
		table.insert(tempTable, midas)
	end
	if necronomicon then
		table.insert(tempTable, necronomicon)
	end

	for i, v in ipairs(tempTable) do

		local itemName = Ability.GetName(v)
		local itemNameShort = string.gsub(itemName, "item_", "")
		local imageHandle
			if FAIO.itemIconHandler[itemNameShort] ~= nil then
				imageHandle = FAIO.itemIconHandler[itemNameShort]
			else
				imageHandle = Renderer.LoadImage(FAIO.itemIconPath .. itemNameShort .. ".png")
				FAIO.itemIconHandler[itemNameShort] = imageHandle
			end
		
		Renderer.SetDrawColor(255, 255, 255, 255)
		Renderer.DrawImage(imageHandle, startX + 3 + (39*(i-1)), startYinfo + 135, 37, 26)
		if Ability.GetCooldownTimeLeft(v) > 0 then
			Renderer.SetDrawColor(255, 255, 255, 45)
			Renderer.DrawFilledRect(startX + 3 + (39*(i-1)), startYinfo + 135, 37, 26)
			Renderer.SetDrawColor(255, 0, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + 21 + (39*(i-1)), startYinfo + 139, math.ceil(Ability.GetCooldownTimeLeft(v)), 0)
		end
			
	end

end
		
function FAIO.MorphCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroMorphling) then return end

	local waveForm = NPC.GetAbilityByIndex(myHero, 0)
	local adaptiveStrikeAGI = NPC.GetAbilityByIndex(myHero, 1)
	local adaptiveStrikeSTR = NPC.GetAbilityByIndex(myHero, 2)

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	FAIO_itemHandler.itemUsage(myHero, enemy)

	FAIO.GetMorphShotgunDMG(myHero, myMana, enemy)
	FAIO.MorphSelectCombo(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) then
		Engine.ExecuteCommand("dota_range_display 800")
	else
		Engine.ExecuteCommand("dota_range_display 0")
	end

	if Menu.IsEnabled(FAIO_options.optionHeroMorphHPBalance) then
		FAIO.MorphBalaceHP(myHero, myMana)
	end

	local replicateMod = NPC.GetModifier(myHero, "modifier_morphling_replicate")	

	if not replicateMod then
		if enemy and Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
				if not NPC.IsEntityInRange(myHero, enemy, 800) then
					if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1550) then
						Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(300)))
						return
					end
				else
					if NPC.HasItem(myHero, "item_ethereal_blade", true) then
						if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_ethereal_blade", true)) > 0.1 then
							if FAIO.morphlingComboSelect == false then
								FAIO.MorphComboWithoutWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR)
							else
								FAIO.MorphComboWithWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR, waveForm)
							end
						end
					else
						if not FAIO.morphlingComboSelect then
							FAIO.MorphComboWithoutWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR)
						else
							FAIO.MorphComboWithWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR, waveForm)
						end
					end
				end	
			end
		FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
		end
	else
		if enemy and Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 then
			FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
		end
	end
		
end

function FAIO.MorphComboWithWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR, waveForm)

	if not myHero then return end
	if not enemy then return end
	if not adaptiveStrikeAGI or not waveForm then return end
	if Ability.GetLevel(adaptiveStrikeAGI) < 1 or Ability.GetLevel(waveForm) < 1 then return end

	if adaptiveStrikeAGI and Ability.IsCastable(adaptiveStrikeAGI, myMana) then
		Ability.CastTarget(adaptiveStrikeAGI, enemy)
		FAIO.lastTick = os.clock()
		return
	end
	if FAIO.SleepReady(0.1) and waveForm and Ability.IsCastable(waveForm, myMana) and not Ability.IsReady(adaptiveStrikeAGI) then
		Ability.CastPosition(waveForm, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(99))
		return
	end
	if adaptiveStrikeSTR and Ability.IsCastable(adaptiveStrikeSTR, myMana) then
		Ability.CastTarget(adaptiveStrikeSTR, enemy)
		FAIO.lastTick = os.clock()
		return
	end

	return

end

function FAIO.MorphComboWithoutWave(myHero, myMana, enemy, adaptiveStrikeAGI, adaptiveStrikeSTR)

	if not myHero then return end
	if not enemy then return end
	if not adaptiveStrikeAGI then return end
	if Ability.GetLevel(adaptiveStrikeAGI) < 1 then return end

	if adaptiveStrikeAGI and Ability.IsCastable(adaptiveStrikeAGI, myMana) then
		Ability.CastTarget(adaptiveStrikeAGI, enemy)
		return
	end
	if adaptiveStrikeSTR and Ability.IsCastable(adaptiveStrikeSTR, myMana) then
		Ability.CastTarget(adaptiveStrikeSTR, enemy)
		FAIO.lastTick = os.clock()
		return
	end

	return

end

function FAIO.GetMorphShotgunDMG(myHero, myMana, enemy)

	if not myHero then return end
	if not enemy then return end
	if not NPC.GetUnitName(myHero) == "npc_dota_hero_morphling" then return end

	local waveForm = NPC.GetAbilityByIndex(myHero, 0)
	local adaptiveStrike = NPC.GetAbilityByIndex(myHero, 1)

	local waveFormLevel
	if waveForm then
		waveFormLevel = Ability.GetLevel(waveForm)
	end
	local waveFormDMG
	if waveForm and Ability.IsCastable(waveForm, myMana) then
		waveFormDMG = 100 + 75 * (waveFormLevel - 1)
	elseif not waveForm or (waveForm and not Ability.IsCastable(waveForm, myMana)) then
		waveFormDMG = 0
	end

	local adaptiveStrikeLevel
	if adaptiveStrike then
		adaptiveStrikeLevel = Ability.GetLevel(adaptiveStrike)
	end
	local adaptiveStrikeDMG
	if adaptiveStrike and Ability.IsCastable(adaptiveStrike, myMana) then
		local basicDamage = 100
		local myAgility = Hero.GetAgilityTotal(myHero)
		local myStrength = Hero.GetStrengthTotal(myHero)
		local minMultiplier = 0.25
		local maxMultiplier = 0.5 + 0.5 * (adaptiveStrikeLevel - 1)

		local ratio = myAgility / myStrength
		local multiplier = minMultiplier
			if ratio > 1.5 then
				multiplier = maxMultiplier
			end

		adaptiveStrikeDMG = basicDamage + myAgility * multiplier
	elseif not adaptiveStrike or (adaptiveStrike and not Ability.IsCastable(adaptiveStrike, myMana)) then
		adaptiveStrikeDMG = 0
	end
	
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local eBladeDMG
	if eBlade and Ability.IsCastable(eBlade, myMana) then
		local myAgility = Hero.GetAgilityTotal(myHero)
		eBladeDMG = (2 * myAgility + 75)
	elseif not eBlade or (eBlade and not Ability.IsCastable(eBlade, myMana)) then
		eBladeDMG = 0
	end

	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end
	local dagonDMG = 0
	if dagon and Ability.IsCastable(dagon, myMana) then
		dagonDMG = Ability.GetLevelSpecialValueFor(dagon, "damage")
	end

	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)

	local overAllDMG = waveFormDMG + adaptiveStrikeDMG + eBladeDMG + dagonDMG
	if veil and Ability.IsCastable(veil, myMana) then
		overAllDMG = overAllDMG * 1.25
	end
	if eBlade and Ability.IsCastable(eBlade, myMana) then
		overAllDMG = overAllDMG * 1.4
	end

	local overAllDMGwoWave = adaptiveStrikeDMG + eBladeDMG + dagonDMG
	if veil and Ability.IsCastable(veil, myMana) then
		overAllDMGwoWave = overAllDMGwoWave * 1.25
	end
	if eBlade and Ability.IsCastable(eBlade, myMana) then
		overAllDMGwoWave = overAllDMGwoWave * 1.4
	end
	
	local trueOverallDMG = math.floor((1 - NPC.GetMagicalArmorValue(enemy)) * overAllDMG + overAllDMG * (Hero.GetIntellectTotal(myHero) / 14 / 100))
	local trueOverallDMGwoWave = math.floor((1 - NPC.GetMagicalArmorValue(enemy)) * overAllDMGwoWave + overAllDMGwoWave * (Hero.GetIntellectTotal(myHero) / 14 / 100))

	if NPC.HasModifier(myHero, "modifier_morphling_replicate") then
		FAIO.morphlingTotalDMG = 0
		FAIO.morphlingTotalDMGwoWave = 0
	end

	FAIO.morphlingTotalDMG = trueOverallDMG - 35
	FAIO.morphlingTotalDMGwoWave = trueOverallDMGwoWave - 35
	

end

function FAIO.MorphBalaceHP(myHero, myMana)

	if not myHero then return end
	if not FAIO.MorphBalanceToggler then return end
	
	if os.clock() - FAIO.MorphBalanceTimer < 0.1 then return end

	if NPC.IsSilenced(myHero) then return end
	if NPC.IsStunned(myHero) then return end

	local targetHP
	if FAIO.MorphBalanceSelectedHP > 0 then
		targetHP = FAIO.MorphBalanceSelectedHP
	end

	if not targetHP then return end

	local morphAGI = NPC.GetAbility(myHero, "morphling_morph_agi")
	local morphSTR = NPC.GetAbility(myHero, "morphling_morph_str")

		if not morphAGI or not morphSTR then return end
		if Ability.GetLevel(morphAGI) < 1 then return end
		if NPC.HasModifier(myHero, "modifier_morphling_replicate") then return end

	local myHP = Entity.GetHealth(myHero)
	local myMAXHP = Entity.GetMaxHealth(myHero)

	local shouldToggleAGI = false
	local shouldToggleStr = false
	local allowedDeviation = Menu.GetValue(FAIO_options.optionHeroMorphHPBalanceDeviation)

	if NPC.HasModifier(myHero, "modifier_fountain_aura_buff") then return end
		if targetHP - myHP >= allowedDeviation then
			if Hero.GetAgility(myHero) > 1 then
				shouldToggleStr = true
			else
				shouldToggleStr = false
			end
		else
			shouldToggleStr = false
		end

		if myMAXHP - targetHP >= allowedDeviation and (myHP - targetHP) >= allowedDeviation then
			if Hero.GetStrength(myHero) > 1 then
				shouldToggleAGI = true
			else
				shouldToggleAGI = false
			end
		else
			shouldToggleAGI = false
		end

	if shouldToggleStr then
		if not Ability.GetToggleState(morphSTR) then
			Ability.Toggle(morphSTR)
			FAIO.MorphBalanceTimer = os.clock()
			return
		end
	else
		if Ability.GetToggleState(morphSTR) then
			Ability.Toggle(morphSTR)
			FAIO.MorphBalanceTimer = os.clock()
			return
		end
	end

	if shouldToggleAGI then
		if not Ability.GetToggleState(morphAGI) then
			Ability.Toggle(morphAGI)
			FAIO.MorphBalanceTimer = os.clock()
			return
		end
	else
		if Ability.GetToggleState(morphAGI) then
			Ability.Toggle(morphAGI)
			FAIO.MorphBalanceTimer = os.clock()
			return
		end
	end
				
end

function FAIO.MorphDrawBalanceBoard(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroMorphDrawBoard) then return end

	local maxMorphAGI = math.floor(Hero.GetAgility(myHero))
	local maxMorphSTR = math.floor(Hero.GetStrength(myHero))

	local currentMAXHP = Entity.GetMaxHealth(myHero)

	local minHP = currentMAXHP - maxMorphSTR * 20
	local maxHP = currentMAXHP + maxMorphAGI * 20

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	local startX = w - 300 - Menu.GetValue(FAIO_options.optionHeroMorphDrawBoardXPos)
	local startY = 300 + Menu.GetValue(FAIO_options.optionHeroMorphDrawBoardYPos)
	
	if Menu.IsKeyDownOnce(FAIO_options.optionHeroMorphBoardToggleKey) then
		FAIO.Toggler = not FAIO.Toggler
	end

	if not FAIO.Toggler then return end
		
	-- black background
	Renderer.SetDrawColor(0, 0, 0, 150)
	Renderer.DrawFilledRect(startX-1, startY, 202, 25)

	-- black border
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX-1, startY, 202, 25)

	-- min/max HP
	Renderer.SetDrawColor(0, 255, 0, 150)
	Renderer.DrawText(FAIO.font, startX-25, startY-25, minHP, 0)
	Renderer.SetDrawColor(255, 0, 0, 150)
	Renderer.DrawText(FAIO.font, startX+175, startY-25, maxHP, 0)

	-- colored rect
	for i = 1, 20 do
		Renderer.SetDrawColor(25 + i*10, 230 - i*10, 0, 150)
		Renderer.DrawFilledRect(startX + (i-1)*10 , startY+1, 10, 23)
	end

	-- hovering rects
	local hoveringTable = {}
	if next(hoveringTable) == nil then
		for i = 1, 20 do
			hoveringTable[i] = Input.IsCursorInRect(startX + (i-1)*10 , startY+1, 10, 23)
		end
	end

	-- on/off rects
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX+75, startY-25, 50, 20)
	Renderer.SetDrawColor(0, 0, 0, 150)
	Renderer.DrawFilledRect(startX+75, startY-25, 50, 20)
		local togglerHovering = Input.IsCursorInRect(startX+75, startY-25, 50, 20)
		if togglerHovering and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			FAIO.MorphBalanceToggler = not FAIO.MorphBalanceToggler
		end

	if FAIO.MorphBalanceToggler then
		Renderer.SetDrawColor(0, 255, 0, 150)
		Renderer.DrawTextCenteredX(FAIO.font, startX+100, startY-27, "ON", 0)
	else
		Renderer.SetDrawColor(255, 0, 0, 150)
		Renderer.DrawTextCenteredX(FAIO.font, startX+100, startY-27, "OFF", 0)
	end

	local HPsteps = math.floor((maxHP - minHP) / 20)

	if Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		for i, v in ipairs(hoveringTable) do
			if hoveringTable[1] == true then
				FAIO.MorphBalanceSelectedHP = minHP
				FAIO.MorphBalanceSelected = 1
			elseif hoveringTable[20] == true then
				FAIO.MorphBalanceSelectedHP = maxHP
				FAIO.MorphBalanceSelected = 20
			else
				if v == true then
					FAIO.MorphBalanceSelectedHP = minHP + HPsteps*i
					FAIO.MorphBalanceSelected = i
				end
			end		
		end
	end

	if FAIO.MorphBalanceSelected > 0 then
		Renderer.SetDrawColor(0, 0, 0, 200)
		Renderer.DrawFilledRect(startX+3+10*(FAIO.MorphBalanceSelected-1), startY, 4, 30)
		Renderer.DrawTextCenteredX(FAIO.font, startX+3+10*(FAIO.MorphBalanceSelected-1), startY+30, FAIO.MorphBalanceSelectedHP, 0)
	end

end

function FAIO.MorphSelectCombo(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local adaptiveStrike = NPC.GetAbilityByIndex(myHero, 1)

	if adaptiveStrike and Ability.SecondsSinceLastUse(adaptiveStrike) > -1 and Ability.SecondsSinceLastUse(adaptiveStrike) < ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1150) + 0.15 then
		FAIO.morphlingComboSelect = false
		return
	end

	if Entity.GetHealth(enemy) >= FAIO.morphlingTotalDMGwoWave then
		FAIO.morphlingComboSelect = true
	else
		FAIO.morphlingComboSelect = false
	end
	return

end		

function FAIO.drawMorphlingKillIndicator(myHero)

	if not myHero then return end
	
	if FAIO.morphlingTotalDMG == 0 then return end

	local enemy = FAIO.targetChecker(Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY))
		if not enemy then return end
		if not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end

	local pos = Entity.GetAbsOrigin(enemy)
	local posY = NPC.GetHealthBarOffset(enemy)
		pos:SetZ(pos:GetZ() + posY)
			
	local x, y, visible = Renderer.WorldToScreen(pos)

	if FAIO.morphlingTotalDMG > 0 then
		if visible then
			if Entity.GetHealth(enemy) > FAIO.morphlingTotalDMG then
				Renderer.SetDrawColor(255,102,102,255)
			else
				Renderer.SetDrawColor(50,205,50,255)
			end
				Renderer.DrawText(FAIO.skywrathFont, x-50, y-70, "Shotgun DMG:  " .. math.floor(FAIO.morphlingTotalDMG), 0)
		end
	end

end

function FAIO.PuckCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroPuck) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	local illusoryOrb = NPC.GetAbilityByIndex(myHero, 0)
	local etherealJaunt = NPC.GetAbility(myHero, "puck_ethereal_jaunt")
	local waningRift = NPC.GetAbilityByIndex(myHero, 1)
	local phaseShift = NPC.GetAbility(myHero, "puck_phase_shift")
	local dreamCoil = NPC.GetAbility(myHero, "puck_dream_coil")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)
	FAIO_itemHandler.itemUsage(myHero, enemy)

	local orbIsFlying = false
	if illusoryOrb and Ability.SecondsSinceLastUse(illusoryOrb) > 0 and Ability.SecondsSinceLastUse(illusoryOrb) <= 2.995 then
		orbIsFlying = true
	end

	if orbIsFlying then
		FAIO.lastPosition = Vector(0, 0, 0)
	end
		
	if Menu.IsEnabled(FAIO_options.optionHeroPuckPanic) then
		if Menu.IsKeyDownOnce(FAIO_options.optionHeroPuckPanicKey) then
			FAIO.GenericUpValue = false
		end
		if Menu.IsKeyDown(FAIO_options.optionHeroPuckPanicKey) then
			FAIO.PuckPanic(myHero, enemy, myMana, orbIsFlying)
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroPuckDefend) then
		FAIO.PuckDefend(myHero, enemy, myMana, waningRift)
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.GetHealth(enemy) > 0 and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and FAIO.heroCanCastSpells(myHero, enemy) == true then
		if not NPC.IsEntityInRange(myHero, enemy, 375) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1000) then
					FAIO.lastPosition = Entity.GetAbsOrigin(myHero)
					if Menu.GetValue(FAIO_options.optionHeroPuckJump) == 0 then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(175))
						return
					else
						if #NPCs.InRadius(Entity.GetAbsOrigin(enemy), 375, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) <= 1 then
							Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(175))
							return
						else
							local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 700, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 350)
							if bestPos ~= nil then
								Ability.CastPosition(blink, bestPos)
								return
							end
						end
					end
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end

			if not blink and Menu.IsEnabled(FAIO_options.optionHeroPuckOrbInit) then
				if FAIO.SleepReady(0.15) and illusoryOrb and Ability.IsCastable(illusoryOrb, myMana) then
					local orbPrediction = Ability.GetCastPoint(illusoryOrb) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 651) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(illusoryOrb, FAIO_utility_functions.castLinearPrediction(myHero, enemy, orbPrediction))
					FAIO.lastTick = os.clock()
					FAIO.PuckOrbCastTime = GameRules.GetGameTime()
					return
				end
				if etherealJaunt and Ability.IsReady(etherealJaunt) then
					for _, v in ipairs(FAIO.PuckOrbHitSim) do
						local origin = v[1]
						local velocity = v[2]
						local orbPos = origin + velocity:Scaled(GameRules.GetGameTime() - FAIO.PuckOrbCastTime)
						if NPC.IsPositionInRange(enemy, orbPos, 150, 0) then
							Ability.CastNoTarget(etherealJaunt)
							FAIO.PuckOrbHitSim = {}
							return
						end
					end
				end		
			end
		else
			if not Ability.IsChannelling(phaseShift) or NPC.HasModifier(myHero, "modifier_eul_cyclone") then
				if FAIO.SleepReady(0.15) and waningRift and Ability.IsCastable(waningRift, myMana) then 
					Ability.CastNoTarget(waningRift)
					FAIO.lastTick = os.clock()
				end
				if Menu.IsKeyDown(FAIO_options.optionHeroPuckComboAltKey) then	
					if FAIO.SleepReady(0.15) and dreamCoil and Ability.IsCastable(dreamCoil, myMana) then
						local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 700, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), 350)
						if bestPos ~= nil then
							Ability.CastPosition(dreamCoil, bestPos)
							FAIO.lastTick = os.clock()
						end
					end
				end
				if FAIO.SleepReady(0.15) and illusoryOrb and Ability.IsCastable(illusoryOrb, myMana) then
					if FAIO.lastPosition:__tostring() ~= Vector(0, 0, 0):__tostring() then
						Ability.CastPosition(illusoryOrb, Entity.GetAbsOrigin(myHero) + (FAIO.lastPosition - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500))
						FAIO.lastTick = os.clock()
						return
					end
					if FAIO.lastPosition:__tostring() == Vector(0, 0, 0):__tostring() then
						Ability.CastPosition(illusoryOrb, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500))
						FAIO.lastTick = os.clock()
						return
					end
				end			
			else
				FAIO.GenericUpValue = false
				FAIO.PuckPanic(myHero, enemy, myMana, orbIsFlying)
			end
		end
	FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)	
	end
end

function FAIO.PuckPanic(myHero, enemy, myMana, orbIsFlying)

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end

	local illusoryOrb = NPC.GetAbilityByIndex(myHero, 0)
	local etherealJaunt = NPC.GetAbility(myHero, "puck_ethereal_jaunt")
	local phaseShift = NPC.GetAbility(myHero, "puck_phase_shift")

	local blink = NPC.GetItem(myHero, "item_blink", true)
	local euls = NPC.GetItem(myHero, "item_cyclone", true)

	local orbFlyingTimeLeft = 0
		if orbIsFlying then
			orbFlyingTimeLeft = 2.995 - Ability.SecondsSinceLastUse(illusoryOrb)
		end

	if NPC.IsSilenced(myHero) then
		if not FAIO.GenericUpValue then
			if blink and Ability.IsReady(blink) then
				if Menu.GetValue(FAIO_options.optionHeroPuckPanicDirection) == 0 then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
					FAIO.GenericUpValue = true
					return
				else
					Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
					FAIO.GenericUpValue = true
					return
				end
			end
			if (blink and Ability.GetCooldownTimeLeft(blink) <= 2.5) or (illusoryOrb and Ability.GetCooldownTimeLeft(illusoryOrb) <= 2.5) or (phaseShift and blink and Ability.GetCooldownTimeLeft(blink) <= 2.5 + Ability.GetLevelSpecialValueForFloat(phaseShift, "duration")) then
				if euls and Ability.IsCastable(euls, myMana) then
					Ability.CastTarget(euls, myHero)
					return
				end
			end
		end
		if (not euls or (euls and not Ability.IsCastable(euls, myMana))) and (not blink or (blink and not Ability.IsReady(blink))) then
			return
		end	
	else
		if not FAIO.GenericUpValue and not Ability.IsChannelling(phaseShift) then
			if illusoryOrb and Ability.SecondsSinceLastUse(illusoryOrb) > 0 and Ability.SecondsSinceLastUse(illusoryOrb) <= 2.995 then
				if Ability.SecondsSinceLastUse(illusoryOrb) > 0 and Ability.SecondsSinceLastUse(illusoryOrb) <= 1.25 then
					if phaseShift and Ability.IsReady(phaseShift) then
						Ability.CastNoTarget(phaseShift)
						return
					end
				end
				if Ability.SecondsSinceLastUse(illusoryOrb) > 1.25 and Ability.SecondsSinceLastUse(illusoryOrb) <= 2.995 then
					if etherealJaunt and Ability.IsReady(etherealJaunt) then
						Ability.CastNoTarget(etherealJaunt)
						FAIO.GenericUpValue = true
						return
					end
				end
			end		
			if blink then
				if Ability.IsReady(blink) then
					if Menu.GetValue(FAIO_options.optionHeroPuckPanicDirection) == 0 then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
						FAIO.GenericUpValue = true
						return
					else
						Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
						FAIO.GenericUpValue = true
						return
					end
				end
				if Ability.GetCooldownTimeLeft(blink) > 0.1 and Ability.GetCooldownTimeLeft(blink) < Ability.GetLevelSpecialValueForFloat(phaseShift, "duration") then
					if phaseShift and Ability.IsReady(phaseShift) then
						Ability.CastNoTarget(phaseShift)
						return
					end
				end
			end
			if illusoryOrb and Ability.IsCastable(illusoryOrb, myMana) and (phaseShift and Ability.IsReady(phaseShift)) then
				if Menu.GetValue(FAIO_options.optionHeroPuckPanicDirection) == 0 then
					Ability.CastPosition(illusoryOrb, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500))
					Ability.CastNoTarget(phaseShift, true)
					return
				else
					Ability.CastPosition(illusoryOrb, Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500))
					Ability.CastNoTarget(phaseShift, true)
					return
				end
			end
			if euls and Ability.IsCastable(euls, myMana) then
				if (blink and Ability.GetCooldownTimeLeft(blink) > Ability.GetLevelSpecialValueForFloat(phaseShift, "duration") and Ability.GetCooldownTimeLeft(blink) <= Ability.GetLevelSpecialValueForFloat(phaseShift, "duration") + 2.5) or (illusoryOrb and Ability.GetCooldownTimeLeft(illusoryOrb) > 0 and Ability.GetCooldownTimeLeft(illusoryOrb) < 2.5 and phaseShift and Ability.GetCooldownTimeLeft(phaseShift) < 2.5) then
					Ability.CastTarget(euls, myHero)
					return
				end
			end	
		end
	end

	if Ability.IsChannelling(phaseShift) then
		if not FAIO.GenericUpValue then
			if orbIsFlying then
				local phaseShiftTimeLeft = math.max(Ability.GetChannelStartTime(phaseShift) + Ability.GetLevelSpecialValueForFloat(phaseShift, "duration") - GameRules.GetGameTime(), 0)
				if etherealJaunt and Ability.IsReady(etherealJaunt) then
					if phaseShiftTimeLeft > orbFlyingTimeLeft then
						if orbFlyingTimeLeft / 2.995 <= 0.25 then
							Ability.CastNoTarget(etherealJaunt)
							FAIO.GenericUpValue = true
							return
						end
					else
						if phaseShiftTimeLeft / Ability.GetLevelSpecialValueForFloat(phaseShift, "duration") <= 0.25 then
							Ability.CastNoTarget(etherealJaunt)
							FAIO.GenericUpValue = true
							return
						end
					end
						
				end
			end
			if not orbIsFlying then
				if blink and Ability.IsReady(blink) then
					if Menu.GetValue(FAIO_options.optionHeroPuckPanicDirection) == 0 then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
						FAIO.GenericUpValue = true
						return
					else
						Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
						FAIO.GenericUpValue = true
						return
					end
				end
			end
			
		end
	end				
end


function FAIO.PuckDefend(myHero, enemy, myMana, waningRift)

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not waningRift then return end
	if not Ability.IsCastable(waningRift, myMana) then return end

	for _, heroes in ipairs(NPC.GetHeroesInRadius(myHero, 400, Enum.TeamType.TEAM_ENEMY)) do
		if heroes and not NPC.IsDormant(heroes) and Entity.IsAlive(heroes) then
			local enemyDagger = NPC.GetItem(heroes, "item_blink", true)
			if enemyDagger and NPC.IsEntityInRange(myHero, heroes, 375) and Ability.GetCooldownTimeLeft(enemyDagger) >= 9 and Ability.SecondsSinceLastUse(enemyDagger) > 0 and Ability.SecondsSinceLastUse(enemyDagger) <= 1 then
				if waningRift and Ability.IsCastable(waningRift, myMana) and not NPC.HasState(heroes, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					Ability.CastNoTarget(waningRift)
					break
					return
				end
			end
		end
	end
end

function FAIO.ZuusCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroZuus) then return end

  	local arc = NPC.GetAbilityByIndex(myHero, 0)
 	local bolt = NPC.GetAbilityByIndex(myHero, 1)
 	local static = NPC.GetAbilityByIndex(myHero, 2)
 	local wrath = NPC.GetAbility(myHero, "zuus_thundergods_wrath")
	local nimbus = NPC.GetAbility(myHero, "zuus_cloud")

	local lens = NPC.GetItem(myHero, "item_aether_lens", true)
	local refresher = NPC.GetItem(myHero, "item_refresher", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	local bonusTalentRange = NPC.GetAbility(myHero, "special_bonus_cast_range_200")
  	local arcBonusTalentDamage = NPC.GetAbility(myHero, "special_bonus_unique_zeus_2")
  	local staticBonusTalentDamage = NPC.GetAbility(myHero, "special_bonus_unique_zeus")
	local spellAmplification = Hero.GetIntellectTotal(myHero)  / 14 / 100

	local arcCastRange = 850
  	local boltCastRange = 700
  	local staticCastRange = 1200

	if lens then
    		arcCastRange = arcCastRange + 250
    		boltCastRange = boltCastRange + 250
    		staticCastRange = staticCastRange + 250
  	end

	local arcDamage = 0
		if arc then
			arcDamage = Ability.GetLevelSpecialValueFor(arc, "arc_damage") * (1 + spellAmplification / 100)
		end
  	local boltDamage = Ability.GetDamage(bolt) * (1 + spellAmplification / 100)
	local staticDamage = 0
	if static and Ability.GetLevel(static) > 0 then
		staticDamage = 2 + (2 * Ability.GetLevel(static))
	end
  	local wrathDamage = (225 + (100 * (Ability.GetLevel(wrath) - 1))) * (1 + spellAmplification / 100)

	if arcBonusTalentDamage and Ability.GetLevel(arcBonusTalentDamage) > 0 then
    		arcDamage = arcDamage + (75 * (1 + spellAmplification / 100))
  	end

	if bonusTalentRange and Ability.GetLevel(bonusTalentRange) > 0 then
    		arcCastRange = arcCastRange + 200
    		boltCastRange = boltCastRange + 200
    		staticCastRange = staticCastRange + 200
  	end

	if staticBonusTalentDamage and Ability.GetLevel(staticBonusTalentDamage) > 0 then
      		staticDamage = staticDamage + 2
    	end

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsKeyDown(FAIO_options.optionHeroZuusFarmKey) then
		FAIO.ZuusArcFarm(myHero, myMana, arc, arcDamage, arcCastRange, staticDamage)
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroZuusHarassKey) then
		FAIO.ZuusArcHarass(myHero, myMana, arc, arcCastRange)
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroZuusFarmKey) or Menu.IsKeyDown(FAIO_options.optionHeroZuusHarassKey) then
		Engine.ExecuteCommand("dota_range_display " .. tostring(arcCastRange))
	else
		Engine.ExecuteCommand("dota_range_display 0")
	end

	if Menu.IsEnabled(FAIO_options.optionHeroZuusKillsteal) then
		FAIO.ZuusFullKillSteal(myHero, myMana, arc, bolt, static, wrath, arcCastRange, boltCastRange, staticCastRange, arcDamage, boltDamage, staticDamage, wrathDamage, refresher, nimbus)
	end
	
	if enemy and NPC.IsEntityInRange(myHero, enemy, 2000) then	
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				if not NPC.IsEntityInRange(myHero, enemy, boltCastRange) then
					if blink and Ability.IsReady(blink) and Menu.IsEnabled(FAIO_options.optionHeroZuusBlink) then
						if NPC.IsEntityInRange(myHero, enemy, 1900) then
							Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(750))
							return
						else
							if FAIO.SleepReady(0.5) then
								Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
					if not blink or (blink and not Ability.IsReady(blink)) or not Menu.IsEnabled(FAIO_options.optionHeroZuusBlink) then
						if FAIO.SleepReady(0.5) then
							NPC.MoveTo(myHero, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(boltCastRange - 75), false, false)
							FAIO.lastTick = os.clock()
							return
						end
					end
					if arc and Ability.IsCastable(arc, myMana) and NPC.IsEntityInRange(myHero, enemy, arcCastRange) then
						Ability.CastTarget(arc, enemy)
						FAIO.lastTick = os.clock()
					end	
				else
					if arc and Ability.IsCastable(arc, myMana) then
						Ability.CastTarget(arc, enemy)
						FAIO.lastTick = os.clock()
					end
					if FAIO.SleepReady(0.2) and bolt and Ability.IsCastable(bolt, myMana) then
						Ability.CastTarget(bolt, enemy)
						FAIO.lastTick = os.clock()
					end
				end
			end
			if Menu.IsEnabled(FAIO_options.optionHeroZuusRightClick) then
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			end
		end
	end

end

function FAIO.ZuusArcHarass(myHero, myMana, arc, arcCastRange)

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not arc then return end
		if not Ability.IsCastable(arc, myMana) then return end

	local targetHero
	local minHP = 99999

	if (myMana / NPC.GetMaxMana(myHero)) >= (Menu.GetValue(FAIO_options.optionHeroZuusHarassMana) / 100) then
		for _, hero in ipairs(NPC.GetHeroesInRadius(myHero, arcCastRange - 25, Enum.TeamType.TEAM_ENEMY)) do
			if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then
				if Entity.IsAlive(hero) then
					if Entity.GetHealth(hero) < minHP then
						targetHero = hero
						minHP = Entity.GetHealth(hero)
					end
				end
			end
		end
	end

	if targetHero then
		Ability.CastTarget(arc, targetHero)
        	return
	else
		if (myMana / NPC.GetMaxMana(myHero)) >= (Menu.GetValue(FAIO_options.optionHeroZuusHarassMana) / 100) then
			for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, arcCastRange - 25, Enum.TeamType.TEAM_ENEMY)) do
				if npc and not Entity.IsDormant(npc) and not Entity.IsHero(npc) and NPC.IsCreep(npc) then 
					if Entity.IsAlive(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
        					Ability.CastTarget(arc, npc)
						break
        					return
					end
				end	
			end
      		end		
	end

end

function FAIO.ZuusArcFarm(myHero, myMana, arc, arcDamage, arcCastRange, staticDamage)

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not arc then return end
		if not Ability.IsCastable(arc, myMana) then return end

	for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, arcCastRange - 25, Enum.TeamType.TEAM_ENEMY)) do

		if npc and not Entity.IsDormant(npc) and not Entity.IsHero(npc) and NPC.IsCreep(npc) then 
			if Entity.IsAlive(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
      				if Entity.GetHealth(npc) < (arcDamage + (Entity.GetHealth(npc) * (staticDamage / 100))) * NPC.GetMagicalArmorDamageMultiplier(npc) then
        				Ability.CastTarget(arc, npc)
					break
        				return
				end
			end
      		end		
	end

end

function FAIO.ZuusFullKillSteal(myHero, myMana, arc, bolt, static, wrath, arcCastRange, boltCastRange, staticCastRange, arcDamage, boltDamage, staticDamage, wrathDamage, refresher, nimbus)

	if not myHero then return end
	
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	for i = 1, Heroes.Count() do
	local enemies = Heroes.Get(i)
		if enemies ~= nil and Entity.IsHero(enemies) and not Entity.IsSameTeam(myHero, enemies) then
			local enemy = FAIO.targetChecker(enemies)
			if enemy then
				if Ability.GetLevel(static) > 0 and NPC.IsEntityInRange(myHero, enemy, staticCastRange-25, 0) then
          				boltDamage  = boltDamage + (Entity.GetHealth(enemy) * (staticDamage / 100))
          				arcDamage = arcDamage + (Entity.GetHealth(enemy) * (staticDamage / 100))
        			end
        			boltDamage = NPC.GetMagicalArmorDamageMultiplier(enemy) * boltDamage
        			arcDamage = NPC.GetMagicalArmorDamageMultiplier(enemy) * arcDamage
        			wrathDamage = NPC.GetMagicalArmorDamageMultiplier(enemy) * wrathDamage
				if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.HasModifier(enemy, "modifier_templar_assassin_refraction_absorb") then
        				if FAIO.ZuusWrathCount(myHero, myMana, wrath, wrathDamage, static, staticDamage, staticCastRange, false) == true and wrath and Ability.IsCastable(wrath, myMana) then
            					Ability.CastNoTarget(wrath) 
            					return
          				end
					if refresher and Ability.IsCastable(refresher, myMana) then
						if FAIO.ZuusWrathCount(myHero, myMana, wrath, wrathDamage, static, staticDamage, staticCastRange, true) == true and wrath and Ability.IsCastable(wrath, myMana) then
            						Ability.CastNoTarget(wrath)
							Ability.CastNoTarget(refresher, true)
            						return
						end
					end
					if nimbus and not Ability.IsHidden(nimbus) and Ability.IsCastable(nimbus, myMana) then
						if not NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), arcCastRange, 0) then
							if Entity.GetHealth(enemy) <= boltDamage then
								Ability.CastPosition(nimbus, Entity.GetAbsOrigin(enemy))
								return
							end
						end
					end
					if not NPC.IsLinkensProtected(enemy) and Entity.GetHealth(enemy) <= arcDamage and arc and Ability.IsCastable(arc, myMana) and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), arcCastRange, 0) then
            					Ability.CastTarget(arc, enemy) 
            					return 
         				end
        				if not NPC.IsLinkensProtected(enemy) and Entity.GetHealth(enemy) <= boltDamage and bolt and Ability.IsCastable(bolt, myMana) and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), boltCastRange, 0) then
            					Ability.CastTarget(bolt, enemy) 
           	 				return
          				end
        				if not NPC.IsLinkensProtected(enemy) and Entity.GetHealth(enemy) <= (boltDamage + arcDamage) and arc and bolt and Ability.IsCastable(bolt, myMana - 80) and Ability.IsCastable(arc, myMana) and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), boltCastRange, 0) then
            					Ability.CastTarget(bolt, enemy)
						Ability.CastTarget(arc, enemy, true)
            					return 
          				end
          			end
			end
		end
	end

end

function FAIO.ZuusWrathCount(myHero, myMana, wrath, wrathDamage, static, staticDamage, staticCastRange, doubleUlt)

	if not myHero then return false end
	if not wrath then return false end
		if not Ability.IsReady(wrath) then return false end
		if not Ability.IsCastable(wrath, myMana) then return false end

	local count = 0
	local countRefresher = 0
	for i = 1, Heroes.Count(), 1 do
	local enemies = Heroes.Get(i)
		if enemies ~= nil and Entity.IsHero(enemies) and not Entity.IsSameTeam(myHero, enemies) then
			local enemy = FAIO.targetChecker(enemies)
			if enemy then
				if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
					if not doubleUlt then
						if Ability.GetLevel(static) > 0 and NPC.IsEntityInRange(myHero, enemy, staticCastRange-25, 0) then
							if Entity.GetHealth(enemy) <= (wrathDamage + (Entity.GetHealth(enemy) * (staticDamage / 100))) then
								count = count + 1
							end
						else
							if Entity.GetHealth(enemy) <= wrathDamage then
								count = count + 1
							end
						end
					else
						if Ability.GetLevel(static) > 0 and NPC.IsEntityInRange(myHero, enemy, staticCastRange-25, 0) then
							if Entity.GetHealth(enemy) <= (wrathDamage + (Entity.GetHealth(enemy) * (staticDamage / 100))) * 2 then
								countRefresher = countRefresher + 1
							end
						else
							if Entity.GetHealth(enemy) <= wrathDamage * 2 then
								countRefresher = countRefresher + 1
							end
						end	
					end
				end
			end
		end
	end

	if count > 0 and doubleUlt == false then
		if count >= Menu.GetValue(FAIO_options.optionHeroZuusUltCount) then
			return true
		end
	end

	if countRefresher > 0 and doubleUlt == true and myMana > (Ability.GetManaCost(wrath) * 2 + 375) then
		if countRefresher >= Menu.GetValue(FAIO_options.optionHeroZuusUltCountRefresher) then
			return true
		end
	end

	return false

end

function FAIO.ProphetHelper(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroProphet) then return end
	
	if Menu.IsKeyDownOnce(FAIO_options.optionHeroProphetToggleKey) then
		FAIO.Toggler = not FAIO.Toggler
		FAIO.TogglerTime = os.clock()
	end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if enemy and NPC.IsEntityInRange(myHero, enemy, 2000) then	
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) and FAIO.heroCanCastItems(myHero) == true then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		end
	end
	
	local treantEntities = {}
	if FAIO.Toggler then
		for i = 1, NPCs.Count() do 
		local npc = NPCs.Get(i)
			if npc and Entity.IsSameTeam(myHero, npc) and Entity.IsAlive(npc) then
				if npc ~= myHero then
					if Entity.GetOwner(npc) == myHero then
						if npc ~= nil then
							if NPC.GetUnitName(npc) == "npc_dota_furion_treant" then
								if npc ~= nil then
									FAIO.GenericAttackIssuer2("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE", nil, FAIO.GenericLanePusher(npc), npc)
								end
							end	
						end
					end
				end
			end
		end
	end
			
end

function FAIO.DrawProphetHelperSwitch()

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 0, 255)

	if os.clock() - FAIO.TogglerTime < 3 then
		if FAIO.Toggler then
			Renderer.DrawTextCentered(FAIO.font, w / 2, h / 2 + 300, "LANE PUSH ON", 1)
		else 
			Renderer.DrawTextCentered(FAIO.font, w / 2, h / 2 + 300, "LANE PUSH OFF", 1)
		end
	end

end

function FAIO.DrawProphetAwareness(myHero)

	if not myHero then return end
	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	for i = 1, Heroes.Count() do 
	local hero = Heroes.Get(i)
		if hero and not Entity.IsSameTeam(myHero, hero) and Entity.IsAlive(hero) then
			if not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then
				if Entity.GetHealth(hero) / Entity.GetMaxHealth(hero) <= 0.20 then
					Renderer.DrawTextCentered(FAIO.font, w / 2, h / 2 + 300, "POSSIBLE PORT TARGET", 1)
					FAIO.DrawProphetAwarenessMinimap(hero)
				end
			end
		end
	end
end

function FAIO.DrawProphetAwarenessMinimap(hero)

	if not hero then return end
	if not Menu.IsEnabled(FAIO_options.optionProphetDrawKSminimap) then return end

	local w, h = Renderer.GetScreenSize()
	local targetPos = Entity.GetAbsOrigin(hero)
	Renderer.SetDrawColor(255, 255, 255)

	position = FAIO:WorldToMiniMap(targetPos, w, h)
	Renderer.DrawText(FAIO.font, position:GetX(), position:GetY(), "X", 1)

end

function FAIO.InvokerCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroInvoker) then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end

	if os.clock() - FAIO.invokerCaptureGhostwalkActivation < 1.0 then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then
		return
	end

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	local emp = NPC.GetAbility(myHero, "invoker_emp")
	local tornado = NPC.GetAbility(myHero, "invoker_tornado")
	local ghostWalk = NPC.GetAbility(myHero, "invoker_ghost_walk")
	local deafeningBlast = NPC.GetAbility(myHero, "invoker_deafening_blast")
	local chaosMeteor = NPC.GetAbility(myHero, "invoker_chaos_meteor")
	local iceWall = NPC.GetAbility(myHero, "invoker_ice_wall")
	local coldSnap = NPC.GetAbility(myHero, "invoker_cold_snap")
	local alacrity = NPC.GetAbility(myHero, "invoker_alacrity")
	local forgeSpirit = NPC.GetAbility(myHero, "invoker_forge_spirit")

	local invoke = NPC.GetAbility(myHero, "invoker_invoke")
	local myMana = NPC.GetMana(myHero)
	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local refresher = NPC.GetItem(myHero, "item_refresher", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)
		if not Menu.IsEnabled(FAIO_options.optionHeroInvokerBlink) then
			blink = nil
		end

	if NPC.HasAbility(myHero, "special_bonus_unique_invoker_8") then
		if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_invoker_8")) > 0 then
			if FAIO_data.invokerTornadoLiftDuration[1] < 1.1 then
				FAIO_data.invokerTornadoLiftDuration = { 1.1, 1.4, 1.7, 2.0, 2.3, 2.6, 2.9, 3.2 }
			end
		end
	end
	
	local euls = NPC.GetItem(myHero, "item_cyclone", true)

	local invokeTranslator = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity"
			}

	if Menu.IsKeyDown(FAIO_options.optionHeroInvokerAltKey) and Menu.IsKeyDown(FAIO_options.optionComboKey) then
		if FAIO.InvokerComboSelector == 1 then
			FAIO.PreInvokeSkills = {{coldSnap, forgeSpirit}}
		elseif FAIO.InvokerComboSelector == 2 then
			FAIO.PreInvokeSkills = {{coldSnap, forgeSpirit}}
		elseif FAIO.InvokerComboSelector == 3 then
			FAIO.PreInvokeSkills = {{emp, tornado}}
		elseif FAIO.InvokerComboSelector == 4 then
			FAIO.PreInvokeSkills = {{chaosMeteor, tornado}}
		elseif FAIO.InvokerComboSelector == 5 then
			FAIO.PreInvokeSkills = {{chaosMeteor, sunStrike}}
		elseif FAIO.InvokerComboSelector == 6 then
			FAIO.PreInvokeSkills = {{emp, tornado}}
		elseif FAIO.InvokerComboSelector == 7 then
			FAIO.PreInvokeSkills = {{sunStrike, tornado}}
		elseif FAIO.InvokerComboSelector == 8 then
			FAIO.PreInvokeSkills = {{sunStrike, tornado}}
		elseif FAIO.InvokerComboSelector == 9 then
			FAIO.PreInvokeSkills = {{emp, tornado}}
		elseif FAIO.InvokerComboSelector == 10 then
			FAIO.PreInvokeSkills = {{deafeningBlast, chaosMeteor}}
		elseif FAIO.InvokerComboSelector == 12 then
			if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) <= 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])}}
				else
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
				end
			end
		elseif FAIO.InvokerComboSelector == 13 then
			if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) <= 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])}}
				else
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
				end
			end
		elseif FAIO.InvokerComboSelector == 14 then
			if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) <= 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
				elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])}}
				else
					FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
				end
			end
		end
	end
	
	if FAIO.getInvokerGhostWalkKey == nil then
		FAIO.getInvokerGhostWalkKey = Config.ReadString("", "Ghost Walk Key0", defaultValue)
	end

	if Input.IsKeyDownOnce(FAIO.getInvokerGhostWalkKey) then
		FAIO.invokerCaptureGhostwalkActivation = os.clock()
	end
	
	if next(FAIO.PreInvokeSkills) ~= nil then
		FAIO.InvokerPreInvoke(myHero, myMana, invoke)
	end
	
	if Menu.IsKeyDown(FAIO_options.optionHeroInvokerIcewallKey) then
		FAIO.InvokerFastIceWall(myHero, myMana, invoke, enemy)
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroInvokerAlacrityKey) then
		FAIO.InvokerFastAlacrity(myHero, myMana, invoke, enemy)
	end

	if Menu.IsKeyDown(FAIO_options.optionHeroInvokerTornadoKey) then
		FAIO.InvokerFastTornado(myHero, myMana, invoke, enemy)
	end

	if Menu.IsKeyDownOnce(FAIO_options.optionHeroInvokerCustom1Key) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 12 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)])}}
						FAIO.InvokerComboSelector = 12
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
						FAIO.InvokerComboSelector = 12
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])}}
						FAIO.InvokerComboSelector = 12
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
						FAIO.InvokerComboSelector = 12
					end
				else
					FAIO.InvokerComboSelector = 0
				end	
			end
		else
			if FAIO.InvokerComboSelector ~= 12 then
				FAIO.InvokerComboSelector = 12
			end
		end
	end

	if Menu.IsKeyDownOnce(FAIO_options.optionHeroInvokerCustom2Key) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 13 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)])}}
						FAIO.InvokerComboSelector = 13
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
						FAIO.InvokerComboSelector = 13
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])}}
						FAIO.InvokerComboSelector = 13
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
						FAIO.InvokerComboSelector = 13
					end
				else
					FAIO.InvokerComboSelector = 0
				end		
			end
		else
			if FAIO.InvokerComboSelector ~= 13 then
				FAIO.InvokerComboSelector = 13
			end
		end
	end

	if Menu.IsKeyDownOnce(FAIO_options.optionHeroInvokerCustom3Key) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 14 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)])}}
						FAIO.InvokerComboSelector = 14
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
						FAIO.InvokerComboSelector = 14
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])}}
						FAIO.InvokerComboSelector = 14
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
						FAIO.InvokerComboSelector = 14
					end
				else
					FAIO.InvokerComboSelector = 0
				end		
			end
		else
			if FAIO.InvokerComboSelector ~= 14 then
				FAIO.InvokerComboSelector = 14
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerCancelEnable) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerCancelTPFog) then
			FAIO.InvokerCancelTPingInFog(myHero, myMana, enemy, invoke, tornado)
		end
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerCancelBara) then
			FAIO.InvokerCancelBaraCharge(myHero, myMana, enemy, invoke, coldSnap, tornado, deafeningBlast)
		end
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerCancelChannelling) then
			FAIO.InvokerCancelVisibleChannellingAbilities(myHero, myMana, enemy, invoke, coldSnap, tornado)
		end
	end

	if Menu.IsEnabled(FAIO_options.optionKillStealInvokerTPpartice) then
		FAIO.EnemyHPTracker(myHero)
	end
	
	if Menu.IsEnabled(FAIO_options.optionHeroInvokerCataKS) then
		FAIO.InvokerCataclysmKillSteal(myHero, myMana, invoke)
	end

	if FAIO.getInvokerSettings == nil then
		FAIO.getInvokerSettings = Menu.GetValue(FAIO_options.optionHeroInvokerDisableBuildInGetOption)
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerDisableBuildIn) then
		if FAIO.getInvokerSettings > 0 then
			if Menu.IsKeyDown(FAIO_options.optionComboKey) then
    				Menu.SetValue(FAIO_options.optionHeroInvokerDisableBuildInGetOption, 0)
			else
				Menu.SetValue(FAIO_options.optionHeroInvokerDisableBuildInGetOption, 1)
			end
		end
	end

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and not Menu.IsKeyDown(FAIO_options.optionHeroInvokerAltKey) then
		if enemy and Entity.GetHealth(enemy) > 0 then
			if NPC.IsEntityInRange(myHero, enemy, 1500) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				if FAIO.InvokerComboSelector == 0 then
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
				elseif FAIO.InvokerComboSelector == 1 then
					FAIO.InvokerComboCSAlacritySpirit(myHero, myMana, enemy, coldSnap, alacrity, forgeSpirit, blink, invoke)
				elseif FAIO.InvokerComboSelector == 2 then
					FAIO.InvokerComboCSSpiritSunstrike(myHero, myMana, enemy, coldSnap, forgeSpirit, sunStrike, blink, invoke)
				elseif FAIO.InvokerComboSelector == 3 then
					FAIO.InvokerComboTornadoEmpIcewall(myHero, myMana, enemy, tornado, emp, iceWall, coldSnap, blink, invoke)
				elseif FAIO.InvokerComboSelector == 4 then
					FAIO.InvokerComboTornadoMeteorBlast(myHero, myMana, enemy, tornado, chaosMeteor, deafeningBlast, blink, invoke)
				elseif FAIO.InvokerComboSelector == 5 then
					FAIO.InvokerComboEulsSunstrikeMeteorBlast(myHero, myMana, enemy, sunStrike, chaosMeteor, deafeningBlast, blink, euls, invoke)
				elseif FAIO.InvokerComboSelector == 6 then
					FAIO.InvokerComboAghaTornadoEmpMeteorBlast(myHero, myMana, enemy, tornado, emp, chaosMeteor, deafeningBlast, aghanims, blink, invoke)
				elseif FAIO.InvokerComboSelector == 7 then
					FAIO.InvokerComboAghaTornadoSunstrikeMeteorBlast(myHero, myMana, enemy, tornado, sunStrike, chaosMeteor, deafeningBlast, aghanims, blink, invoke)
				elseif FAIO.InvokerComboSelector == 8 then
					FAIO.InvokerComboRefresherAghaTornadoSunstrikeMeteorBlast(myHero, myMana, enemy, tornado, sunStrike, chaosMeteor, deafeningBlast, aghanims, refresher, blink, invoke)
				elseif FAIO.InvokerComboSelector == 9 then
					FAIO.InvokerComboRefresherAghaTornadoEmpMeteorBlast(myHero, myMana, enemy, tornado, emp, chaosMeteor, deafeningBlast, aghanims, refresher, blink, invoke)
				elseif FAIO.InvokerComboSelector == 10 then
					FAIO.InvokerComboRefresherAghaBlastMeteorSunstrike(myHero, myMana, enemy, deafeningBlast, chaosMeteor, sunStrike, blink, aghanims, refresher, invoke)
				elseif FAIO.InvokerComboSelector == 11 then
					FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				elseif FAIO.InvokerComboSelector == 12 then
					FAIO.InvokerComboCustomMode(myHero, myMana, enemy, blink, invoke)
				elseif FAIO.InvokerComboSelector == 13 then
					FAIO.InvokerComboCustomMode(myHero, myMana, enemy, blink, invoke)
				elseif FAIO.InvokerComboSelector == 14 then
					FAIO.InvokerComboCustomMode(myHero, myMana, enemy, blink, invoke)
				end
			else
				FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			end
		end
	else
		FAIO.InvokerCanComboStart = false
	end

end

function FAIO.InvokerIceWallHelper(myHero, enemy, iceWall, myMana)
	
	if not myHero then return end
	if not enemy then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end

	if not iceWall then return end
	if not Ability.IsReady(iceWall) or not Ability.IsCastable(iceWall, myMana) or not FAIO.InvokerIsAbilityInvoked(myHero, iceWall) then return end
	if not NPC.IsEntityInRange(myHero, enemy, 600) then return end

	local betaRad = math.acos(200 / (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D())
	local beta = betaRad * 180 / math.pi
	local delta = math.acos((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Dot(Entity.GetRotation(myHero):GetForward()) / (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() * (Entity.GetRotation(myHero):GetForward()):Length2D()) * 180 / math.pi

	if NPC.IsEntityInRange(myHero, enemy, 275) then
		Ability.CastNoTarget(iceWall)
		return
	else
		if math.abs(delta - beta) > 7.5 then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(5):Rotated(Angle(0, beta, 0)))
			return
		else
			Ability.CastNoTarget(iceWall)
			return
		end
	end

end

function FAIO.InvokerComboCSAlacritySpirit(myHero, myMana, enemy, coldSnap, alacrity, forgeSpirit, blink, invoke)

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if FAIO.InvokerInvokedChecker(myHero, "invoker_cold_snap", "invoker_forge_spirit") and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + 400) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(400))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				return
			end
		else
			if FAIO.SleepReady(0.05) and coldSnap and Ability.IsCastable(coldSnap, myMana) then
				Ability.CastTarget(coldSnap, enemy)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.05) and forgeSpirit and Ability.IsCastable(forgeSpirit, myMana) then
				Ability.CastNoTarget(forgeSpirit)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, alacrity) then
				FAIO.invokerInvokeAbility(myHero, alacrity)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end	




	if not Ability.IsReady(coldSnap) and not Ability.IsReady(forgeSpirit) then
		if FAIO.SleepReady(0.05) and alacrity and Ability.IsCastable(alacrity, myMana) then
			Ability.CastTarget(alacrity, myHero)
			FAIO.lastTick = os.clock()
			return
		end
	end

	FAIO.invokerForgedSpiritController(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(coldSnap) and not Ability.IsReady(forgeSpirit) and not Ability.IsReady(alacrity) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

function FAIO.InvokerComboCSSpiritSunstrike(myHero, myMana, enemy, coldSnap, forgeSpirit, sunStrike, blink, invoke)

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if FAIO.InvokerInvokedChecker(myHero, "invoker_cold_snap", "invoker_forge_spirit") and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + 400) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(400))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				return
			end
		else
			if FAIO.SleepReady(0.05) and coldSnap and Ability.IsCastable(coldSnap, myMana) then
				Ability.CastTarget(coldSnap, enemy)
				FAIO.lastTick = os.clock()
				return
			end
			if not Ability.IsReady(coldSnap) and FAIO.SleepReady(0.05) and forgeSpirit and Ability.IsCastable(forgeSpirit, myMana) then
				Ability.CastNoTarget(forgeSpirit)
				FAIO.lastTick = os.clock()
				return
			end
			if not Ability.IsReady(forgeSpirit) and FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
				FAIO.invokerInvokeAbility(myHero, sunStrike)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end
	
	FAIO.invokerForgedSpiritController(myHero, enemy)

	if not Ability.IsReady(coldSnap) and not Ability.IsReady(forgeSpirit) then
		if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
			if not Entity.IsTurning(enemy) then
				Ability.CastPosition(sunStrike, FAIO_utility_functions.castPrediction(myHero, enemy, Ability.GetCastPoint(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)))
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(coldSnap) and not Ability.IsReady(forgeSpirit) and not Ability.IsReady(sunStrike) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end


function FAIO.InvokerComboTornadoEmpIcewall(myHero, myMana, enemy, tornado, emp, iceWall, coldSnap, blink, invoke)

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	local rangeChecker
		if 400 + (400 * Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1))) < 1000 then
			rangeChecker = 400 + (400 * Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)))
		else
			rangeChecker = 1000
		end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end

	if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(emp), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, 1000) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					FAIO.noItemCastFor(0.5)
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor(0.5)
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				FAIO.noItemCastFor(0.5)
				return
			end
		else
			local travelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
			local tornadoTiming = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + travelTime
			if tornadoTiming < 2.9 then
				if FAIO.SleepReady(0.05) and emp and Ability.IsCastable(emp, myMana) then
					if NPC.IsEntityInRange(myHero, enemy, 925) then
						Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						return
					else
						Ability.CastPosition(emp, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(925))
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						return
					end
				end
				if not Ability.IsReady(emp) then
					if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
						if os.clock() - FAIO.lastCastTime <= 2.9 - tornadoTiming - 0.5 then
							FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
							return
						else	
							if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
								local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
								Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
								FAIO.lastTick = os.clock()
								FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
								return
							else
								Ability.CastPosition(tornado, Input.GetWorldCursorPos())
								FAIO.lastTick = os.clock()
								FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
								return
							end
						end
					end
				end
			else
				if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
					if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
						local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
						Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					else
						Ability.CastPosition(tornado, Input.GetWorldCursorPos())
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					end
				end
				if FAIO.SleepReady(0.05) and emp and Ability.IsCastable(emp, myMana) then
					local travelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
					local tornadoTiming = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + travelTime
					if os.clock() - FAIO.lastCastTime > tornadoTiming - 2.9 + 0.05 then
						if NPC.IsEntityInRange(myHero, enemy, 925) then
							Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
							FAIO.lastTick = os.clock()
							return
						else
							Ability.CastPosition(emp, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(925))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end
			if not Ability.IsReady(emp) and not Ability.IsReady(tornado) and NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				local distance = math.abs((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - 550)
				local timeToTarget = distance / NPC.GetMoveSpeed(myHero)
				if GameRules.GetGameTime() + timeToTarget <= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) then
					if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, iceWall) then
						FAIO.invokerInvokeAbility(myHero, iceWall)
						FAIO.lastTick = os.clock()
						return
					end
				else
					if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, coldSnap) then
						FAIO.invokerInvokeAbility(myHero, coldSnap)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(tornado) and not Ability.IsReady(emp) then
		if FAIO.InvokerIsAbilityInvoked(myHero, iceWall) then
			if FAIO.SleepReady(0.05) and iceWall and Ability.IsCastable(iceWall, myMana) then
				if not NPC.IsEntityInRange(myHero, enemy, 550) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(500), myHero)
				else
					FAIO.InvokerIceWallHelper(myHero, enemy, iceWall, myMana)
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
		if FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) then
			if FAIO.SleepReady(0.05) and coldSnap and Ability.IsCastable(coldSnap, myMana) then
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero) - 25), myHero)
					end
				else
					Ability.CastTarget(coldSnap, enemy)
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(tornado) and not Ability.IsReady(emp) and (not Ability.IsReady(coldSnap) or not Ability.IsReady(iceWall)) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return

end

function FAIO.InvokerComboTornadoMeteorBlast(myHero, myMana, enemy, tornado, chaosMeteor, deafeningBlast, blink, invoke)

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end	

	if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, 950) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					FAIO.noItemCastFor(0.5)
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor(0.5)
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				FAIO.noItemCastFor(0.5)
				return
			end
		else
			local travelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
			local tornadoTiming = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + travelTime
			if tornadoTiming < 1.3 then
				if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
					Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(250))
					FAIO.lastTick = os.clock()
					FAIO.lastCastTime = os.clock()
					return
				end
				if not Ability.IsReady(chaosMeteor) then
					if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
						if os.clock() - FAIO.lastCastTime <= 1.3 - tornadoTiming then
							FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
							return
						else	
							if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
								local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
								Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
								FAIO.lastTick = os.clock()
								return
							else
								Ability.CastPosition(tornado, Input.GetWorldCursorPos())
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				end
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					if FAIO.SleepReady(0.05) and not Ability.IsReady(tornado) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
						FAIO.invokerInvokeAbility(myHero, deafeningBlast)
						FAIO.lastTick = os.clock()
						return
					end
				end
			else
				if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
					if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
						local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
						Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					else
						Ability.CastPosition(tornado, Input.GetWorldCursorPos())
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					end
				end
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					if FAIO.SleepReady(0.05) and not Ability.IsReady(tornado) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
						FAIO.invokerInvokeAbility(myHero, deafeningBlast)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(tornado) then
		if Ability.IsReady(chaosMeteor) and NPC.HasModifier(enemy, "modifier_invoker_tornado") then
			local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetAttackRange(myHero)
				if distance < 0 then
					distance = 0
				end
			local timeToPosition = distance / NPC.GetMoveSpeed(myHero)
			if GameRules.GetGameTime() + timeToPosition < Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
				if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)), myHero)	
				else
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
						if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
							Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			else
				if not NPC.IsEntityInRange(myHero, enemy, 950) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(950), myHero)	
				else
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
						if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
							Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end
		else
			if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
						Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				else
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(tornado) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return

end

function FAIO.InvokerComboEulsSunstrikeMeteorBlast(myHero, myMana, enemy, sunStrike, chaosMeteor, deafeningBlast, blink, euls, invoke)

	if not euls then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(sunStrike)) and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, 550) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					FAIO.noItemCastFor(0.5)
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(500))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor(0.5)
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy), myHero)
				FAIO.noItemCastFor(0.5)
				return
			end
		else
			if FAIO.SleepReady(0.05) and euls and Ability.IsCastable(euls, myMana) then
				Ability.CastTarget(euls, enemy)
				FAIO.lastTick = os.clock()
				FAIO.noItemCastFor(2.5)
				return
			else
				if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
					FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
					return
				end
			end
			if NPC.HasModifier(enemy, "modifier_eul_cyclone") then
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_eul_cyclone")) - 1.7 then
					if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
						Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
			if FAIO.SleepReady(0.05) and not Ability.IsReady(sunStrike) and invoke and Ability.IsCastable(invoke, myMana) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
				FAIO.invokerInvokeAbility(myHero, deafeningBlast)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and not Ability.IsReady(sunStrike) then
		if NPC.HasModifier(enemy, "modifier_eul_cyclone") then
			if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_eul_cyclone")) - 1.3 then
				if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
					Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
					FAIO.lastTick = os.clock()
					return
				end
			end
			local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
			if not Ability.IsReady(chaosMeteor) then
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_eul_cyclone")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
	end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(sunStrike) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return

end


function FAIO.InvokerComboAghaTornadoEmpMeteorBlast(myHero, myMana, enemy, tornado, emp, chaosMeteor, deafeningBlast, aghanims, blink, invoke)

	if not aghanims and not NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end

	if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(emp), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, 1000) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					FAIO.noItemCastFor(0.5)
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor(0.5)
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				FAIO.noItemCastFor(0.5)
				return
			end
		else
			if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
				if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
					local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
					FAIO.lastTick = os.clock()
					FAIO.lastCastTime = os.clock()
					FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
					return
				else
					Ability.CastPosition(tornado, Input.GetWorldCursorPos())
					FAIO.lastTick = os.clock()
					FAIO.lastCastTime = os.clock()
					FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
					return
				end
			end
			if not Ability.IsReady(tornado) then
				if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, chaosMeteor) then
					FAIO.invokerInvokeAbility(myHero, chaosMeteor)
					FAIO.lastTick = os.clock()
					return
				end
			end	
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(tornado) and FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(emp)) then
		if FAIO.SleepReady(0.05) and emp and Ability.IsCastable(emp, myMana) then
			local travelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
			local tornadoTiming = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + travelTime
			if os.clock() - FAIO.lastCastTime > tornadoTiming - 2.9 + 0.25 then
				if NPC.IsEntityInRange(myHero, enemy, 925) then
					Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				else
					Ability.CastPosition(emp, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(925))
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
		if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
			if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
				local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetAttackRange(myHero)
					if distance < 0 then
						distance = 0
					end
				local timeToPosition = distance / NPC.GetMoveSpeed(myHero)
				if GameRules.GetGameTime() + timeToPosition < Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
					if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)), myHero)	
					else
						if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
							if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
								Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				else
					if not NPC.IsEntityInRange(myHero, enemy, 950) then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(950), myHero)	
					else
						if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
							if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
								Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				end
			end
		end			
	end
	if not Ability.IsReady(chaosMeteor) then
		if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
			FAIO.invokerInvokeAbility(myHero, deafeningBlast)
			FAIO.lastTick = os.clock()
			return
		end
		if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
			if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			else
				Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(tornado) and not Ability.IsReady(emp) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return

	
end

function FAIO.InvokerComboAghaTornadoSunstrikeMeteorBlast(myHero, myMana, enemy, tornado, sunStrike, chaosMeteor, deafeningBlast, aghanims, blink, invoke)

	if not aghanims and not NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end

	if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(sunStrike), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
	FAIO.InvokerCanComboStart = true
		if not NPC.IsEntityInRange(myHero, enemy, 1000) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					FAIO.noItemCastFor(0.5)
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
					return
				else
					if FAIO.SleepReady(0.1) then
						Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor(0.5)
						return
					end
				end
			end
			if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
				FAIO.noItemCastFor(0.5)
				return
			end
		else
			if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
				if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
					local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
					FAIO.lastTick = os.clock()
					FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
					return
				else
					Ability.CastPosition(tornado, Input.GetWorldCursorPos())
					FAIO.lastTick = os.clock()
					FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
					return
				end
			end
			if not Ability.IsReady(tornado) then
				if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, chaosMeteor) then
					FAIO.invokerInvokeAbility(myHero, chaosMeteor)
					FAIO.lastTick = os.clock()
					return
				end
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			if not FAIO.InvokerCanComboStart then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end
		
	if NPC.HasModifier(enemy, "modifier_invoker_tornado") and FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(sunStrike)) then
		if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
			local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetAttackRange(myHero)
				if distance < 0 then
					distance = 0
				end
			local timeToPosition = distance / NPC.GetMoveSpeed(myHero)
			if GameRules.GetGameTime() + timeToPosition < Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
				if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)), myHero)	
				else
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
						if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
							Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			else
				if not NPC.IsEntityInRange(myHero, enemy, 950) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(950), myHero)	
				else
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
						if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
							Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end
		end			
		
		if not Ability.IsReady(tornado) and not Ability.IsReady(sunStrike) then
			if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
					if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
						Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(250))
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
		end
	end

	if not Ability.IsReady(chaosMeteor) then
		if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
			FAIO.invokerInvokeAbility(myHero, deafeningBlast)
			FAIO.lastTick = os.clock()
			return
		end
		if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
			if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			else
				Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end	
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(tornado) and not Ability.IsReady(sunStrike) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return
		
end

function FAIO.InvokerComboRefresherAghaTornadoSunstrikeMeteorBlast(myHero, myMana, enemy, tornado, sunStrike, chaosMeteor, deafeningBlast, aghanims, refresher, blink, invoke)

	if not aghanims and not NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if not refresher then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) or not Ability.IsReady(refresher) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end

	if Ability.IsReady(refresher) then
		if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(sunStrike), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
		FAIO.InvokerCanComboStart = true
			if not NPC.IsEntityInRange(myHero, enemy, 1000) then
				if blink and Ability.IsReady(blink) then
					if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
						FAIO.noItemCastFor(0.5)
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
						return
					else
						if FAIO.SleepReady(0.1) then
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
							FAIO.lastTick = os.clock()
							FAIO.noItemCastFor(0.5)
							return
						end
					end
				end
				if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
					FAIO.noItemCastFor(0.5)
					return
				end
			else
				if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
					if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
						local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
						Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					else
						Ability.CastPosition(tornado, Input.GetWorldCursorPos())
						FAIO.lastTick = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					end
				end
				if not Ability.IsReady(tornado) then
					if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, chaosMeteor) then
						FAIO.invokerInvokeAbility(myHero, chaosMeteor)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
		else
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				if not FAIO.InvokerCanComboStart then
					FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
					return
				end
			end
		end
		
		if NPC.HasModifier(enemy, "modifier_invoker_tornado") and FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(sunStrike)) then
			if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
				local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetAttackRange(myHero)
					if distance < 0 then
						distance = 0
					end
				local timeToPosition = distance / NPC.GetMoveSpeed(myHero)
				if GameRules.GetGameTime() + timeToPosition < Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
					if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)), myHero)	
					else
						if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
							if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
								Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy))
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				else
					if not NPC.IsEntityInRange(myHero, enemy, 950) then
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(950), myHero)	
					else
						if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7 then
							if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
								Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy))
								FAIO.lastTick = os.clock()
								return
							end
						end
					end
				end
			end			
		
			if not Ability.IsReady(tornado) and not Ability.IsReady(sunStrike) then
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
						if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
							Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(250))
							FAIO.lastTick = os.clock()
							return
						end
					end
				end
			end
		end
		

		if not Ability.IsReady(chaosMeteor) then
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
				FAIO.invokerInvokeAbility(myHero, deafeningBlast)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
						Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				else
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end	
			end
		end

		if not Ability.IsReady(tornado) and not Ability.IsReady(sunStrike) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			if refresher and Ability.IsCastable(refresher, myMana) then
				Ability.CastNoTarget(refresher)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Ability.SecondsSinceLastUse(refresher) > 3 then
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(refresher) and Ability.SecondsSinceLastUse(refresher) > 0 and Ability.SecondsSinceLastUse(refresher) < 3 then
		if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
			Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy))
			FAIO.lastTick = os.clock()
			return
		end
		if not Ability.IsReady(chaosMeteor) and not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
				FAIO.invokerInvokeAbility(myHero, sunStrike)
				FAIO.lastTick = os.clock()
				return
			end
		end
		if FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
			if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
					Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300))
					FAIO.lastTick = os.clock()
					return
			end
		end
		if not Ability.IsReady(sunStrike) then
			if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
				Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(refresher) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(sunStrike) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end
	
	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return		
end

function FAIO.InvokerComboRefresherAghaTornadoEmpMeteorBlast(myHero, myMana, enemy, tornado, emp, chaosMeteor, deafeningBlast, aghanims, refresher, blink, invoke)

	if not aghanims and not NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if not refresher then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
		FAIO_itemHandler.itemUsage(myHero, enemy)
	else
		if not Ability.IsReady(tornado) or not Ability.IsReady(refresher) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		end
	end

	if Ability.IsReady(refresher) then
		if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(emp), Ability.GetName(tornado)) and invoke and Ability.IsReady(invoke) then
		FAIO.InvokerCanComboStart = true
			if not NPC.IsEntityInRange(myHero, enemy, 1000) then
				if blink and Ability.IsReady(blink) then
					if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
						FAIO.noItemCastFor(0.5)
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(600))
						return
					else
						if FAIO.SleepReady(0.1) then
							Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, target, Entity.GetAbsOrigin(enemy), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, npc, queue, showEffects)
							FAIO.lastTick = os.clock()
							FAIO.noItemCastFor(0.5)
							return
						end
					end
				end
				if not blink or (blink and not Ability.IsReady(blink)) and not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
					FAIO.noItemCastFor(0.5)
					return
				end
			else
				if FAIO.SleepReady(0.05) and tornado and Ability.IsCastable(tornado, myMana) then
					if Menu.GetValue(FAIO_options.optionHeroInvokerSkillshotStyle) == 0 then
						local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
						Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					else
						Ability.CastPosition(tornado, Input.GetWorldCursorPos())
						FAIO.lastTick = os.clock()
						FAIO.lastCastTime = os.clock()
						FAIO.noItemCastFor((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + 0.5)
						return
					end
				end
				if not Ability.IsReady(tornado) then
					if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, chaosMeteor) then
						FAIO.invokerInvokeAbility(myHero, chaosMeteor)
						FAIO.lastTick = os.clock()
						return
					end
				end	
			end
		else
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				if not FAIO.InvokerCanComboStart then
					FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
					return
				end
			end
		end

		if not Ability.IsReady(tornado) and FAIO.InvokerInvokedChecker(myHero, Ability.GetName(chaosMeteor), Ability.GetName(emp)) then
			if FAIO.SleepReady(0.05) and emp and Ability.IsCastable(emp, myMana) then
				local travelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
				local tornadoTiming = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + travelTime
				if os.clock() - FAIO.lastCastTime > tornadoTiming - 2.9 + 0.25 then
					if NPC.IsEntityInRange(myHero, enemy, 925) then
						Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					else
						Ability.CastPosition(emp, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(925))
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
			if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
					local distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetAttackRange(myHero)
						if distance < 0 then
							distance = 0
						end
					local timeToPosition = distance / NPC.GetMoveSpeed(myHero)
					if GameRules.GetGameTime() + timeToPosition < Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
						if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
							FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)), myHero)	
						else
							if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
								if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
									Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
									FAIO.lastTick = os.clock()
									return
								end
							end
						end
					else
						if not NPC.IsEntityInRange(myHero, enemy, 950) then
							FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(950), myHero)	
						else
							if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3 then
								if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
									Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
									FAIO.lastTick = os.clock()
									return
								end
							end
						end
					end
				end
			end			
		end		

		if not Ability.IsReady(chaosMeteor) then
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and FAIO.InvokerIsSkillInvokable(myHero, deafeningBlast) then
				FAIO.invokerInvokeAbility(myHero, deafeningBlast)
				FAIO.lastTick = os.clock()
				return
			end
			if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
				if NPC.HasModifier(enemy, "modifier_invoker_tornado") then
					local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
					if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
						Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				else
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			end
		end

		if not Ability.IsReady(tornado) and not Ability.IsReady(emp) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(deafeningBlast) then
			if refresher and Ability.IsCastable(refresher, myMana) then
				Ability.CastNoTarget(refresher)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Ability.SecondsSinceLastUse(refresher) > 3 then
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(refresher) and Ability.SecondsSinceLastUse(refresher) > 0 and Ability.SecondsSinceLastUse(refresher) < 3 then
		if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
			Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy))
			FAIO.lastTick = os.clock()
			return
		end
		if not Ability.IsReady(chaosMeteor) and not FAIO.InvokerIsAbilityInvoked(myHero, emp) then
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, emp) then
				FAIO.invokerInvokeAbility(myHero, emp)
				FAIO.lastTick = os.clock()
				return
			end
		end
		if FAIO.InvokerIsAbilityInvoked(myHero, emp) then
			if FAIO.SleepReady(0.05) and emp and Ability.IsCastable(emp, myMana) then
				if NPC.IsEntityInRange(myHero, enemy, 625) then
							Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300))
							FAIO.lastTick = os.clock()
							return
						else
							Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
							FAIO.lastTick = os.clock()
							return
						end
					Ability.CastPosition(emp, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
			end
		end
		if not Ability.IsReady(emp) then
			if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) and FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) then
				Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(refresher) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(emp) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	if not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	end
	return		
end

function FAIO.InvokerComboRefresherAghaBlastMeteorSunstrike(myHero, myMana, enemy, deafeningBlast, chaosMeteor, sunStrike, blink, aghanims, refresher, invoke)

	if not aghanims and not NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if not refresher then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end
	FAIO_itemHandler.itemUsage(myHero, enemy)

	if Ability.IsReady(refresher) then
		if FAIO.InvokerInvokedChecker(myHero, Ability.GetName(deafeningBlast), Ability.GetName(chaosMeteor)) and invoke and Ability.IsReady(invoke) then
		FAIO.InvokerCanComboStart = true
			if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
				if blink and Ability.IsReady(blink) then
					if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)-50))
						FAIO.lastTick = os.clock()
						return
					else
						FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, Entity.GetAbsOrigin(enemy), myHero)
						return
					end
				end
				if not blink or (blink and not Ability.IsReady(blink)) then
					FAIO.GenericAttackIssuer("Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil, myHero)
					return
				end
			else
				if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) then
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end

				if not Ability.IsReady(deafeningBlast) then
					if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
						Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy))
						FAIO.lastTick = os.clock()
						return
					end
				end

				if not Ability.IsReady(deafeningBlast) and not Ability.IsReady(chaosMeteor) and not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
					if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
						FAIO.invokerInvokeAbility(myHero, sunStrike)
						FAIO.lastTick = os.clock()
						return
					end
				end
			end
		else
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				if not FAIO.InvokerCanComboStart then
					FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
					return
				end
			end
		end
		
		if NPC.HasModifier(enemy, "modifier_invoker_deafening_blast_knockback") and FAIO.InvokerInvokedChecker(myHero, Ability.GetName(sunStrike), Ability.GetName(deafeningBlast)) then
			if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
				Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300))
				FAIO.lastTick = os.clock()
				return
			end
		end
	
		if not Ability.IsReady(deafeningBlast) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(sunStrike) then
			if refresher and Ability.IsCastable(refresher, myMana) then
				Ability.CastNoTarget(refresher)
				FAIO.lastTick = os.clock()
				return
			end
		end
	else
		if Ability.SecondsSinceLastUse(refresher) > 3 then
			if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
				FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
				return
			end
		end
	end

	if not Ability.IsReady(refresher) and Ability.SecondsSinceLastUse(refresher) > 0 and Ability.SecondsSinceLastUse(refresher) < 3 then
		if FAIO.SleepReady(0.05) and deafeningBlast and Ability.IsCastable(deafeningBlast, myMana) then
			if NPC.HasModifier(enemy, "modifier_invoker_deafening_blast_knockback") then
				local blastTime = ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) - 0.25
				if GameRules.GetGameTime() >= Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_deafening_blast_knockback")) - blastTime - NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
					Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
					FAIO.lastTick = os.clock()
					return
				end
			else
				Ability.CastPosition(deafeningBlast, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end
		end
		if not Ability.IsReady(deafeningBlast) and not FAIO.InvokerIsAbilityInvoked(myHero, chaosMeteor) then
			if FAIO.SleepReady(0.05) and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, chaosMeteor) then
				FAIO.invokerInvokeAbility(myHero, chaosMeteor)
				FAIO.lastTick = os.clock()
				return
			end
		end
		if not Ability.IsReady(deafeningBlast) and FAIO.InvokerIsAbilityInvoked(myHero, chaosMeteor) then
			if FAIO.SleepReady(0.05) and sunStrike and Ability.IsCastable(sunStrike, myMana) then
				Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300))
				FAIO.lastTick = os.clock()
				return
			end
		end
		if not Ability.IsReady(deafeningBlast) and FAIO.InvokerIsAbilityInvoked(myHero, chaosMeteor) and not Ability.IsReady(sunStrike) then
			if FAIO.SleepReady(0.05) and chaosMeteor and Ability.IsCastable(chaosMeteor, myMana) then
				Ability.CastPosition(chaosMeteor, Entity.GetAbsOrigin(enemy))
				FAIO.lastTick = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if not Ability.IsReady(refresher) and not Ability.IsReady(chaosMeteor) and not Ability.IsReady(sunStrike) and not Ability.IsReady(deafeningBlast) then
			FAIO.InvokerComboSelector = 11
		end
	end

	FAIO.invokerProcessInstancesWhileComboing(myHero)
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

function FAIO.InvokerSkillProcessingTornado(myHero, myMana, enemy)

	if not enemy then return end

	local tornado = NPC.GetAbility(myHero, "invoker_tornado")
		if not tornado then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local blastTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) <= 2.9 then
		if tornadoTiming > 2.95 then
			delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) + 2.95 - tornadoTravelTime
		else
			delay = FAIO.InvokerLastCastedSkillTime + 0.05
		end
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) <= 1.7 then
		if tornadoTiming > 1.75 then
			delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.75 - tornadoTravelTime + 0.1
		else
			delay = FAIO.InvokerLastCastedSkillTime + 0.05
		end
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) <= 1.3 + 2 then
		if tornadoTiming > 1.3 then
			delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) + 3.0 - tornadoTravelTime
		else
			delay = FAIO.InvokerLastCastedSkillTime + 0.05
		end
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) <= Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) * 0.25 + blastTravelTime then
		if tornadoTiming > Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) * 0.25 + blastTravelTime then
			delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) * 0.25 + blastTravelTime - tornadoTravelTime
		else
			delay = FAIO.InvokerLastCastedSkillTime + 0.05
		end
	elseif NPC.HasModifier(enemy, "modifier_invoker_cold_snap") then
		delay = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_cold_snap")) - 0.1 - tornadoTravelTime
	elseif  NPC.HasModifier(enemy, "modifier_sheepstick_debuff") then
		delay = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_sheepstick_debuff")) - 0.1 - tornadoTravelTime
	elseif FAIO.TargetDisableTimer(myHero, enemy) > 0 then
		delay = FAIO.TargetDisableTimer(myHero, enemy) + 0.05 - tornadoTravelTime
	else
		delay = FAIO.InvokerLastCastedSkillTime + 0.05
	end
		

	return { delay, FAIO_utility_functions.castLinearPrediction(myHero, enemy, Ability.GetCastPoint(NPC.GetAbility(myHero, "invoker_tornado")) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)) }

end

function FAIO.InvokerSkillProcessingEMP(myHero, myMana, enemy)

	if not enemy then return end

	local emp = NPC.GetAbility(myHero, "invoker_emp")
		if not emp then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if FAIO.InvokerLastCastedSkill == nil then
		delay = 0.05
	else
		if Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_tornado" then
			if FAIO.InvokerLastCastedSkillTime + tornadoTiming > curTime + 2.9 then
				delay = FAIO.InvokerLastCastedSkillTime + tornadoTiming - 2.9
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		else
			delay = FAIO.InvokerLastCastedSkillTime + 0.05
		end
	end

	return { delay, Entity.GetAbsOrigin(enemy) }

end

function FAIO.InvokerSkillProcessingMeteor(myHero, myMana, enemy)

	if not enemy then return end

	local chaosMeteor = NPC.GetAbility(myHero, "invoker_chaos_meteor")
		if not chaosMeteor then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if FAIO.InvokerLastCastedSkill == nil then
		if FAIO.TargetIsInvulnarable(myHero, enemy) > 0 then
			local timing = FAIO.TargetIsInvulnarable(myHero, enemy) - 1.25
			delay = timing
		else
			delay = 0.05
		end
	else
		if Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_tornado" then
			if FAIO.InvokerLastCastedSkillTime + tornadoTiming > curTime + 1.3 then
				delay = FAIO.InvokerLastCastedSkillTime + tornadoTiming - 1.3
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		else
			if FAIO.TargetIsInvulnarable(myHero, enemy) > 0 then
				local timing = FAIO.TargetIsInvulnarable(myHero, enemy) - 1.25
				delay = timing
			elseif not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > 0 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + 0.5) then
					delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) + tornadoTiming - 1.3
				else
					delay = FAIO.InvokerLastCastedSkillTime + 0.05
				end
			elseif NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				delay = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.3
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		end
	end

	local position = Vector()
	if NPC.HasModifier(enemy, "modifier_invoker_deafening_blast_knockback") or Ability.IsReady(NPC.GetAbility(myHero, "invoker_deafening_blast")) then
		position = Entity.GetAbsOrigin(enemy)
	elseif FAIO.InvokerLastCastedSkill ~= nil and Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_deafening_blast" then
		position = Entity.GetAbsOrigin(enemy)
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100 + 0.25) then
		position = Entity.GetAbsOrigin(enemy)
	else
		position = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100))
	end

	return { delay, position }

end

function FAIO.InvokerSkillProcessingBlast(myHero, myMana, enemy)

	if not enemy then return end

	local deafeningBlast = NPC.GetAbility(myHero, "invoker_deafening_blast")
		if not deafeningBlast then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration
	
	local curTime = GameRules.GetGameTime()

	local delay
	if FAIO.InvokerLastCastedSkill == nil then
		if FAIO.TargetIsInvulnarable(myHero, enemy) > 0 then
			local timing = FAIO.TargetIsInvulnarable(myHero, enemy) - ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + 0.25
			delay = timing
		else
			delay = 0.05
		end
	else
		if Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_tornado" then
			if FAIO.InvokerLastCastedSkillTime + tornadoTiming > curTime + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100 - 0.25 then
				delay = FAIO.InvokerLastCastedSkillTime + tornadoTiming - ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + 0.25
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		else
			if FAIO.TargetIsInvulnarable(myHero, enemy) > 0 then
				local timing = FAIO.TargetIsInvulnarable(myHero, enemy) - ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + 0.25
				delay = timing
			elseif not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > 0 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + 0.5) then
					delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) + tornadoTiming - ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + 0.25
				else
					delay = FAIO.InvokerLastCastedSkillTime + 0.05
				end
			elseif NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				delay = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + 0.25
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		end
	end

	return { delay, Entity.GetAbsOrigin(enemy) }

end

function FAIO.InvokerSkillProcessingSunstrike(myHero, myMana, enemy)

	if not enemy then return end

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
		if not sunStrike then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if FAIO.InvokerLastCastedSkill == nil then
		if FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy) ~= nil and FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1] > 0 then
			local timing = FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1]
			delay = timing
		elseif NPC.HasItem(myHero, "item_rod_of_atos", true) and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_rod_of_atos", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_rod_of_atos", true)) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1500 + 0.25) then
			delay = curTime + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1500 + 0.25
		else
			delay = 0.05
		end
	else
		if Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_tornado" then
			if FAIO.InvokerLastCastedSkillTime + tornadoTiming > curTime + 1.7 then
				delay = FAIO.InvokerLastCastedSkillTime + tornadoTiming - 1.7
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		elseif Ability.GetName(FAIO.InvokerLastCastedSkill) == "item_rod_of_atos" then
			delay = FAIO.InvokerLastCastedSkillTime + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1500
		elseif Ability.GetName(FAIO.InvokerLastCastedSkill) == "item_cyclone" then
			if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_cyclone", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_cyclone", true)) < 2.55 then
				delay = curTime - Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_cyclone", true)) + 2.5 - 1.7
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end

		else
			if FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy) ~= nil and FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1] > 0 then
				local timing = FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1]
				delay = timing
			elseif not NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + 0.5) then
					delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) + tornadoTiming - 1.7
				else
					delay = FAIO.InvokerLastCastedSkillTime + 0.05
				end
			elseif NPC.HasModifier(enemy, "modifier_invoker_tornado") then
				delay = Modifier.GetDieTime(NPC.GetModifier(enemy, "modifier_invoker_tornado")) - 1.7
			else
				delay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		end
	end

	local position = Vector()
	if NPC.HasModifier(enemy, "modifier_invoker_deafening_blast_knockback") then
		position = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(250))
--	elseif FAIO.InvokerLastCastedSkill ~= nil and Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_deafening_blast" then
--		position = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300 - (curTime - FAIO.InvokerLastCastedSkillTime)*150))
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_deafening_blast")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1100 + 0.25) then
		position = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(300))
	elseif NPC.HasModifier(enemy, "modifier_invoker_tornado") then
		position = Entity.GetAbsOrigin(enemy)
	else
		if FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy) ~= nil and FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1] > 0 then
			position = Entity.GetAbsOrigin(enemy)
		else
			position = FAIO_utility_functions.castPrediction(myHero, enemy, Ability.GetCastPoint(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2))
		end
	end

	return { delay, position }

end

function FAIO.InvokerSkillProcessingIcewall(myHero, myMana, enemy)

	if not enemy then return end

	local iceWall = NPC.GetAbility(myHero, "invoker_ice_wall")
		if not iceWall then return end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + 0.1) then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) + tornadoTiming - 0.5
	else
		delay = FAIO.InvokerLastCastedSkillTime + 0.05
	end

	return { delay, nil }

end

function FAIO.InvokerSkillProcessingEuls(myHero, myMana, enemy)

	if not enemy then return end

	local euls = NPC.GetItem(myHero, "item_cyclone", true)
		if not euls then return { 0.05, nil } end

	local tornadoTravelTime = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000
	local tornadoLiftDuration = FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))
	local tornadoTiming = tornadoTravelTime + tornadoLiftDuration

	local curTime = GameRules.GetGameTime()

	local delay
	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100)) + 0.1) then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) + tornadoTiming + 0.15
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) < 2.95 then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_emp")) + 2.95
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) < 1.8 then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.8
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) < 2.5 then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) + 2.5
	elseif Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_cold_snap")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_cold_snap")) < 4 then
		delay = curTime - Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_chaos_meteor")) + 4
	else
		delay = FAIO.InvokerLastCastedSkillTime + 0.05
	end

	return { delay, enemy }
	

end

function FAIO.InvokerComboCustomMode(myHero, myMana, enemy, blink, invoke)

	if not myHero then return end
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 1500) then return end
	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	local skillTranslator = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity",
		"item_cyclone",
		"item_rod_of_atos",
		"item_refresher"
			}
		
	local skillOrder = {}
	if FAIO.InvokerComboSelector == 12 then
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6)])
		end
	elseif FAIO.InvokerComboSelector == 13 then
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6)])
		end
	elseif FAIO.InvokerComboSelector == 14 then
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5)])
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6) > 0 then
			table.insert(skillOrder, skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6)])
		end
	end

	local skillProcessing = { 
		["invoker_tornado"] = { "position", FAIO.InvokerSkillProcessingTornado(myHero, myMana, enemy) }, 
		["invoker_emp"] = { "position", FAIO.InvokerSkillProcessingEMP(myHero, myMana, enemy) },
		["invoker_chaos_meteor"] = { "position", FAIO.InvokerSkillProcessingMeteor(myHero, myMana, enemy) },
		["invoker_deafening_blast"] = { "position", FAIO.InvokerSkillProcessingBlast(myHero, myMana, enemy) },
		["invoker_sun_strike"] = { "position", FAIO.InvokerSkillProcessingSunstrike(myHero, myMana, enemy) },
		["invoker_ice_wall"] = { "no target", FAIO.InvokerSkillProcessingIcewall(myHero, myMana, enemy) },
		["invoker_cold_snap"] = { "target", enemy },
		["invoker_forge_spirit"] = { "no target", nil },
		["invoker_alacrity"] = { "target", myHero },
		["item_cyclone"] = { "target", FAIO.InvokerSkillProcessingEuls(myHero, myMana, enemy) },
		["item_rod_of_atos"] = { "target", enemy },
		["item_refresher"] = { "no target", nil }
				}

	local readyTable = {}
	for i = 1, #skillOrder do
		if skillOrder[i] == "item_refresher" then
			if NPC.HasItem(myHero, skillOrder[i], true) then
				if Ability.IsReady(NPC.GetItem(myHero, skillOrder[i], true)) then
					table.insert(readyTable, NPC.GetItem(myHero, skillOrder[i], true))
				end
			else
				break	
			end
		elseif skillOrder[i] == "item_cyclone" then
			if NPC.HasItem(myHero, skillOrder[i], true) then
				if Ability.IsReady(NPC.GetItem(myHero, skillOrder[i], true)) then
					table.insert(readyTable, NPC.GetItem(myHero, skillOrder[i], true))
				end
			end
		elseif skillOrder[i] == "item_rod_of_atos" then
			if NPC.HasItem(myHero, skillOrder[i], true) then
				if Ability.IsReady(NPC.GetItem(myHero, skillOrder[i], true)) then
					table.insert(readyTable, NPC.GetItem(myHero, skillOrder[i], true))
				end
			end
		else
			if Ability.IsReady(NPC.GetAbility(myHero, skillOrder[i])) then
				table.insert(readyTable, NPC.GetAbility(myHero, skillOrder[i]))
			end
		end
	end

	if NPC.HasItem(myHero, "item_refresher", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_refresher", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_refresher", true)) < 7 then
			for a, b in ipairs(skillOrder) do
				if b == "item_refresher" then
					readyTable = {}
					for i = a+1, #skillOrder do
						if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) then
							table.insert(readyTable, NPC.GetAbilityByIndex(myHero, 4))
						end
						if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) then
							table.insert(readyTable, NPC.GetAbilityByIndex(myHero, 3))
						end
						if skillOrder[i] == "item_cyclone" then
							if NPC.HasItem(myHero, "item_cyclone", true) then
								if Ability.IsReady(NPC.GetItem(myHero, "item_cyclone", true)) then
									table.insert(readyTable, NPC.GetItem(myHero, "item_cyclone", true))
								end
							end
						else
							if Ability.IsReady(NPC.GetAbility(myHero, skillOrder[i])) then
								table.insert(readyTable, NPC.GetAbility(myHero, skillOrder[i]))
							end
						end
					end
				end
			end
		end
	end

	local skill
		if #readyTable > 0 then
			skill = readyTable[1]
		else
			skill = nil
		end

	local invokeSkill
		if not Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) then
			if #readyTable > 1 then
				invokeSkill = readyTable[2]
			else
				invokeSkill = nil
			end
		elseif not Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and not Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) then
			if #readyTable > 0 then
				invokeSkill = readyTable[1]
			else
				invokeSkill = nil
			end
		end

	if invokeSkill then
		if not FAIO.InvokerIsAbilityInvoked(myHero, invokeSkill) then
			if GameRules.GetGameTime() - FAIO.lastCastTime3 > 0.05 and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, invokeSkill) then
				FAIO.invokerInvokeAbility(myHero, invokeSkill)
				FAIO.lastCastTime3 = GameRules.GetGameTime()
				return
			end
		end
	end

	local processingTempTable = {}
		if skill then
			if Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" or Ability.GetName(skill) == "invoker_ice_wall" then
				table.insert(processingTempTable, skillProcessing[Ability.GetName(skill)][2])
			elseif NPC.HasItem(myHero, "item_cyclone", true) and Ability.GetName(skill) == "item_cyclone" then
				table.insert(processingTempTable, skillProcessing[Ability.GetName(skill)][2])
			else
				processingTempTable = {}
			end
		end

	local targetingStyle
		if skill then
			targetingStyle = skillProcessing[Ability.GetName(skill)][1]
		end

	local targetingDelay
		if skill then
			if FAIO.InvokerLastCastedSkill == nil then
				targetingDelay = FAIO.InvokerLastCastedSkillTime + 0.05
			elseif Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" or Ability.GetName(skill) == "invoker_ice_wall" then
				targetingDelay = processingTempTable[1][1]
			elseif NPC.HasItem(myHero, "item_cyclone", true) and Ability.GetName(skill) == "item_cyclone" then
				targetingDelay = processingTempTable[1][1]
			else
				targetingDelay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		end

	local targetingTarget	
		if skill then
			if Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" then
				targetingTarget = processingTempTable[1][2]
			elseif NPC.HasItem(myHero, "item_cyclone", true) and Ability.GetName(skill) == "item_cyclone" then
				targetingTarget = processingTempTable[1][2]
			else
				targetingTarget = skillProcessing[Ability.GetName(skill)][2]
			end
		end

	if skill and Ability.GetName(skill) == "invoker_tornado" then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		else
			if not Ability.IsReady(skill) then
				FAIO_itemHandler.itemUsage(myHero, enemy)
			end
		end
	else
		FAIO_itemHandler.itemUsage(myHero, enemy)
	end

	if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
		FAIO.invokerForgedSpiritController(myHero, enemy)
	end

	if skill then
		if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)+200) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)-100))
					return
				end
			end
		else
			if FAIO.InvokerIsAbilityInvoked(myHero, skill) or Ability.GetName(skill) == "item_refresher" or Ability.GetName(skill) == "item_cyclone" or Ability.GetName(skill) == "item_rod_of_atos" then
			FAIO.InvokerCanComboStart = true
				if GameRules.GetGameTime() > targetingDelay then
					if Ability.IsCastable(skill, myMana) then
						if skillProcessing[Ability.GetName(skill)][1] == "position" then
							if Ability.GetName(skill) == "invoker_tornado" then
								Ability.CastPosition(skill, targetingTarget)
								FAIO.noItemCastFor(((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + 0.5)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							else
								Ability.CastPosition(skill, targetingTarget)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end
						end
						if skillProcessing[Ability.GetName(skill)][1] == "target" then
							if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
								Ability.CastTarget(skill, targetingTarget)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end
						end
						if skillProcessing[Ability.GetName(skill)][1] == "no target" then
							if Ability.GetName(skill) == "invoker_ice_wall" then
								if not NPC.IsEntityInRange(myHero, enemy, 600) then
									FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
									return
								else
									FAIO.InvokerIceWallHelper(myHero, enemy, skill, myMana)
									FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime() + 0.1
									FAIO.InvokerLastCastedSkill = skill
									return
								end
							else
								Ability.CastNoTarget(skill)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end			
						end
					end
				end
			else
				if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
					if not FAIO.InvokerCanComboStart then
						FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
						return
					end
				end
			end
		end
	else
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerForceDynamic) then
			FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)
			return
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroInvokerSwitch) then
		if next(readyTable) == nil then
			FAIO.InvokerComboSelector = 11
		end
	end
	FAIO.invokerProcessInstancesWhileComboing(myHero)

		
end

function FAIO.InvokerComboDynamicMode(myHero, myMana, enemy, blink, invoke)

	if not myHero then return end
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 1500) then return end
	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 0.25 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end

	local InvokerDynamicSpellsOrder = {}
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynCS) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynCS), "invoker_cold_snap" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynFS) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynFS), "invoker_forge_spirit" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynAL) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynAL), "invoker_alacrity" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynIW) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynIW), "invoker_ice_wall" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynTO) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynTO), "invoker_tornado" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynEMP) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynEMP), "invoker_emp" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynSS) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynSS), "invoker_sun_strike" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynCM) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynCM), "invoker_chaos_meteor" })
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerDynDB) > 0 then
		table.insert(InvokerDynamicSpellsOrder, { Menu.GetValue(FAIO_options.optionHeroInvokerDynDB), "invoker_deafening_blast" })
	end

	table.sort(InvokerDynamicSpellsOrder, function(a, b)
        	return a[1] < b[1]
    	end)

	local skillPicker = {}
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerDynOrder) then
			i = 1
			repeat
				table.insert(skillPicker, InvokerDynamicSpellsOrder[i][2])
				i = i + 1
			until i > #InvokerDynamicSpellsOrder
		else
			skillPicker[1] = "invoker_cold_snap"
			skillPicker[2] = "invoker_forge_spirit"
			skillPicker[3] = "invoker_alacrity" 
			skillPicker[4] = "invoker_ice_wall"
			skillPicker[5] = "invoker_tornado"
			skillPicker[6] = "invoker_emp"
			skillPicker[7] = "invoker_sun_strike"
			skillPicker[8] = "invoker_chaos_meteor" 
			skillPicker[9] = "invoker_deafening_blast"
		end

	

	local skillProcessing = { 
		["invoker_tornado"] = { "position", FAIO.InvokerSkillProcessingTornado(myHero, myMana, enemy) }, 
		["invoker_emp"] = { "position", FAIO.InvokerSkillProcessingEMP(myHero, myMana, enemy) },
		["invoker_chaos_meteor"] = { "position", FAIO.InvokerSkillProcessingMeteor(myHero, myMana, enemy) },
		["invoker_deafening_blast"] = { "position", FAIO.InvokerSkillProcessingBlast(myHero, myMana, enemy) },
		["invoker_sun_strike"] = { "position", FAIO.InvokerSkillProcessingSunstrike(myHero, myMana, enemy) },
		["invoker_ice_wall"] = { "no target", FAIO.InvokerSkillProcessingIcewall(myHero, myMana, enemy) },
		["invoker_cold_snap"] = { "target", enemy },
		["invoker_forge_spirit"] = { "no target", nil },
		["invoker_alacrity"] = { "target", myHero }
				}

	local readyTable = {}
	for i = 1, #skillPicker do
		if Ability.IsReady(NPC.GetAbility(myHero, skillPicker[i])) and not FAIO.InvokerIsAbilityInvoked(myHero, NPC.GetAbility(myHero, skillPicker[i])) and FAIO.InvokerIsSkillInvokable(myHero, NPC.GetAbility(myHero, skillPicker[i])) then
			table.insert(readyTable, NPC.GetAbility(myHero, skillPicker[i]))
		end
	end

	local skill
	local invokeSkill
	if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_tornado" and FAIO.TargetDisableTimer(myHero, enemy) == 0 then
		skill = NPC.GetAbilityByIndex(myHero, 3)	
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == "invoker_ice_wall" then
		if NPC.IsEntityInRange(myHero, enemy, 800) then
			skill = NPC.GetAbilityByIndex(myHero, 4)
		else
			if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) then
				skill = NPC.GetAbilityByIndex(myHero, 3)
			else
				if next(readyTable) ~= nil then
					if #readyTable >= 1 then
						invokeSkill = readyTable[1]
					else
						skill = nil
						invokeSkill = nil
					end
				end
			end
		end
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == "invoker_ghost_walk" then
		if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) then
			skill = NPC.GetAbilityByIndex(myHero, 3)
		else
			if next(readyTable) ~= nil then
				if #readyTable >= 1 then
					invokeSkill = readyTable[1]
				else
					skill = nil
					invokeSkill = nil
				end
			end
		end
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_ghost_walk" then
		if Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) then
			skill = NPC.GetAbilityByIndex(myHero, 4)
		else
			if next(readyTable) ~= nil then
				if #readyTable >= 1 then
					invokeSkill = readyTable[1]
				else
					skill = nil
					invokeSkill = nil
				end
			end
		end
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == "invoker_tornado" and FAIO.TargetDisableTimer(myHero, enemy) > 0 then
		skill = NPC.GetAbilityByIndex(myHero, 3)
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) ~= "invoker_ghost_walk" and Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) ~= "invoker_empty2" then
		skill = NPC.GetAbilityByIndex(myHero, 4)
	elseif Ability.IsReady(NPC.GetAbilityByIndex(myHero, 3)) and Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) ~= "invoker_ghost_walk"  and Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) ~= "invoker_empty1" then
		skill = NPC.GetAbilityByIndex(myHero, 3)
	end

	
	if not Ability.IsReady(NPC.GetAbilityByIndex(myHero, 4)) then
		if next(readyTable) ~= nil then
			if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_tornado")) < ((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000 + FAIO_data.invokerTornadoLiftDuration[Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0))] * (1 - (math.ceil(Hero.GetStrengthTotal(enemy) * 0.15)/100))) and NPC.GetCurrentLevel(myHero) >= 10 then
				if Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_emp" then
					if Ability.IsReady(NPC.GetAbility(myHero, "invoker_chaos_meteor")) then
						invokeSkill = NPC.GetAbility(myHero, "invoker_chaos_meteor")
					else
						if Ability.IsReady(NPC.GetAbility(myHero, "invoker_deafening_blast")) then
							invokeSkill = NPC.GetAbility(myHero, "invoker_deafening_blast")
						else
							invokeSkill = readyTable[1]
						end
					end
				elseif Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_sun_strike" then
					if Ability.IsReady(NPC.GetAbility(myHero, "invoker_chaos_meteor")) then
						invokeSkill = NPC.GetAbility(myHero, "invoker_chaos_meteor")
					else
						if Ability.IsReady(NPC.GetAbility(myHero, "invoker_deafening_blast")) then
							invokeSkill = NPC.GetAbility(myHero, "invoker_deafening_blast")
						else
							invokeSkill = readyTable[1]
						end
					end
				elseif Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_chaos_meteor" then
					if Ability.IsReady(NPC.GetAbility(myHero, "invoker_deafening_blast")) then
						invokeSkill = NPC.GetAbility(myHero, "invoker_deafening_blast")
					else
						invokeSkill = readyTable[1]
					end
				else
					invokeSkill = readyTable[1]
				end
			else
				if FAIO.InvokerLastCastedSkill ~= nil and Ability.GetName(FAIO.InvokerLastCastedSkill) == "invoker_deafening_blast" and Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == "invoker_chaos_meteor" then
					if Ability.IsReady(NPC.GetAbility(myHero, "invoker_sun_strike")) then
						invokeSkill = NPC.GetAbility(myHero, "invoker_sun_strike")
					else
						invokeSkill = readyTable[1]
					end
				elseif  Ability.GetName(readyTable[1]) == "invoker_ice_wall" and #readyTable >= 1 then
					if NPC.IsEntityInRange(myHero, enemy, 800) then
						invokeSkill = readyTable[1]
					else
						if #readyTable > 1 then
							invokeSkill = readyTable[2]
						else
							invokeSkill = nil
						end
					end
				elseif  Ability.GetName(readyTable[1]) == "invoker_sun_strike" and #readyTable >= 1 then
					if FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy) ~= nil and FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)[1] > 0 then
						invokeSkill = readyTable[1]
					else
						if NPC.HasModifier(enemy, "modifier_sheepstick_debuff") or NPC.HasModifier(enemy, "modifier_invoker_cold_snap") or NPC.HasModifier(enemy, "modifier_invoker_ice_wall_slow_debuff") then
							invokeSkill = readyTable[1]
						else
							if #readyTable > 1 then
								invokeSkill = readyTable[2]
							else
								invokeSkill = nil
							end
						end
					end
				else
					invokeSkill = readyTable[1]
				end
			end
		end
	end

	if invokeSkill then
		if not FAIO.InvokerIsAbilityInvoked(myHero, invokeSkill) then
			if GameRules.GetGameTime() - FAIO.lastCastTime3 > 0.05 and invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, invokeSkill) then
				FAIO.invokerInvokeAbility(myHero, invokeSkill)
				FAIO.lastCastTime3 = GameRules.GetGameTime()
				return
			end
		end
	end

	local processingTempTable = {}
		if skill then
			if Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" or Ability.GetName(skill) == "invoker_ice_wall" then
				table.insert(processingTempTable, skillProcessing[Ability.GetName(skill)][2])
			else
				processingTempTable = {}
			end
		end

	local targetingStyle
		if skill then
			targetingStyle = skillProcessing[Ability.GetName(skill)][1]
		end

	local targetingDelay
		if skill then
			if Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" or Ability.GetName(skill) == "invoker_ice_wall" then
				targetingDelay = processingTempTable[1][1]
			elseif Ability.GetName(skill) == "invoker_alacrity" or Ability.GetName(skill) == "invoker_forge_spirit" or Ability.GetName(skill) == "invoker_cold_snap" then
				targetingDelay = FAIO.InvokerLastCastedSkillTime + 0.05
			end
		end

	local targetingTarget	
		if skill then
			if Ability.GetName(skill) == "invoker_tornado" or Ability.GetName(skill) == "invoker_emp" or Ability.GetName(skill) == "invoker_chaos_meteor" or Ability.GetName(skill) == "invoker_deafening_blast" or Ability.GetName(skill) == "invoker_sun_strike" then
				targetingTarget = processingTempTable[1][2]
			else
				targetingTarget = skillProcessing[Ability.GetName(skill)][2]
			end
		end

	if skill and Ability.GetName(skill) == "invoker_tornado" then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoItems) then
			FAIO_itemHandler.itemUsage(myHero, enemy)
		else
			if not Ability.IsReady(skill) then
				FAIO_itemHandler.itemUsage(myHero, enemy)
			end
		end
	else
		FAIO_itemHandler.itemUsage(myHero, enemy)
	end

	if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if skill and not Ability.GetName(skill) == "invoker_ice_wall" then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			FAIO.invokerForgedSpiritController(myHero, enemy)
		elseif not skill or (skill and not Ability.IsCastable(skill, myMana)) then
			FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
			FAIO.invokerForgedSpiritController(myHero, enemy)
		end
	end

	if skill then
		if not NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)+200) then
			if blink and Ability.IsReady(blink) then
				if NPC.IsEntityInRange(myHero, enemy, 1150 + NPC.GetAttackRange(myHero)) then
					Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(NPC.GetAttackRange(myHero)-100))
					return
				end
			end
		else
			if FAIO.InvokerIsAbilityInvoked(myHero, skill) then
				if GameRules.GetGameTime() > targetingDelay then
					if Ability.IsCastable(skill, myMana) then
						if skillProcessing[Ability.GetName(skill)][1] == "position" then
							if Ability.GetName(skill) == "invoker_tornado" then
								Ability.CastPosition(skill, targetingTarget)
								FAIO.noItemCastFor(((Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + 0.5)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							else
								Ability.CastPosition(skill, targetingTarget)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end
						end
						if skillProcessing[Ability.GetName(skill)][1] == "target" then
							if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
								Ability.CastTarget(skill, targetingTarget)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end
						end
						if skillProcessing[Ability.GetName(skill)][1] == "no target" then
							if Ability.GetName(skill) == "invoker_ice_wall" then
								if not NPC.IsEntityInRange(myHero, enemy, 600) then
									FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
									return
								else
									FAIO.InvokerIceWallHelper(myHero, enemy, skill, myMana)
									FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime() + 0.5
									FAIO.InvokerLastCastedSkill = skill
									return
								end
							else
								Ability.CastNoTarget(skill)
								FAIO.InvokerLastCastedSkillTime = GameRules.GetGameTime()
								FAIO.InvokerLastCastedSkill = skill
								return
							end		
						end
					end
				end
			end
		end
	end
	FAIO.invokerProcessInstancesWhileComboing(myHero)
end

function FAIO.InvokerFastIceWall(myHero, myMana, invoke, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroInvokerIcewallEnable) then return end
	if not myHero then return end
	if enemy then
		if not NPC.IsEntityInRange(myHero, enemy, 600) then
			enemy = nil
		end
	end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	
	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end
	
	local iceWall = NPC.GetAbility(myHero, "invoker_ice_wall")
		if not iceWall then return end
		if not Ability.IsReady(iceWall) then return end

	if not FAIO.InvokerIsAbilityInvoked(myHero, iceWall) then
		if invoke and Ability.IsCastable(invoke, myMana-175) and FAIO.InvokerIsSkillInvokable(myHero, iceWall) then
			if enemy then
				FAIO.invokerInvokeAbility(myHero, iceWall)
				FAIO.InvokerIceWallHelper(myHero, enemy, iceWall, myMana)
				return
			else
				FAIO.invokerInvokeAbility(myHero, iceWall)
				Ability.CastNoTarget(iceWall, true)
				return
			end
		end
	else
		if Ability.IsCastable(iceWall, myMana) then
			if enemy then
				FAIO.InvokerIceWallHelper(myHero, enemy, iceWall, myMana)
			else
				Ability.CastNoTarget(iceWall)
				return
			end
		end
	end

end

function FAIO.InvokerFastAlacrity(myHero, myMana, invoke, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroInvokerAlacrityEnable) then return end
	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	
	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end
	
	local alacrity = NPC.GetAbility(myHero, "invoker_alacrity")
		if not alacrity then return end
		if not Ability.IsReady(alacrity) then return end
	
	if not FAIO.InvokerIsAbilityInvoked(myHero, alacrity) then
		if invoke and Ability.IsCastable(invoke, myMana-60) and FAIO.InvokerIsSkillInvokable(myHero, alacrity) then
			FAIO.invokerInvokeAbility(myHero, alacrity)
			Ability.CastTarget(alacrity, myHero)
			return
		end
	else
		if Ability.IsCastable(alacrity, myMana) then
			Ability.CastTarget(alacrity, myHero)
			return
		end
	end

end

function FAIO.InvokerFastTornado(myHero, myMana, invoke, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroInvokerTornadoEnable) then return end
	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	
	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 then return end

	local tornado = NPC.GetAbility(myHero, "invoker_tornado")
		if not tornado then return end
		if not Ability.IsReady(tornado) then return end

	local tornadoRange = math.min(400 + 400 * Ability.GetLevel(NPC.GetAbility(myHero, "invoker_wex")), 2000)

	if not FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
		if invoke and Ability.IsCastable(invoke, myMana-150) and FAIO.InvokerIsSkillInvokable(myHero, tornado) then
			FAIO.invokerInvokeAbility(myHero, tornado)
			if Menu.GetValue(FAIO_options.optionHeroInvokerTornadoStyle) == 0 then
				if NPC.IsEntityInRange(myHero, enemy, tornadoRange) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
					return
				end
			else
				local pos = Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500)
				Ability.CastPosition(tornado, pos)
				return
			end
		end
	else
		if Menu.GetValue(FAIO_options.optionHeroInvokerTornadoStyle) == 0 then
			if NPC.IsEntityInRange(myHero, enemy, tornadoRange) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
				Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, enemy, tornadoPrediction))
				return
			end
		else
			local pos = Entity.GetAbsOrigin(myHero) + (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(500)
			Ability.CastPosition(tornado, pos)
			return
		end
	end

end

function FAIO.InvokerCataclysmKillSteal(myHero, myMana, invoke)

	if not myHero then return false end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end
	
	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end

	local cataclysm = NPC.GetAbility(myHero, "special_bonus_unique_invoker_4")
		if not cataclysm then return end
		if Ability.GetLevel(cataclysm) < 1 then return end

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
		if not sunStrike then return end
		if not Ability.IsReady(sunStrike) then return end
		if not Ability.IsCastable(sunStrike, myMana) then return end

	local damage = (37.5 + 62.5 * Ability.GetLevel(NPC.GetAbility(myHero, "invoker_exort"))) * 0.95

	local ssSlot = 3
		if FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
			if Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == "invoker_sun_strike" then
				ssSlot = 4
			end
		end

	local count = 0
	for i = 1, Heroes.Count(), 1 do
		local enemies = Heroes.Get(i)
		if enemies ~= nil and Entity.IsHero(enemies) and not Entity.IsSameTeam(myHero, enemies) then
			local enemy = FAIO.targetChecker(enemies)
			if enemy then
				if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
					if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) * 2 <= damage then
						count = count + 1
					end
				end
			end
		end
	end

	if count > 0 then
		if count >= Menu.GetValue(FAIO_options.optionHeroInvokerCataKSCount) then
			if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
				if invoke and Ability.IsCastable(invoke, myMana-175) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
					FAIO.invokerInvokeAbility(myHero, sunStrike)
					return
				end
			else
				if os.clock() - FAIO.invokerChannellingKillstealTimer > 0.5 then
					Ability.CastTarget(sunStrike, myHero)
					FAIO.invokerChannellingKillstealTimer = os.clock()
					return
				end
			end	
		end
	end

	return

end

function FAIO.InvokerCancelTPingInFog(myHero, myMana, enemy, invoke, tornado)

	if Menu.IsKeyDownOnce(FAIO_options.optionComboKey) then return end
	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	if os.clock() - FAIO.invokerChannellingKillstealTimer <= 3 then return end

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end

	if not tornado then return end
	if not Ability.IsReady(tornado) then return end
	if not FAIO.InvokerIsAbilityInvoked(myHero, tornado) and not Ability.IsCastable(invoke, myMana) then return end

	if FAIO.TPParticleUnit ~= nil and NPC.IsDormant(FAIO.TPParticleUnit) then
		if FAIO.TPParticleTime > 0 and FAIO.TPParticlePosition:__tostring() ~= Vector(0.0, 0.0, 0.0):__tostring() and not FAIO.invokerSunstrikeKSParticleProcess(myHero) then
			if (Entity.GetAbsOrigin(myHero) - FAIO.TPParticlePosition):Length2D() < 2250 then
				if GameRules.GetGameTime() + ((Entity.GetAbsOrigin(myHero) - FAIO.TPParticlePosition):Length2D() / 1000) < FAIO.TPParticleTime + 2.75 then
					if NPC.IsPositionInRange(myHero, FAIO.TPParticlePosition, (400 + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) * 400), 0) then
						if tornado and Ability.IsReady(tornado) then
							if not FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
								if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(tornado, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, tornado) then
									FAIO.invokerInvokeAbility(myHero, tornado)
									Ability.CastPosition(tornado, Entity.GetAbsOrigin(myHero) + (FAIO.TPParticlePosition - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(250), true)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									return
								end
							else
								if Ability.IsCastable(tornado, myMana) then
									Ability.CastPosition(tornado, Entity.GetAbsOrigin(myHero) + (FAIO.TPParticlePosition - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(250))
									FAIO.invokerChannellingKillstealTimer = os.clock()
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

function FAIO.InvokerCancelBaraCharge(myHero, myMana, enemy, invoke, coldSnap, tornado, deafeningBlast)

	if Menu.IsKeyDownOnce(FAIO_options.optionComboKey) then return end
	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	if os.clock() - FAIO.invokerChannellingKillstealTimer <= 3 then return end

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end

	if not coldSnap or not tornado or not deafeningBlast then return end
	if not Ability.IsReady(coldSnap) and not Ability.IsReady(tornado) and not Ability.IsReady(deafeningBlast) then return end
	if not FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) and not FAIO.InvokerIsAbilityInvoked(myHero, tornado) and not FAIO.InvokerIsAbilityInvoked(myHero, deafeningBlast) and not Ability.IsCastable(invoke, myMana) then return end

	local skillSelector
	if Ability.IsReady(coldSnap) then
		skillSelector = coldSnap
	else
		if Ability.IsReady(tornado) then
			skillSelector = tornado
		else
			if Ability.IsReady(deafeningBlast) then
				skillSelector = deafeningBlast
			end
		end
	end

	if not skillSelector then return end

	local castRange = 950
	if skillSelector ~= nil and skillSelector == tornado then
		castRange = 400 + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) * 400
	end
	if castRange > 1750 then
		castRange = 1750
	end

	local cancelEnemies = NPC.GetHeroesInRadius(myHero, castRange, Enum.TeamType.TEAM_ENEMY)
	for _, cancelEnemy in ipairs(cancelEnemies) do
		if cancelEnemy and not NPC.IsDormant(cancelEnemy) and not NPC.IsIllusion(cancelEnemy) and Entity.IsAlive(cancelEnemy) then
			if NPC.HasModifier(cancelEnemy, "modifier_spirit_breaker_charge_of_darkness") then
				if not NPC.HasState(cancelEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then	
					if not NPC.IsLinkensProtected(cancelEnemy) then
						if skillSelector == coldSnap then
							if not FAIO.InvokerIsAbilityInvoked(myHero, skillSelector) then
								if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
									FAIO.invokerInvokeAbility(myHero, skillSelector)
									Ability.CastTarget(skillSelector, cancelEnemy, true)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									break
									return
								end
							else
								if Ability.IsCastable(skillSelector, myMana) then
									Ability.CastTarget(skillSelector, cancelEnemy)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									break
									return
								end
							end
						elseif skillSelector == deafeningBlast then
							local deafeningBlastPrediction = Ability.GetCastPoint(skillSelector) + (Entity.GetAbsOrigin(cancelEnemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + NPC.GetTimeToFace(myHero, cancelEnemy) + 1
							if NPC.IsRunning(cancelEnemy) and FAIO_utility_functions.GetMoveSpeed(cancelEnemy) > 500 then
								if not FAIO.InvokerIsAbilityInvoked(myHero, skillSelector) then
									if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
										FAIO.invokerInvokeAbility(myHero, skillSelector)
										Ability.CastPosition(skillSelector, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.castLinearPrediction(myHero, cancelEnemy, deafeningBlastPrediction) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(50), true)
										FAIO.invokerChannellingKillstealTimer = os.clock()
										break
										return
									end
								else
									if Ability.IsCastable(skillSelector, myMana) then
										Ability.CastPosition(deafeningBlast, FAIO_utility_functions.castLinearPrediction(myHero, cancelEnemy, deafeningBlastPrediction))
										FAIO.invokerChannellingKillstealTimer = os.clock()
										break
										return
									end
								end
							end
						end
					end		
					if skillSelector == tornado then
						local tornadoPrediction = Ability.GetCastPoint(tornado) + (Entity.GetAbsOrigin(cancelEnemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1000) * 1.25 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + 0.75 + NPC.GetTimeToFace(myHero, cancelEnemy)
						if NPC.IsRunning(cancelEnemy) and FAIO_utility_functions.GetMoveSpeed(cancelEnemy) > 500 and not NPC.IsDormant(cancelEnemy) then
							if not FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
								if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
									FAIO.invokerInvokeAbility(myHero, tornado)
									Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, cancelEnemy, tornadoPrediction), true)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									break
									return
								end
							else
								if Ability.IsCastable(tornado, myMana) then
									Ability.CastPosition(tornado, FAIO_utility_functions.castLinearPrediction(myHero, cancelEnemy, tornadoPrediction))
									FAIO.invokerChannellingKillstealTimer = os.clock()
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

function FAIO.InvokerCancelVisibleChannellingAbilities(myHero, myMana, enemy, invoke, coldSnap, tornado)

	if Menu.IsKeyDownOnce(FAIO_options.optionComboKey) then return end
	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	if os.clock() - FAIO.invokerChannellingKillstealTimer <= 3 then return end

	if not myHero then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 or Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end

	if not coldSnap or not tornado then return end
	if not Ability.IsReady(coldSnap) and not Ability.IsReady(tornado) then return end
	if not FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) and not FAIO.InvokerIsAbilityInvoked(myHero, tornado) and not Ability.IsCastable(invoke, myMana) then return end

	local channellingTable = {
		npc_dota_hero_bane = { "bane_fiends_grip", { 5, 5, 5 } },
		npc_dota_hero_crystal_maiden = { "crystal_maiden_freezing_field", { 10, 10, 10} },
		npc_dota_hero_enigma = { "enigma_black_hole", { 4, 4, 4 } },
		npc_dota_hero_oracle = { "oracle_fortunes_end", { 2.5, 2.5, 2.5, 2.5 } },
		npc_dota_hero_pudge = { "pudge_dismember", { 3, 3, 3 } },
		npc_dota_hero_pugna = { "pugna_life_drain", { 10, 10, 10 } },
		npc_dota_hero_sand_king = { "sandking_epicenter", { 2, 2, 2} },
		npc_dota_hero_shadow_shaman = { "shadow_shaman_shackles", { 2.75, 3.5, 4.25, 5 } },
		npc_dota_hero_tinker = { "tinker_rearm", { 3, 1.5, 0.75 } },
		npc_dota_hero_warlock = { "warlock_upheaval", { 16, 16, 16, 16 } },
		npc_dota_hero_witch_doctor = { "witch_doctor_death_ward", { 8, 8, 8} }
				}

	local cancelEnemies = NPC.GetHeroesInRadius(myHero, 1750, Enum.TeamType.TEAM_ENEMY)
	for _, cancelEnemy in ipairs(cancelEnemies) do
		if cancelEnemy and not NPC.IsDormant(cancelEnemy) and not NPC.IsIllusion(cancelEnemy) and Entity.IsAlive(cancelEnemy) then
			if not NPC.HasState(cancelEnemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				for i, v in pairs(channellingTable) do
					if (NPC.GetUnitName(cancelEnemy) == i and Ability.IsChannelling(NPC.GetAbility(cancelEnemy, v[1]))) or NPC.HasModifier(cancelEnemy, "modifier_teleporting") then
						local enemyRange = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(cancelEnemy)):Length2D()
						local skillSelector
							if FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) then
								if Ability.IsReady(coldSnap) and enemyRange < 950 then
									skillSelector = coldSnap
								else
									if Ability.IsReady(tornado) and enemyRange < 400 + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) * 400 then
										if not FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
											if Ability.IsReady(invoke) then
												skillSelector = tornado
											end
										else
											skillSelector = tornado
										end
									end
								end
							elseif FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
								if Ability.IsReady(tornado) and enemyRange < 400 + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) * 400 then
									skillSelector = tornado
								else
									if Ability.IsReady(coldSnap) and enemyRange < 950 then
										if not FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) then
											if Ability.IsReady(invoke) then
												skillSelector = coldSnap
											end
										else
											skillSelector = coldSnap
										end
									end
								end
							elseif not FAIO.InvokerIsAbilityInvoked(myHero, coldSnap) and not FAIO.InvokerIsAbilityInvoked(myHero, tornado) then
								if Ability.IsReady(invoke) then
									if Ability.IsReady(coldSnap) and enemyRange < 950 then
										skillSelector = coldSnap
									else
										if Ability.IsReady(tornado) and enemyRange < 400 + Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) * 400 then
											skillSelector = tornado
										end
									end
								end
							end
						if skillSelector == nil then
							break
							return
						end

						if skillSelector == coldSnap then
							if not NPC.IsLinkensProtected(cancelEnemy) then
								if not FAIO.InvokerIsAbilityInvoked(myHero, skillSelector) then
									if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
										FAIO.invokerInvokeAbility(myHero, skillSelector)
										Ability.CastTarget(skillSelector, cancelEnemy, true)
										FAIO.invokerChannellingKillstealTimer = os.clock()
										break
										return
									end
								else
									if Ability.IsCastable(skillSelector, myMana) then
										Ability.CastTarget(coldSnap, cancelEnemy)
										FAIO.invokerChannellingKillstealTimer = os.clock()
										break
										return
									end
								end
							end
						elseif skillSelector == tornado then
							if NPC.GetUnitName(cancelEnemy) == i and Ability.IsChannelling(NPC.GetAbility(cancelEnemy, v[1])) then
								if Ability.GetChannelStartTime(NPC.GetAbility(cancelEnemy, v[1])) + v[2][Ability.GetLevel(NPC.GetAbility(cancelEnemy, v[1]))] > GameRules.GetGameTime() + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1000) then
									if not FAIO.InvokerIsAbilityInvoked(myHero, skillSelector) then
										if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
											FAIO.invokerInvokeAbility(myHero, skillSelector)
											Ability.CastPosition(skillSelector, Entity.GetAbsOrigin(cancelEnemy), true)
											FAIO.invokerChannellingKillstealTimer = os.clock()
											break
											return
										end
									else
										if Ability.IsCastable(skillSelector, myMana) then
											Ability.CastPosition(skillSelector, Entity.GetAbsOrigin(cancelEnemy))
											FAIO.invokerChannellingKillstealTimer = os.clock()
											break
											return
										end
									end
								end
							elseif NPC.HasModifier(cancelEnemy, "modifier_teleporting") then
								if GameRules.GetGameTime() + ((Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D() / 1000) < Modifier.GetDieTime(NPC.GetModifier(cancelEnemy, "modifier_teleporting")) and Ability.IsReady(tornado) then
									if not FAIO.InvokerIsAbilityInvoked(myHero, skillSelector) then
										if invoke and Ability.IsCastable(invoke, myMana) and Ability.IsCastable(skillSelector, myMana - 60) and FAIO.InvokerIsSkillInvokable(myHero, skillSelector) then
											FAIO.invokerInvokeAbility(myHero, skillSelector)
											Ability.CastPosition(skillSelector, Entity.GetAbsOrigin(cancelEnemy), true)
											FAIO.invokerChannellingKillstealTimer = os.clock()
											break
											return
										end
									else
										if Ability.IsCastable(skillSelector, myMana) then
											Ability.CastPosition(skillSelector, Entity.GetAbsOrigin(cancelEnemy))
											FAIO.invokerChannellingKillstealTimer = os.clock()
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

end

function FAIO.InvokerIsSkillInvokable(myHero, skill)

	if not myHero then return false end
	if not skill then return false end

	local skillName = Ability.GetName(skill)

	for i, v in pairs(FAIO_data.invokerInvokeOrder) do
		if i == skillName then
			for k, l in ipairs(v) do
				if not NPC.GetAbilityByIndex(myHero, l) or (NPC.GetAbilityByIndex(myHero, l) and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, l)) < 1) then
					return false
				end
			end
		end
	end

	return true

end

function FAIO.InvokerPreInvoke(myHero, myMana, invoke)

	if not myHero then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if os.clock() - FAIO.lastTick < 0.5 then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 1)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then
		FAIO.PreInvokeSkills = {}
		return
	end

	local skill1
	local skill2
	for _, v in ipairs(FAIO.PreInvokeSkills) do
		if v then
			skill1 = v[1]
			skill2 = v[2]
		end
	end

	if not FAIO.InvokerIsSkillInvokable(myHero, skill1) or not FAIO.InvokerIsSkillInvokable(myHero, skill2) then
		FAIO.PreInvokeSkills = {}
		return
	end
		
	local invokeChecker = FAIO.InvokerInvokedChecker(myHero, Ability.GetName(skill1), Ability.GetName(skill2))

	if invokeChecker then
		FAIO.PreInvokeSkills = {}
		return
	end

	if next(FAIO.PreInvokeSkills) == nil then return end

	if Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == Ability.GetName(skill1) or Ability.GetName(NPC.GetAbilityByIndex(myHero, 4)) == Ability.GetName(skill1) then
		if invoke and Ability.IsCastable(invoke, myMana) then
			FAIO.invokerInvokeAbility(myHero, NPC.GetAbilityByIndex(myHero, 4))
			FAIO.lastTick = os.clock()
			return
		end
	end

	if Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) ~= Ability.GetName(skill2) then
		if invoke and Ability.IsCastable(invoke, myMana) then
			FAIO.invokerInvokeAbility(myHero, skill2)
			FAIO.lastTick = os.clock()
			return
		end
	end

	if Ability.GetName(NPC.GetAbilityByIndex(myHero, 3)) == Ability.GetName(skill2) then
		if invoke and Ability.IsCastable(invoke, myMana) then
			FAIO.invokerInvokeAbility(myHero, skill1)
			FAIO.lastTick = os.clock()
			return
		end
	end
end
			
function FAIO.InvokerIsAbilityInvoked(myHero, skill)

	for i = 3, 4 do
		if Ability.GetName(NPC.GetAbilityByIndex(myHero, i)) == Ability.GetName(skill) then
			return true
		end
	end
	
	return false

end
	

function FAIO.InvokerInvokedChecker(myHero, skill1, skill2)

	if Ability.GetName(NPC.GetAbilityByIndex(myHero,3)) == skill1 and Ability.GetName(NPC.GetAbilityByIndex(myHero,4)) == skill2 then
		return true
	end
	
	return false

end

function FAIO.invokerInvokeAbility(myHero, ability)
	
	if not myHero then return end
	if not ability then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if not FAIO.InvokerIsSkillInvokable(myHero, ability) then return end

	local skillName = Ability.GetName(ability)
    		if not skillName then return end

	local invokeOrder = FAIO_data.invokerInvokeOrder[skillName]
    		if not invokeOrder then return end

	local invoke = NPC.GetAbility(myHero, "invoker_invoke")
		if not invoke then return end

	for i, v in ipairs(invokeOrder) do
        	local orb = NPC.GetAbilityByIndex(myHero, v)

        	if orb then
			Ability.CastNoTarget(orb)
		end
	end

	Ability.CastNoTarget(invoke)

end

function FAIO.invokerProcessInstancesWhileComboing(myHero)

	if not myHero then return end
	if os.clock() - FAIO.invokerCaptureGhostwalkActivation < 1.5 then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetCooldownTimeLeft(NPC.GetAbility(myHero, "invoker_invoke")) < 0.25 then return end
	if Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then return end
	
	if os.clock() - FAIO.InvokerCaptureManualInstances < 2.5 then return end

	if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 1 then return end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return end
	
	if os.clock() - FAIO.InvokerLastChangedInstance < 0.75 then return end

	local instanceTable = {}
	local modifiers = NPC.GetModifiers(myHero)
	for _, modifier in ipairs(modifiers) do
		if modifier then
			local modifierName = Modifier.GetName(modifier)
			if modifierName == "modifier_invoker_quas_instance" or modifierName == "modifier_invoker_wex_instance" or modifierName == "modifier_invoker_exort_instance" then
				table.insert(instanceTable, modifierName)
			end
		end
	end

	if #instanceTable < 3 then return end

	if Entity.GetHealth(myHero) < Entity.GetMaxHealth(myHero) * 0.25 then
		if instanceTable[1] ~= "modifier_invoker_quas_instance" or instanceTable[2] ~= "modifier_invoker_quas_instance" or instanceTable[3] ~= "modifier_invoker_quas_instance" then
			FAIO.invokerChangeInstances(myHero, "QQQ")
			FAIO.InvokerLastChangedInstance = os.clock()
		end
	else
		if instanceTable[1] ~= "modifier_invoker_exort_instance" or instanceTable[2] ~= "modifier_invoker_exort_instance" or instanceTable[3] ~= "modifier_invoker_exort_instance" then
			FAIO.invokerChangeInstances(myHero, "EEE")
			FAIO.InvokerLastChangedInstance = os.clock()
		end
	end

end

function FAIO.invokerProcessInstances(myHero, order)

	if not myHero then return end
	if not order then return end
	if os.clock() - FAIO.invokerCaptureGhostwalkActivation < 1.5 then return end
	if os.clock() - FAIO.InvokerCaptureManualInstances < 2.5 then return end
	if next(FAIO.PreInvokeSkills) ~= nil then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then
		return
	end

	if os.clock() - FAIO.InvokerLastChangedInstance < Menu.GetValue(FAIO_options.optionHeroInvokerInstanceDelay) * 0.25 then return end

	local instanceTable = {}
	local modifiers = NPC.GetModifiers(myHero)
	for _, modifier in ipairs(modifiers) do
		if modifier then
			local modifierName = Modifier.GetName(modifier)
			if modifierName == "modifier_invoker_quas_instance" or modifierName == "modifier_invoker_wex_instance" or modifierName == "modifier_invoker_exort_instance" then
				table.insert(instanceTable, modifierName)
			end
		end
	end

	if #instanceTable < 3 then return end

	if order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION or order == Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET then
		if Entity.GetHealth(myHero) < Entity.GetMaxHealth(myHero) then
			if instanceTable[1] ~= "modifier_invoker_quas_instance" or instanceTable[2] ~= "modifier_invoker_quas_instance" or instanceTable[3] ~= "modifier_invoker_quas_instance" then
				FAIO.invokerChangeInstances(myHero, "QQQ")
				FAIO.InvokerLastChangedInstance = os.clock()
			end
		else
			if instanceTable[1] ~= "modifier_invoker_wex_instance" or instanceTable[2] ~= "modifier_invoker_wex_instance" or instanceTable[3] ~= "modifier_invoker_wex_instance" then
				FAIO.invokerChangeInstances(myHero, "WWW")
				FAIO.InvokerLastChangedInstance = os.clock()
			end
		end
	end

	if order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE or order == Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET then
		local exort = NPC.GetAbilityByIndex(myHero, 2)
		if exort and Ability.GetLevel(exort) > 0 then
			if instanceTable[1] ~= "modifier_invoker_exort_instance" or instanceTable[2] ~= "modifier_invoker_exort_instance" or instanceTable[3] ~= "modifier_invoker_exort_instance" then
				FAIO.invokerChangeInstances(myHero, "EEE")
				FAIO.InvokerLastChangedInstance = os.clock()
			end
		else
			if instanceTable[1] ~= "modifier_invoker_wex_instance" or instanceTable[2] ~= "modifier_invoker_wex_instance" or instanceTable[3] ~= "modifier_invoker_wex_instance" then
				FAIO.invokerChangeInstances(myHero, "WWW")
				FAIO.InvokerLastChangedInstance = os.clock()
			end
		end
	end

end		

function FAIO.invokerChangeInstances(myHero, instance)

	if not myHero then return end
	if not instance then return end

	if os.clock() - FAIO.invokerCaptureGhostwalkActivation < 1.5 then return end
	
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 0)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 and Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then
		return
	end

	local invokeOrder = {}
	if instance == "QQQ" then
		local quas = NPC.GetAbilityByIndex(myHero, 0)
		if quas and Ability.GetLevel(quas) > 0 then
			invokeOrder = {0,0,0}
		end
	elseif instance == "WWW" then
		local wex = NPC.GetAbilityByIndex(myHero, 1)
		if wex and Ability.GetLevel(wex) > 0 then
			invokeOrder = {1,1,1}
		end
	elseif instance == "EEE" then
		local exort = NPC.GetAbilityByIndex(myHero, 2)
		if exort and Ability.GetLevel(exort) > 0 then
			invokeOrder = {2,2,2}
		end
	end

	for i, v in ipairs(invokeOrder) do
        	local orb = NPC.GetAbilityByIndex(myHero, v)

        	if orb then
			Ability.CastNoTarget(orb)
		end
	end

end

function FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, enemy)

	if not myHero then return end
	if not enemy then return end

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	if not sunStrike or (sunStrike and not Ability.IsReady(sunStrike)) then return end
	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local sunStrikeDMG = 37.5 + (62.5 * Ability.GetLevel(NPC.GetAbility(myHero, "invoker_exort")))
		if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
			sunStrikeDMG = 37.5 + (62.5 * (Ability.GetLevel(NPC.GetAbility(myHero, "invoker_exort")) + 1))
		end

	local curTime = GameRules.GetGameTime()

	local stunRootList = {
		"modifier_stunned",
		"modifier_bashed",
		"modifier_alchemist_unstable_concoction", 
		"modifier_ancientapparition_coldfeet_freeze", 
		"modifier_axe_berserkers_call",
		"modifier_bane_fiends_grip",
		"modifier_bane_nightmare",
		"modifier_bloodseeker_rupture",
		"modifier_rattletrap_hookshot", 
		"modifier_earthshaker_fissure_stun", 
		"modifier_earth_spirit_boulder_smash",
		"modifier_enigma_black_hole_pull",
		"modifier_faceless_void_chronosphere_freeze",
		"modifier_jakiro_ice_path_stun", 
		"modifier_keeper_of_the_light_mana_leak_stun", 
		"modifier_kunkka_torrent", 
		"modifier_legion_commander_duel", 
		"modifier_lion_impale", 
		"modifier_magnataur_reverse_polarity", 
		"modifier_medusa_stone_gaze_stone", 
		"modifier_morphling_adaptive_strike", 
		"modifier_naga_siren_ensnare", 
		"modifier_nyx_assassin_impale", 
		"modifier_pudge_dismember", 
		"modifier_sandking_impale", 
		"modifier_shadow_shaman_shackles", 
		"modifier_techies_stasis_trap_stunned", 
		"modifier_tidehunter_ravage", 
		"modifier_treant_natures_guise",
		"modifier_windrunner_shackle_shot",
		"modifier_rooted", 
		"modifier_crystal_maiden_frostbite", 
		"modifier_ember_spirit_searing_chains", 
		"modifier_meepo_earthbind",
		"modifier_lone_druid_spirit_bear_entangle_effect",
		"modifier_slark_pounce_leash",
		"modifier_storm_spirit_electric_vortex_pull",
		"modifier_treant_overgrowth", 
		"modifier_abyssal_underlord_pit_of_malice_ensare", 
		"modifier_rod_of_atos_debuff",
		"modifier_eul_cyclone",
		"modifier_obsidian_destroyer_astral_imprisonment_prison",
		"modifier_shadow_demon_disruption",
		"modifier_teleporting",
		"modifier_invoker_tornado"
			}
	
	local searchMod
	for _, modifier in ipairs(stunRootList) do
		if NPC.HasModifier(enemy, modifier) then
			searchMod = NPC.GetModifier(enemy, modifier)
			break
		end
	end

	if not searchMod then return { 0, 0 } end

	local timing = 0
	local HPtreshold = 0
	if searchMod then
		if NPC.HasModifier(enemy, Modifier.GetName(searchMod)) then
			if Modifier.GetName(searchMod) == "modifier_enigma_black_hole_pull" then
				if Modifier.GetCreationTime(searchMod) + 4 - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod) + 0.3
					HPtreshold = sunStrikeDMG + 2 * FAIO.GetTeammateAbilityLevel(myHero, "enigma_black_hole") * 37
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_faceless_void_chronosphere_freeze" then
				if Modifier.GetCreationTime(searchMod) + (3.5 + FAIO.GetTeammateAbilityLevel(myHero, "faceless_void_chronosphere") * 0.5) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod)
					HPtreshold = sunStrikeDMG * 1.25
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_axe_berserkers_call" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod)
					HPtreshold = sunStrikeDMG * 1.35
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_bane_fiends_grip" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod) + 0.3
					HPtreshold = sunStrikeDMG + 2 * (45 + FAIO.GetTeammateAbilityLevel(myHero, "bane_fiends_grip") * 55)
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_legion_commander_duel" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod)
					HPtreshold = sunStrikeDMG * 1.35
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_pudge_dismember" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod) + 0.3
					HPtreshold = sunStrikeDMG + 2 * (22 + FAIO.GetTeammateAbilityLevel(myHero, "pudge_dismember") * 22)
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_crystal_maiden_frostbite" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod) + 0.3
					HPtreshold = sunStrikeDMG + 75
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_ember_spirit_searing_chains" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod) + 0.3
					HPtreshold = sunStrikeDMG + 85
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_eul_cyclone" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetDieTime(searchMod) - 1.7 + 0.05
					HPtreshold = sunStrikeDMG - 10
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_obsidian_destroyer_astral_imprisonment_prison" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetDieTime(searchMod) - 1.7 + 0.15
					HPtreshold = sunStrikeDMG + (25 + FAIO.GetTeammateAbilityLevel(myHero, "obsidian_destroyer_astral_imprisonment") * 75) * 0.75
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_shadow_demon_disruption" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetDieTime(searchMod) - 1.7 + 0.1
					HPtreshold = sunStrikeDMG - 10
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_invoker_tornado" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetDieTime(searchMod) - 1.7 + 0.05
					HPtreshold = sunStrikeDMG - 10
				else
					timing = 0
					HPtreshold = 0
				end
			elseif Modifier.GetName(searchMod) == "modifier_teleporting" then
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod)
					HPtreshold = sunStrikeDMG - 10
				else
					timing = 0
					HPtreshold = 0
				end
			else
				if Modifier.GetDieTime(searchMod) - curTime >= 1.5 then
					timing = Modifier.GetCreationTime(searchMod)
					HPtreshold = sunStrikeDMG * (1 + Menu.GetValue(FAIO_options.optionKillStealInvokerTreshold) / 100)
				else
					timing = 0
					HPtreshold = 0
				end
			end
		else
			timing = 0
			HPtreshold = 0
		end
	else
		timing = 0
		HPtreshold = 0
	end

	return { timing, HPtreshold }

end

function FAIO.invokerSunstrikeKSParticleProcess(myHero)

	if not myHero then return false end
	if FAIO.TPParticlePosition:__tostring() == Vector(0.0, 0.0, 0.0):__tostring() then return false end
	if NPC.GetMana(myHero) < 175 then return false end	

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	if not sunStrike or (sunStrike and not Ability.IsReady(sunStrike)) then return false end
	if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) and not Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then return false end
	
	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local sunStrikeDMG = 37.5 + (62.5 * Ability.GetLevel(NPC.GetAbility(myHero, "invoker_exort")))
		if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
			sunStrikeDMG = 37.5 + (62.5 * (Ability.GetLevel(NPC.GetAbility(myHero, "invoker_exort")) + 1))
		end

	if FAIO.TPParticleTime > 0 and FAIO.TPParticleUnit ~= nil then
		for hero, data in pairs(FAIO.enemyHeroTable) do
			local heroHP = data[1]
			local heroHPreg = data[2]
			local timeStamp = data[3]
			if hero and NPC.IsDormant(hero) and hero == FAIO.TPParticleUnit then
				if GameRules.GetGameTime() - timeStamp <= 10 then
					if heroHP + heroHPreg * (math.ceil(GameRules.GetGameTime() - timeStamp)) <= sunStrikeDMG and heroHP > 0 then
						return true
					end
				end
			end
		end
	end
	return false

end

function FAIO.InvokerDrawShort(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroInvoker) then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroInvokerPanelShort) then return end
	if FAIO.Toggler then return end

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	local startX = w/2 + Menu.GetValue(FAIO_options.optionHeroInvokerPanelShortXPos)
	local startY = h/2 + Menu.GetValue(FAIO_options.optionHeroInvokerPanelShortYPos)

	local numberCombos = 1
	local maxSkills = 6

	local invokeTranslator = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity",
		"item_cyclone",
		"item_rod_of_atos",
		"item_refresher"
			}

	local imageHandleSnap = FAIO.invokerCachedIcons["invoker_cold_snap"]
	local imageHandleSunStrike = FAIO.invokerCachedIcons["invoker_sun_strike"]
	local imageHandleEmp = FAIO.invokerCachedIcons["invoker_emp"]
	local imageHandleTornado = FAIO.invokerCachedIcons["invoker_tornado"]
	local imageHandleAlacrity = FAIO.invokerCachedIcons["invoker_alacrity"]
	local imageHandleBlast = FAIO.invokerCachedIcons["invoker_deafening_blast"]
	local imageHandleMeteor = FAIO.invokerCachedIcons["invoker_chaos_meteor"]
	local imageHandleIcewall = FAIO.invokerCachedIcons["invoker_ice_wall"]
	local imageHandleSpirit = FAIO.invokerCachedIcons["invoker_forge_spirit"]
	local imageHandleGhost = FAIO.invokerCachedIcons["invoker_ghost_walk"]
	local imageHandleAgha = FAIO.invokerCachedIcons["item_ultimate_scepter"]
	local imageHandleRefresher = FAIO.invokerCachedIcons["item_refresher"]
	local imageHandleDagger = FAIO.invokerCachedIcons["item_blink"]
	local imageHandleEul = FAIO.invokerCachedIcons["item_cyclone"]
	local imageHandleAtos = FAIO.invokerCachedIcons["item_rod_of_atos"]

	local skillTranslator = {
		imageHandleTornado,
		imageHandleEmp,
		imageHandleMeteor, 
		imageHandleBlast,
		imageHandleSunStrike,
		imageHandleIcewall,
		imageHandleSnap,
		imageHandleSpirit,
		imageHandleAlacrity,
		imageHandleEul,
		imageHandleAtos,
		imageHandleRefresher
			}

		-- custom mode 1
	if FAIO.InvokerComboSelector == 12 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)], startX+2+25*0, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)], startX+2+25*1, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)], startX+2+25*2, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)], startX+2+25*3, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5)], startX+2+25*4, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6)], startX+2+25*5, startY+2, 25, 25)
		end
		Renderer.SetDrawColor(255, 255, 255, 150)
		Renderer.DrawText(FAIO.font, startX-20, startY+1, "1", 0)
	end
		-- custom mode 2
	if FAIO.InvokerComboSelector == 13 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)], startX+2+25*0, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)], startX+2+25*1, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)], startX+2+25*2, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)], startX+2+25*3, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5)], startX+2+25*4, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6)], startX+2+25*5, startY+2, 25, 25)
		end
		Renderer.SetDrawColor(255, 255, 255, 150)
		Renderer.DrawText(FAIO.font, startX-20, startY+1, "2", 0)
	end
		-- custom mode 3
	if FAIO.InvokerComboSelector == 14 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)], startX+2+25*0, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)], startX+2+25*1, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)], startX+2+25*2, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)], startX+2+25*3, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5)], startX+2+25*4, startY+2, 25, 25)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6) > 0 then
			Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6)], startX+2+25*5, startY+2, 25, 25)
		end
		Renderer.SetDrawColor(255, 255, 255, 150)
		Renderer.DrawText(FAIO.font, startX-20, startY+1, "3", 0)
	end

	if FAIO.InvokerComboSelector == 11 then
		Renderer.SetDrawColor(255, 255, 255, 150)
		Renderer.DrawText(FAIO.font, startX+2+25*2, startY+1, "dyn", 0)
		Renderer.SetDrawColor(0, 0, 0, 100)
		Renderer.DrawFilledRect(startX, startY, (25 * maxSkills) + 4, (25 * numberCombos) + 4)
	end

end

function FAIO.InvokerDraw(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroInvoker) then return end

	if FAIO.invokerPanelNeedsInit then
        	FAIO.invokerPanelInit()
        	FAIO.invokerPanelNeedsInit = false
    	end

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	local startX = w - 300 - Menu.GetValue(FAIO_options.optionHeroInvokerPanelXPos)
	local startY = 300 + Menu.GetValue(FAIO_options.optionHeroInvokerPanelYPos)

	local numberCombos = 11
	local maxSkills = 6

	local imageSize = FAIO.invokerPanelBoxSize

	if Menu.IsKeyDownOnce(FAIO_options.optionHeroInvokerToggleKey) then
		FAIO.Toggler = not FAIO.Toggler
	end

	if not FAIO.Toggler then return end
		
	 -- black background
	Renderer.SetDrawColor(0, 0, 0, 150)
	Renderer.DrawFilledRect(startX, startY, (imageSize * maxSkills) + 4, ((imageSize+2) * numberCombos) + 12)
	Renderer.DrawFilledRect(startX, startY+(imageSize+2)*12+12, (imageSize * maxSkills) + 4, (imageSize+2)*3 + 4)

	-- black border
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY, (imageSize * maxSkills) + 4, ((imageSize+2) * numberCombos) + 12)
	Renderer.DrawOutlineRect(startX, startY+(imageSize+2)*12+12, (imageSize * maxSkills) + 4, (imageSize+2)*3 + 4)

	local hoveringOverCombo1 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*0 + 0, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo2 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*1 + 1, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo3 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*2 + 2, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo4 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*3 + 3, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo5 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*4 + 4, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo6 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*5 + 5, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo7 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*6 + 6, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo8 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*7 + 7, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo9 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*8 + 8, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo10 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*9 + 9, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo11 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*10 + 10, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo12 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*12 + 12, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo13 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*13 + 13, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo14 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*14 + 14, (imageSize * maxSkills)+2 , (imageSize+2))

	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	local emp = NPC.GetAbility(myHero, "invoker_emp")
	local tornado = NPC.GetAbility(myHero, "invoker_tornado")
	local deafeningBlast = NPC.GetAbility(myHero, "invoker_deafening_blast")
	local chaosMeteor = NPC.GetAbility(myHero, "invoker_chaos_meteor")
	local coldSnap = NPC.GetAbility(myHero, "invoker_cold_snap")
	local forgeSpirit = NPC.GetAbility(myHero, "invoker_forge_spirit")
	local alacrity = NPC.GetAbility(myHero, "invoker_alacrity")
	local iceWall = NPC.GetAbility(myHero, "invoker_ice_wall")
	local euls = NPC.GetItem(myHero, "item_cyclone", true)
	local refresher = NPC.GetItem(myHero, "item_refresher", true)

	local invokeTranslator = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity",
		"item_cyclone",
		"item_rod_of_atos",
		"item_refresher"
			}

	if hoveringOverCombo1 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 1 then
				FAIO.PreInvokeSkills = {{coldSnap, forgeSpirit}}
				FAIO.InvokerComboSelector = 1
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 1 then
				FAIO.InvokerComboSelector = 1
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo2 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 2 then
				FAIO.PreInvokeSkills = {{coldSnap, forgeSpirit}}
				FAIO.InvokerComboSelector = 2
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 2 then
				FAIO.InvokerComboSelector = 2
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo3 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 3 then
				FAIO.PreInvokeSkills = {{emp, tornado}}
				FAIO.InvokerComboSelector = 3
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 3 then
				FAIO.InvokerComboSelector = 3
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo4 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 4 then
				FAIO.PreInvokeSkills = {{chaosMeteor, tornado}}
				FAIO.InvokerComboSelector = 4
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 4 then
				FAIO.InvokerComboSelector = 4
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo5 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 5 then
				FAIO.PreInvokeSkills = {{chaosMeteor, sunStrike}}
				FAIO.InvokerComboSelector = 5
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 5 then
				FAIO.InvokerComboSelector = 5
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo6 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 6 then
				FAIO.PreInvokeSkills = {{emp, tornado}}
				FAIO.InvokerComboSelector = 6
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 6 then
				FAIO.InvokerComboSelector = 6
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo7 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 7 then
				FAIO.PreInvokeSkills = {{sunStrike, tornado}}
				FAIO.InvokerComboSelector = 7
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 7 then
				FAIO.InvokerComboSelector = 7
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo8 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 8 then
				FAIO.PreInvokeSkills = {{sunStrike, tornado}}
				FAIO.InvokerComboSelector = 8
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 8 then
				FAIO.InvokerComboSelector = 8
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo9 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 9 then
				FAIO.PreInvokeSkills = {{emp, tornado}}
				FAIO.InvokerComboSelector = 9
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 9 then
				FAIO.InvokerComboSelector = 9
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo10 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 10 then
				FAIO.PreInvokeSkills = {{deafeningBlast, chaosMeteor}}
				FAIO.InvokerComboSelector = 10
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 10 then
				FAIO.InvokerComboSelector = 10
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo11 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if FAIO.InvokerComboSelector ~= 11 then
			FAIO.InvokerComboSelector = 11
		else
			FAIO.InvokerComboSelector = 0
		end
	elseif hoveringOverCombo12 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 12 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)])}}
						FAIO.InvokerComboSelector = 12
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
						FAIO.InvokerComboSelector = 12
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])}}
						FAIO.InvokerComboSelector = 12
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)])}}
						FAIO.InvokerComboSelector = 12
					end
				else
					FAIO.InvokerComboSelector = 0
				end	
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 12 then
				FAIO.InvokerComboSelector = 12
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo13 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 13 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)])}}
						FAIO.InvokerComboSelector = 13
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
						FAIO.InvokerComboSelector = 13
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])}}
						FAIO.InvokerComboSelector = 13
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)])}}
						FAIO.InvokerComboSelector = 13
					end
				else
					FAIO.InvokerComboSelector = 0
				end	
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 13 then
				FAIO.InvokerComboSelector = 13
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	elseif hoveringOverCombo14 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if Menu.IsEnabled(FAIO_options.optionHeroInvokerAutoInvoke) then
			if FAIO.InvokerComboSelector ~= 14 then
				if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
					if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) <= 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)])}}
						FAIO.InvokerComboSelector = 14
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) <= 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
						FAIO.InvokerComboSelector = 14
					elseif Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 9 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 9 then
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])}}
						FAIO.InvokerComboSelector = 14
					else
						FAIO.PreInvokeSkills = {{NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)])}}
						FAIO.InvokerComboSelector = 14
					end
				else
					FAIO.InvokerComboSelector = 0
				end	
			else
				FAIO.InvokerComboSelector = 0
			end
		else
			if FAIO.InvokerComboSelector ~= 14 then
				FAIO.InvokerComboSelector = 14
			else
				FAIO.InvokerComboSelector = 0
			end
		end
	end

	-- border
	if FAIO.InvokerComboSelector == 1 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*0 + 0, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 2 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*1 + 1, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 3 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*2 + 2, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 4 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*3 + 3, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 5 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*4 + 4, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 6 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*5 + 5, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 7 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*6 + 6, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 8 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*7 + 7, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 9 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*8 + 8, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 10 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*9 + 9, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 11 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*10 + 10, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 12 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*12 + 12, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 13 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*13 + 13, (imageSize * maxSkills)+2 , (imageSize+2))
	end
	if FAIO.InvokerComboSelector == 14 then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*14 + 14, (imageSize * maxSkills)+2 , (imageSize+2))
	end

	local imageHandleSnap = FAIO.invokerCachedIcons["invoker_cold_snap"]
	local imageHandleSunStrike = FAIO.invokerCachedIcons["invoker_sun_strike"]
	local imageHandleEmp = FAIO.invokerCachedIcons["invoker_emp"]
	local imageHandleTornado = FAIO.invokerCachedIcons["invoker_tornado"]
	local imageHandleAlacrity = FAIO.invokerCachedIcons["invoker_alacrity"]
	local imageHandleBlast = FAIO.invokerCachedIcons["invoker_deafening_blast"]
	local imageHandleMeteor = FAIO.invokerCachedIcons["invoker_chaos_meteor"]
	local imageHandleIcewall = FAIO.invokerCachedIcons["invoker_ice_wall"]
	local imageHandleSpirit = FAIO.invokerCachedIcons["invoker_forge_spirit"]
	local imageHandleGhost = FAIO.invokerCachedIcons["invoker_ghost_walk"]
	local imageHandleAgha = FAIO.invokerCachedIcons["item_ultimate_scepter"]
	local imageHandleRefresher = FAIO.invokerCachedIcons["item_refresher"]
	local imageHandleDagger = FAIO.invokerCachedIcons["item_blink"]
	local imageHandleEul = FAIO.invokerCachedIcons["item_cyclone"]
	local imageHandleAtos = FAIO.invokerCachedIcons["item_rod_of_atos"]

	

	-- combo CS, Forge, Alacrity
	if FAIO.InvokerComboSelector == 1 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_cold_snap", "invoker_forge_spirit") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleSnap, startX+2+imageSize*0, startY+2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(coldSnap) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*0+4, startY+2+4, math.floor(Ability.GetCooldownTimeLeft(coldSnap)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSpirit, startX+2+imageSize*1, startY+2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(forgeSpirit) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+2+4, math.floor(Ability.GetCooldownTimeLeft(forgeSpirit)), 0)
			end
		end
	Renderer.DrawImage(imageHandleAlacrity, startX+2+imageSize*2, startY+2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(alacrity) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+2+4, math.floor(Ability.GetCooldownTimeLeft(alacrity)), 0)
			end
		end

	-- combo CS, Forge, SS
	if FAIO.InvokerComboSelector == 2 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_cold_snap", "invoker_forge_spirit") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleSnap, startX+2+imageSize*0, startY+3+(imageSize+2)*1, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(coldSnap) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*0+4, startY+3+(imageSize+2)*1+4, math.floor(Ability.GetCooldownTimeLeft(coldSnap)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSpirit, startX+2+imageSize*1, startY+3+(imageSize+2)*1, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(forgeSpirit) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+3+(imageSize+2)*1+4, math.floor(Ability.GetCooldownTimeLeft(forgeSpirit)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSunStrike, startX+2+imageSize*2, startY+3+(imageSize+2)*1, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(sunStrike) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+3+(imageSize+2)*1+4, math.floor(Ability.GetCooldownTimeLeft(sunStrike)), 0)
			end
		end

	-- combo Tornado, EMP, Icewall
	if FAIO.InvokerComboSelector == 3 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_emp", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*0, startY+4+(imageSize+2)*2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*0+4, startY+4+(imageSize+2)*2+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleEmp, startX+2+imageSize*1, startY+4+(imageSize+2)*2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(emp) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+4+(imageSize+2)*2+4, math.floor(Ability.GetCooldownTimeLeft(emp)), 0)
			end
		end
	Renderer.DrawImage(imageHandleIcewall, startX+2+imageSize*2, startY+4+(imageSize+2)*2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(iceWall) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+4+(imageSize+2)*2+4, math.floor(Ability.GetCooldownTimeLeft(iceWall)), 0)
			end
		end
	Renderer.DrawText(FAIO.invokerPanelFont, startX+math.floor(imageSize/3)+imageSize*3, startY+4+(imageSize+2)*2+math.floor(imageSize/5), "or", 1)
	Renderer.DrawImage(imageHandleSnap, startX+2+imageSize*4, startY+4+(imageSize+2)*2, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(coldSnap) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+4+(imageSize+2)*2+4, math.floor(Ability.GetCooldownTimeLeft(coldSnap)), 0)
			end
		end

	-- combo Tornado, Meteor, Blast
	if FAIO.InvokerComboSelector == 4 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_chaos_meteor", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*0, startY+5+(imageSize+2)*3, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*0+4, startY+5+(imageSize+2)*3+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*1, startY+5+(imageSize+2)*3, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+5+(imageSize+2)*3+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*2, startY+5+(imageSize+2)*3, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+5+(imageSize+2)*3+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Eul, Sunstrike, Meteor, Blast
	if FAIO.InvokerComboSelector == 5 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_chaos_meteor", "invoker_sun_strike") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleEul, startX+2+imageSize*0, startY+6+(imageSize+2)*4, imageSize, imageSize)
	Renderer.DrawImage(imageHandleSunStrike, startX+2+imageSize*1, startY+6+(imageSize+2)*4, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(sunStrike) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+6+(imageSize+2)*4+4, math.floor(Ability.GetCooldownTimeLeft(sunStrike)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*2, startY+6+(imageSize+2)*4, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+6+(imageSize+2)*4+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*3, startY+6+(imageSize+2)*4, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+6+(imageSize+2)*4+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Tornado, EMP, Meteor, Blast
	if FAIO.InvokerComboSelector == 6 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_emp", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleAgha, startX+2+imageSize*0, startY+7+(imageSize+2)*5, imageSize, imageSize)
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*1, startY+7+(imageSize+2)*5, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+7+(imageSize+2)*5+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleEmp, startX+2+imageSize*2, startY+7+(imageSize+2)*5, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(emp) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+7+(imageSize+2)*5+4, math.floor(Ability.GetCooldownTimeLeft(emp)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*3, startY+7+(imageSize+2)*5, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+7+(imageSize+2)*5+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*4, startY+7+(imageSize+2)*5, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+7+(imageSize+2)*5+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Tornado, Sunstrike, Meteor, Blast
	if FAIO.InvokerComboSelector == 7 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_sun_strike", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleAgha, startX+2+imageSize*0, startY+8+(imageSize+2)*6, imageSize, imageSize)
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*1, startY+8+(imageSize+2)*6, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1+4, startY+8+(imageSize+2)*6+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSunStrike, startX+2+imageSize*2, startY+8+(imageSize+2)*6, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(sunStrike) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+8+(imageSize+2)*6+4, math.floor(Ability.GetCooldownTimeLeft(sunStrike)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*3, startY+8+(imageSize+2)*6, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+8+(imageSize+2)*6+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*4, startY+8+(imageSize+2)*6, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+8+(imageSize+2)*6+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Tornado, Sunstrike, Meteor, Blast, Refresher
	if FAIO.InvokerComboSelector == 8 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_sun_strike", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleRefresher, startX+2+imageSize*0, startY+9+(imageSize+2)*7, imageSize, imageSize)
	Renderer.DrawImage(imageHandleAgha, startX+2+imageSize*1, startY+9+(imageSize+2)*7, imageSize, imageSize)
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*2, startY+9+(imageSize+2)*7, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+9+(imageSize+2)*7+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSunStrike, startX+2+imageSize*3, startY+9+(imageSize+2)*7, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(sunStrike) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+9+(imageSize+2)*7+4, math.floor(Ability.GetCooldownTimeLeft(sunStrike)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*4, startY+9+(imageSize+2)*7, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+9+(imageSize+2)*7+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*5, startY+9+(imageSize+2)*7, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*5+4, startY+9+(imageSize+2)*7+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Tornado, Sunstrike, Meteor, Blast, Refresher
	if FAIO.InvokerComboSelector == 9 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_emp", "invoker_tornado") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleRefresher, startX+2+imageSize*0, startY+10+(imageSize+2)*8, imageSize, imageSize)
	Renderer.DrawImage(imageHandleAgha, startX+2+imageSize*1, startY+10+(imageSize+2)*8, imageSize, imageSize)
	Renderer.DrawImage(imageHandleTornado, startX+2+imageSize*2, startY+10+(imageSize+2)*8, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(tornado) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*2+4, startY+10+(imageSize+2)*8+4, math.floor(Ability.GetCooldownTimeLeft(tornado)), 0)
			end
		end
	Renderer.DrawImage(imageHandleEmp, startX+2+imageSize*3, startY+10+(imageSize+2)*8, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(emp) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+10+(imageSize+2)*8+4, math.floor(Ability.GetCooldownTimeLeft(emp)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*4, startY+10+(imageSize+2)*8, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+10+(imageSize+2)*8+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*5, startY+10+(imageSize+2)*8, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*5+4, startY+10+(imageSize+2)*8+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end

	-- combo Dagger, Blast, Meteor, Sunstrike
	if FAIO.InvokerComboSelector == 10 then
		if FAIO.InvokerInvokedChecker(myHero, "invoker_deafening_blast", "invoker_chaos_meteor") and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleRefresher, startX+2+imageSize*0, startY+11+(imageSize+2)*9, imageSize, imageSize)
	Renderer.DrawImage(imageHandleAgha, startX+2+imageSize*1, startY+11+(imageSize+2)*9, imageSize, imageSize)
	Renderer.DrawImage(imageHandleDagger, startX+2+imageSize*2, startY+11+(imageSize+2)*9, imageSize, imageSize)
	Renderer.DrawImage(imageHandleBlast, startX+2+imageSize*3, startY+11+(imageSize+2)*9, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(deafeningBlast) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*3+4, startY+11+(imageSize+2)*9+4, math.floor(Ability.GetCooldownTimeLeft(deafeningBlast)), 0)
			end
		end
	Renderer.DrawImage(imageHandleMeteor, startX+2+imageSize*4, startY+11+(imageSize+2)*9, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(chaosMeteor) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*4+4, startY+11+(imageSize+2)*9+4, math.floor(Ability.GetCooldownTimeLeft(chaosMeteor)), 0)
			end
		end
	Renderer.DrawImage(imageHandleSunStrike, startX+2+imageSize*5, startY+11+(imageSize+2)*9, imageSize, imageSize)
		if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 2 then
			if Ability.GetCooldownTimeLeft(sunStrike) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*5+4, startY+11+(imageSize+2)*9+4, math.floor(Ability.GetCooldownTimeLeft(sunStrike)), 0)
			end
		end

	-- dynamic mode
	if FAIO.InvokerComboSelector == 11 then
		Renderer.SetDrawColor(0, 205, 0, 255)
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	Renderer.DrawImage(imageHandleBlast, startX+2+(imageSize/2)*0, startY+12+(imageSize+2)*10, (imageSize/2), (imageSize/2))
	Renderer.DrawImage(imageHandleMeteor, startX+2+(imageSize/2)*1, startY+12+(imageSize+2)*10, (imageSize/2), (imageSize/2))
	
	Renderer.DrawImage(imageHandleSunStrike, startX+2+(imageSize/2)*0, startY+12+(imageSize+2)*10+(imageSize/2), (imageSize/2), (imageSize/2))
	Renderer.DrawImage(imageHandleTornado, startX+2+(imageSize/2)*1, startY+12+(imageSize+2)*10+(imageSize/2), (imageSize/2), (imageSize/2))
	
	Renderer.DrawImage(imageHandleEmp, startX+2+(imageSize/2)*2, startY+12+(imageSize+2)*10, (imageSize/2), (imageSize/2))
	Renderer.DrawImage(imageHandleSnap, startX+2+(imageSize/2)*3, startY+12+(imageSize+2)*10, (imageSize/2), (imageSize/2))
	
	Renderer.DrawImage(imageHandleSpirit, startX+2+(imageSize/2)*2, startY+12+(imageSize+2)*10+(imageSize/2), (imageSize/2), (imageSize/2))
	Renderer.DrawImage(imageHandleAlacrity, startX+2+(imageSize/2)*3, startY+12+(imageSize+2)*10+(imageSize/2), (imageSize/2), (imageSize/2))
	
	Renderer.DrawImage(imageHandleIcewall, startX+2+(imageSize/2)*4, startY+12+(imageSize+2)*10, (imageSize/2), (imageSize/2))
	Renderer.DrawImage(imageHandleGhost, startX+2+(imageSize/2)*4, startY+12+(imageSize+2)*10+(imageSize/2), (imageSize/2), (imageSize/2))

	Renderer.DrawText(FAIO.invokerPanelFont, startX+2+(imageSize/2)*6, startY+12+(imageSize+2)*10+math.floor(imageSize/6), "dynamic", 1)


	-- custom mode
	local skillTranslator = {
		imageHandleTornado,
		imageHandleEmp,
		imageHandleMeteor, 
		imageHandleBlast,
		imageHandleSunStrike,
		imageHandleIcewall,
		imageHandleSnap,
		imageHandleSpirit,
		imageHandleAlacrity,
		imageHandleEul,
		imageHandleAtos,
		imageHandleRefresher
			}
		-- custom mode 1
	if FAIO.InvokerComboSelector == 12 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)], startX+2+imageSize*0, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)], startX+2+imageSize*1, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)], startX+2+imageSize*2, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill4)], startX+2+imageSize*3, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill5)], startX+2+imageSize*4, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill6)], startX+2+imageSize*5, startY+14+(imageSize+2)*12, imageSize, imageSize)
	end
		-- custom mode 2
	if FAIO.InvokerComboSelector == 13 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)], startX+2+imageSize*0, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)], startX+2+imageSize*1, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)], startX+2+imageSize*2, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill4)], startX+2+imageSize*3, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill5)], startX+2+imageSize*4, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill6)], startX+2+imageSize*5, startY+15+(imageSize+2)*13, imageSize, imageSize)
	end
		-- custom mode 3
	if FAIO.InvokerComboSelector == 14 then
		if FAIO.InvokerInvokedChecker(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)], invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)]) and Ability.IsReady(NPC.GetAbility(myHero, "invoker_invoke")) then
			Renderer.SetDrawColor(0, 205, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 0, 255)
		end
	else	
		Renderer.SetDrawColor(255, 255, 255, 150)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)], startX+2+imageSize*0, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)], startX+2+imageSize*1, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)], startX+2+imageSize*2, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill4)], startX+2+imageSize*3, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill5)], startX+2+imageSize*4, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
	if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6) > 0 then
		Renderer.DrawImage(skillTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill6)], startX+2+imageSize*5, startY+16+(imageSize+2)*14, imageSize, imageSize)
	end
		-- custom combo text
	Renderer.SetDrawColor(255, 50, 0, 150)
	Renderer.DrawText(FAIO.invokerPanelFont, startX+2+imageSize*1, startY+11+math.floor(imageSize/3)+(imageSize+2)*11, "custom combo", 1)
	
	-- longest CDs
	if Menu.GetValue(FAIO_options.optionHeroInvokerPanelCD) == 1 then
		Renderer.SetDrawColor(255, 0, 0, 150)
		if FAIO.GetLongestCooldown(myHero, coldSnap, forgeSpirit, alacrity) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+2+(imageSize+2)*0+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, coldSnap, forgeSpirit, alacrity), 1)
		end
		if FAIO.GetLongestCooldown(myHero, coldSnap, forgeSpirit, sunStrike) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+3+(imageSize+2)*1+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, coldSnap, forgeSpirit, sunStrike), 1)
		end
		if FAIO.GetLongestCooldown(myHero, coldSnap, iceWall, tornado, emp) > 0 then
		Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+4+(imageSize+2)*2+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, coldSnap, iceWall, tornado, emp), 1)
		end
		if FAIO.GetLongestCooldown(myHero, tornado, chaosMeteor, deafeningBlast) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+5+(imageSize+2)*3+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, tornado, chaosMeteor, deafeningBlast), 1)
		end
		if FAIO.GetLongestCooldown(myHero, euls, sunStrike, chaosMeteor, deafeningBlast) > 0 then
		Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+6+(imageSize+2)*4+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, euls, sunStrike, chaosMeteor, deafeningBlast), 1)
		end
		if FAIO.GetLongestCooldown(myHero, tornado, emp, chaosMeteor, deafeningBlast) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+7+(imageSize+2)*5+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, tornado, emp, chaosMeteor, deafeningBlast), 1)
		end
		if FAIO.GetLongestCooldown(myHero, tornado, sunStrike, chaosMeteor, deafeningBlast) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+8+(imageSize+2)*6+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, tornado, sunStrike, chaosMeteor, deafeningBlast), 1)
		end
		if FAIO.GetLongestCooldown(myHero, tornado, sunStrike, chaosMeteor, deafeningBlast, refresher) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+9+(imageSize+2)*7+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, tornado, sunStrike, chaosMeteor, deafeningBlast, refresher), 1)
		end
		if FAIO.GetLongestCooldown(myHero, tornado, emp, chaosMeteor, deafeningBlast, refresher) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+10+(imageSize+2)*8+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, tornado, emp, chaosMeteor, deafeningBlast, refresher), 1)
		end
		if FAIO.GetLongestCooldown(myHero, sunStrike, chaosMeteor, deafeningBlast, refresher) > 0 then
			Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+11+(imageSize+2)*9+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, sunStrike, chaosMeteor, deafeningBlast, refresher), 1)
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3) > 0 then
			if FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+14+(imageSize+2)*12+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo1Skill3)])), 1)
			end
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3) > 0 then
			if FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+15+(imageSize+2)*13+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo2Skill3)])), 1)
			end
		end
		if Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2) > 0 and Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3) > 0 then
			if FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])) > 0 then
				Renderer.DrawText(FAIO.invokerPanelFont, startX+1-imageSize, startY+16+(imageSize+2)*14+math.floor(imageSize/9), FAIO.GetLongestCooldown(myHero, NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill1)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill2)]), NPC.GetAbility(myHero, invokeTranslator[Menu.GetValue(FAIO_options.optionHeroInvokerCombo3Skill3)])), 1)
			end
		end
	end

end

function FAIO.invokerPanelInit()

	FAIO.invokerPanelBoxSize = Menu.GetValue(FAIO.invokerPanelSizeOption)

	FAIO.invokerPanelFont = Renderer.LoadFont("Tahoma", math.floor(FAIO.invokerPanelBoxSize * 0.6), Enum.FontWeight.BOLD)

	local iconsTempTable = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity",
		"item_cyclone",
		"item_rod_of_atos",
		"item_refresher",
		"item_blink",
		"item_ultimate_scepter",
		"invoker_ghost_walk"
			}

	for i = 1, #iconsTempTable do
		local imageHandle = FAIO.invokerCachedIcons[iconsTempTable[i]]
		if imageHandle == nil then
			if iconsTempTable[i] ~= "item_cyclone" and iconsTempTable[i] ~= "item_rod_of_atos" and iconsTempTable[i] ~= "item_refresher" and iconsTempTable[i] ~= "item_blink" and iconsTempTable[i] ~= "item_ultimate_scepter" then
				imageHandle = Renderer.LoadImage("resource/flash3/images/spellicons/" .. iconsTempTable[i] .. ".png")	
				FAIO.invokerCachedIcons[iconsTempTable[i]] = imageHandle
			else
				imageHandle = Renderer.LoadImage("resource/flash3/images/items/" .. string.gsub(iconsTempTable[i], "item_", "") .. ".png")
				FAIO.invokerCachedIcons[iconsTempTable[i]] = imageHandle
			end
		end
	end
	
end

function FAIO.invokerDisplayInit()

	FAIO.invokerDisplayBoxSize = Menu.GetValue(FAIO.invokerDisplaySizeOption)
	FAIO.invokerDisplayInnerBoxSize = FAIO.invokerDisplayBoxSize - 2

	FAIO.invokerDisplayFont = Renderer.LoadFont("Tahoma", math.floor(FAIO.invokerDisplayInnerBoxSize * 0.643), Enum.FontWeight.BOLD)

	local iconsTempTable = {
		"invoker_tornado",
		"invoker_emp",
		"invoker_chaos_meteor", 
		"invoker_deafening_blast",
		"invoker_sun_strike",
		"invoker_ice_wall",
		"invoker_cold_snap",
		"invoker_forge_spirit",
		"invoker_alacrity",
		"item_cyclone",
		"item_rod_of_atos",
		"item_refresher",
		"item_blink",
		"item_ultimate_scepter",
		"invoker_ghost_walk"
			}

	for i = 1, #iconsTempTable do
		local imageHandle = FAIO.invokerCachedIcons[iconsTempTable[i]]
		if imageHandle == nil then
			if iconsTempTable[i] ~= "item_cyclone" and iconsTempTable[i] ~= "item_rod_of_atos" and iconsTempTable[i] ~= "item_refresher" and iconsTempTable[i] ~= "item_blink" and iconsTempTable[i] ~= "item_ultimate_scepter" then
				imageHandle = Renderer.LoadImage("resource/flash3/images/spellicons/" .. iconsTempTable[i] .. ".png")	
				FAIO.invokerCachedIcons[iconsTempTable[i]] = imageHandle
			else
				imageHandle = Renderer.LoadImage("resource/flash3/images/items/" .. string.gsub(iconsTempTable[i], "item_", "") .. ".png")
				FAIO.invokerCachedIcons[iconsTempTable[i]] = imageHandle
			end
		end
	end

end

function FAIO.invokerDisplayDrawDisplay(myHero)

	if not Menu.IsEnabled(FAIO.invokerDisplayOption) then return end

	if FAIO.invokerDisplayNeedsInit then
        	FAIO.invokerDisplayInit()
        	FAIO.invokerDisplayNeedsInit = false
    	end

	local w, h = Renderer.GetScreenSize()
	x = math.floor(w/2);
	y = math.floor(h/5*3);
	y = y+Menu.GetValue(FAIO.invokerDisplayY)
	x = x+Menu.GetValue(FAIO.invokerDisplayX)

	local abilities = {}

	for i = 3, 15 do
        	local ability = NPC.GetAbilityByIndex(myHero, i)
		local name = Ability.GetName(ability)
        	if ability ~= nil and Entity.IsAbility(ability) and not Ability.IsAttributes(ability) and name~="invoker_invoke" and name ~= "invoker_empty1" and name~= "invoker_empty2"then
            		if Ability.GetCooldownTimeLeft(ability)==0 then
               			table.insert(abilities, 1, ability)
            		else 
                		table.insert(abilities, #abilities+1, ability)
            		end 
        	end
    	end

    	if Menu.IsEnabled(FAIO.invokerDisplaySortAbilitiesOption) then
        	table.sort(abilities, function(a, b) return Ability.GetName(a) < Ability.GetName(b) end)
    	end

    	local startX = x - math.floor(((#abilities) / 2) * FAIO.invokerDisplayBoxSize)

    	Renderer.SetDrawColor(0, 0, 0, 150)
    	Renderer.DrawFilledRect(startX + 1, y - 1, (FAIO.invokerDisplayBoxSize * #abilities) + 2, FAIO.invokerDisplayBoxSize + 2)

   	for i, ability in ipairs(abilities) do
        	FAIO.invokerDisplayDrawAbilitySquare(myHero, ability, startX, y, i - 1)
    	end


    	Renderer.SetDrawColor(0, 0, 0, 255)
    	Renderer.DrawOutlineRect(startX + 1, y - 1, (FAIO.invokerDisplayBoxSize * #abilities) + 2, FAIO.invokerDisplayBoxSize + 2)

end

function FAIO.invokerDisplayDrawAbilitySquare(myHero, ability, x, y, index)

    	local abilityName = Ability.GetName(ability)
    	local imageHandle = FAIO.invokerCachedIcons[abilityName]
		if imageHandle == nil then
			FAIO.invokerPanelInit()
		end
			

    	local realX = x + (index * FAIO.invokerDisplayBoxSize) + 2

    	local castable = Ability.IsCastable(ability, NPC.GetMana(myHero), true)

    	local imageColor = { 255, 255, 255 }
    	local outlineColor = { 0, 255 , 0 }

    	if not castable then
        	if Ability.GetLevel(ability) == 0 then
            		imageColor = { 125, 125, 125 }
            		outlineColor = { 255, 0, 0 }
        	elseif Ability.GetManaCost(ability) > NPC.GetMana(myHero) then
            		imageColor = { 150, 150, 255 }
            		outlineColor = { 0, 0, 255 }
        	else
            		imageColor = { 255, 150, 150 }
            		outlineColor = { 255, 0, 0 }
        	end
    	end

    	local hoveringOver = Input.IsCursorInRect(realX, y, FAIO.invokerDisplayBoxSize, FAIO.invokerDisplayBoxSize)

    	local boxSize = FAIO.invokerDisplayBoxSize

    	if hoveringOver then
        	boxSize = math.floor(boxSize * 1.25)
    	end

    	Renderer.SetDrawColor(imageColor[1], imageColor[2], imageColor[3], 255)
    	Renderer.DrawImage(imageHandle, realX, y, FAIO.invokerDisplayBoxSize, FAIO.invokerDisplayBoxSize)

    	Renderer.SetDrawColor(outlineColor[1], outlineColor[2], outlineColor[3], 255)
    	Renderer.DrawOutlineRect(realX, y, FAIO.invokerDisplayBoxSize, FAIO.invokerDisplayBoxSize)

    	local cdLength = Ability.GetCooldownLength(ability)

    	if not Ability.IsReady(ability) and cdLength > 0.0 then
        	local cooldownRatio = Ability.GetCooldown(ability) / cdLength
        	local cooldownSize = math.floor(FAIO.invokerDisplayBoxSize * cooldownRatio)

        	Renderer.SetDrawColor(255, 255, 255, 50)
        	Renderer.DrawFilledRect(realX + 1, y + (FAIO.invokerDisplayInnerBoxSize - cooldownSize) + 1, FAIO.invokerDisplayInnerBoxSize, cooldownSize)

        	Renderer.SetDrawColor(255, 255, 255)
        	Renderer.DrawText(FAIO.invokerDisplayFont, realX + 1, y, math.floor(Ability.GetCooldown(ability)), 0)
    	elseif hoveringOver and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
        	FAIO.invokerInvokeAbility(myHero, ability)
    	end

end
				
-- killsteal functions


function FAIO.AutoSunstrikeKillStealNew(myHero)

	if not myHero then return end
	if os.clock() - FAIO.invokerChannellingKillstealTimer <= 3 then return end
	
	if Ability.GetLevel(NPC.GetAbilityByIndex(myHero, 2)) < 1 then return end
	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 
	if FAIO.IsHeroInvisible(myHero) == true then return end

	if Menu.IsKeyDownOnce(FAIO_options.optionComboKey) then return end
	if Menu.IsKeyDown(FAIO_options.optionComboKey) then return end

	local myMana = NPC.GetMana(myHero)

	local exort = NPC.GetAbility(myHero, "invoker_exort")
	local invoke = NPC.GetAbility(myHero, "invoker_invoke")
	local aghanims = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local sunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	local sunStrikeDMG = 37.5 + (62.5 * Ability.GetLevel(exort))
		if aghanims or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
			sunStrikeDMG = 37.5 + (62.5 * (Ability.GetLevel(exort) + 1))
		end
	
	if not sunStrike then return end
	if not Ability.IsReady(sunStrike) then return end
	if not Ability.IsCastable(sunStrike, myMana) then return end

	if Menu.IsEnabled(FAIO_options.optionKillStealInvokerTPpartice) then
		if FAIO.invokerSunstrikeKSParticleProcess(myHero) == true then
			if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
				if Menu.IsEnabled(FAIO_options.optionKillStealAutoInvoke) then
					if invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
						FAIO.invokerInvokeAbility(myHero, sunStrike)
						Ability.CastPosition(sunStrike, FAIO.TPParticlePosition, true)
						FAIO.invokerChannellingKillstealTimer = os.clock()
						return
					end
				else
					return
				end
			else
				Ability.CastPosition(sunStrike, FAIO.TPParticlePosition)
				FAIO.invokerChannellingKillstealTimer = os.clock()
				return
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionKillStealInvokerImmobil) then
		for _, immobilizedEntity in ipairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_ENEMY)) do
			if immobilizedEntity then
				local immobilizedEnemy = FAIO.targetChecker(immobilizedEntity)
				if immobilizedEnemy and Entity.IsAlive(immobilizedEnemy) and not NPC.HasModifier(immobilizedEnemy, "modifier_templar_assassin_refraction_absorb") then
					local enemyProcessing = FAIO.invokerSunstrikeKSdisabledTargetProcess(myHero, immobilizedEnemy)
					if next(enemyProcessing) ~= nil then
						if enemyProcessing[1] > 0 and enemyProcessing[2] > 0 then
							local timing = enemyProcessing[1]
							local HPthreshold = enemyProcessing[2]
							if Entity.GetHealth(immobilizedEnemy) < HPthreshold then
								if GameRules.GetGameTime() >= timing then
									if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
										if Menu.IsEnabled(FAIO_options.optionKillStealAutoInvoke) then
											if invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
												FAIO.invokerInvokeAbility(myHero, sunStrike)
												Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(immobilizedEnemy), true)
												FAIO.invokerChannellingKillstealTimer = os.clock()
												return
											end
										else
											return
										end
									else
										Ability.CastPosition(sunStrike, Entity.GetAbsOrigin(immobilizedEnemy))
										FAIO.invokerChannellingKillstealTimer = os.clock()
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

	if FAIO.InvokerKSparticleProcess[1][5]:__tostring() ~= Vector():__tostring() then
		local processData = table.remove(FAIO.InvokerKSparticleProcess, 1)
		FAIO.InvokerKSparticleProcess = {{nil, nil, 0, nil, Vector()}}
		local name = processData[2]
		local time = processData[3]
		local pos = processData[5]

		for _, v in ipairs(Heroes.InRadius(pos, 175, Entity.GetTeamNum(myHero), Enum.UnitType.TEAM_ENEMY)) do
			if v and Entity.IsHero(v) and not NPC.IsIllusion(v) and Entity.IsAlive(v) and not not NPC.HasModifier(v, "modifier_templar_assassin_refraction_absorb") then
				if Entity.GetHealth(v) < sunStrikeDMG * (1 + Menu.GetValue(FAIO_options.optionKillStealInvokerTreshold) / 100) then
					local duration
					if name == "rattletrap_cog_deploy" then
						duration = 2 + FAIO.GetTeammateAbilityLevel(myHero, "rattletrap_cog")
					elseif name == "furion_sprout" then
						duration = 2 + FAIO.GetTeammateAbilityLevel(myHero, "furion_sprout")
					end
					if GameRules.GetGameTime() + 1.5 < time + duration then
						if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
							if Menu.IsEnabled(FAIO_options.optionKillStealAutoInvoke) then
								if invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
									FAIO.invokerInvokeAbility(myHero, sunStrike)
									Ability.CastPosition(sunStrike, pos, true)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									return
								end
							else
								return
							end
						else
							Ability.CastPosition(sunStrike, pos)
							FAIO.invokerChannellingKillstealTimer = os.clock()
							return
						end
					end
				end
			end
		end
	end		
	
	if FAIO.GlimpseParticleTime > 0 and FAIO.GlimpseParticleUnit ~= nil and FAIO.GlimpseParticlePosition ~= Vector() and FAIO.GlimpseParticlePositionStart ~= Vector() then
		if not NPC.IsIllusion(FAIO.GlimpseParticleUnit) and Entity.IsAlive(FAIO.GlimpseParticleUnit) and not NPC.HasModifier(FAIO.GlimpseParticleUnit, "modifier_templar_assassin_refraction_absorb") then
			if Entity.GetHealth(FAIO.GlimpseParticleUnit) < sunStrikeDMG - 25 then
				local glimpseTiming
					if (FAIO.GlimpseParticlePositionStart - FAIO.GlimpseParticlePosition):Length2D() / 600 >= 1.8 then
						glimpseTiming = 1.8
					else
						glimpseTiming = (FAIO.GlimpseParticlePositionStart - FAIO.GlimpseParticlePosition):Length2D() / 600
					end
				if glimpseTiming > 1.5 then
					if GameRules.GetGameTime() >= FAIO.GlimpseParticleTime + glimpseTiming - 1.65 then
						if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
							if Menu.IsEnabled(FAIO_options.optionKillStealAutoInvoke) then
								if invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
									FAIO.invokerInvokeAbility(myHero, sunStrike)
									Ability.CastPosition(sunStrike, FAIO.GlimpseParticlePosition, true)
									FAIO.invokerChannellingKillstealTimer = os.clock()
									FAIO.GlimpseParticleUnit = nil
									return
								end
							else
								return
							end
						else
							Ability.CastPosition(sunStrike, FAIO.GlimpseParticlePosition)
							FAIO.invokerChannellingKillstealTimer = os.clock()
							FAIO.GlimpseParticleUnit = nil
							return
						end
					end
				end
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionKillStealInvokerRunning) then
		for _, stealEnemyEntity in ipairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_ENEMY)) do
			local sunStrikeEnemy = FAIO.targetChecker(stealEnemyEntity)
			if sunStrikeEnemy and Entity.IsAlive(sunStrikeEnemy) and not NPC.HasModifier(sunStrikeEnemy, "modifier_templar_assassin_refraction_absorb") then
				local bestTarget
				local maxAgi = 0
				if Entity.GetHealth(sunStrikeEnemy) <= sunStrikeDMG and Hero.GetAgilityTotal(sunStrikeEnemy) > maxAgi then
					bestTarget = sunStrikeEnemy
					maxAgi = Hero.GetAgilityTotal(sunStrikeEnemy)
				end
				if Entity.GetHealth(sunStrikeEnemy) > sunStrikeDMG or Entity.GetHealth(sunStrikeEnemy) < 1  then
					bestTarget = nil
					maxAgi = 0
				end
				if bestTarget then
					if not NPC.IsRunning(bestTarget) then
						return
					else
						if FAIO_utility_functions.isEnemyTurning(bestTarget) == false then
							if Ability.IsReady(sunStrike) and Ability.IsCastable(sunStrike, myMana) then
								if not FAIO.InvokerIsAbilityInvoked(myHero, sunStrike) then
									if Menu.IsEnabled(FAIO_options.optionKillStealAutoInvoke) then
										if invoke and Ability.IsCastable(invoke, myMana) and FAIO.InvokerIsSkillInvokable(myHero, sunStrike) then
											FAIO.invokerInvokeAbility(myHero, sunStrike)
											Ability.CastPosition(sunStrike, FAIO_utility_functions.castPrediction(myHero, bestTarget, Ability.GetCastPoint(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)), true)
											return
										end
									else
										return
									end
								else
									Ability.CastPosition(sunStrike, FAIO_utility_functions.castPrediction(myHero, bestTarget, Ability.GetCastPoint(NPC.GetAbility(myHero, "invoker_sun_strike")) + 1.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)))
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

function FAIO.Debugger(time, npc, ability, order)

	if not Menu.IsEnabled(FAIO_options.optionDebugEnable) then return end
	Log.Write(tostring(time) .. " " .. tostring(NPC.GetUnitName(npc)) .. " " .. tostring(ability) .. " " .. tostring(order))

end

function FAIO.TinkerCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroTinker) then return end

  	local laser = NPC.GetAbilityByIndex(myHero, 0)
 	local missile = NPC.GetAbilityByIndex(myHero, 1)
 	local march = NPC.GetAbilityByIndex(myHero, 2)
 	local rearm = NPC.GetAbility(myHero, "tinker_rearm")

	local lens = NPC.GetItem(myHero, "item_aether_lens", true)
	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero) - 75

	local travels = NPC.GetItem(myHero, "item_travel_boots", true) or NPC.GetItem(myHero, "item_travel_boots_2", true)

	FAIO_itemHandler.itemUsage(myHero, enemy)
	FAIO.TinkerPanicBlink(myHero, blink, rearm)

	if enemy and NPC.IsEntityInRange(myHero, enemy, 2400) then
		if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then
			FAIO.TinkerStatus = 1
			FAIO.TinkerFullCombo(myHero, enemy, myMana, laser, missile, march, rearm, blink)
		else
			if FAIO.TinkerStatus == 1 then
				FAIO.TinkerStatus = 0
			end
		end
	end

	if Menu.GetValue(FAIO_options.optionHeroTinkerPushMode) == 1 then
		if Menu.IsKeyDown(FAIO_options.optionHeroTinkerPushKey) then
			FAIO.TinkerStatus = 2
 			FAIO.TinkerPush(myHero, myMana, march, rearm, blink, travels)
		else
			if FAIO.TinkerStatus == 2 then
				FAIO.TinkerStatus = 0
			end
		end
	else
		if Menu.IsKeyDownOnce(FAIO_options.optionHeroTinkerPushKey) then
			FAIO.TinkerPusher = not FAIO.TinkerPusher
		end
	end

	if Menu.GetValue(FAIO_options.optionHeroTinkerPushMode) < 1 then
		if FAIO.TinkerPusher then
			FAIO.TinkerStatus = 2
			FAIO.TinkerPush(myHero, myMana, march, rearm, blink, travels)
		else
			if FAIO.TinkerStatus == 2 then
				FAIO.TinkerStatus = 0
			end
		end
	end

	if Menu.IsEnabled(FAIO_options.optionHeroTinkerRocket) then
		if Menu.IsKeyDown(FAIO_options.optionHeroTinkerRocketKey) then
			FAIO.TinkerStatus = 3	
			FAIO.TinkerRocketSpam(myHero, myMana, missile, rearm, blink)
		else
			if FAIO.TinkerStatus == 3 then
				FAIO.TinkerStatus = 0
			end
		end
	end	

end

function FAIO.TinkerPanicBlink(myHero, blink, rearm)

	if not myHero then return end
	if not blink then return end
	if not rearm then return end

	if FAIO.TinkerPanicRearmBlink < 1 then return end
	if os.clock() - FAIO.TinkerPanicRearmBlink > Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING) then return end
	
	if Ability.IsChannelling(rearm) then return end

	local blinkPos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(1150)
	Ability.CastPosition(blink, blinkPos)

	return

end

function FAIO.TinkerFullCombo(myHero, enemy, myMana, laser, missile, march, rearm, blink)

	if not myHero then return end
	if not enemy then return end
	if NPC.IsChannellingAbility(myHero) then return end
	
	if FAIO.heroCanCastSpells(myHero, enemy) == true then

		if not NPC.IsEntityInRange(myHero, enemy, 900) then
			if Menu.IsEnabled(FAIO_options.optionHeroTinkerBlink) and blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1150 + Menu.GetValue(FAIO_options.optionHeroTinkerBlinkRange)) then
				Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(Menu.GetValue(FAIO_options.optionHeroTinkerBlinkRange))))
				FAIO.lastTick = os.clock() + 0.15
				return
			end
		end	

		if os.clock() > FAIO.lastTick then
			if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				if missile and Ability.IsCastable(missile, myMana) then
					Ability.CastNoTarget(missile)
					FAIO.lastTick = os.clock() + 0.15
					return
				end
				
				if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(laser)) then
					if laser and Ability.IsCastable(laser, myMana) then
						Ability.CastTarget(laser, enemy)
						FAIO.lastTick = os.clock() + 0.4
						return
					end
				end
			end
			if FAIO.TinkerCheckForFullDMGRearm(myHero, myMana, rearm) then
				if rearm and Ability.IsCastable(rearm, myMana) then
					Ability.CastNoTarget(rearm)
					FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.53 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			end
		end
	end
				
	FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

function FAIO.TinkerCheckForFullDMGRearm(myHero, myMana, rearm)

	if not myHero then return false end
	if not rearm then return false end

	local rearmMana = Ability.GetManaCost(rearm)

	local laser = NPC.GetAbilityByIndex(myHero, 0)
 	local missile = NPC.GetAbilityByIndex(myHero, 1)
	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)
	local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local shivas = NPC.GetItem(myHero, "item_shivas_guard", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
		if not dagon then
			for i = 2, 5 do
				dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
				if dagon then break end
			end
		end
	
	if (laser and Ability.GetLevel(laser) < 1) or (missile and Ability.GetLevel(missile) < 1) then return false end

	local neededMana = 0
		if laser and Ability.GetLevel(laser) > 0 then
			neededMana = neededMana + Ability.GetManaCost(laser)
		end
		if missile and Ability.GetLevel(missile) > 0 then
			neededMana = neededMana + Ability.GetManaCost(missile)
		end
		if soulRing and Menu.IsEnabled(FAIO_options.optionItemSoulring) then
			neededMana = neededMana - 150
		end
		
		if neededMana + rearmMana > myMana then return false end

	if laser and Ability.IsReady(laser) then return false end
	if missile and Ability.IsReady(missile) then return false end

	if Menu.GetValue(FAIO_options.optionItemeBlade) > 0 and eBlade and Ability.IsReady(eBlade) then return false end
	if Menu.GetValue(FAIO_options.optionItemShivas) > 0 and shivas and Ability.IsReady(shivas) then return false end
	if Menu.GetValue(FAIO_options.optionItemDagon) > 0 and dagon and Ability.IsReady(dagon) then return false end

	return true

end

function FAIO.TinkerRocketSpam(myHero, myMana, missile, rearm, blink)

	if not myHero then return end
	if NPC.IsChannellingAbility(myHero) then return end

	local mousePos = Input.GetWorldCursorPos()
	local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)
	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)

	if not missile then return end
		if Ability.GetLevel(missile) < 1 then return end

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 

	local harassTarget = nil
		for _, hero in ipairs(Entity.GetHeroesInRadius(myHero, 2350, Enum.TeamType.TEAM_ENEMY)) do
			if hero and Entity.IsHero(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) then 
				if Entity.IsAlive(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
        				harassTarget = hero
					break
				end
      			end			
		end

	if os.clock() < FAIO.lastTick then return end

	if harassTarget ~= nil then

		if soulRing and Ability.IsReady(soulRing) then
			Ability.CastNoTarget(soulRing)
			FAIO.lastTick = os.clock() + 0.05
			return	
		end

		if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscGlimmer) then
			if glimmer and Ability.IsCastable(glimmer, myMana) and os.clock() > FAIO.TinkerGlimmerCastTime then
				Ability.CastTarget(glimmer, myHero)
				FAIO.lastTick = os.clock() + 0.05
				FAIO.TinkerGlimmerCastTime = os.clock() + 5
				return
			end
		end

		local bottle = NPC.GetItem(myHero, "item_bottle", true)
		if bottle then
			if Item.GetCurrentCharges(bottle) > 0 then	
				if not NPC.HasModifier(myHero, "modifier_bottle_regeneration") then
					local hpGap = Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)
					local manaGap = NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)
					if hpGap > 0.8 or manaGap > 0.8 then
						Ability.CastNoTarget(bottle)
						FAIO.lastTick = os.clock() + 0.05
						return
					end
				end
			end
		end
	
		if missile and Ability.IsCastable(missile, myMana) then
			Ability.CastNoTarget(missile)
			FAIO.lastTick = os.clock() + 0.05
			return
		end

		if rearm and Ability.IsCastable(rearm, myMana) then
			if myMana > Ability.GetManaCost(missile) + Ability.GetManaCost(rearm) then
				Ability.CastNoTarget(rearm)
				FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.53 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end
		end

	else
		if not NPC.IsPositionInRange(myHero, mousePos, 50, 0) then
			if not Menu.IsEnabled(FAIO_options.optionHeroTinkerRocketBlink) then
				if Menu.IsEnabled(FAIO_options.optionHeroTinkerRocketMove) then
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
					return
				end
			else
				if not NPC.IsPositionInRange(myHero, mousePos, Menu.GetValue(FAIO_options.optionHeroTinkerRocketBlinkMin), 0) then
					if blink and Ability.IsReady(blink) then
						if NPC.IsPositionInRange(myHero, mousePos, 1180, 0) then
							Ability.CastPosition(blink, mousePos)
							return
						else
							Ability.CastPosition(blink, (Entity.GetAbsOrigin(myHero) + (mousePos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1180)))
							return
						end
					else
						FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
						return
					end
				else
					FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, mousePos)
					return
				end
			end
		end
	end

	return	

end

function FAIO.TinkerAmIAtFountain(myHero)

	if not myHero then return false end

	local myFountainPos = FAIO_utility_functions.GetMyFountainPos(myHero)
	local myPos = Entity.GetAbsOrigin(myHero)

	local dist = (myFountainPos - myPos):Length2D()

	if dist < 1600 then
		return true
	end

	return false
	
end

function FAIO.TinkerIsFarmTupleAlive(myHero, camp1, camp2)

	if not myHero then return false end
	if next(FAIO.JungleTrackTable) == nil then return false end

	local check = false
	local checkPos = false
	for _, info in ipairs(FAIO.JungleTrackTable) do
		if info then
			local pos = info[1]
			local alive = info[2]
			if (camp1 - pos):Length2D() < 250 and alive then
				checkPos = true
			end
			if checkPos then
				if (camp2 - pos):Length2D() < 250 and alive then
					check = true
					break
				end
			end
		end
	end

	return check

end

function FAIO.TinkerSetCampsToCleared(myHero, pos)

	if not myHero then return end
	if not pos then return end
		pos:SetZ(0)

	local minute = math.floor((GameRules.GetGameTime() - GameRules.GetGameStartTime()) / 60)

	for i, v in ipairs(FAIO.JungleTrackTable) do
		if v then
			local campPos = v[1]
			local alive = v[2]
			if (pos - campPos):Length2D() < 1500 then
				if alive then
					FAIO.JungleTrackTable[i][2] = false
					FAIO.JungleTrackTable[i][3] = minute
				end
			end
		end
	end

	return

end

function FAIO.TinkerIsShrineAlive(myHero, pos)
	
	if not myHero then return false end
	if not pos then return false end

	for i = 1, NPCs.Count() do
		local npcs = NPCs.Get(i)
		if npcs and Entity.IsNPC(npcs) and Entity.IsSameTeam(myHero, npcs) and NPC.IsStructure(npcs) and Entity.IsAlive(npcs) then
			if Entity.GetClassName(npcs) == "C_DOTA_BaseNPC_Healer" then
				local entityPos = Entity.GetAbsOrigin(npcs)
				if (entityPos - pos):Length2D() < 6000 then
					return true
				end
			end
		end
	end

	return false

end

function FAIO.GenericJungleTracker(myHero)

	if not myHero then return end
	if GameRules.GetGameStartTime() < 1 then return end
	if GameRules.GetGameTime() - GameRules.GetGameStartTime() < 59 then return end

	local minute = math.floor((GameRules.GetGameTime() - GameRules.GetGameStartTime()) / 60)
	local respawnChecker = false
		if (((GameRules.GetGameTime() - GameRules.GetGameStartTime()) / 60) - minute) > 0.99 or (((GameRules.GetGameTime() - GameRules.GetGameStartTime()) / 60) - minute) < 0.02 then
			respawnChecker = true
		end
	
	if next(FAIO.JungleTrackTable) == nil then
		for i = 1, 14 do
			table.insert(FAIO.JungleTrackTable, { FAIO_data.JunglePositionTable[i][1], true, minute, FAIO_data.JunglePositionTable[i][4], FAIO_data.JunglePositionTable[i][2], FAIO_data.JunglePositionTable[i][3] })
		end
	end

	if next(FAIO.ShrinePositionTable) == nil then
		if FAIO_utility_functions.GetMyFaction(myHero) == "radiant" then
			FAIO.ShrinePositionTable = {	
				top = Vector(-4389, 211, 0),
				bot = Vector(1313, -4163, 0)
					}
		else
			FAIO.ShrinePositionTable = {	
				bot = Vector(3443, 316, 0),
				top = Vector(-1221, 3905, 0)
					}
		end
	end

	if respawnChecker then
		for key, info in ipairs(FAIO.JungleTrackTable) do
			if info then
				local update = info[3]
				local pos = info[1]
				if minute > update then
					if #Heroes.InRadius(pos, 800, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH) < 1 then
						FAIO.JungleTrackTable[key][2] = true
						FAIO.JungleTrackTable[key][3] = minute
					else
						FAIO.JungleTrackTable[key][3] = minute
					end
				end
			end
		end
	end

	return	

end

function FAIO.TinkerGetJunglePos(myHero, march, rearm)

	if not myHero then return end
	if next(FAIO.JungleTrackTable) == nil then return end
	if not march then return end
		if Ability.GetLevel(march) < 4 then return end
	if not rearm then return end

	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)
	local myMaxMana = NPC.GetMaxMana(myHero)
		local marchCount = 3
		if NPC.HasAbility(myHero, "special_bonus_unique_tinker_2") and Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_tinker_2")) > 0 then
			marchCount = 2
		end
		local neededMana = Ability.GetManaCost(rearm) * (marchCount - 1) + Ability.GetManaCost(march) * marchCount
			if soulRing then
				neededMana = neededMana - (marchCount * 150)
			end
		if myMaxMana < neededMana then return end

	local farmRadiantTop = {{ Vector(-4862, -477, 0), Vector(-3707, 878, 0) }}
	local farmRadiantBottom = {{ Vector(-1845, -4214, 0), Vector(-416, -3345, 0) }, { Vector(4591, -4354, 0), Vector(2889, -4558, 0) }}
	local farmDireBottom = {{ Vector(4411, 847, 0), Vector(2554, 81, 0) }}
	local farmDireTop = {{ Vector(-2000, 4275, 0), Vector(-2677, 4593, 0) }, { Vector(1349, 3317, 0), Vector(-227, 3396, 0) }}

	local myFaction = FAIO_utility_functions.GetMyFaction(myHero)

	if next(FAIO.TinkerJungleFarmPos) == nil then
		if myFaction == "radiant" then
			if FAIO.TinkerIsFarmTupleAlive(myHero, farmRadiantTop[1][1], farmRadiantTop[1][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmRadiantTop[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(-4620, 156, 256), Vector(-4568, 252, 256) }
				end
			elseif FAIO.TinkerIsFarmTupleAlive(myHero, farmRadiantBottom[1][1], farmRadiantBottom[1][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmRadiantBottom[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(-903, -4109, 384), Vector(-1033, -3828, 256) }
				end
			elseif FAIO.TinkerIsFarmTupleAlive(myHero, farmRadiantBottom[2][1], farmRadiantBottom[2][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmRadiantBottom[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(3670, -4655, 256), Vector(3757, -4497, 256) }
				end
			end
		else
			if FAIO.TinkerIsFarmTupleAlive(myHero, farmDireBottom[1][1], farmDireBottom[1][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmDireBottom[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(3520, 155, 384), Vector(3696, 321, 384) }
				end
			elseif FAIO.TinkerIsFarmTupleAlive(myHero, farmDireTop[1][1], farmDireTop[1][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmDireTop[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(-2406, 3738, 256), Vector(-2409, 3863, 256) }
				end
			elseif FAIO.TinkerIsFarmTupleAlive(myHero, farmDireTop[2][1], farmDireTop[2][2]) then
				if FAIO.TinkerIsShrineAlive(myHero, farmDireTop[1][1]) then
					FAIO.TinkerJungleFarmPos = { Vector(474, 3788, 384), Vector(583, 3650, 384) }
				end
			end
		end
	end

	return
	
end

function FAIO.TinkerJungleFarm(myHero, myMana, march, rearm, blink, travels)

	if not myHero then return end

	if next(FAIO.TinkerJungleFarmPos) == nil then return end

	local movePos = FAIO.TinkerJungleFarmPos[1]
	local castPos = FAIO.TinkerJungleFarmPos[2]

	local marchCount = 3
		if NPC.HasAbility(myHero, "special_bonus_unique_tinker_2") and Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_tinker_2")) > 0 then
			marchCount = 2
		end

	if not NPC.IsPositionInRange(myHero, movePos, 35, 0) then
		if blink and Ability.IsCastable(blink, myMana) and (Entity.GetAbsOrigin(myHero) - movePos):Length2D() > 500 then
			if (Entity.GetAbsOrigin(myHero) - movePos):Length2D() > 1190 then
				local blinkPos = Entity.GetAbsOrigin(myHero) + (movePos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1190)
				if #Trees.InRadius(blinkPos, 150, true) < 1 then
					Ability.CastPosition(blink, blinkPos)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
			else
				Ability.CastPosition(blink, movePos)
				FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			end
		end
		FAIO.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, movePos)
	end

	if not NPC.IsRunning(myHero) and NPC.IsPositionInRange(myHero, movePos, 35, 0) then
		if FAIO.TinkerMarched < marchCount then	
			if Ability.IsCastable(march, myMana) then
				Ability.CastPosition(march, castPos)
				FAIO.TinkerMarched = FAIO.TinkerMarched + 1
				FAIO.lastTick = os.clock() + 0.65 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			else
				if rearm and Ability.IsCastable(rearm, myMana) then
					Ability.CastNoTarget(rearm)
					FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				else
					if Ability.IsCastable(travels, myMana) then
						Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
						FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						FAIO.TinkerMarched = 0
						FAIO.TinkerJungle = false
						FAIO.TinkerJungleFarmPos = {}
						FAIO.TinkerSetCampsToCleared(myHero, castPos)
						return
					end
				end
			end
		else
			if Ability.IsCastable(travels, myMana) then
				Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
				FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				FAIO.TinkerMarched = 0
				FAIO.TinkerJungle = false
				FAIO.TinkerJungleFarmPos = {}
				FAIO.TinkerSetCampsToCleared(myHero, castPos)
				return
			else
				if rearm and Ability.IsCastable(rearm, myMana) then
					Ability.CastNoTarget(rearm)
					FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
			end
		end
	end

	return	
				
end

function FAIO.TinkerPush(myHero, myMana, march, rearm, blink, travels)

	if not myHero then return end
	if NPC.IsChannellingAbility(myHero) then return end

	local mousePos = Input.GetWorldCursorPos()

	if not travels then return end

	if not march then return end
		if Ability.GetLevel(march) < 1 then return end

	local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)

	if FAIO.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO.isHeroChannelling(myHero) == true then return end 

	if os.clock() < FAIO.lastTick then 
		return 
	else
		if NPC.IsRunning(myHero) and FAIO.TinkerJungle == false then
			Player.HoldPosition(Players.GetLocal(), myHero, false)
		end
	end

	if FAIO.TinkerFarmDANGER(myHero) then
		if FAIO.TinkerPushDefend then
			local hex = NPC.GetItem(myHero, "item_sheepstick", true)
			local blood = NPC.GetItem(myHero, "item_bloodthorn", true)
			local eBlade = NPC.GetItem(myHero, "item_ethereal_blade", true)
			local orchid = NPC.GetItem(myHero, "item_orchid", true)
			if FAIO.TinkerFarmFindDANGERnpc(myHero) ~= nil then
				local target = FAIO.TinkerFarmFindDANGERnpc(myHero)
				if hex and Ability.IsCastable(blink, myMana) then
					Ability.CastTarget(hex, target)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
				if eBlade and Ability.IsCastable(eBlade, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
					Ability.CastTarget(eBlade, target)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
				if blood and Ability.IsCastable(blood, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
					Ability.CastTarget(blood, target)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
				if orchid and Ability.IsCastable(orchid, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
					Ability.CastTarget(orchid, target)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
			end
		end	
		if blink and Ability.IsCastable(blink, myMana) then
			local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
			if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
				Ability.CastPosition(blink, saveSpot)
				FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			else
				Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
				FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			end
		end
	end
		
	if NPC.HasModifier(myHero, "modifier_fountain_aura_buff") and FAIO.TinkerAmIAtFountain(myHero) then
		if not Ability.IsReady(march) or Ability.SecondsSinceLastUse(travels) > -1 then
			if rearm and Ability.IsCastable(rearm, myMana) then
				Ability.CastNoTarget(rearm)
				FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			end
		end

		if (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) > 0.8 then
			if FAIO.TinkerPorted then
				FAIO.TinkerPorted = false
				FAIO.TinkerJungleFarmPos = {}
				FAIO.TinkerJungle = false
				return
			end
		end
	end

	if not FAIO.TinkerPorted then
		if FAIO.TinkerAmIAtFountain(myHero) then
			if (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) > 0.8 then	
				if FAIO.TinkerPort(myHero, blink) ~= nil then
					if Ability.IsCastable(travels, myMana) then
						Ability.CastPosition(travels, FAIO.TinkerPort(myHero, blink))
						FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						FAIO.TinkerPorted = true
						FAIO.TinkerMarched = 0
						if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscGlimmer) then
							if glimmer and Ability.IsCastable(glimmer, myMana) and os.clock() > FAIO.TinkerGlimmerCastTime then
								Ability.CastTarget(glimmer, myHero)
								FAIO.TinkerGlimmerCastTime = os.clock() + 5
								return
							end
						end
						return
					end
				else
					if FAIO.TinkerPushJungle then
						FAIO.TinkerGetJunglePos(myHero, march, rearm)
						if next(FAIO.TinkerJungleFarmPos) ~= nil then
							if Ability.IsCastable(travels, myMana) then
								Ability.CastPosition(travels, FAIO.TinkerJungleFarmPos[1])
								FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								FAIO.TinkerPorted = true
								FAIO.TinkerJungle = true
								FAIO.TinkerMarched = 0
								return
							end
						end
					end
				end
			end
		else
			if (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) > 0.6 then	
				if FAIO.TinkerPort(myHero, blink) ~= nil then
					if Ability.IsCastable(travels, myMana) then
						Ability.CastPosition(travels, FAIO.TinkerPort(myHero, blink))
						FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						FAIO.TinkerPorted = true
						FAIO.TinkerMarched = 0
						if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscGlimmer) then
							if glimmer and Ability.IsCastable(glimmer, myMana) and os.clock() > FAIO.TinkerGlimmerCastTime then
								Ability.CastTarget(glimmer, myHero)
								FAIO.TinkerGlimmerCastTime = os.clock() + 5
								return
							end
						end
						return
					end
				else
					if FAIO.TinkerPushJungle then
						FAIO.TinkerGetJunglePos(myHero, march, rearm)
						if next(FAIO.TinkerJungleFarmPos) ~= nil then
							if Ability.IsCastable(travels, myMana) then
								Ability.CastPosition(travels, FAIO.TinkerJungleFarmPos[1])
								FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								FAIO.TinkerPorted = true
								FAIO.TinkerJungle = true
								FAIO.TinkerMarched = 0
								return
							end
						end
					end
				end
			else
				if Ability.IsCastable(travels, myMana) then
					Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
					FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					FAIO.TinkerPorted = false
					FAIO.TinkerMarched = 0
					FAIO.TinkerJungle = false
					return
				end
			end
		end
	end

	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)
		if soulRing and Ability.IsReady(soulRing) then
			if not FAIO.TinkerAmIAtFountain(myHero) then
				Ability.CastNoTarget(soulRing)
				Player.HoldPosition(Players.GetLocal(), myHero, true)
				FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				return
			else
				if (NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)) > 0.7 then
					Ability.CastNoTarget(soulRing)
					Player.HoldPosition(Players.GetLocal(), myHero, true)
					FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
			end	
		end

		if Menu.IsEnabled(FAIO_options.optionHeroTinkerMiscGlimmer) then
			if glimmer and Ability.IsCastable(glimmer, myMana) and os.clock() > FAIO.TinkerGlimmerCastTime then
				Ability.CastTarget(glimmer, myHero)
				FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
				FAIO.TinkerGlimmerCastTime = os.clock() + 5
				return
			end
		end

	local bottle = NPC.GetItem(myHero, "item_bottle", true)
		if bottle then
			if Item.GetCurrentCharges(bottle) > 0 then	
				if not NPC.HasModifier(myHero, "modifier_bottle_regeneration") then
					local hpGap = Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero)
					local manaGap = NPC.GetMana(myHero) / NPC.GetMaxMana(myHero)
					if hpGap < 0.8 or manaGap < 0.8 then
						Ability.CastNoTarget(bottle)
						FAIO.lastTick = os.clock() + 0.1 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						return
					end
				end
			end
		end
	
	local targetCreep = nil
	for _, v in ipairs(Entity.GetUnitsInRadius(myHero, 1150, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsNPC(v) and Entity.IsAlive(v) and not Entity.IsDormant(v) and NPC.IsLaneCreep(v) and not NPC.IsWaitingToSpawn(v) and NPC.GetUnitName(v) ~= nil and NPC.GetUnitName(v) ~= "npc_dota_neutral_caster" then
			if FAIO.TinkerPortGetCreepCount(myHero, myHero, 1250) >= 2 + FAIO.TinkerMarched then
				targetCreep = v
				break
			end
		end
	end

	if FAIO.TinkerJungle then
		FAIO.TinkerJungleFarm(myHero, myMana, march, rearm, blink, travels)
	else
		if targetCreep ~= nil then
			if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
				local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, targetCreep, blink)
				if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
					Ability.CastPosition(blink, saveSpot)
					Player.HoldPosition(Players.GetLocal(), myHero, true)
					FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					return
				end
			end

			if FAIO.TinkerMarched < Menu.GetValue(FAIO_options.optionHeroTinkerPushMarch) then
				if Ability.IsCastable(march, myMana) then
					Ability.CastPosition(march, Entity.GetAbsOrigin(myHero) + (Entity.GetAbsOrigin(targetCreep) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(Ability.GetCastRange(march) - 1))
					FAIO.lastTick = os.clock() + 0.75 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
					FAIO.TinkerMarched = FAIO.TinkerMarched + 1
					return
				else
					if rearm and Ability.IsCastable(rearm, myMana) then
						Ability.CastNoTarget(rearm)
						FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						return
					else
						if Ability.IsCastable(travels, myMana) then
							Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
							FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
							FAIO.TinkerMarched = 0
							if FAIO.TinkerPushMode then
								FAIO.TinkerPusher = false
							end
							return
						end
					end
				end
			else
				if FAIO.TinkerPushMode then
					if Ability.IsCastable(travels, myMana) then
						if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
							local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
							if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
								Ability.CastPosition(blink, saveSpot)
								FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								return
							else
								Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
								FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								return
							end
						end
						Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
						FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						FAIO.TinkerMarched = 0
						FAIO.TinkerPusher = false
						return
					else
						if rearm and Ability.IsCastable(rearm, myMana) then
							Ability.CastNoTarget(rearm)
							FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
							return
						end
					end
				else	
					if NPC.GetMana(myHero) / NPC.GetMaxMana(myHero) < 0.6 then
						if Ability.IsCastable(travels, myMana) then
							if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
								local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
								if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
									Ability.CastPosition(blink, saveSpot)
									FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								else
									Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
									FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								end
							end
							Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
							FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
							FAIO.TinkerMarched = 0
							return
						else
							if rearm and Ability.IsCastable(rearm, myMana) then
								Ability.CastNoTarget(rearm)
								FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								return
							end
						end
					else
						if FAIO.TinkerPort(myHero, blink) ~= nil then
							if Ability.IsCastable(travels, myMana) then
								if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
									local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
									if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
										Ability.CastPosition(blink, saveSpot)
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									else
										Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									end
								end
								if blink and Ability.IsReady(blink) then
									FAIO.TinkerPorted = false
									FAIO.TinkerMarched = 0
									return
								else
									Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
									FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									FAIO.TinkerMarched = 0
									return
								end	
							else
								if rearm and Ability.IsCastable(rearm, myMana) then
									Ability.CastNoTarget(rearm)
									FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								end
							end
						else
							if Ability.IsCastable(travels, myMana) then
								if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
									local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
									if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
										Ability.CastPosition(blink, saveSpot)
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									else
										Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									end
								end
								Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
								FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								FAIO.TinkerMarched = 0
								return
							else
								if rearm and Ability.IsCastable(rearm, myMana) then
									Ability.CastNoTarget(rearm)
									FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								end
							end
						end
					end
				end
			end
		else
			if not FAIO.TinkerAmIAtFountain(myHero) then
				if FAIO.TinkerPushMode then
					if Ability.IsCastable(travels, myMana) then
						if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
							local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
							if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
								Ability.CastPosition(blink, saveSpot)
								FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								return
							else
								Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
								FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								return
							end
						end
						Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
						FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
						FAIO.TinkerMarched = 0
						FAIO.TinkerPusher = false
						return
					else
						if rearm and Ability.IsCastable(rearm, myMana) then
							Ability.CastNoTarget(rearm)
							FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
							return
						end
					end
				else	
					if NPC.GetMana(myHero) / NPC.GetMaxMana(myHero) < 0.6 then
						if FAIO.TinkerPorted then
							if Ability.IsCastable(travels, myMana) then
								if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
									local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
									if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
										Ability.CastPosition(blink, saveSpot)
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									else
										Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									end
								end
								Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
								FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
								FAIO.TinkerMarched = 0
								return
							else
								if rearm and Ability.IsCastable(rearm, myMana) then
									Ability.CastNoTarget(rearm)
									FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								end
							end
						end
					else
						if FAIO.TinkerPort(myHero, blink) ~= nil then
							if Ability.IsCastable(travels, myMana) then
								if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
									local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
									if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
										Ability.CastPosition(blink, saveSpot)
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									else
										Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
										FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
										return
									end
								end
								if blink and Ability.IsReady(blink) then
									FAIO.TinkerPorted = false
									FAIO.TinkerMarched = 0
									return
								else
									Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
									FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									FAIO.TinkerMarched = 0
									return
								end	
							else
								if rearm and Ability.IsCastable(rearm, myMana) then
									Ability.CastNoTarget(rearm)
									FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									return
								end
							end
						else
							if FAIO.TinkerPorted then
								if Ability.IsCastable(travels, myMana) then
									if blink and Ability.IsCastable(blink, myMana) and not FAIO.TinkerFarmAmISave(myHero) then
										local saveSpot = FAIO.TinkerFarmGetSaveSpot(myHero, myHero, blink)
										if saveSpot ~= nil and (Entity.GetAbsOrigin(myHero) - saveSpot):Length2D() > 375 then
											Ability.CastPosition(blink, saveSpot)
											FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
											return
										else
											Ability.CastPosition(blink, Entity.GetAbsOrigin(myHero) + (FAIO_utility_functions.GetMyFountainPos(myHero) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(1150))
											FAIO.lastTick = os.clock() + 0.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
											return
										end
									end
									Ability.CastPosition(travels, FAIO_utility_functions.GetMyFountainPos(myHero))
									FAIO.lastTick = os.clock() + 3.05 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
									FAIO.TinkerMarched = 0
									return
								else
									if rearm and Ability.IsCastable(rearm, myMana) then
										Ability.CastNoTarget(rearm)
										FAIO.lastTick = os.clock() + Ability.GetLevelSpecialValueForFloat(rearm, "channel_tooltip") + 0.58 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING) + NetChannel.GetLatency(Enum.Flow.FLOW_INCOMING)
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

	return

end

function FAIO.TinkerFarmAmISave(myHero)

	if not myHero then return false end

	local myPos = Entity.GetAbsOrigin(myHero)

	if NPC.IsVisible(myHero) then return false end

	for _, hero in ipairs(Entity.GetHeroesInRadius(myHero, 200, Enum.TeamType.TEAM_ENEMY)) do
		if hero and Entity.IsHero(hero) then
			if FAIO.targetChecker(hero) ~= nil then
				return false
			end
		end
	end

	local saveSpotTable = {
		{ Vector(-7332.3, -3269.6, 384.0), 5},
		{ Vector(-7233.3, -1376.7, 384.0), 10}, 
		{ Vector(-7200.2, -1017.2, 384.0), 8}, 
		{ Vector(-7212.0, -551.6, 384.0), 8}, 
		{ Vector(-7125.0, -81.5, 384.0), 8},
		{ Vector(-7114.0, 337.9, 384.0), 5}, 
		{ Vector(-7194.7, 732.3, 384.0), 5}, 
		{ Vector(-7129.5, 1337.3, 384.0), 7},
		{ Vector(-7140.7, 1645.0, 384.0), 7},
		{ Vector(-7176.3, 2070.1, 384.0), 6}, 
		{ Vector(-7089.6, 2307.1, 512.0), 5}, 
		{ Vector(-6847.4, 3532.0, 384.0), 5}, 
		{ Vector(-7226.3, 3989.3, 384.0), 7}, 
		{ Vector(-6994.7, 4915.7, 384.0), 7}, 
		{ Vector(-6900.2, 5118.8, 384.0), 7}, 
		{ Vector(-6732.6, 5540.4, 384.0), 4}, 
		{ Vector(-6581.3, 5919.3, 384.0), 6}, 
		{ Vector(-6273.9, 6178.2, 384.0), 6}, 
		{ Vector(-6104.3, 6542.5, 384.0), 6}, 
		{ Vector(-5458.8, 6709.4, 384.0), 11}, 
		{ Vector(-5130.0, 6783.1, 384.0), 7}, 
		{ Vector(-4631.4, 6760.8, 384.0), 6}, 
		{ Vector(-4308.8, 6977.7, 384.0), 6}, 
		{ Vector(-3791.8, 6757.7, 384.0), 11}, 
		{ Vector(-3497.5, 6873.4, 384.0), 8}, 
		{ Vector(-3117.5, 6930.3, 384.0), 9}, 
		{ Vector(-2696.9, 6878.1, 384.0), 7}, 
		{ Vector(-2321.5, 6938.8, 384.0), 7}, 
		{ Vector(-1731.7, 6864.3, 384.0), 8}, 
		{ Vector(-1100.2, 6951.0, 384.0), 9}, 
		{ Vector(-767.3, 7021.9, 384.0), 11}, 
		{ Vector(-82.5, 6823.9, 384.0), 7}, 
		{ Vector(183.7, 6728.6, 384.0), 7},
		{ Vector(673.7, 6884.9, 384.0), 13}, 
		{ Vector(1009.9, 6861.5, 384.0), 10}, 
		{ Vector(1561.7, 6964.7, 384.0), 6}, 
		{ Vector(2540.2, 6960.1, 384.0), 4}, 
		{ Vector(3445.1, 6863.7, 384.0), 5}, 
		{ Vector(7400.6, 2808.3, 384.0), 6}, 
		{ Vector(7456.3, 2090.7, 256.0), 6}, 
		{ Vector(7226.0, 866.5, 384.0), 7}, 
		{ Vector(7029.8, 494.1, 384.0), 7}, 
		{ Vector(7086.8, -37.7, 384.0), 8}, 
		{ Vector(6932.5, -577.0, 384.0), 4}, 
		{ Vector(6918.2, -908.3, 384.0), 8}, 
		{ Vector(7080.6, -1472.4, 384.0), 7}, 
		{ Vector(7171.4, -1807.0, 384.0), 7}, 
		{ Vector(7297.8, -2177.6, 384.0), 9}, 
		{ Vector(7031.2, -3224.0, 384.0), 5}, 
		{ Vector(6898.3, -3549.7, 384.0), 7}, 
		{ Vector(7460.4, -4648.6, 384.0), 8}, 
		{ Vector(6924.8, -4814.6, 384.0), 6}, 
		{ Vector(6891.3, -5163.1, 384.0), 7}, 
		{ Vector(6701.0, -5480.9, 384.0), 5}, 
		{ Vector(6647.3, -5824.5, 384.0), 10},
		{ Vector(6583.7, -6132.0, 384.0), 11}, 
		{ Vector(6381.3, -6424.0, 384.0), 9}, 
		{ Vector(6059.3, -6451.0, 384.0), 9}, 
		{ Vector(6021.2, -6588.0, 384.0), 8}, 
		{ Vector(5650.1, -6737.3, 384.0), 5}, 
		{ Vector(5378.8, -6735.7, 384.0), 7}, 
		{ Vector(4971.6, -6738.0, 384.0), 7}, 
		{ Vector(4536.9, -6652.2, 384.0), 6}, 
		{ Vector(4333.0, -6725.9, 384.0), 8}, 
		{ Vector(3879.9, -6734.2, 384.0), 10}, 
		{ Vector(3364.7, -6777.9, 384.0), 9}, 
		{ Vector(3013.5, -6804.8, 384.0), 10}, 
		{ Vector(2696.2, -6795.6, 384.0), 9}, 
		{ Vector(2388.5, -6791.8, 384.0), 9}, 
		{ Vector(1970.3, -6840.6, 384.0), 5}, 
		{ Vector(1594.9, -6898.8, 384.0), 2}, 
		{ Vector(1150.0, -6852.4, 384.0), 6}, 
		{ Vector(759.1, -6957.8, 384.0), 6}, 
		{ Vector(289.0, -6964.5, 384.0), 5}, 
		{ Vector(-330.1, -6876.5, 384.0), 8},
		{ Vector(-623.6, -6858.6, 384.0), 6}, 
		{ Vector(-1073.9, -6927.4, 384.0), 5}, 
		{ Vector(-2947.8, -6995.1, 256.0), 1}, 
		{ Vector(-3990.3, -7001.3, 384.0), 7}, 
		{ Vector(-530.9, -5611.3, 384.0), 7}, 
		{ Vector(2463.7, -5622.4, 384.0), 8}, 
		{ Vector(3951.0, -5522.6, 384.0), 7}, 
		{ Vector(5655.3, -3890.3, 384.0), 6}, 
		{ Vector(5565.6, -1369.1, 384.0), 7}, 
		{ Vector(5690.3, 995.4, 384.0), 6}, 
		{ Vector(2228.6, 2684.7, 256.0), 6}, 
		{ Vector(2939.3, 1222.4, 256.0), 8}, 
		{ Vector(1008.6, 1594.0, 256.0), 8}, 
		{ Vector(489.5, 1282.0, 256.0), 7}, 
		{ Vector(1283.7, 19.7, 256.0), 8}, 
		{ Vector(-907.4, -1464.5, 256.0), 7}, 
		{ Vector(-2041.0, -936.2, 256.0), 7}, 
		{ Vector(-2490.0, -1083.8, 256.0), 5}, 
		{ Vector(-1236.1, -1858.3, 256.0), 7}, 
		{ Vector(-2032.8, -2420.4, 256.0), 7}, 
		{ Vector(-2303.3, -2759.6, 256.0), 6}, 
		{ Vector(-2832.8, -1435.9, 256.0), 5}, 
		{ Vector(-3888.1, -2336.0, 256.0), 3}, 
		{ Vector(-2676.4, 5523.4, 384.0), 8}, 
		{ Vector(-1180.0, 5551.6, 384.0), 8}
			}

	for _, saveInfo in ipairs(saveSpotTable) do
		local savePos = saveInfo[1]
		if savePos then
			local distance = (myPos - savePos):Length2D()
			if distance < 75 then
				return true
			end
		end
	end

	if #Trees.InRadius(myPos, 250, true) >= 4 then
		return true
	end

	return false

end

function FAIO.TinkerFarmDANGER(myHero)

	if not myHero then return false end
	if FAIO.TinkerAmIAtFountain(myHero) then return false end

	if next(FAIO_dodgeIT.dodgeItTable) ~= nil then return true end
	if FAIO.TargetGotDisableModifier(myHero, myHero) == true then return true end
	if NPC.IsSilenced(myHero) then return true end

	for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 800, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
			if NPC.FindFacingNPC(v) == myHero then
				if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
					if NPC.IsAttacking(v) then
						return true
					end
				end
			end
		end	
	end

	return false

end

function FAIO.TinkerFarmFindDANGERnpc(myHero)

	if not myHero then return end

	local npc = nil
	for _, v in ipairs(Entity.GetHeroesInRadius(myHero, 750, Enum.TeamType.TEAM_ENEMY)) do
		if v and Entity.IsHero(v) and not Entity.IsDormant(v) and not NPC.IsIllusion(v) then
			if NPC.IsAttacking(v) then
				if NPC.IsEntityInRange(myHero, v, NPC.GetAttackRange(v) + 140) then
					if NPC.FindFacingNPC(v) == myHero then
						npc = v
						break
					end
				end
			end
			for ability, info in pairs(FAIO_data.RawDamageAbilityEstimation) do
				if NPC.HasAbility(v, ability) and Ability.IsInAbilityPhase(NPC.GetAbility(v, ability)) then
					local abilityRange = math.max(Ability.GetCastRange(NPC.GetAbility(v, ability)), info[2])
					local abilityRadius = info[3]
					if FAIO_dodgeIT.dodgeIsTargetMe(myHero, v, abilityRadius, abilityRange) then
						npc = v
						break
					end
				end
			end	
		end
	end

	return npc

end

function FAIO.TinkerFarmGetSaveSpot(myHero, target, blink)

	if not myHero then return end
	if not target then return end
	if not blink then return end

	local targetPos = Entity.GetAbsOrigin(target)
	local myPos = Entity.GetAbsOrigin(myHero)

	local saveSpotTable = {
		{ Vector(-7332.3, -3269.6, 384.0), 5},
		{ Vector(-7233.3, -1376.7, 384.0), 10}, 
		{ Vector(-7200.2, -1017.2, 384.0), 8}, 
		{ Vector(-7212.0, -551.6, 384.0), 8}, 
		{ Vector(-7125.0, -81.5, 384.0), 8},
		{ Vector(-7114.0, 337.9, 384.0), 5}, 
		{ Vector(-7194.7, 732.3, 384.0), 5}, 
		{ Vector(-7129.5, 1337.3, 384.0), 7},
		{ Vector(-7140.7, 1645.0, 384.0), 7},
		{ Vector(-7176.3, 2070.1, 384.0), 6}, 
		{ Vector(-7089.6, 2307.1, 512.0), 5}, 
		{ Vector(-6847.4, 3532.0, 384.0), 5}, 
		{ Vector(-7226.3, 3989.3, 384.0), 7}, 
		{ Vector(-6994.7, 4915.7, 384.0), 7}, 
		{ Vector(-6900.2, 5118.8, 384.0), 7}, 
		{ Vector(-6732.6, 5540.4, 384.0), 4}, 
		{ Vector(-6581.3, 5919.3, 384.0), 6}, 
		{ Vector(-6273.9, 6178.2, 384.0), 6}, 
		{ Vector(-6104.3, 6542.5, 384.0), 6}, 
		{ Vector(-5458.8, 6709.4, 384.0), 11}, 
		{ Vector(-5130.0, 6783.1, 384.0), 7}, 
		{ Vector(-4631.4, 6760.8, 384.0), 6}, 
		{ Vector(-4308.8, 6977.7, 384.0), 6}, 
		{ Vector(-3791.8, 6757.7, 384.0), 11}, 
		{ Vector(-3497.5, 6873.4, 384.0), 8}, 
		{ Vector(-3117.5, 6930.3, 384.0), 9}, 
		{ Vector(-2696.9, 6878.1, 384.0), 7}, 
		{ Vector(-2321.5, 6938.8, 384.0), 7}, 
		{ Vector(-1731.7, 6864.3, 384.0), 8}, 
		{ Vector(-1100.2, 6951.0, 384.0), 9}, 
		{ Vector(-767.3, 7021.9, 384.0), 11}, 
		{ Vector(-82.5, 6823.9, 384.0), 7}, 
		{ Vector(183.7, 6728.6, 384.0), 7},
		{ Vector(673.7, 6884.9, 384.0), 13}, 
		{ Vector(1009.9, 6861.5, 384.0), 10}, 
		{ Vector(1561.7, 6964.7, 384.0), 6}, 
		{ Vector(2540.2, 6960.1, 384.0), 4}, 
		{ Vector(3445.1, 6863.7, 384.0), 5}, 
		{ Vector(7400.6, 2808.3, 384.0), 6}, 
		{ Vector(7456.3, 2090.7, 256.0), 6}, 
		{ Vector(7226.0, 866.5, 384.0), 7}, 
		{ Vector(7029.8, 494.1, 384.0), 7}, 
		{ Vector(7086.8, -37.7, 384.0), 8}, 
		{ Vector(6932.5, -577.0, 384.0), 4}, 
		{ Vector(6918.2, -908.3, 384.0), 8}, 
		{ Vector(7080.6, -1472.4, 384.0), 7}, 
		{ Vector(7171.4, -1807.0, 384.0), 7}, 
		{ Vector(7297.8, -2177.6, 384.0), 9}, 
		{ Vector(7031.2, -3224.0, 384.0), 5}, 
		{ Vector(6898.3, -3549.7, 384.0), 7}, 
		{ Vector(7460.4, -4648.6, 384.0), 8}, 
		{ Vector(6924.8, -4814.6, 384.0), 6}, 
		{ Vector(6891.3, -5163.1, 384.0), 7}, 
		{ Vector(6701.0, -5480.9, 384.0), 5}, 
		{ Vector(6647.3, -5824.5, 384.0), 10},
		{ Vector(6583.7, -6132.0, 384.0), 11}, 
		{ Vector(6381.3, -6424.0, 384.0), 9}, 
		{ Vector(6059.3, -6451.0, 384.0), 9}, 
		{ Vector(6021.2, -6588.0, 384.0), 8}, 
		{ Vector(5650.1, -6737.3, 384.0), 5}, 
		{ Vector(5378.8, -6735.7, 384.0), 7}, 
		{ Vector(4971.6, -6738.0, 384.0), 7}, 
		{ Vector(4536.9, -6652.2, 384.0), 6}, 
		{ Vector(4333.0, -6725.9, 384.0), 8}, 
		{ Vector(3879.9, -6734.2, 384.0), 10}, 
		{ Vector(3364.7, -6777.9, 384.0), 9}, 
		{ Vector(3013.5, -6804.8, 384.0), 10}, 
		{ Vector(2696.2, -6795.6, 384.0), 9}, 
		{ Vector(2388.5, -6791.8, 384.0), 9}, 
		{ Vector(1970.3, -6840.6, 384.0), 5}, 
		{ Vector(1594.9, -6898.8, 384.0), 2}, 
		{ Vector(1150.0, -6852.4, 384.0), 6}, 
		{ Vector(759.1, -6957.8, 384.0), 6}, 
		{ Vector(289.0, -6964.5, 384.0), 5}, 
		{ Vector(-330.1, -6876.5, 384.0), 8},
		{ Vector(-623.6, -6858.6, 384.0), 6}, 
		{ Vector(-1073.9, -6927.4, 384.0), 5}, 
		{ Vector(-2947.8, -6995.1, 256.0), 1}, 
		{ Vector(-3990.3, -7001.3, 384.0), 7}, 
		{ Vector(-530.9, -5611.3, 384.0), 7}, 
		{ Vector(2463.7, -5622.4, 384.0), 8}, 
		{ Vector(3951.0, -5522.6, 384.0), 7}, 
		{ Vector(5655.3, -3890.3, 384.0), 6}, 
		{ Vector(5565.6, -1369.1, 384.0), 7}, 
		{ Vector(5690.3, 995.4, 384.0), 6}, 
		{ Vector(2228.6, 2684.7, 256.0), 6}, 
		{ Vector(2939.3, 1222.4, 256.0), 8}, 
		{ Vector(1008.6, 1594.0, 256.0), 8}, 
		{ Vector(489.5, 1282.0, 256.0), 7}, 
		{ Vector(1283.7, 19.7, 256.0), 8}, 
		{ Vector(-907.4, -1464.5, 256.0), 7}, 
		{ Vector(-2041.0, -936.2, 256.0), 7}, 
		{ Vector(-2490.0, -1083.8, 256.0), 5}, 
		{ Vector(-1236.1, -1858.3, 256.0), 7}, 
		{ Vector(-2032.8, -2420.4, 256.0), 7}, 
		{ Vector(-2303.3, -2759.6, 256.0), 6}, 
		{ Vector(-2832.8, -1435.9, 256.0), 5}, 
		{ Vector(-3888.1, -2336.0, 256.0), 3}, 
		{ Vector(-2676.4, 5523.4, 384.0), 8}, 
		{ Vector(-1180.0, 5551.6, 384.0), 8}
			}

	for _, saveInfo in ipairs(saveSpotTable) do
		local savePos = saveInfo[1]
		local treesAround = saveInfo[2]
		if savePos and #Trees.InRadius(savePos, 251, true) >= treesAround - 1 then
			local distance = (myPos - savePos):Length2D()
			if distance > 200 and distance < 1125 then
				local distanceCreep = (savePos - targetPos):Length2D()
				if distanceCreep < 1050 then
					return savePos
				end
			end
		end
	end

	local treeCount = 0
	local targetTree = nil
	for _, tree in ipairs(Trees.InRadius(targetPos, 900, true)) do
		if tree then
			local treePos = Entity.GetAbsOrigin(tree)
			local myDist = myPos:__sub(treePos):Length2D()
			if myDist >= 315 and myDist < 1100 then
				local treesAround = #Trees.InRadius(treePos, 350, true)
				if treesAround > treeCount then
					treeCount = treesAround
					targetTree = tree
				end
			end
		end
	end

	local treeTargetPos = nil
	if treeCount >= 4 then
		if targetTree ~= nil then
			local bestPos = FAIO_utility_functions.getBestPosition(Trees.InRadius(Entity.GetAbsOrigin(targetTree), 400, true), 200)
			if bestPos ~= nil and bestPos:__sub(targetPos):Length2D() < 1000 and bestPos:__sub(myPos):Length2D() < 1125 then
				treeTargetPos = bestPos
			end		
		end
	end

	if treeTargetPos ~= nil then
		if #Trees.InRadius(treeTargetPos, 25, true) > 0 then
			return (treeTargetPos + (treeTargetPos - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(35))
		else
			return treeTargetPos
		end
	else
		local myFountainPos = FAIO_utility_functions.GetMyFountainPos(myHero)
		local myDist = myPos:__sub(targetPos):Length2D()
		local gap = 1050 - myDist
		local searchPosition =  myPos + (myFountainPos - myPos):Normalized():Scaled(gap)
		local treesArcoundPos = Trees.InRadius(searchPosition, gap, true)
		local myPosZ = myPos:GetZ()
		for _, tree in ipairs(treesArcoundPos) do
			if tree then
				local treePos = Entity.GetAbsOrigin(tree)
				local treePosZ = treePos:GetZ()
				if (treePos - myPos):Length2D() < 1050 then
					if treePosZ > myPosZ and math.abs(treePosZ - myPosZ) > 50 then
						return myPos + (treePos - myPos):Scaled(0.9)
					end
				end
			end
		end
	end

	return

end

function FAIO.TinkerPortGetCreepCount(myHero, target, range)

	if not myHero then return 0 end
	if not target then return 0 end

	local count = 0
	for _, npc in ipairs(Entity.GetUnitsInRadius(target, range, Enum.TeamType.TEAM_ENEMY)) do
		if npc and Entity.IsNPC(npc) and Entity.IsAlive(npc) and NPC.IsLaneCreep(npc) and not NPC.IsDormant(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
			if (Entity.GetHealth(npc) / Entity.GetMaxHealth(npc)) > 0.6 then
				count = count + 1
			end
		end
	end

	return count
		
end

function FAIO.TinkerPortGetHeroCount(myHero, target, range)

	if not myHero then return 0 end
	if not target then return 0 end

	local count = 0
	for _, hero in ipairs(Entity.GetHeroesInRadius(target, range, Enum.TeamType.TEAM_ENEMY)) do
		if hero and Entity.IsHero(hero) and Entity.IsAlive(hero) and not NPC.IsDormant(hero) and not NPC.IsIllusion(hero) then
			count = count + 1
		end
	end

	return count
		
end

function FAIO.TinkerPort(myHero, blink)

	if not myHero then return end

	local enemyFountainPos = FAIO_utility_functions.GetEnemyFountainPos(myHero)
	local myFountainPos = FAIO_utility_functions.GetMyFountainPos(myHero)

	if FAIO.TinkerPushMode then
		local targetCreep
		local maxDistance = 99999
		if NPC.HasItem(myHero, "item_travel_boots", true) or NPC.HasItem(myHero, "item_travel_boots_2", true) then
			for i = 1, NPCs.Count() do 
			local npc = NPCs.Get(i)
    				if npc and Entity.IsSameTeam(myHero, npc) and Entity.IsAlive(npc) and NPC.IsLaneCreep(npc) and NPC.IsRanged(npc) and not NPC.IsDormant(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					if npc ~= nil then
						local creepPosition = Entity.GetAbsOrigin(npc)
						local distanceToMouse = (creepPosition - Input.GetWorldCursorPos()):Length2D()
						if distanceToMouse < maxDistance then
							targetCreep = npc
							maxDistance = distanceToMouse
						end
					end
				end
			end
		end

		if targetCreep == nil then
			maxDistance = 99999
		end

		if targetCreep then
			return Entity.GetAbsOrigin(targetCreep)
		end
	else
		local targetCreep = nil
		local creepCount = 0
		if NPC.HasItem(myHero, "item_travel_boots", true) or NPC.HasItem(myHero, "item_travel_boots_2", true) then
			for i = 1, NPCs.Count() do 
			local npc = NPCs.Get(i)
    				if npc and Entity.IsSameTeam(myHero, npc) and NPC.IsLaneCreep(npc) and NPC.IsRanged(npc) and not NPC.IsDormant(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					if (Entity.GetHealth(npc) / Entity.GetMaxHealth(npc)) >= 0.6 and #Entity.GetUnitsInRadius(npc, 500, Enum.TeamType.TEAM_FRIEND) >= 2 then
						if (Entity.GetAbsOrigin(npc) - Entity.GetAbsOrigin(myHero)):Length2D() > 3000 then	
							if FAIO.TinkerPortGetCreepCount(myHero, npc, 900) >= FAIO.TinkerPushCreeps and FAIO.TinkerPortGetHeroCount(myHero, npc, 900) <= FAIO.TinkerPushEnemies and #Entity.GetHeroesInRadius(npc, 900, Enum.TeamType.TEAM_FRIEND) <= FAIO.TinkerPushAllies then
								if FAIO.TinkerPushSave then
									if not blink then
										if FAIO.TinkerPortGetCreepCount(myHero, npc, 900) > creepCount then
											creepCount = FAIO.TinkerPortGetCreepCount(myHero, npc, 900)
											targetCreep = npc
										end
									else
										if FAIO.TinkerFarmGetSaveSpot(npc, npc, blink) ~= nil then
											if FAIO.TinkerPortGetCreepCount(myHero, npc, 900) > creepCount then
												creepCount = FAIO.TinkerPortGetCreepCount(myHero, npc, 900)
												targetCreep = npc
											end
										end
									end
								else
									if FAIO.TinkerPortGetCreepCount(myHero, npc, 900) > creepCount then
										creepCount = FAIO.TinkerPortGetCreepCount(myHero, npc, 900)
										targetCreep = npc
									end
								end
							end
						end
					end
				end
			end
		end

		if targetCreep == nil then
			creepCount = 0
		end

		if targetCreep ~= nil then
			return Entity.GetAbsOrigin(targetCreep)
		end
	end

	return
end

function FAIO.drawTinkerPanel(myHero)

	if not myHero then return end
	if not Menu.IsEnabled(FAIO_options.optionHeroTinker) then return end
	
	if Menu.IsKeyDownOnce(FAIO_options.optionHeroTinkerPanelKey) then
		FAIO.Toggler = not FAIO.Toggler
	end
	
	if FAIO.Toggler then return end

	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)

	if FAIO.TinkerPanelX ~= Config.ReadInt("tinker", "panelX", w/2) then
		FAIO.TinkerPanelX = Config.ReadInt("tinker", "panelX", w/2)
	end
	if FAIO.TinkerPanelY ~= Config.ReadInt("tinker", "panelY", h/2) then
		FAIO.TinkerPanelY = Config.ReadInt("tinker", "panelY", h/2)
	end

	if Menu.IsEnabled(FAIO_options.optionHeroTinkerPanelMove) then
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_UP) then
			FAIO.TinkerPanelY = FAIO.TinkerPanelY - 10
			Config.WriteInt("tinker", "panelY", FAIO.TinkerPanelY)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_DOWN) then
			FAIO.TinkerPanelY = FAIO.TinkerPanelY + 10
			Config.WriteInt("tinker", "panelY", FAIO.TinkerPanelY)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_LEFT) then
			FAIO.TinkerPanelX = FAIO.TinkerPanelX - 10
			Config.WriteInt("tinker", "panelX", FAIO.TinkerPanelX)
		end
		if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_RIGHT) then
			FAIO.TinkerPanelX = FAIO.TinkerPanelX + 10
			Config.WriteInt("tinker", "panelX", FAIO.TinkerPanelX)
		end
	end

	local startX = FAIO.TinkerPanelX
	local startY = FAIO.TinkerPanelY

	local width = 140
	local height = 320

	 -- black background
	Renderer.SetDrawColor(0, 0, 0, 125)
	Renderer.DrawFilledRect(startX, startY, width, height)


	-- black border
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY, width, height)

	Renderer.SetDrawColor(255, 0, 0, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 10, "PUSH OPTIONS", 1)
	Renderer.SetDrawColor(0, 0, 0, 45)
	Renderer.DrawFilledRect(startX+1, startY+1, width-2, 20-2)

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 30, "Push target", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startY+21, width-2, 20-2)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX, startY+40, width/2, 20)
	Renderer.DrawOutlineRect(startX + width/2, startY+40, width/2, 20)

	local hoveringOverAuto = Input.IsCursorInRect(startX, startY+40, width/2, 20)
	local hoveringOverCursor = Input.IsCursorInRect(startX + width/2, startY+40, width/2, 20)

	if hoveringOverAuto and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if FAIO.TinkerPushMode then
			FAIO.TinkerPushMode = not FAIO.TinkerPushMode
		end
	end

	if hoveringOverCursor and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if not FAIO.TinkerPushMode then
			FAIO.TinkerPushMode = not FAIO.TinkerPushMode
		end
	end
	
	if not FAIO.TinkerPushMode then
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 40, "auto", 0)
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 40, "cursor", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4, startY + 40, "auto", 0)
		Renderer.SetDrawColor(0, 255, 0, 255)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3, startY + 40, "cursor", 0)
	end

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startX + width/2, startY + 70, "Auto line options", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startY+61, width-2, 20-2)
	Renderer.SetDrawColor(0, 0, 0, 255)

	Renderer.DrawOutlineRect(startX + width/4*3, startY+80, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)	
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 81, "Min. creeps", 1)

	local hoveringOverCreeps = Input.IsCursorInRect(startX + width/4*3, startY+80, width/4, 20)
	if hoveringOverCreeps and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushCreeps < 5 then
			FAIO.TinkerPushCreeps = FAIO.TinkerPushCreeps + 1
		end
	end

	if hoveringOverCreeps and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_RIGHT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushCreeps > 1 then
			FAIO.TinkerPushCreeps = FAIO.TinkerPushCreeps - 1
		end
	end

	if FAIO.TinkerPushCreeps > 0 then
		if not FAIO.TinkerPushMode then
			Renderer.SetDrawColor(0, 255, 0, 255)	
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
		end
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 81, FAIO.TinkerPushCreeps, 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 81, FAIO.TinkerPushCreeps, 0)
	end	

	
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX + width/4*3, startY+100, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 101, "Max. enemies", 1)

	local hoveringOverEnemies = Input.IsCursorInRect(startX + width/4*3, startY+100, width/4, 20)
	if hoveringOverEnemies and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushEnemies < 5 then
			FAIO.TinkerPushEnemies = FAIO.TinkerPushEnemies + 1
		end
	end

	if hoveringOverEnemies and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_RIGHT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushEnemies > 0 then
			FAIO.TinkerPushEnemies = FAIO.TinkerPushEnemies - 1
		end
	end

	if FAIO.TinkerPushEnemies > 0 then
		if not FAIO.TinkerPushMode then
			Renderer.SetDrawColor(255, 64, 64, 255)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
		end
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 101, FAIO.TinkerPushEnemies, 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 101, FAIO.TinkerPushEnemies, 0)
	end

	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX + width/4*3, startY+120, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 121, "Max. allies", 1)

	local hoveringOverAllies = Input.IsCursorInRect(startX + width/4*3, startY+120, width/4, 20)
	if hoveringOverAllies and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushAllies < 5 then
			FAIO.TinkerPushAllies = FAIO.TinkerPushAllies + 1
		end
	end

	if hoveringOverAllies and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_RIGHT) and not FAIO.TinkerPushMode then
		if FAIO.TinkerPushAllies > 0 then
			FAIO.TinkerPushAllies = FAIO.TinkerPushAllies - 1
		end
	end

	if FAIO.TinkerPushAllies > 0 then
		if not FAIO.TinkerPushMode then
			Renderer.SetDrawColor(0, 255, 255, 255)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
		end
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 121, FAIO.TinkerPushAllies, 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 121, FAIO.TinkerPushAllies, 0)
	end

	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX + width/4*3, startY+140, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 141, "Only save TP", 1)

	local hoveringOverSave = Input.IsCursorInRect(startX + width/4*3, startY+140, width/4, 20)
	if hoveringOverSave and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and not FAIO.TinkerPushMode then
		FAIO.TinkerPushSave = not FAIO.TinkerPushSave
	end

	if FAIO.TinkerPushSave then
		if not FAIO.TinkerPushMode then
			Renderer.SetDrawColor(0, 255, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
		end
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 141, "on", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 141, "off", 0)
	end


	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX + width/4*3, startY+160, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 161, "Auto defend", 1)

	local hoveringOverDefend = Input.IsCursorInRect(startX + width/4*3, startY+160, width/4, 20)
	if hoveringOverDefend and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		FAIO.TinkerPushDefend = not FAIO.TinkerPushDefend
	end

	if FAIO.TinkerPushDefend then
		Renderer.SetDrawColor(0, 255, 0, 255)	
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 161, "on", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 161, "off", 0)
	end

	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(startX + width/4*3, startY+180, width/4, 20)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawText(FAIO.arcWardenfont, startX + 5, startY + 181, "Allow jungle", 1)

	local hoveringOverJungle = Input.IsCursorInRect(startX + width/4*3, startY+180, width/4, 20)
	if hoveringOverJungle and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and not FAIO.TinkerPushMode then
		FAIO.TinkerPushJungle = not FAIO.TinkerPushJungle
	end

	if FAIO.TinkerPushJungle then
		if not FAIO.TinkerPushMode then
			Renderer.SetDrawColor(0, 255, 0, 255)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
		end
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 181, "on", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/4*3 + 18, startY + 181, "off", 0)
	end

	local startXinfo = startX
	local startYinfo = startY + 210

	Renderer.SetDrawColor(255, 0, 0, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 10, "INFORMATION", 1)
	Renderer.SetDrawColor(0, 0, 0, 45)
	Renderer.DrawFilledRect(startXinfo+1, startYinfo+1, width-2, 20-2)

	Renderer.SetDrawColor(0, 191, 255, 255)
	Renderer.DrawTextCentered(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 30, "Tinker action", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(startX+1, startYinfo+21, width-2, 20-2)


		if FAIO.TinkerStatus == 0 then
			Renderer.SetDrawColor(255, 100, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startX + width/2, startYinfo + 40, "manual", 0)

		elseif FAIO.TinkerStatus == 1 and FAIO.LockedTarget ~= nil then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "comboing", 0)
			local heroName = NPC.GetUnitName(FAIO.LockedTarget)
			local heroNameShort = string.gsub(heroName, "npc_dota_hero_", "")
			local imageHandle
				if FAIO.heroIconHandler[heroNameShort] ~= nil then
					imageHandle = FAIO.heroIconHandler[heroNameShort]
				else
					imageHandle = Renderer.LoadImage(FAIO.heroIconPath .. heroNameShort .. ".png")
					FAIO.heroIconHandler[heroNameShort] = imageHandle
				end
			Renderer.SetDrawColor(255, 255, 255, 255)
			Renderer.DrawImage(imageHandle, startX + width/2 - 35, startYinfo + 58, 67, 48)

		elseif FAIO.TinkerStatus == 2 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "TP pushing", 0)

		elseif FAIO.TinkerStatus == 3 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawTextCenteredX(FAIO.arcWardenfont, startXinfo + width/2, startYinfo + 40, "Rocket spam", 0)
		end


end
	
function FAIO.KunkkaShipCombo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroKunkkaShip) then return end

  	local Q = NPC.GetAbilityByIndex(myHero, 0)
 	local X = NPC.GetAbility(myHero, "kunkka_x_marks_the_spot")
	local Xreturn = NPC.GetAbility(myHero, "kunkka_return")
	local Ship = NPC.GetAbility(myHero, "kunkka_ghostship")

	local blink = NPC.GetItem(myHero, "item_blink", true)

	local myMana = NPC.GetMana(myHero)

	FAIO_itemHandler.itemUsage(myHero, enemy)

	if os.clock() < FAIO.lastTick then return end

	if FAIO.kunkkaGhostshipTimer < os.clock() then
		if enemy and Entity.IsAlive(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(enemy) and FAIO.heroCanCastSpells(myHero, enemy) == true then
			if not NPC.HasModifier(enemy, "modifier_kunkka_x_marks_the_spot") then
				if Menu.IsKeyDownOnce(FAIO_options.optionHeroKunkkaShipKey) then
					if Ship and Ability.IsCastable(Ship, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Ship)) then
						if X and Ability.IsCastable(X, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(X)) then
							Ability.CastTarget(X, enemy)
							FAIO.kunkkaXMarkPosition = Entity.GetAbsOrigin(enemy)
							FAIO.kunkkaXMarkCastTime = os.clock() + 1
							FAIO.lastTick = os.clock() + 0.1
							return
						end
					end
				end
			else
				if Ship and Ability.IsCastable(Ship, myMana) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(Ship)) then
					Ability.CastPosition(Ship, FAIO.kunkkaXMarkPosition)
					FAIO.kunkkaGhostshipTimer = os.clock() + 3.08
					FAIO.lastTick = os.clock() + 0.1
					return
				end
			end
		end
	else
		if FAIO.kunkkaGhostshipTimer - os.clock() <= 2.05 then
			if Q and Ability.IsCastable(Q, myMana) then
				Ability.CastPosition(Q, FAIO.kunkkaXMarkPosition)
				FAIO.lastTick = os.clock() + 0.1
				return
			end
		end

		if FAIO.kunkkaGhostshipTimer - os.clock() <= 0.55 then
			if Xreturn and Ability.IsCastable(Xreturn, myMana) then
				Ability.CastNoTarget(Xreturn)
				FAIO.lastTick = os.clock() + 0.1
				return
			end
		end
	end

	return

end

FAIO.mainTick = 0





function FAIO.comboExecutionTimer(myHero)

	if not myHero then return false end

	if os.clock() < FAIO.mainTick then return false end

	if FAIO_utility_functions.inSkillAnimation(myHero) == true then return false end

	return true

end

function FAIO.blinkHandler(myHero, enemy, triggerRange, distanceToEnemy, bestPos, effectRange)

	if not myHero then return end
	if not enemy then return end

	local blink = NPC.GetItem(myHero, "item_blink", true)
		if not blink then return end
		if not Ability.IsReady(blink) then return end
		if FAIO.heroCanCastItems(myHero) == false then return end
		if NPC.IsEntityInRange(myHero, enemy, triggerRange) then return end

	local targetOrBestPos = bestPos
		if targetOrBestPos == nil then
			targetOrBestPos = false
		end

	if targetOrBestPos and effectRange ~= nil and effectRange > 0 then
		local bestPos = FAIO_utility_functions.getBestPosition(Heroes.InRadius(Entity.GetAbsOrigin(enemy), effectRange * 2, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY), effectRange)
		if bestPos ~= nil and NPC.IsPositionInRange(myHero, bestPos, 1175, 0) then
			Ability.CastPosition(blink, bestPos)
			FAIO.mainTick = os.clock() + 0.055 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
	else
		local blinkSpot = Entity.GetAbsOrigin(enemy)
			if distanceToEnemy > 0 then
				blinkSpot = Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(distanceToEnemy)
			end
		if NPC.IsPositionInRange(myHero, blinkSpot, 1175, 0) then
			Ability.CastPosition(blink, blinkSpot)
			FAIO.mainTick = os.clock() + 0.055 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
	end

	return

end

FAIO.humanizerEnabled = nil
FAIO.humanizerMaxTime = 0

function FAIO.humanizerMouseDelayInit()

	if FAIO.humanizerEnabled == nil then
		FAIO.humanizerEnabled = Config.ReadInt("", "Enable Humanization", defaultValue)
	end

	if FAIO.humanizerEnabled == nil then return end
	if FAIO.humanizerEnabled < 1 then return end

	if FAIO.humanizerMaxTime < 1 then
		FAIO.humanizerMaxTime = Config.ReadInt("", "Unit Order Time", defaultValue)
	end

	return

end

function FAIO.humanizerMouseDelayCalc(pos)

	if not pos then return 0 end

	local humanizerTiming = FAIO.humanizerMaxTime / 1000
	
	local mousePos = Input.GetWorldCursorPos()
	
	local distance = (pos - mousePos):Length()

	local speed = 1500 / humanizerTiming 

	local approxTime = math.max(distance/speed, 0)

	return math.min(approxTime, humanizerTiming)		

end

return FAIO
			
