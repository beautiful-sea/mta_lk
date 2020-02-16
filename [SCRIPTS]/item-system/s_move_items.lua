local function canAccessElement( player, element )
	if getElementType( element ) == "vehicle" then
		if not isVehicleLocked( element ) then
			return true
		else
			local veh = getPedOccupiedVehicle( player )
			local inVehicle = getElementData( player, "realinvehicle" )
			
			if veh == element and inVehicle == 1 then
				return true
			elseif veh == element and inVehicle == 0 then
				outputDebugString( "canAcccessElement failed (hack?): " .. getPlayerName( player ) .. " on Vehicle " .. getElementData( element, "dbid" ) )
				return false
			else
				outputDebugString( "canAcccessElement failed (locked): " .. getPlayerName( player ) .. " on Vehicle " .. getElementData( element, "dbid" ) )
				return false
			end
		end
	else
		return true
	end
end

--

local function openInventory( element, ax, ay )
	if canAccessElement( source, element ) then
		outputChatBox("openInventory")
		triggerEvent( "subscribeToInventoryChanges", source, element )
		triggerClientEvent( source, "openElementInventory", element, ax, ay )
	end
end

addEvent( "openFreakinInventory", true )
addEventHandler( "openFreakinInventory", getRootElement(), openInventory )

--

local function closeInventory( element )
	triggerEvent( "unsubscribeFromInventoryChanges", source, element )
end

addEvent( "closeFreakinInventory", true )
addEventHandler( "closeFreakinInventory", getRootElement(), closeInventory )

--

local function output(from, to, itemID)
	if from ~= to and getElementType(from) == "player" and getElementType(to) == "player" then
		exports.global:sendLocalMeAction( from, "deu para" .. getPlayerName( to ):gsub("_", " ") .. " a " .. getItemName( itemID ) .. "." )
	end
end

--

