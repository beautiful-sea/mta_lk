function vehicleBlown()
	exports['anticheat-system']:changeProtectedElementDataEx(source, "lspd:siren", false)
end
addEventHandler("onVehicleRespawn", getRootElement(), vehicleBlown)

function setSirenState(enabled)
	if not (client) then
		return false
	end
	local theVehicle = getPedOccupiedVehicle(client)
	if not theVehicle then
		return false
	end
	if not (exports.global:hasItem(theVehicle, 85)) then
		exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:siren", false)
	end
	exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:siren", enabled)
	
	return true
end
addEvent( "lspd:setSirenState", true )
addEventHandler( "lspd:setSirenState", getRootElement(), setSirenState )