FAIO_killsteal = {}

FAIO_killsteal.internalTick = 0

FAIO_killsteal.nukeAbilityList = {
	npc_dota_hero_abaddon = 		{{ "abaddon_death_coil", "target_damage", nil }},
	npc_dota_hero_abyssal_underlord = 	{{ "abyssal_underlord_firestorm", "0", nil }},
	npc_dota_hero_bane = 			{{ "bane_brain_sap", "brain_sap_damage", nil }},
	npc_dota_hero_beastmaster = 		{{ "beastmaster_wild_axes", "axe_damage", nil }},
	npc_dota_hero_bloodseeker = 		{{ "bloodseeker_blood_bath", "damage", nil }},
	npc_dota_hero_bounty_hunter = 		{{ "bounty_hunter_shuriken_toss", "bonus_damage", "special" }},
	npc_dota_hero_brewmaster = 		{{ "brewmaster_thunder_clap", "damage", nil }},
	npc_dota_hero_bristleback = 		{{ "bristleback_quill_spray", "quill_base_damage", nil }},
	npc_dota_hero_broodmother = 		{{ "broodmother_spawn_spiderlings", "damage", nil }},
	npc_dota_hero_centaur = 		{{ "centaur_double_edge", "edge_damage", nil }},
	npc_dota_hero_chen = 			{{ "chen_test_of_faith", "damage_min", nil }},
	npc_dota_hero_crystal_maiden = 		{{ "crystal_maiden_crystal_nova", "nova_damage", nil }},
	npc_dota_hero_dazzle = 			{{ "dazzle_poison_touch", "0", nil }},
	npc_dota_hero_death_prophet = 		{{ "death_prophet_carrion_swarm", "0", "skillshot" }},
	npc_dota_hero_disruptor = 		{{ "disruptor_thunder_strike", "0", nil }},
	npc_dota_hero_dragon_knight = 		{{ "dragon_knight_breathe_fire", "0", nil }},
	npc_dota_hero_elder_titan = 		{{ "elder_titan_ancestral_spirit", "pass_damage", nil }},
	npc_dota_hero_gyrocopter = 		{{ "gyrocopter_rocket_barrage", "0", nil }},
	npc_dota_hero_kunkka = 			{{ "kunkka_torrent", "0", "skillshot" }},
	npc_dota_hero_legion_commander = 	{{ "legion_commander_overwhelming_odds", "damage", nil }},
	npc_dota_hero_leshrac = 		{{ "leshrac_lightning_storm", "0", nil }},
	npc_dota_hero_lich = 			{{ "lich_frost_nova", "aoe_damage", nil }},
	npc_dota_hero_lina = 			{{ "lina_dragon_slave", "0", "skillshot" }},
	npc_dota_hero_luna = 			{{ "luna_lucent_beam", "beam_damage", nil }},
	npc_dota_hero_magnataur = 		{{ "magnataur_shockwave", "shock_damage", "skillshot" }},
	npc_dota_hero_medusa = 			{{ "medusa_mystic_snake", "snake_damage", nil }},
	npc_dota_hero_mirana = 			{{ "mirana_starfall", "0", nil }},
	npc_dota_hero_monkey_king = 		{{ "monkey_king_boundless_strike", "0", nil }},
	npc_dota_hero_morphling = 		{{ "morphling_adaptive_strike_agi", "damage_base", nil }},
	npc_dota_hero_naga_siren = 		{{ "naga_siren_rip_tide", "0", nil }},
	npc_dota_hero_necrolyte = 		{{ "necrolyte_death_pulse", "0", nil }},
	npc_dota_hero_nevermore =		{{ "nevermore_shadowraze1", "shadowraze_damage", "special" },
						{ "nevermore_shadowraze2", "shadowraze_damage", "special" },
						{ "nevermore_shadowraze3", "shadowraze_damage", "special" }},
	npc_dota_hero_night_stalker = 		{{ "night_stalker_void", "0", nil }},
	npc_dota_hero_nyx_assassin = 		{{ "nyx_assassin_mana_burn", "float_multiplier", nil }},
	npc_dota_hero_ogre_magi = 		{{ "ogre_magi_fireblast", "0", nil }},
	npc_dota_hero_oracle = 			{{ "oracle_purifying_flames", "damage", nil }},
	npc_dota_hero_phantom_assassin = 	{{ "phantom_assassin_stifling_dagger", "base_damage", nil }},
	npc_dota_hero_phantom_lancer = 		{{ "phantom_lancer_spirit_lance", "lance_damage", nil }},
	npc_dota_hero_puck = 			{{ "puck_waning_rift", "damage", nil }},
	npc_dota_hero_pugna = 			{{ "pugna_nether_blast", "blast_damage", "skillshot" }},
	npc_dota_hero_queenofpain = 		{{ "queenofpain_shadow_strike", "strike_damage", nil },
						{ "queenofpain_scream_of_pain", "0", "special" }},
	npc_dota_hero_rattletrap = 		{{ "rattletrap_rocket_flare", "0", "skillshot" }},
	npc_dota_hero_razor = 			{{ "razor_plasma_field", "damage_max", nil }},
	npc_dota_hero_rubick = 			{{ "rubick_fade_bolt", "damage", nil }},	
	npc_dota_hero_shadow_shaman = 		{{ "shadow_shaman_ether_shock", "damage", nil }},	
	npc_dota_hero_shredder = 		{{ "shredder_whirling_death", "whirling_damage", nil }},	
	npc_dota_hero_silencer = 		{{ "silencer_last_word", "damage", nil }},	
	npc_dota_hero_skywrath_mage = 		{{ "skywrath_mage_arcane_bolt", "bolt_damage", nil },
						{ "skywrath_mage_concussive_shot", "damage", "special" }},	
	npc_dota_hero_slark = 			{{ "slark_dark_pact", "total_damage", nil }},	
	npc_dota_hero_spectre = 		{{ "spectre_spectral_dagger", "damage", nil }},	
	npc_dota_hero_tidehunter = 		{{ "tidehunter_anchor_smash", "0", nil },
						{ "tidehunter_gush", "gush_damage", nil }},	
	npc_dota_hero_tinker = 			{{ "tinker_laser", "laser_damage", nil },
						{ "tinker_heat_seeking_missile", "damage", nil }},	
	npc_dota_hero_tiny = 			{{ "tiny_toss", "toss_damage", nil }},
	npc_dota_hero_troll_warlord = 		{{ "troll_warlord_whirling_axes_melee", "0", nil },
						{ "troll_warlord_whirling_axes_ranged", "0", nil }},
	npc_dota_hero_tusk = 			{{ "tusk_ice_shards", "shard_damage", "skillshot" }},
	npc_dota_hero_undying = 		{{ "undying_decay", "decay_damage", nil }},	
	npc_dota_hero_ursa = 			{{ "ursa_earthshock", "0", nil }},	
	npc_dota_hero_vengefulspirit = 		{{ "vengefulspirit_wave_of_terror", "0", "skillshot" }},	
	npc_dota_hero_warlock = 		{{ "warlock_shadow_word", "0", nil }},	
	npc_dota_hero_windrunner = 		{{ "windrunner_powershot", "powershot_damage", "skillshot" }},	
	npc_dota_hero_winter_wyvern = 		{{ "winter_wyvern_splinter_blast", "0","special" }},
	npc_dota_hero_pangolier = 		{{ "pangolier_swashbuckle", "damage", "special" }}
		}
	
