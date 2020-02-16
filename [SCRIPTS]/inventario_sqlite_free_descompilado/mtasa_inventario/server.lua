-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

mysqlConnection = exports.mysql

function getElementItems(playerSource, elementSource, playerValue)
	if (elementSource) then
		local elementTypes = getTypeOfElement(elementSource)
		local elementOwnerID = tonumber(getElementData(elementSource, "ID"))
		
		local loadedItems = {
			["bag"] = {},
			["key"] = {},
			["cards"] = {},
		}
		local query = dbPoll(dbQuery(mysqlConnection, "SELECT * FROM items WHERE item_owner = ? and item_type = ?", elementOwnerID, elementTypes[1]), -1)
		if query then
			for index, sor in ipairs (query) do
				if not loadedItems[items[tonumber(sor["item_id"])].typ] then loadedItems[items[tonumber(sor["item_id"])].typ] = {} end
				loadedItems[items[tonumber(sor["item_id"])].typ][tonumber(sor["item_slot"])] = {
					["ID"] = tonumber(sor["id"]),
					["id"] = tonumber(sor["item_id"]),
					["value"] = tostring(sor["item_value"]),
					["count"] = tonumber(sor["item_count"]),
					["duty"] = tonumber(sor["item_duty"]),
					["slot"] = tonumber(sor["item_slot"]),	
					["health"] = tonumber(sor["item_health"]),	
				}
			end
		end
		if (tonumber(playerValue) == 1 or tonumber(playerValue) == 2) then
			triggerClientEvent(playerSource, "setElementItems", playerSource, loadedItems, playerValue, elementSource)		
		else
			return loadedItems
		end		
	end
end
addEvent("getElementItems", true)
addEventHandler("getElementItems", getRootElement(), getElementItems)

addEvent("itemBugFixServer", true)
addEventHandler("itemBugFixServer", root, function(player)
triggerClientEvent(player, "itemBugFixClient", player)	
end)

function takeStatus(playerSource, elementSource, itemDBID, newStatus)
	if (newStatus) then
		dbPoll(dbQuery(mysqlConnection, "UPDATE items SET item_health = ? WHERE id = ?", newStatus, itemDBID), -1)
	end
end
addEvent("takeStatus", true)
addEventHandler("takeStatus", getRootElement(), takeStatus)

function updateItemSlot(playerSource, elementSource, newSlot, oldItem)
	if (newSlot and oldItem) then
		local itemDBID = oldItem["ID"]	
		dbPoll(dbQuery(mysqlConnection, "UPDATE items SET item_slot = ? WHERE id = ?", newSlot, itemDBID), -1)
	end
end
addEvent("updateItemSlot", true)
addEventHandler("updateItemSlot", getRootElement(), updateItemSlot)

function updateItemCount(playerSource, elementSource, itemSlot, newCount, itemDBID)
	if (newCount and itemDBID) then		
		dbPoll(dbQuery(mysqlConnection, "UPDATE items SET item_count = ? WHERE id = ?", newCount, itemDBID), -1)
	end
end
addEvent("updateItemCount", true)
addEventHandler("updateItemCount", getRootElement(), updateItemCount)

function updateItemValue(playerSource, elementSource, itemSlot, newValue, itemDBID)
	if (newValue and itemDBID) then		
		dbPoll(dbQuery(mysqlConnection, "UPDATE items SET item_value = ? WHERE id = ?", newValue, itemDBID), -1)
	end
end
addEvent("updateItemValue", true)
addEventHandler("updateItemValue", getRootElement(), updateItemValue)

function removeDutyItems(element)
	if not mysqlConnection then
		return
	end
	local playerItems = getElementItems(element, element, 0)
	for k, v in ipairs(playerItems["bag"]) do		
		if (tonumber(v["duty"]) >= 1) then
			deleteItem(element, element, v["ID"])
		end			
	end
	for k, v in ipairs(playerItems["key"]) do
		if (tonumber(v["duty"]) >= 1) then
			deleteItem(element, element, v["ID"])
		end			
	end
	for k, v in ipairs(playerItems["cards"]) do
		if (tonumber(v["duty"]) >= 1) then
			deleteItem(element, element, v["ID"])
		end			
	end
	getElementItems(element, element, 1)
end
addEvent("removeDutyItems", true)
addEventHandler("removeDutyItems", getRootElement(), removeDutyItems)

