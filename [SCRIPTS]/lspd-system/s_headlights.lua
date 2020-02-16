governmentVehicle = { [416]=true, [427]=true, [490]=true, [528]=true, [407]=true, [544]=true, [523]=true, [596]=true, [597]=true, [598]=true, [599]=true, [601]=true, [428]=true }
orangeVehicle = { [525]=true, [403]=true, [514]=true, [515]=true, [524]=true, [486]=true, [552]=true }

function vehicleBlown()
	exports['anticheat-system']:changeProtectedElementDataEx(source, "lspd:flashers", nil, true)
end
addEventHandler("onVehicleRespawn", getRootElement(), vehicleBlown)

function toggleFlasherState()
	if not (client) then
		return false
	end
	local theVehicle = getPedOccupiedVehicle(client)
	if not theVehicle then
		return false
	end
	
	if (theVehicle) then
		local vehicleModelID = getElementModel(theVehicle)
		local currentFlasherState = getElementData(theVehicle, "lspd:flashers") or 0
		
		if (governmentVehicle[vehicleModelID]) or (exports.global:hasItem(theVehicle, 61)) then
			-- LSPD Cars and beacons
			exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:flashers", 1-currentFlasherState, true)
		elseif orangeVehicle[vehicleModelID] then
			if currentFlasherState == 2 then
				exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:flashers", 0, true)
			else
				exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:flashers", 2, true)
			end
		else
			exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "lspd:flashers", 0, true)
		end
	end
end
addEvent( "lspd:toggleFlashers", true )
addEventHandler( "lspd:toggleFlashers", getRootElement(), toggleFlasherState )