function FAIO_killsteal.autoNuke(myHero)

	if not myHero then return end

	if os.clock() - FAIO_killsteal.internalTick < 3 then return end

	if FAIO_killsteal.nukeAbilityList[FAIO_killsteal.myUnitName] == nil then return end

	local myMana = NPC.GetMana(myHero)

	if FAIO_killsteal.heroCanCastSpells(myHero, enemy) == false then return end
	if FAIO_killsteal.isHeroChannelling(myHero) == true then return end 
	if FAIO_killsteal.IsHeroInvisible(myHero) == true then return end
	if FAIO_killsteal.inSkillAnimation(myHero) == true then return end

	local nukeSkill = nil
	local damageAttribute = nil
	local nukeStyle = nil
		for i, v in pairs(FAIO_killsteal.nukeAbilityList[FAIO_killsteal.myUnitName]) do
			local skillName = v[1]
			if NPC.HasAbility(myHero, skillName) then
				local temp = NPC.GetAbility(myHero, skillName)
				if temp and Ability.IsReady(temp) and Ability.IsCastable(temp, myMana) then
					nukeSkill = temp
					damageAttribute = v[2]
					nukeStyle = v[3]
				end
			end
		end

	if not nukeSkill then return end
	if not Ability.IsReady(nukeSkill) then return end
	if not Ability.IsCastable(nukeSkill, myMana) then return end

	for _, enemy in ipairs(NPC.GetHeroesInRadius(myHero, 2000, Enum.TeamType.TEAM_ENEMY)) do
		if not enemy then return end
		if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return end

		if Entity.IsHero(enemy) and Entity.IsAlive(enemy) and not NPC.IsDormant(enemy) and not NPC.IsIllusion(enemy) then
			if not NPC.HasModifier(enemy, "modifier_templar_assassin_refraction_absorb") and
			not NPC.HasModifier(enemy, "modifier_nyx_assassin_spiked_carapace") and
			not NPC.HasModifier(enemy, "modifier_ursa_enrage") and
			not NPC.HasModifier(enemy, "modifier_abaddon_borrowed_time") and
			not NPC.HasModifier(enemy, "modifier_dazzle_shallow_grave") and
			not NPC.HasModifier(enemy, "modifier_winter_wyvern_winters_curse") and
			not NPC.HasModifier(enemy, "modifier_skeleton_king_reincarnation_scepter_active") then
				local skillDamage = Ability.GetDamage(nukeSkill)
					if skillDamage < 1 then
						if Ability.GetName(nukeSkill) == "skywrath_mage_arcane_bolt" then
							skillDamage = Ability.GetLevelSpecialValueFor(nukeSkill, damageAttribute) + (1.6 * Hero.GetIntellectTotal(myHero))
						elseif Ability.GetName(nukeSkill) == "nyx_assassin_mana_burn" then
							skillDamage = Ability.GetLevelSpecialValueForFloat(nukeSkill, damageAttribute) * Hero.GetIntellectTotal(enemy) * (1 + Hero.GetIntellectTotal(myHero) / 14 / 100)
						else
							skillDamage = Ability.GetLevelSpecialValueFor(nukeSkill, damageAttribute)
						end
					end
				
				local killable = false
					if Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
						if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) * 2 < (((1 - NPC.GetMagicalArmorValue(enemy)) * skillDamage) + (skillDamage * (Hero.GetIntellectTotal(myHero) / 14 / 100))) then
							killable = true
						end
					elseif Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_PURE ~= 0 then
						if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) * 2 < skillDamage then
							killable = true
						end	
					elseif Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_PHYSICAL ~= 0 then
						if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) * 2 < math.floor(NPC.GetDamageMultiplierVersus(myHero, enemy) * skillDamage * NPC.GetArmorDamageMultiplier(enemy)) then
							killable = true	
						end
					end

				local targetable = true
					if Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ~= 0 then
						if NPC.IsLinkensProtected(enemy) then
							targetable = false
						elseif NPC.HasModifier(enemy, "modifier_item_lotus_orb_active") then
							targetable = false
						elseif NPC.HasItem(enemy, "item_ultimate_scepter", true) and NPC.HasModifier(enemy, "modifier_antimage_spell_shield") and Ability.IsReady(NPC.GetAbility(enemy, "antimage_spell_shield")) then
							targetable = false
						else
							if Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
								if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
									targetable = false
								end
							end
						end
					elseif Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET ~= 0 then
						if Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
							if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
								targetable = false
							end
						end
					elseif Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT ~= 0 then
						if Ability.GetDamageType(nukeSkill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
							if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
								targetable = false
							end
						end
					end

					if killable and targetable then
						if nukeStyle == nil then
							if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(nukeSkill)) then	
								if Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET ~= 0 then
									FAIO_killsteal.executeSkillOrder(nukeSkill)
									FAIO_killsteal.internalTick = os.clock()
									return
								elseif Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ~= 0 then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy)
									FAIO_killsteal.internalTick = os.clock()
									return
								elseif Ability.GetBehavior(nukeSkill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT ~= 0 then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, Entity.GetAbsOrigin(enemy))
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							end
						elseif nukeStyle == "skillshot" then
							local skillName = Ability.GetName(nukeSkill)
							if skillName == "windrunner_powershot" then
								local powershotPrediction = 1 + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 3000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, powershotPrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "death_prophet_carrion_swarm" then
								local carrionPrediction = 0.5 + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, carrionPrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "kunkka_torrent" then
								local kunkkaPrediction = 2 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castPrediction(myHero, enemy, kunkkaPrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "lina_dragon_slave" then		
								local dragonSlavePrediction = Ability.GetCastPoint(nukeSkill) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1200) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, dragonSlavePrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "magnataur_shockwave" then
								local shockwavePrediction = Ability.GetCastPoint(nukeSkill) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1050) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, shockwavePrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "pugna_nether_blast" then
								local blastPrediction = Ability.GetCastPoint(nukeSkill) + 0.9 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castPrediction(myHero, enemy, blastPrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "rattletrap_rocket_flare" then
								local flairPrediction = Ability.GetCastPoint(nukeSkill) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1750) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, flairPrediction)
								if predPos then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "tusk_ice_shards" then
								local shardsPrediction = Ability.GetCastPoint(nukeSkill) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 1100) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, shardsPrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "vengefulspirit_wave_of_terror" then
								local wavePrediction = Ability.GetCastPoint(nukeSkill) + (Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() / 2000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))	
								local predPos = FAIO_killsteal.castLinearPrediction(myHero, enemy, wavePrediction)
								if predPos and NPC.IsPositionInRange(myHero, predPos, Ability.GetCastRange(nukeSkill), 0) then
									FAIO_killsteal.executeSkillOrder(nukeSkill, enemy, predPos)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
						else
							local skillName = Ability.GetName(nukeSkill)
							if skillName == "queenofpain_scream_of_pain" then
								if NPC.IsEntityInRange(myHero, enemy, Ability.GetLevelSpecialValueFor(nukeSkill, "area_of_effect")) then
									FAIO_killsteal.executeSkillOrder(nukeSkill)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "nevermore_shadowraze1" then
								local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(200)
								local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)	
								local predictedPos = FAIO_killsteal.castPrediction(myHero, enemy, razePrediction)
								local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
								if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
									FAIO_killsteal.executeSkillOrder(nukeSkill)
									FAIO_killsteal.internalTick = os.clock()
									return
								end

							elseif skillName == "nevermore_shadowraze2" then
								local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(450)
								local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)			
								local predictedPos = FAIO_killsteal.castPrediction(myHero, enemy, razePrediction)
								local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
								if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
									FAIO_killsteal.executeSkillOrder(nukeSkill)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "nevermore_shadowraze3" then
								local razePos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(700)
								local razePrediction = 0.55 + 0.1 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)			
								local predictedPos = FAIO_killsteal.castPrediction(myHero, enemy, razePrediction)
								local disRazePOSpredictedPOS = (razePos - predictedPos):Length2D()
								if disRazePOSpredictedPOS <= 200 and not Entity.IsTurning(myHero) then
									FAIO_killsteal.executeSkillOrder(nukeSkill)
									FAIO_killsteal.internalTick = os.clock()
									return
								end
							elseif skillName == "skywrath_mage_concussive_shot" then
								if NPC.IsEntityInRange(myHero, enemy, 1600, 0) then
									local enemyDis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length2D()
									local aghanimsBuffed = false
										if NPC.HasItem(myHero, "item_ultimate_scepter", true) or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed") then
											aghanimsBuffed = true
										end
									if not aghanimsBuffed then
										if #Entity.GetHeroesInRadius(myHero, enemyDis, Enum.TeamType.TEAM_ENEMY) <= 1 then
											FAIO_killsteal.executeSkillOrder(nukeSkill)
											FAIO_killsteal.internalTick = os.clock()
											return
										end
									else
										if #Entity.GetHeroesInRadius(myHero, enemyDis, Enum.TeamType.TEAM_ENEMY) <= 2 then
											FAIO_killsteal.executeSkillOrder(nukeSkill)
											FAIO_killsteal.internalTick = os.clock()
											return
										end
									end
								end
							elseif skillName == "pangolier_swashbuckle" and targetMode == "special" and not NPC.HasModifier(myHero, "modifier_pangolier_gyroshell") then
								if NPC.HasAbility(myHero, "special_bonus_unique_pangolier_3") then
									if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_pangolier_3")) > 0 then
										skillDamage = skillDamage + 30
									end
								end
								local trueSkillDamage = NPC.GetDamageMultiplierVersus(myHero, enemy) * (skillDamage * NPC.GetArmorDamageMultiplier(enemy)) * 4
								local castRange = 1000
								local slashRange = 900
								if NPC.IsEntityInRange(myHero, enemy, castRange + slashRange, 0) then
									if Entity.GetHealth(enemy) + NPC.GetHealthRegen(enemy) <= trueSkillDamage then
										if NPC.IsEntityInRange(myHero, enemy, castRange, 0) then
											local swashPrediction = 0.2 + ((Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() - 100) / 2000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
											local pos = FAIO_killsteal.castPrediction(myHero, enemy, swashPrediction) + (Entity.GetAbsOrigin(myHero) - FAIO_killsteal.castPrediction(myHero, enemy, swashPrediction)):Normalized():Scaled(100)
										    	Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, pos, nukeSkill, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, myHero)
											Ability.CastPosition(nukeSkill, Entity.GetAbsOrigin(myHero), true)
											FAIO_killsteal.mainTick = os.clock() + 0.255 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
											return
										else
											local swashPrediction = 0.2 + ((Entity.GetAbsOrigin(enemy):__sub(Entity.GetAbsOrigin(myHero)):Length2D() - 100) / 2000) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
											local pos = Entity.GetAbsOrigin(myHero) + (FAIO_killsteal.castPrediction(myHero, enemy, swashPrediction) - Entity.GetAbsOrigin(myHero)):Normalized():Scaled(999)
										    	Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, pos, nukeSkill, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, myHero)
											Ability.CastPosition(nukeSkill, Entity.GetAbsOrigin(myHero), true)
											FAIO_killsteal.mainTick = os.clock() + 0.255 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + FAIO_killsteal.humanizerMouseDelayCalc(Entity.GetAbsOrigin(enemy))
											return
										end
									end
								end
							elseif skillName == "winter_wyvern_splinter_blast"then	
								if NPC.IsEntityInRange(myHero, enemy, 1600, 0) then
									local target
									for _, possibleTargets in ipairs(Heroes.InRadius(Entity.GetAbsOrigin(enemy), 499, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)) do
										if possibleTargets and possibleTargets ~= enemy and Entity.IsHero(possibleTargets) and Entity.IsAlive(possibleTargets) and not NPC.HasState(possibleTargets, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsLinkensProtected(possibleTargets) then
											if NPC.IsEntityInRange(myHero, possibleTargets, 1199) then
												target = possibleTargets
												break
											end
										end
									end
									if target ~= nil then
										FAIO_killsteal.executeSkillOrder(nukeSkill, target)
										FAIO_killsteal.internalTick = os.clock()
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


return FAIO_killsteal