local function moveToElement( element, slot, ammo, event )
	if not canAccessElement( source, element ) then
		return
	end
	
	local name = getElementModel( element ) == 2147 and "Fridge" or getElementModel(source) == 3761 and "Shelf" or ( getElementType( element ) == "vehicle" and "Vehicle" or ( getElementType( element ) == "player" and "Player" or "Safe" ) )
			
	if not ammo then
		local item = getItems( source )[ slot ]
		outputChatBox(item[1])
		if item then
			if not hasSpaceForItem( element, item[1] ) then
				outputChatBox( "O inventário está cheio.", source, 255, 0, 0 )
			else
				if getElementType( element ) == "object" then -- safe
					if ( getElementDimension( element ) < 19000 and ( item[1] == 4 or item[1] == 5 ) and getElementDimension( element ) == item[2] ) or ( getElementDimension( element ) >= 20000 and item[1] == 3 and getElementDimension( element ) - 20000 == item[2] ) then -- keys to that safe as well
						if countItems( source, item[1], item[2] ) < 2 then
							outputChatBox("Você não pode colocar sua única chave aqui.", source, 255, 0, 0)
							triggerClientEvent( source, event or "finishItemMove", source )
							return
						end
					end
				end
			
				local success, reason = moveItem( source, element, slot )
				if not success then
					outputChatBox( "Falha ao mover: " .. tostring( reason ), source, 255, 0, 0 )
				else
					exports.logs:logMessage( getPlayerName( source ) .. "->" .. name .. " #" .. getElementID(element) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
					output(source, element, item[1])
					
					if name and not (name == "Player" or name == "player") then
						if(name == "Vehicle") then
							name = "veículo"
						end
						exports.global:sendLocalMeAction(source,"colocou ".. getItemName( item[1] ) .." no "..name..".")
					end
				end
			end
		end
	else
		if not ( ( slot == -100 and hasSpaceForItem( element, slot ) ) or ( slot > 0 and hasSpaceForItem( element, -slot ) ) ) then
			outputChatBox( "O inventário está cheio.", source, 255, 0, 0 )
		else
			if tonumber(getElementData(source, "duty")) > 0 then
				outputChatBox("You can't put your weapons in a " .. name .. " while being on duty.", source, 255, 0, 0)
			elseif tonumber(getElementData(source, "job")) == 4 and slot == 41 then
				outputChatBox("You can't put this spray can into a " .. name .. ".", source, 255, 0, 0)
			else
				if slot == -100 then
					local ammo = math.ceil( getPedArmor( source ) )
					if ammo > 0 then
						setPedArmor( source, 0 )
						giveItem( element, slot, ammo )
						exports.logs:logMessage( getPlayerName( source ) .. "->" .. name .. " #" .. getElementID(element) .. " - " .. getItemName( slot ) .. " - " .. ammo, 17)
						output(source, element, -100)
					end
				else
					exports.global:takeWeapon( source, slot )
					if ammo > 0 then
						giveItem( element, -slot, ammo )
						exports.logs:logMessage( getPlayerName( source ) .. "->" .. name .. " #" .. getElementID(element) .. " - " .. getItemName( -slot ) .. " - " .. ammo, 17)
						output(source, element, -slot)
					end
				end
			end
		end
	end
	triggerClientEvent( source, event or "finishItemMove", source )
end

addEvent( "moveToElement", true )
addEventHandler( "moveToElement", getRootElement(), moveToElement )

--

local function moveWorldItemToElement( item, element )
	if not isElement( item ) or not isElement( element ) or not canAccessElement( source, element ) then
		return
	end
	
	local id = getElementData( item, "id" )
	local itemID = getElementData( item, "itemID" )
	local itemValue = getElementData( item, "itemValue" )
	local name = getElementModel( element ) == 2147 and "Fridge" or getElementModel(source) == 3761 and "Shelf" or ( getElementType( element ) == "vehicle" and "Vehicle" or ( getElementType( element ) == "player" and "Player" or "Safe" ) )
	
	if giveItem( element, itemID, itemValue ) then
		output(source, element, itemID)
		exports.logs:logMessage( getPlayerName( source ) .. " put item #" .. id .. " (" .. itemID .. ":" .. getItemName( itemID ) .. ") - " .. itemValue .. " in " .. name .. " #" .. getElementID(element), 17)
		mysql_free_result( mysql_query(handler, "DELETE FROM worlditems WHERE id='" .. id .. "'") )
		
		while #getItems( item ) > 0 do
			moveItem( item, element, 1 )
		end
		destroyElement( item )
	else
		outputChatBox( "O inventário está cheio.", source, 255, 0, 0 )
	end
end

addEvent( "moveWorldItemToElement", true )
addEventHandler( "moveWorldItemToElement", getRootElement(), moveWorldItemToElement )

--

local function moveFromElement( element, slot, ammo, index )
	if not canAccessElement( source, element ) then
		return
	end
	
	local name = getElementModel( element ) == 2147 and "Fridge" or getElementModel(source) == 3761 and "Shelf" or ( getElementType( element ) == "vehicle" and "Vehicle" or "Safe" )
	
	local item = getItems( element )[slot]
	if item and item[3] == index then
		if item[1] > 0 then
			moveItem( element, source, slot )
			
			exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
			if name then
				exports.global:sendLocalMeAction(source,"takes out a ".. getItemName( item[1] ) .." from "..name..".")
			end
		elseif item[1] == -100 then
			local armor = math.max( 0, ( ( getElementData( source, "faction" ) == 1 or ( getElementData( source, "faction" ) == 3 and ( getElementData( source, "factionrank" ) == 4 or getElementData( source, "factionrank" ) == 5 or getElementData( source, "factionrank" ) == 13 ) ) ) and 100 or 50 ) - math.ceil( getPedArmor( source ) ) )
			
			if armor == 0 then
				outputChatBox( "You can't wear any more armor.", source, 255, 0, 0 )
			else
				takeItemFromSlot( element, slot )
				
				local leftover = math.max( 0, item[2] - armor )
				if leftover > 0 then
					giveItem( element, item[1], leftover )
				end
				
				setPedArmor( source, math.ceil( getPedArmor( source ) + math.min( item[2], armor ) ) )
				exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. ( math.min( item[2], armor ) ), 17)
			end
			triggerClientEvent( source, "forceElementMoveUpdate", source )
		else
			takeItemFromSlot( element, slot )
			if ammo < item[2] then
				exports.global:giveWeapon( source, -item[1], ammo )
				giveItem( element, item[1], item[2] - ammo )
				exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. ( item[2] - ammo ), 17)
			else
				exports.global:giveWeapon( source, -item[1], item[2] )
				exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
			end
			triggerClientEvent( source, "forceElementMoveUpdate", source )
		end
	elseif item then
		outputDebugString( "Index mismatch: " .. tostring( item[3] ) .. " " .. tostring( index ) )
	end
	triggerClientEvent( source, "finishItemMove", source )
end

addEvent( "moveFromElement", true )
addEventHandler( "moveFromElement", getRootElement(), moveFromElement )