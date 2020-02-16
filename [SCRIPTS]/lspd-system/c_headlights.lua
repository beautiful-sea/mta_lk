local flashingVehicles = { }

function bindKeys(res)
	bindKey("p", "down", toggleFlashers)
	
	for key, value in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(value) then
			local flasherState = getElementData(value, "lspd:flashers")
			if flasherState and flasherState > 0 then
				flashingVehicles[value] = true
			end
		end
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), bindKeys)

function toggleFlashers()
	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	
	if (theVehicle) then
		triggerServerEvent("lspd:toggleFlashers", theVehicle)
	end
end

function streamIn()
	if getElementType( source ) == "vehicle" and getElementData( source, "lspd:flashers" ) then
		local flasherState = getElementData(source, "lspd:flashers")
		if flasherState and flasherState > 0 then
			flashingVehicles[source] = true
		end
	end
end
addEventHandler("onClientElementStreamIn", getRootElement(), streamIn)

function streamOut()
	if getElementType( source ) == "vehicle" then
		flashingVehicles[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", getRootElement(), streamOut)

function updateSirens( name )
	if name == "lspd:flashers" and isElementStreamedIn( source ) and getElementType( source ) == "vehicle" then
		local flasherState = getElementData(source, "lspd:flashers")
		if flasherState and flasherState > 0 then
			flashingVehicles[source] = true
		else
			flashingVehicles[source] = false
		end
	end
end
addEventHandler("onClientElementDataChange", getRootElement(), updateSirens)

function doFlashes()
	for veh in pairs(flashingVehicles) do
		if not (isElement(veh)) then
			flashingVehicles[veh] = nil
		else
			local flasherState = getElementData(veh, "lspd:flashers")
			if flasherState and flasherState == 0 then
				flashingVehicles[veh] = nil
				setVehicleHeadLightColor(veh, 255, 255, 255)
				setVehicleLightState(veh, 0, 0)
				setVehicleLightState(veh, 1, 0)
				setVehicleLightState(veh, 2, 0)
				setVehicleLightState(veh, 3, 0)
			else
				local state = getVehicleLightState(veh, 0)
				if flasherState == 2 then
					setVehicleHeadLightColor(veh, 128, 64, 0)
				else
					if (state==0) then
						setVehicleHeadLightColor(veh, 0, 0, 255)
					else
						setVehicleHeadLightColor(veh, 255, 0, 0)
					
					end
				end
				setVehicleLightState(veh, 0, 1-state)
				setVehicleLightState(veh, 1, state)
				setVehicleLightState(veh, 2, 1-state)
				setVehicleLightState(veh, 3, state)
			end
		end		
	end
end
setTimer(doFlashes, 200, 0)