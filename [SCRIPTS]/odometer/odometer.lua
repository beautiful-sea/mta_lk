-- start the odometer and make a table when the player enters the vehicle.
function startOdometerOnEnter( theVehicle, seat )
	if (seat < 2) then
		startOdometer( )
		odometer_table = { }
	end	
end
addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(), startOdometerOnEnter)

-- kilometer count...
function startOdometer( )
	if (isPedInVehicle(getLocalPlayer())) then
		if (isTimer(addTimer)) then
			killTimer(addTimer)
		end
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		currX, currY, currZ = getElementPosition(vehicle)
		addTimer = setTimer(getNewPosition, 1000, 0, vehicle)
	end
end
addCommandHandler("startOdo", startOdometer)	

-- get the new position after every 1 second.
function getNewPosition( vehicle )
	if (isElement(vehicle)) then
		local newX, newY, newZ = getElementPosition(vehicle)
		local distanceTravelled = getDistanceBetweenPoints3D(currX, currY, currZ, newX, newY, newZ)
		local accurateMeters = distanceTravelled
		local approximateMeters = math.floor(accurateMeters)
		odometer_table = approximateMeters
		local newValue = odometer_table
		updateOdometerOfVehicle( vehicle, newValue )
		currX, currY, currZ = nil
		if (isTimer(addTimer)) then
			killTimer(addTimer)
		end
		odometer_table = nil
		startOdometer( ) 
	end
end	

-- update the vehicle's odometer, by adding the distance travelled, to it.
function updateOdometerOfVehicle( vehicle, newValue )
	local newValue = tonumber(newValue)
	local vehicleOdometer = getElementData(vehicle, "odometer")
	local vehicleOdometer = tonumber(vehicleOdometer)
	triggerServerEvent("updateVehicleOdometer", getLocalPlayer(), vehicle, vehicleOdometer + newValue)
	triggerEvent("updateOdo", getLocalPlayer(), vehicleOdometer + newValue) 
end

-- remove the timer and destroy the table as soon as the player exits the vehicle.
function removeTimer( )
	if (isTimer(addTimer)) then
		killTimer(addTimer)
	end
	odometer_table = nil
end	
addEventHandler("onClientPlayerVehicleExit", getLocalPlayer(), removeTimer )
	