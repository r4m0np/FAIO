FAIO_skillHandler = {}

function FAIO_skillHandler.skillIsReady(skill)

	local myHero = Heroes.GetLocal()
		if not myHero then return false end

	if not skill then return false end

	if Ability.GetLevel(skill) < 1 then
		return false
	end 

	local myMana = NPC.GetMana(myHero)

	if Ability.GetManaCost(skill) > 0 then
		if not Ability.IsCastable(skill, myMana) then
			return false
		end
	else
		if not Ability.IsReady(skill) then
			return false
		end
	end

	return true

end

function FAIO_skillHandler.skillIsCastable(skill, castRange, target, position, linkens)

	local myHero = Heroes.GetLocal()
		if not myHero then return false end

	if not target then return false end

	local linkensCheck = linkens
		if linkensCheck == nil then
			linkensCheck = false
		end

	local myMana = NPC.GetMana(myHero)

	if not skill then return false end
		if Ability.GetManaCost(skill) > 0 then
			if not Ability.IsCastable(skill, myMana) then
				return false
			end
		else
			if not Ability.IsReady(skill) then
				return false
			end
		end
		if Ability.GetLevel(skill) < 1 then
			return false
		end

	if FAIO_skillHandler.heroCanCastItems(myHero) == false then
		return false
	end

	if Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_ITEM == 0 then
		if FAIO_skillHandler.heroCanCastSpells(myHero, target) == false then
			return false
		end
	end

	local piercesSpellImmunity = false
		if not Entity.IsSameTeam(myHero, target) then
			if Ability.GetImmunityType(skill) & Enum.ImmunityTypes.SPELL_IMMUNITY_ENEMIES_YES ~= 0 then
				piercesSpellImmunity = true
			end
			if not piercesSpellImmunity then
				if Ability.GetDamageType(skill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL == 0 then
					piercesSpellImmunity = true
				end
			end
		else
			if Ability.GetImmunityType(skill) & Enum.ImmunityTypes.SPELL_IMMUNITY_ALLIES_YES ~= 0 then
				piercesSpellImmunity = true
			end
		end

	local targetable = true
		if Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ~= 0 and Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT == 0 then
			if linkensCheck and NPC.IsLinkensProtected(target) then
				targetable = false
			elseif NPC.HasModifier(target, "modifier_item_lotus_orb_active") then
				targetable = false
			elseif linkensCheck and NPC.HasItem(target, "item_ultimate_scepter", true) and NPC.HasModifier(target, "modifier_antimage_spell_shield") and Ability.IsReady(NPC.GetAbility(target, "antimage_spell_shield")) then
				targetable = false
			else
				if Ability.GetDamageType(skill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
					if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not piercesSpellImmunity then
						targetable = false
					end
				end
			end
			if not NPC.IsEntityInRange(myHero, target, castRange) then
				targetable = false
			end
			if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				targetable = false
			end
		elseif Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET ~= 0 then
			if Ability.GetDamageType(skill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
				if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not piercesSpellImmunity then
					targetable = false
				end
			end
			if not NPC.IsEntityInRange(myHero, target, castRange) then
				targetable = false
			end
			if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				targetable = false
			end
		elseif Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT ~= 0 then
			if position == nil then
				targetable = false
			end
			if not NPC.IsPositionInRange(myHero, position, castRange, 0) then
				targetable = false
			end
			if Ability.GetDamageType(skill) & Enum.DamageTypes.DAMAGE_TYPE_MAGICAL ~= 0 then
				if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not piercesSpellImmunity then
					targetable = false
				end
			end
		end
		if NPC.HasModifier(target, "modifier_winter_wyvern_winters_curse") then
			targetable = false
		end
		if NPC.HasModifier(target, "modifier_abaddon_borrowed_time") then
			targetable = false
		end
		if NPC.HasModifier(target, "modifier_dazzle_shallow_grave") then
			targetable = false
		end
		if NPC.HasModifier(target, "modifier_nyx_assassin_spiked_carapace") then
			targetable = false
		end
		if NPC.HasModifier(target, "modifier_skeleton_king_reincarnation_scepter_active") then
			targetable = false
		end
		if NPC.HasModifier(target, "modifier_ursa_enrage") then
			targetable = false
		end

	if not targetable then
		return false
	end

	return true
		
end

function FAIO_skillHandler.executeSkillOrder(skill, target, position)

	if not skill then return end

	local myHero = Heroes.GetLocal()

	if Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET ~= 0 then

		Ability.CastNoTarget(skill)
		FAIO_skillHandler.mainTick = os.clock() + 0.055 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return

	elseif Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ~= 0 and Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT == 0 then
		
		if not target then return end

		local mousePos = Input.GetWorldCursorPos()
		local humanizerAdjustment = FAIO_skillHandler.humanizerMouseDelayCalc(Entity.GetAbsOrigin(target))
		local turnAdjustment = math.max(NPC.GetTimeToFace(myHero, target), 0)

		Ability.CastTarget(skill, target)
		FAIO_skillHandler.mainTick = os.clock() + 0.055 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + humanizerAdjustment + turnAdjustment
		return

	elseif Ability.GetBehavior(skill) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT ~= 0 then

		local pos = position
			if not pos then return end

		local mousePos = Input.GetWorldCursorPos()
		local humanizerAdjustment = FAIO_skillHandler.humanizerMouseDelayCalc(pos)
		local turnAdjustment = FAIO_skillHandler.TimeToFacePosition(myHero, pos)

		Ability.CastPosition(skill, pos)
		FAIO_skillHandler.mainTick = os.clock() + 0.055 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + humanizerAdjustment + turnAdjustment
		return

	end

	return

end

return FAIO_skillHandler