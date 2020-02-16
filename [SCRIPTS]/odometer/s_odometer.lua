mysql = exports.mysql
-- update the vehicle's 'odometer' element data as the player moves.
function updateTheElementData( vehicle, value )
	if (isElement(vehicle)) then
		local value = tonumber(value)
		
		exports['anticheat-system']:changeProtectedElementDataEx(vehicle, "odometer", value, true)
	end
end
addEvent("updateVehicleOdometer", true)
addEventHandler("updateVehicleOdometer", getRootElement(), updateTheElementData)

function updateonexit(thePlayer)
		local vehID = getElementData(source, "dbid")
		local km = getElementData(source, "odometer")
		mysql:query_free("UPDATE vehicles SET odometer = '"..km.."' WHERE id = " .. vehID .. "")	
end
addEventHandler("onVehicleExit",getRootElement(),updateonexit)
-- /RESETALLODO - resets all the odometers on the server.	
function applyData( thePlayer, commandName )
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		for key, vehicles in ipairs (getElementsByType("vehicle")) do
			exports['anticheat-system']:changeProtectedElementDataEx(vehicles, "odometer", 0, true)
		end
		outputChatBox("Odometer Added.", thePlayer, 255, 194, 14)
	end	
end
addCommandHandler("resetallodo", applyData)

--/ODO - get the distance the vehicle has travelled so far (meters).	
function getTravelled( thePlayer )
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if (isPedInVehicle(thePlayer)) then
			local vehicle = getPedOccupiedVehicle(thePlayer)
			local travelled = getElementData(vehicle, "odometer")
			outputChatBox("This vehicle has travelled "..tonumber(travelled).." meters.", thePlayer, 255, 194, 14)
		end
	end	
end
addCommandHandler("odo", getTravelled)	