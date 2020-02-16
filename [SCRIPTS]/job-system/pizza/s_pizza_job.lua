local lockTimer = nil
local pizzaruns = { }
local pizzawage = { }
local pizzaroute = { }
local pizza = { [448] = true }

function givePizzaMoney(vehicle)
	outputChatBox("You earned $" .. ( pizzawage[vehicle] or 0 ) .. " on your pizza delivery stops.", source, 255, 194, 15)
	exports.global:giveMoney(source, pizzawage[vehicle] or 0)

	if (pizzawage[vehicle] > 1500) then
		triggerPizzaCheatEvent(thePlayer, 2, pizzawage[vehicle])
	end
	
	-- respawn the vehicle
	exports['anticheat-system']:changeProtectedElementDataEx(source, "realinvehicle", 0, false)
	removePedFromVehicle(source, vehicle)
	respawnVehicle(vehicle)
	setVehicleLocked(vehicle, false)
	setElementVelocity(vehicle,0,0,0)
	
	-- reset runs/wage
	pileruns[vehicle] = nil
	pilewage[vehicle] = nil
end
addEvent("givePizzaMoney", true)
addEventHandler("givePizzaMoney", getRootElement(), givePizzaMoney)


function checkPizzaEnterVehicle(thePlayer, seat)
	if getElementData(source, "owner") == -2 and getElementData(source, "faction") == -1 and seat == 0 and pizza[getElementModel(source)] and getElementData(thePlayer,"job") == 9 then
		triggerClientEvent(thePlayer, "startPizzaJob", thePlayer, pizzaroute[source] or -1)
		if (pizzaruns[vehicle] ~= nil) and (pizzawage[vehicle] > 0) then
			triggerClientEvent(thePlayer, "spawnFinishMarkerPizzaJob", thePlayer)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), checkPizzaEnterVehicle)

function startEnterPizza(thePlayer, seat, jacked) 
	if seat == 0 and pizza[getElementModel(source)] and getElementData(thePlayer,"job") == 9 and jacked then -- if someone try to jack the driver stop him
		if isTimer(lockTimer) then
			killTimer(lockTimer)
			lockTimer = nil
		end
		setVehicleLocked(source, true)
		lockTimer = setTimer(setVehicleLocked, 5000, 1, source, false)
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), startEnterPizza)

function savePizzaProgress(vehicle, earned)
	if (pizzaruns[vehicle] == nil) then
		pizzaruns[vehicle] = 0
		pizzawage[vehicle] = 0
	end
	
	pizzaruns[vehicle] = pizzaruns[vehicle] + 1
	pizzawage[vehicle] = pizzawage[vehicle] + earned
	
	outputChatBox("You completed your " .. pizzaruns[vehicle] .. ".  delivery on in this bike and earned $" .. earned .. ".", client, 0, 255, 0)
	if (earned > 60) then
		triggerPizzaCheatEvent(client, 1, earned)
	end
	
	if (pizzaruns[vehicle] == 4) then
		outputChatBox("#FF9933You have no more pizzas to deliver, return to the #CC0000restaurant #FF9933first.", client, 0, 0, 0, true)
	else 
		outputChatBox("#FF9933You can now either return to the #CC0000restaurant #FF9933and obtain your wage", client, 0, 0, 0, true)
		outputChatBox("#FF9933or continue onto the next #FFFF00drop off point#FF9933 and increase your wage.", client, 0, 0, 0, true)
		triggerClientEvent( client, "loadNewCheckpointPizzaJob",  client)
		triggerEvent("updateGlobalSupplies", client, math.random(10,20))
	end
end
addEvent("savePizzaProgress", true)
addEventHandler("savePizzaProgress", getRootElement(), savePizzaProgress)

function triggerPizzaCheatEvent(thePlayer, cheatType, value1)
	local cheatStr = ""
	if (cheatType == 1) then
		cheatStr = "Too much earned on one pizza stop, (c:"..value1..", max 60)"
	elseif (cheatType == 2) then
		cheatStr = "Too much earned in total. (c:"..value1..", max 1500)"
	end
	exports.logs:logMessage("[savePizzaProgress]".. getPlayerName(thePlayer) .. " " .. getPlayerIP(thePlayer) .. " ".. cheatStr  , 32)
end

function updateNextCheckpoint(vehicle, pointid)
	pizzaroute[vehicle] = pointid
end
addEvent("updateNextCheckpoint", true)
addEventHandler("updateNextCheckpoint", getRootElement(), updateNextCheckpoint)

function restorePizzaJob()
	if getElementData(source, "job") == 9 then
		triggerClientEvent(source, "restorePizzaJob", source)
	end
end
addEventHandler("restoreJob", getRootElement(), restorePizzaJob)