function takeAllItem(element, itemID, itemValue)
	if not mysqlConnection then
		return
	end
	local playerItems = getElementItems(element, element, 0)
	for k, v in ipairs(playerItems["bag"]) do		
		if (tonumber(v["id"]) == itemID) and (tonumber(v["value"]) == itemValue)then
			deleteItem(element, element, v["ID"])
		end			
	end
	for k, v in ipairs(playerItems["key"]) do
		if (tonumber(v["id"]) == itemID) and (tonumber(v["value"]) == itemValue) then
			deleteItem(element, element, v["ID"])
		end			
	end
	for k, v in ipairs(playerItems["cards"]) do
		if (tonumber(v["id"]) == itemID) and (tonumber(v["value"]) == itemValue) then
			deleteItem(element, element, v["ID"])
		end			
	end
	getElementItems(element, element, 1)
end
addEvent("takeAllItem", true)
addEventHandler("takeAllItem", getRootElement(), takeAllItem)

function deleteItem(playerSource, elementSource, itemDBID)
	if (elementSource and itemDBID) then	
		dbPoll(dbQuery(mysqlConnection, "DELETE FROM items WHERE id = ?", itemDBID), -1)
	end
end
addEvent("deleteItem", true)
addEventHandler("deleteItem", getRootElement(), deleteItem)

function takeWeaponFromPlayer(element)
	if not mysqlConnection then
		return
	end
	takeAllWeapons(element)
	setElementData(element, "Char->usingWeapon", {false, -1, -1, -1, -1, -1})
end
addEvent("takeWeaponFromPlayer", true)
addEventHandler("takeWeaponFromPlayer", getRootElement(), takeWeaponFromPlayer)

playerWeapons = {}

