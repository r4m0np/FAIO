FAIO_ogre_magi = {}

local Q = nil
local W = nil
local S = nil

function FAIO_ogre_magi.combo(myHero, enemy)

	if not Menu.IsEnabled(FAIO_options.optionHeroOgre) then return end

	Q = NPC.GetAbilityByIndex(myHero, 0)
 	W = NPC.GetAbilityByIndex(myHero, 1)
 	S = NPC.GetAbility(myHero, "ogre_magi_unrefined_fireblast")

	local myMana = NPC.GetMana(myHero)
	
	if not enemy then return end
	if not NPC.IsEntityInRange(myHero, enemy, 3000)	then return end

	FAIO_itemHandler.itemUsage(myHero, enemy)

	local switch = FAIO_ogre_magi.comboExecutionTimer(myHero)

	if Menu.IsKeyDown(FAIO_options.optionComboKey) and Entity.IsAlive(enemy) then

		FAIO_ogre_magi.system(switch, function (continue, wait)

			continue(FAIO_ogre_magi.comboExecute(myHero, enemy, myMana))
			wait()

		end)()
		
	end

	return

end

function FAIO_ogre_magi.comboExecute(myHero, enemy, myMana)

	if Menu.IsEnabled(FAIO_options.optionHeroOgreBlink) then
		FAIO_ogre_magi.blinkHandler(myHero, enemy, 600, 150, false)
	end

	if FAIO_skillHandler.skillIsCastable(Q, Ability.GetCastRange(Q), enemy, nil, true) then
		FAIO_skillHandler.executeSkillOrder(Q, enemy)
		return
	end

	if FAIO_skillHandler.skillIsCastable(W, Ability.GetCastRange(W), enemy, nil, false) then
		local check = true
			if NPC.HasItem(myHero, "item_blink", true) and Ability.IsReady(NPC.GetItem(myHero, "item_blink", true)) and not NPC.IsEntityInRange(myHero, enemy, 600) then 
				check = false
			end

		if check then
			FAIO_skillHandler.executeSkillOrder(W, enemy)
			return
		end
	end

	if FAIO_skillHandler.skillIsCastable(S, Ability.GetCastRange(S), enemy, nil, true) then
		local stunMod = NPC.GetModifier(enemy, "modifier_stunned")
		local dieTime = 0
			if stunMod then
				dieTime = Modifier.GetDieTime(stunMod) - 0.55
			end
		local check = true
			if dieTime > 0 and GameRules.GetGameTime() < dieTime then
				check = false
			end

		if check then
			FAIO_skillHandler.executeSkillOrder(S, enemy)
			return
		end
	end

	FAIO_ogre_magi.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
	return

end

return FAIO_ogre_magi