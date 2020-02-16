-- reverse carshop

local mysql = exports.mysql

local cOutsideCol = createColPolygon(
	-1880, -1659, -- dummy
	-1940, -1786,
	-1724, -1650,
	-1907, -1500,
	-1907, -1633,
	-1940, -1635)

local function showInformation(thePlayer, matching)
	if isElement(thePlayer) and matching and getElementType(thePlayer) == "player" then
		outputChatBox("Welcome to the Iron Monger!", thePlayer, 0, 255, 0)
		outputChatBox("We'd be pleased to crush your car - Head over to the ramp for more information.", thePlayer, 255, 194, 14)
	end
end
addEventHandler( "onColShapeHit", cOutsideCol, showInformation)

local function resetPrice(theVehicle, matching)
	if isElement(theVehicle) and matching and getElementType(theVehicle) == "vehicle" then
		if getElementData(theVehicle, "crushing") then
			exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "crushing")
			
			local thePlayer = getVehicleOccupant(theVehicle)
			if thePlayer then
				outputChatBox("Volte quando você pensar sobre isso!", thePlayer, 255, 194, 14)
			end
		end
	end
end
addEventHandler( "onColShapeLeave", cOutsideCol, resetPrice)
--

local vehiclecount = { }
local function countVehicles( )
	vehiclecount = {}
	for key, value in pairs( getElementsByType( "vehicle" ) ) do
		if isElement( value ) then
			local model = getElementModel( value )
			if vehiclecount[ model ] then
				vehiclecount[ model ] = vehiclecount[ model ] + 1
			else
				vehiclecount[ model ] = 1
			end
		end
	end
end

local function getVehiclePrice(theVehicle)
	local model = getElementModel(theVehicle)
	for k, v in ipairs(g_shops) do
		for key, value in ipairs(v) do
			if value[1] == model then
				return math.ceil(tonumber( value[2] or 0 + ( vehiclecount[ model ] * 600 )) / 300) * 100 -- 1/3 of the price, round to $100
				--return value[2] -- 100%
			end
		end
	end
	return 0
end

--

local cRampDown = createColSphere(-1880, -1659.15, 21.75, 3)
local pRampDown = createPickup(-1880, -1659.15, 21.75, 3, 1239)

local function showMoreInformation(thePlayer, matching)
	if isElement(thePlayer) and matching and getElementType(thePlayer) == "player" then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle and getVehicleOccupant(theVehicle) == thePlayer then -- player is driver
			if getElementData(theVehicle, "owner") == getElementData(thePlayer, "dbid") and getElementData(theVehicle,"rent")==0 then
				local price = getVehiclePrice(theVehicle)
				if getElementData(theVehicle, "requires.vehpos") then
					outputChatBox("I'm busy at the moment, come back later.", thePlayer, 255, 0, 0)
				elseif price == 0 then
					outputChatBox("This " .. getVehicleName(theVehicle) .. " ain't worth anything", thePlayer, 255, 0, 0 )
				else
					if getElementData(theVehicle, "crushing") then
						outputChatBox("My Price still stands - $" .. getElementData(theVehicle, "crushing") .. " for it.", thePlayer, 0, 255, 0)
					else
						outputChatBox("Hey, nice " .. getVehicleName(theVehicle) .. ", I could give you $" .. price .. " for it, alright?", thePlayer, 0, 255, 0)
						setElementData(theVehicle, "crushing", price, false)
					end
					outputChatBox("(( Drive the " .. getVehicleName(theVehicle) .. " up the ramp to crush it. ))", thePlayer, 255, 194, 14)
					outputChatBox("(( This will permanently delete your vehicle. ))", thePlayer, 255, 194, 14)
				end
			else
				outputChatBox("Got the Registration for that? Sorry, Bro', can't touch it then.", thePlayer, 255, 0, 0)
			end
		else
			outputChatBox("Come back when you've got a car to crush!", thePlayer, 255, 0, 0)
		end
	end
end
addEventHandler( "onColShapeHit", cRampDown, showMoreInformation)

--

local cRampUp = createColSphere(-1853, -1698, 40.8, 3)
local pRampUp = createPickup(-1853, -1698, 40.8, 3, 1274)