function checkWeapons(player, array)
	if array then
		if playerWeapons[player] then
			for k, v in ipairs(playerWeapons[player]) do
				if isElement(v[1]) then
					destroyElement(v[1])
				end
				playerWeapons[player] = {}
			end
		end
		for i=1, row * column do
			if array["bag"] and array["bag"][i] and tonumber(array["bag"][i]["id"] or -1) > -1 and weaponModels[array["bag"][i]["id"]] then
				local model_ID = weaponModels[array["bag"][i]["id"]][1]
				if not playerWeapons[player] then
					playerWeapons[player] = {}				
				end
									
				local obj = createObject(model_ID, 0, 0, 0)
				setObjectScale(obj, weaponModels[array["bag"][i]["id"]].scale)
				setElementCollisionsEnabled(obj, false)
				
				playerWeapons[player][#playerWeapons[player] + 1] = {obj, model_ID, item_id = array["bag"][i]["id"], slot = array["bag"][i]["slot"]}
			end
		end
	end
end
addEvent("Inventory->checkWeapons", true)
addEventHandler("Inventory->checkWeapons", getRootElement(), checkWeapons)


function getWeaponFromID(playerSource, wID)
	for k, v in ipairs(playerWeapons[playerSource]) do
		if (tonumber(v.model_ID) == tonumber(weaponModels[wID][1])) then
			return k
		end
	end
	return -1
end

addEventHandler("onPlayerQuit", root, function()
	for k, v in ipairs(getElementsByType("vehicle")) do
		if (getElementData(v, "Inventory->Vehicle->isOpened") or false) then
			if getElementData(v, "Inventory->Vehicle->opener_Player") == source then
				setElementData(v, "Inventory->Vehicle->opener_Player", nil)
				setElementData(v, "Inventory->Vehicle->isOpened", false)
			end
		end
	end
	if playerWeapons[source] then
		for k, v in ipairs(playerWeapons[source]) do
			if isElement(v[1]) then
				destroyElement(v[1])
			end
			playerWeapons[source] = {}
		end
	end
end)


function createNewItem(playerSource, elementSource, itemID, itemSlot, itemCount)
	if (itemID and itemSlot) then	
		local elementType = getTypeOfElement(elementSource)
		local elementOwnerID = tonumber(getElementData(elementSource, "ID"))
		local elementOwnerType = elementType[1]
		dbPoll(dbQuery(mysqlConnection, "INSERT INTO items SET item_id = ?, item_slot = ?, item_owner = ?, item_value = 1, item_count = ?, item_type = ?, item_duty = 0", itemID, itemSlot, elementOwnerID, itemCount, elementOwnerType), -1)
		if (elementSource == playerSource) then
			getElementItems(playerSource, elementSource, 2)
		end
		getElementItems(playerSource, elementSource, 1)
	end
end
addEvent("createNewItem", true)
addEventHandler("createNewItem", getRootElement(), createNewItem)

function tradeItem(playerSource, elementSource, activeElementSource, activeItem)
	if (playerSource and elementSource and activeItem) then
		local elementType = getTypeOfElement(elementSource)
		local itemDBID = activeItem["ID"]
		local elementOwnerID = tonumber(getElementData(elementSource, "ID"))
		local elementOwnerType = elementType[1]
		
		local pSlotState, pSlotID = getFreeSlot(elementSource, activeItem["id"])
		if (pSlotState and pSlotID) then
			if dbPoll(dbQuery(mysqlConnection, "UPDATE items SET item_type = ?, item_owner = ?, item_slot = ? WHERE id = ?", elementOwnerType, elementOwnerID, pSlotID, itemDBID), -1) then
				if (activeElementSource == playerSource) then
					getElementItems(playerSource, activeElementSource, 2)
				end
				local playerItems = getElementItems(elementSource, elementSource, 0)
				checkWeapons(elementSource, playerItems)
				getElementItems(playerSource, activeElementSource, 1)
			end
		end
		if elementOwnerType == "player" then
		elseif elementOwnerType == "vehicle" then
		elseif elementOwnerType == "object" then
		end
	end
end
addEvent("tradeItem", true)
addEventHandler("tradeItem", getRootElement(), tradeItem)

function getElementItemsWeight(element)
	local playerItems = getElementItems(element, element, 0)
	local bagWeight = 0
	local keyWeight = 0
	local cardsWeight = 0
	for i = 1, row * column do
		if (playerItems["bag"][i]) then
			bagWeight = bagWeight + (getItemWeight(playerItems["bag"][i]["id"]) * playerItems["bag"][i]["count"])
		end
	end
	for i = 1, row * column do
		if (playerItems["key"][i]) then
			keyWeight = keyWeight + (getItemWeight(playerItems["key"][i]["id"]) * playerItems["key"][i]["count"])
		end
	end
	for i = 1, row * column do
		if (playerItems["cards"][i]) then
			cardsWeight = cardsWeight + (getItemWeight(playerItems["cards"][i]["id"]) * playerItems["cards"][i]["count"])
		end	
	end
	return math.ceil(bagWeight + cardsWeight + keyWeight)
end

function hasItem(playerSource, itemID)
	if not mysqlConnection then
		return
	end
	local playerItems = getElementItems(playerSource, playerSource, 0)
	if playerItems then
		for i=1, (row*column) do
			if(playerItems["bag"][i] and tonumber(playerItems["bag"][i]["id"] or -1) > 0)then
				if tonumber(playerItems["bag"][i]["id"]) == itemID and tonumber(playerItems["bag"][i]["value"]) > 0 then
					return {true, i, playerItems["bag"][i]["value"]}
				end
			end
		end
		return {false, -1, 0}
	end
end
addEvent("hasItem", true)
addEventHandler("hasItem", getRootElement(), hasItem)

function giveItem(playerSource, itemID, itemValue, itemCount, itemDuty)
	if (playerSource and itemID and itemValue and itemCount and itemDuty) then
		local elementType = getTypeOfElement(playerSource)
		local elementOwnerID = tonumber(getElementData(playerSource, "ID"))
		local elementOwnerType = elementType[1]
		
		local pSlotState, pSlotID = getFreeSlot(playerSource, itemID)
		dbPoll(dbQuery(mysqlConnection, "INSERT INTO items ( item_id, item_slot, item_owner, item_value, item_count, item_type, item_duty) VALUES ( '"..itemID.."', '"..pSlotID.."', '"..elementOwnerID.."', '"..itemValue.."', '"..itemCount.."', '"..elementOwnerType.."', '"..itemDuty.."' )"), -1)
		getElementItems(playerSource, playerSource, 1)	
		getElementItems(playerSource, playerSource, 2)
	end
end
addEvent("giveItem", true)
addEventHandler("giveItem", root, giveItem)

addCommandHandler("enviaritem",
	function(playerSource, cmd, id, item, value, count,dutyitem, itemState)
		if getElementData(playerSource, "char.adminlevel") >= 5 then -- Administrador acima do nivel *5 podera usar a função
			if id and item and value and count and dutyitem then
				local targetPlayer, targetPlayerName = exports['vz_main']:findPlayerByPartialNick(playerSource, id)		
				if targetPlayer then
						if tonumber(item) == 1 then
							addPhone(targetPlayer)
						elseif tonumber(item) == 53 then
							addLaptop(targetPlayer)
						else
							giveItem(targetPlayer,tonumber(item),tostring(value),tonumber(count),tonumber(dutyitem))
						end
				end
			else
				outputChatBox("#4169E1[Use]:#ffffff /"..cmd.." [ID] [ItemID] [Quantidade] [DB] [Bloqueado [0=Não , 1=Sim]", playerSource,255,255,255,true)	
			end
		end
	end
)

function hasPlayerAmmo(playerSource, item_id)
	if not mysqlConnection then
		return
	end
		
	local playerItems = getElementItems(playerSource, playerSource, 0)
	if playerItems then
		for i=1, (row*column) do
			if(playerItems["bag"][i] and tonumber(playerItems["bag"][i]["id"] or -1) > 0)then
				if tonumber(playerItems["bag"][i]["id"]) == item_id and tonumber(playerItems["bag"][i]["value"]) > 0 then
					return {true, i, playerItems["bag"][i]["value"]}
				end
			end
		end
		return {false, -1, 0}
	end
end

function getFreeSlot(elementSource, forItemID)
	local playerItems = getElementItems(elementSource, elementSource, 0)
	local nextSlot = 1
	for i = 1, (row * column) do
		if not (playerItems[items[forItemID].typ][i]) then
			return true, nextSlot
		else
			nextSlot = nextSlot  + 1
		end
	end

	return false, -1
end

function loadCraftMarkers()
	for k,v in ipairs(craftMarkers) do
		local markers = createMarker(v[1],v[2],v[3]-1, "cylinder", 0.55,65, 105, 225,150)
		setElementDimension(markers,9)
		setElementInterior(markers,2)
		setElementData(markers, "craftMark", true)
		setElementData(markers, "craftMark:ID", k)
	end
	for k,v in ipairs(getElementsByType("vehicle")) do
		setElementData(v,"veh:use",false)
	end
end
addEventHandler("onResourceStart", resourceRoot, loadCraftMarkers)

function doorState(vehicle,typ)
	if typ == 1 then
		setVehicleDoorOpenRatio(vehicle,1,1,1200)
		setElementData(vehicle,"veh:use",true)
	else
		setVehicleDoorOpenRatio(vehicle,1,0,1200)
		setElementData(vehicle,"veh:use",false)
	end
end
addEvent("doorState", true)
addEventHandler("doorState", root, doorState)

function itemAnim(element, targetElement)
	setPedAnimation(element,"DEALER","DEALER_DEAL",3000,false,false,false,false)
	setPedAnimation(targetElement,"DEALER","DEALER_DEAL",3000,false,false,false,false)
end
addEvent("itemAnim", true)
addEventHandler("itemAnim", root, itemAnim)

function takeItem(playerSource,item)
	triggerClientEvent(playerSource,"takeItemServer",playerSource,item)
end

function onServerBikeLockStateChange(v)
	local lockState = tonumber(getElementData(v, "veh.locked")) or 0
	if lockState == 1 then
		setVehicleLocked(v, false)
		setElementData(v, "veh.locked", 0)
	else
		setElementData(v, "veh.locked", 1)
		setVehicleLocked(v, true)
	end
end
addEvent("onServerBikeLockStateChange", true)
addEventHandler("onServerBikeLockStateChange", root, onServerBikeLockStateChange)

addEvent("sendBugMessageToAdmins", true)
addEventHandler("sendBugMessageToAdmins", root, function(player)
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "char.adminlevel") or 0) >= 6 then
		end
	end
end)

local serverItemCache = {}
function loadPlayerItems(player)
	for i=0,31 do
		setElementData(player, "items"..i, 0)
	end
	serverItemCache[player] = {}
	local dbid = tonumber(getElementData(player, "ID"))
	dbQuery(
		function (queryHandler)
			local result, numAffectedRows, errorMsg = dbPoll(queryHandler, 0)
			if numAffectedRows > 0 then
				for k,row in pairs(result) do
					local slot = tonumber(row.slot) or -1
					local id = tonumber(row.id) or 0
					local item = tonumber(row.itemID) or 0
					local value = tostring(row.itemValue) or 0
					serverItemCache[player][#serverItemCache[player] + 1] = {item,value,slot,id}
				end
				triggerClientEvent(player, "onClientReceiveItems", player, serverItemCache[player])
			end
		end,
		connection,
		"SELECT * FROM items WHERE type = 1 AND owner = ?", dbid
	)
end
addEvent("loadPlayerItems",true)
addEventHandler("loadPlayerItems", getRootElement(), loadPlayerItems)