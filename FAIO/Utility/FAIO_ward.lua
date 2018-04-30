FAIO_ward = {}

FAIO_ward.font = Renderer.LoadFont("Tahoma", 22, Enum.FontWeight.EXTRABOLD)

FAIO_ward.wardCaptureTiming = 0
FAIO_ward.sentryImageHandle = nil
FAIO_ward.obsImageHandle = nil
FAIO_ward.wardDrawingRemove = 0

FAIO_ward.wardDispenserCount = {}
FAIO_ward.wardProcessingTable = {}

function FAIO_ward.OnEntityDestroy(ent)

	if not Menu.IsEnabled(FAIO_options.optionWardAwareness) then return end
	if not Menu.IsEnabled(FAIO_options.optionWardAwarenessRemove) then return end

	if not Heroes.GetLocal() then return end

	if not Entity.IsNPC(ent) then return end
	if Entity.IsSameTeam(Heroes.GetLocal(), ent) then return end
	if NPC.GetUnitName(ent) ~= "npc_dota_sentry_wards" and NPC.GetUnitName(ent) ~= "npc_dota_observer_wards" then return end

	if next(FAIO_ward.wardProcessingTable) ~= nil then
		for i, v in pairs(FAIO_ward.wardProcessingTable) do
			if v then
				if (v.pos - Entity.GetAbsOrigin(ent)):Length2D() <= 500 then
					FAIO_ward.wardProcessingTable[i] = nil
				end
			end
		end
	end

end

function FAIO_ward.wardProcessing(myHero)

	if not myHero then return end

	if os.clock() - FAIO_ward.wardCaptureTiming < 0.5 then return end

	for i = 1, Heroes.Count() do
		local heroes = Heroes.Get(i)
		if heroes and Entity.IsHero(heroes) and Entity.IsAlive(heroes) and not Entity.IsDormant(heroes) and not Entity.IsSameTeam(myHero, heroes) and not NPC.IsIllusion(heroes) then
			local sentry = NPC.GetItem(heroes, "item_ward_sentry", true)
			local observer = NPC.GetItem(heroes, "item_ward_observer", true)
			local dispenser = NPC.GetItem(heroes, "item_ward_dispenser", true)
			local sentryStack = 0
			local observerStack = 0
			local ownerID = Entity.GetIndex(heroes)
			if sentry then
				sentryStack = Item.GetCurrentCharges(sentry)
			elseif observer then
				observerStack = Item.GetCurrentCharges(observer)
			elseif dispenser then
				sentryStack = Item.GetSecondaryCharges(dispenser)
				observerStack = Item.GetCurrentCharges(dispenser)
			end

			if sentryStack == 0 and observerStack == 0 then
				if FAIO_ward.wardDispenserCount[ownerID] == nil then
					FAIO_ward.wardDispenserCount[ownerID] = nil
					FAIO_ward.wardCaptureTiming = os.clock()
				else
					if FAIO_ward.wardDispenserCount[ownerID]["sentry"] > sentryStack then
						FAIO_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "sentry", pos = Entity.GetAbsOrigin(heroes), dieTime = math.floor(GameRules.GetGameTime() + 240)}
						FAIO_ward.wardDispenserCount[ownerID] = nil
						FAIO_ward.wardCaptureTiming = os.clock()
					elseif FAIO_ward.wardDispenserCount[ownerID]["observer"] > sentryStack then
						FAIO_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "observer", pos = Entity.GetAbsOrigin(heroes), dieTime = math.floor(GameRules.GetGameTime() + 360)}
						FAIO_ward.wardDispenserCount[ownerID] = nil
						FAIO_ward.wardCaptureTiming = os.clock()
					end
				end
			end
						
			if FAIO_ward.wardDispenserCount[ownerID] == nil then
				if sentryStack > 0 or observerStack > 0 then
					FAIO_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_ward.wardCaptureTiming = os.clock()
				end
			else
				if FAIO_ward.wardDispenserCount[ownerID]["sentry"] < sentryStack then
					FAIO_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_ward.wardCaptureTiming = os.clock()
				elseif FAIO_ward.wardDispenserCount[ownerID]["observer"] < observerStack then
					FAIO_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_ward.wardCaptureTiming = os.clock()
				elseif FAIO_ward.wardDispenserCount[ownerID]["sentry"] > sentryStack then
					FAIO_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "sentry", pos = Entity.GetAbsOrigin(heroes), dieTime = math.floor(GameRules.GetGameTime() + 240)}
					FAIO_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_ward.wardCaptureTiming = os.clock()
				elseif FAIO_ward.wardDispenserCount[ownerID]["observer"] > observerStack then
					FAIO_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "observer", pos = Entity.GetAbsOrigin(heroes), dieTime = math.floor(GameRules.GetGameTime() + 360)}
					FAIO_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_ward.wardCaptureTiming = os.clock()
				end
			end
		elseif heroes and Entity.IsHero(heroes) and Entity.IsDormant(heroes) then
			local ownerID = Entity.GetIndex(heroes)
			FAIO_ward.wardDispenserCount[ownerID] = nil
			FAIO_ward.wardCaptureTiming = os.clock()
		end
	end

	for k, l in pairs(FAIO_ward.wardProcessingTable) do
		if l then
			if GameRules.GetGameTime() > l.dieTime then
				FAIO_ward.wardProcessingTable[k] = nil
			end	
		end
	end

end

function FAIO_ward.drawWard(myHero)

	if not myHero then return end

	if next(FAIO_ward.wardProcessingTable) == nil then return end

	local sentryImageHandle = FAIO_ward.sentryImageHandle
		if sentryImageHandle == nil then
			sentryImageHandle = Renderer.LoadImage("resource/flash3/images/items/" .. "ward_sentry" .. ".png")
			FAIO_ward.sentryImageHandle = sentryImageHandle
		end
	local obsImageHandle = FAIO_ward.obsImageHandle
		if obsImageHandle == nil then
			obsImageHandle = Renderer.LoadImage("resource/flash3/images/items/" .. "ward_observer" .. ".png")
			FAIO_ward.obsImageHandle = obsImageHandle
		end

	for i, v in pairs(FAIO_ward.wardProcessingTable) do
		if v then
			local type = v.type
			local pos = v.pos
			local dieTime = v.dieTime
			if dieTime > GameRules.GetGameTime() then
				local x, y, visible = Renderer.WorldToScreen(pos)
				local hoveringOver = Input.IsCursorInRect(x, y, 30, 30)
				if visible then
					if type == "sentry" then
						Renderer.SetDrawColor(255, 255, 255, 255)
						Renderer.DrawImage(sentryImageHandle, x, y, 30, 30)
						Renderer.DrawText(FAIO_ward.font, x, y+30, math.floor(dieTime - GameRules.GetGameTime()), 0)
					elseif type == "observer" then
						Renderer.SetDrawColor(255, 255, 255, 255)
						Renderer.DrawImage(obsImageHandle, x, y, 30, 30)
						Renderer.DrawText(FAIO_ward.font, x, y+30, math.floor(dieTime - GameRules.GetGameTime()), 0)
					end
					if Menu.IsEnabled(FAIO_options.optionWardAwarenessClickRemove) and (os.clock() - FAIO_ward.wardDrawingRemove) >= 0.25 then
						if hoveringOver and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
							FAIO_ward.wardDrawingRemove = os.clock()
						end
					else
						if hoveringOver and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
							FAIO_ward.wardProcessingTable[i] = nil
						end
					end
				end
			end
		end
	end

end





return FAIO_ward