local function crushCar(thePlayer, matching)
	if isElement(thePlayer) and matching and getElementType(thePlayer) == "player" then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle and getVehicleOccupant(theVehicle) == thePlayer then -- player is driver
			if getElementData(theVehicle, "owner") == getElementData(thePlayer, "dbid") then
				local price = getElementData(theVehicle, "crushing")
				if price and price > 0 then
					local dbid = getElementData(theVehicle, "dbid")
					
					local result = mysql:query_free( "DELETE FROM vehicles WHERE id = " .. mysql:escape_string(dbid) )
					if result then
						exports.global:giveMoney(thePlayer, price)
						call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
						call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
						outputChatBox("You crushed your " .. getVehicleName(theVehicle) .. " for $" .. price .. ".", thePlayer, 0, 255, 0)
						
						-- just make sure admins/irc are informed (just in case, so he can't reclaim the vehicle)
						exports.global:sendMessageToAdmins("Removing vehicle #" .. dbid .. " (Crushed by " .. getPlayerName(thePlayer) .. ").")
						
						exports.logs:logMessage("[CRUSHER DELETE] Car #" .. dbid .. " was deleted by " .. getPlayerName(thePlayer), 9)
						
						destroyElement(theVehicle)
					else
						outputChatBox("Error 9004 - Report on Forums.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addEventHandler( "onColShapeHit", cRampUp, crushCar)
local blackmarker = 
createMarker(
 1359.63671875, -1670.3740234375, 12.296471786,"cylinder",2,0,22,222,230)
function MarkerHit( hitElement, matchingDimension )
        if getElementType( hitElement ) == "player" then
		local playerVehicle = getPedOccupiedVehicle (hitElement)
		if playerVehicle then
			
			local vehicleHealth = getElementHealth ( playerVehicle )
			vehicleHealth = math.floor(vehicleHealth)
			local message = "inspects vehicle's bodywork and number plate."
			exports.chat:localizedMessage2( source, "Dealer ", message, 255, 51, 102, 13 )
			if tonumber(getElementData(playerVehicle,"rent"))== 0 then
				local message = "This is not my car."
				exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
				return
			end
			if vehicleHealth>= 950 then
				
				local message="You want to return your vehicle to us? ((/unrentveh))"
				exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
			else
				local message="Vehicle is damaged.Repair it and come back.I don't want any scratch."
				exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
			end
		else
			
			local message = "smiles."
			exports.chat:localizedMessage2( source, "Dealer ", message, 255, 51, 102, 13 )
			local message="Bring the vehicle you want to unrent."
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
		end
         end
end
addEventHandler( "onMarkerHit",blackmarker, MarkerHit )
function blackcommand(thePlayer,command)
	if isElementWithinMarker(thePlayer,blackmarker) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle and getVehicleOccupant(theVehicle) == thePlayer then -- player is driver
			if getElementData(theVehicle, "owner") == getElementData(thePlayer, "dbid")  then
				
					if tonumber(getElementData(theVehicle,"rent"))== 0 then
						outputChatBox("LOL? You want to unrent your owned vehicle?",thePlayer,233,2,2)
						return
					end
					local vehicleHealth = getElementHealth(theVehicle)
					if vehicleHealth < 950 then
				
						local message="You still here? I am going to report to cops if you will not repair my car."
						exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )	
						return
					end
					local dbid = getElementData(theVehicle, "dbid")
					
					local result = mysql:query_free( "DELETE FROM vehicles WHERE id = " .. mysql:escape_string(dbid) )
					if result then
						call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
						call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
						outputChatBox("You returned your " .. getVehicleName(theVehicle) .. ".", thePlayer, 0, 255, 0)
						
						-- just make sure admins/irc are informed (just in case, so he can't reclaim the vehicle)
						exports.global:sendMessageToAdmins("Removing vehicle #" .. dbid .. " (Unrented by " .. getPlayerName(thePlayer) .. ").")
						
						exports.logs:logMessage("[UNRENT DELETE] Car #" .. dbid .. " was deleted by " .. getPlayerName(thePlayer), 9)
						
						destroyElement(theVehicle)
					else
						outputChatBox("Error 9004 - Report on Forums.", thePlayer, 255, 0, 0)
					end
				
			end
		end
	end
end
addCommandHandler("unrentveh",blackcommand)