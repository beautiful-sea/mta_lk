function cmdHandbrake(sourcePlayer)
	if isPedInVehicle ( sourcePlayer ) and (getElementData(sourcePlayer,"realinvehicle") == 1)then
		local playerVehicle = getPedOccupiedVehicle ( sourcePlayer )
		if (getVehicleOccupant(playerVehicle, 0) == sourcePlayer) then
			local handbrake = getElementData(playerVehicle, "handbrake")
			if (handbrake == 0) then
				if isVehicleOnGround(playerVehicle) or getVehicleType(playerVehicle) == "Boat" then
					exports['anticheat-system']:changeProtectedElementDataEx(playerVehicle, "handbrake", 1, false)
					setElementFrozen(playerVehicle, true)
					outputChatBox("Handbrake has been applied.", sourcePlayer)
				else
					outputChatBox("You can only apply the handbrake when your vehicle is on the ground.", sourcePlayer)
				end
			else
				exports['anticheat-system']:changeProtectedElementDataEx(playerVehicle, "handbrake", 0, false)
				setElementFrozen(playerVehicle, false) 
				outputChatBox("Handbrake has been released.", sourcePlayer)
			end
		else
			outputChatBox("You need to be an driver to control the handbrake...", sourcePlayer, 255, 0, 0)
		end
	else
		outputChatBox("Ahum, how would you apply a handbrake without a vehicle...", sourcePlayer, 255, 0, 0)
	end
end
addCommandHandler("handbrake", cmdHandbrake)
addEvent("handbrake",true)
addEventHandler("handbrake",getRootElement(),cmdHandbrake)