enginelessVehicle = { [510]=true, [509]=true, [481]=true }

-- draw the odometer as soon as the player enters the car.
function showOdometer( theVehicle, seat )
	 if ( guiGetVisible (odometer ) == false) then
		local id = getElementModel(theVehicle)
		if (seat < 2) then
			if not (enginelessVehicle[id]) then -- If the vehicle has an engine.
				local x, y = guiGetScreenSize()
				
				local vehicle = getPedOccupiedVehicle(getLocalPlayer())
				local km = getElementData(vehicle, "odometer")
				
				local km = math.floor(km/1000)
				local odoKM = string.format("%07d", km)
				odometer = guiCreateLabel(x-138, y-215, 200, 200, tostring(odoKM), false)
				guiSetFont(odometer, "default-bold-small")
				
				kilo = guiCreateLabel(x-122, y-202, 200, 200, "km", false)
				guiSetFont(kilo, "default-bold-small")
			end	
		end	
	end
end
addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(), showOdometer)

-- hide the odometer as soon as the player exits the car.		
function hideOdometer( )
	if not (isVehicleLocked(source)) then
		setTimer( -- So that the odometer doesn't disappear as soon as you press 'F'.
		function()
			if (odometer) then
				destroyElement(odometer)
				odometer = nil
			end
			if (kilo) then
				destroyElement(kilo)
				kilo = nil
			end
		end, 1700, 1)	
	end	
end
addEventHandler("onClientVehicleStartExit", getLocalPlayer(), hideOdometer)	

-- update the odometer as the player moves in his vehicle.
function updateOdometer( currentKilometers )
	 if ( guiGetVisible ( odometer ) == true ) then
		local currentKilometers = math.floor(currentKilometers/1000)
		local odoKM = string.format("%07d", currentKilometers)
		guiSetText(odometer, tostring(odoKM))
	end
end
addEvent("updateOdo", true)
addEventHandler("updateOdo", getLocalPlayer(), updateOdometer)

-- remove the odometer if the player is not a in a vehicle but he is still seeing it.
function removeOdometer()
	if not (isPedInVehicle(getLocalPlayer())) then
		if (odometer) then
			destroyElement(odometer)
			odometer = nil
		end
		if (kilo) then
			destroyElement(kilo)
			kilo = nil
		end
	end
end
setTimer(removeOdometer, 50, 0)