local blip, endblip
local jobstate = 0
local route = 0
local oldroute = -1
local marker, endmarker
local pizzaStopTimer = nil

local localPlayer = getLocalPlayer()

local routes = {
	{ 2281.59863, -1644.55884, 15.24396 },
	{ 2511.55200, -1689.21130, 13.54460 },
	{ 2508.22705, -2000.57373, 13.54688 },
	{ 2646.95483, -2021.75110, 13.54688 },
	{ 2784.57397, -1926.11304, 13.54688 },
	{ 2853.23438, -1330.26257, 11.06950 },
	{ 2756.23682, -1180.78833, 69.39526 },
	{ 2475.86426, -1369.82959, 28.83464 },
	{ 2309.38403, -1719.61121, 14.26524 },
	{ 2071.82983, -1703.04016, 13.55468 },
	{ 1894.86719, -2059.23853, 13.54688 },
	{ 1684.78894, -2100.71216, 13.83432 },
	{ 1248.42285, -902.01392, 42.88281 },
	{ 1171.25415, -1100.62280, 25.15855 },
	{ 685.47058, -1418.42712, 14.06982 },
	{ 807.08441, -1456.31519, 13.54099 },
	{ 315.97827, -1773.75916, 4.72966 },
	{ 192.31653, -1307.86328, 70.30926 },
	{ 814.19006, -767.29242, 76.83934 }, 
	{ 1090.54321, -787.43042, 107.30646 },
	{ 2198.01221, -1005.82684, 62.32243 },
	{ 2570.57959, -1029.48059, 69.58233 },
	{ 2105.62720, -1244.48181, 25.17283 },
	{ 1910.19934, -1120.66370, 25.90341 },
	{ 993.49188, -1046.18835, 30.81641 },
	{ 706.46979, -1699.75696, 3.44754 },
	{ 739.24542, -589.46973, 17.07691 },
	{ 1849.42224, -1924.71802, 13.54688 }}
local pizza = { [448] = true }

function resetPizzaJob()
	jobstate = 0
	oldroute = -1
	
	if (isElement(marker)) then
		destroyElement(marker)
		marker = nil
	end
	
	if (isElement(blip)) then
		destroyElement(blip)
		blip = nil
	end
	
	if (isElement(endmarker)) then
		destroyElement(endmarker)
		endmarker = nil
	end
	
	if (isElement(endcolshape)) then
		destroyElement(endcolshape)
		endcolshape = nil
	end
	
	if (isElement(endblip)) then
		destroyElement(endblip)
		endblip = nil
	end
	
	if pizzaStopTimer then
		killTimer(pizzaStopTimer)
		deliveryStopTimer = nil
	end
end
addEventHandler("onClientChangeChar", getRootElement(), resetPizzaJob)

function displayPizzaJob(notext)
	if (jobstate==0) then
		jobstate = 1
		blip = createBlip(2125.96143, -1787.66370, 13.55469, 51, 2, 255, 127, 255)
		
		if not notext then
			outputChatBox("#FF9933Approach the #CCCCCCblip#FF9933 on your radar and get on a bike to start your job.", 255, 194, 15, true)
		end
	end
end

addEvent("restorePizzaJob", true)
addEventHandler("restorePizzaJob", getRootElement(), function() displayPizzaJob(true) end )


function startPizzaJob(routeid)
	if (jobstate==1) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
			outputChatBox("#FF9933Drive to the #FFFF00blip#FF9933 to complete your first pizza delivery.", 255, 194, 15, true)
			outputChatBox("#FF9933Remember to #FFFF00follow the street rules#FF9933.", 255, 194, 15, true)
			outputChatBox("#FF9933If your bike is #FFFF00damaged#FF9933, the customers may pay less or refuse to accept the delivery.", 255, 194, 15, true)
			outputChatBox("#FF9933Your wage is bound to this bike, #FFFF00don't lose it#FF9933!", 255, 194, 15, true)
			destroyElement(blip)
			
			local rand = math.random(1, #routes)
			
			if not (routeid == -1) then
				rand = routeid
			else
				
			end
			route = routes[rand]
			local x, y, z = route[1], route[2], route[3]
			blip = createBlip(x, y, z, 0, 2, 255, 200, 0)
			marker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
			addEventHandler("onClientMarkerHit", marker, waitAtPizza)
							
			jobstate = 2
			oldroute = rand
			if (routeid == -1) then
				triggerServerEvent("updateNextCheckpoint", localPlayer, vehicle, rand)
			end
		else
			outputChatBox("You must be on a bike to start this job.", 255, 0, 0)
		end
	end
end

addEvent("startPizzaJob", true)
addEventHandler("startPizzaJob", getRootElement(), startPizzaJob)

function waitAtPizza(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if thePlayer == localPlayer and vehicle and getVehicleController(vehicle) == localPlayer and bike[getElementModel(vehicle)] then
		if getElementHealth(vehicle) < 350 then
			outputChatBox("You need to get your bike repaired.", 255, 0, 0)
		else
			deliveryStopTimer = setTimer(nextDeliveryCheckpoint, 5000, 1)
			outputChatBox("#FF9933Wait a moment while your delivery is collected.", 255, 0, 0, true )
			addEventHandler("onClientMarkerLeave", marker, checkWaitAtPizza)
		end
	end
end

function checkWaitAtPizza(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and thePlayer == localPlayer and getVehicleController(vehicle) == localPlayer and bike[getElementModel(vehicle)] then
		if getElementHealth(vehicle) >= 350 then
			outputChatBox("You did not wait at the collection point.", 255, 0, 0)
			if deliveryStopTimer then
				killTimer(pizzaStopTimer)
				pizzaStopTimer = nil
			end
			removeEventHandler("onClientMarkerLeave", source, checkWaitAtPizza)
		end
	end
end

function nextPizzaCheckpoint()
	pizzaStopTimer = nil
	if jobstate == 2 or jobstate == 3 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
			destroyElement(marker)
			destroyElement(blip)
			
			vehicleid = tonumber( getElementData(vehicle, "dbid") )
			
			local health = getElementHealth(vehicle)
			if health >= 975 then
				pay = 60 -- bonus: $60
			elseif health >= 800 then
				pay = 50
			elseif health >= 350 then
				-- 350 (black smoke) to 800, round to $5
				pay = math.ceil( 10 * ( health - 300 ) / 500 ) * 5
			else
				pay = 0
			end
			spawnFinishMarkerPizzaJob()
			triggerServerEvent("savePizzaProgress", localPlayer, vehicle, pay)
			
		else
			outputChatBox("#FF9933You must be on a bike to complete deliveries.", 255, 0, 0, true ) -- Wrong car type.
		end
	end
end

function spawnFinishMarkerPizzaJob()
	if jobstate == 2 then
		-- no final checkpoint set yet
		endblip = createBlip(2125.96143, -1787.66370, 13.55469, 0, 2, 255, 0, 0)
		endmarker = createMarker(2125.96143, -1787.66370, 13.55469, 4, 255, 0, 0, 150)
		setMarkerIcon(endmarker, "finish")
		addEventHandler("onClientMarkerHit", endmarker, endPizza)
	end
	jobstate = 3
end

addEvent("spawnFinishMarkerPizzaJob", true)
addEventHandler("spawnFinishMarkerPizzaJob", getRootElement(), spawnFinishMarkerPizaJob)

function loadNewCheckpointPizzaJob()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	-- next drop off
	local rand = -1
	repeat
		rand = math.random(1, #routes)
	until oldroute ~= rand and getDistanceBetweenPoints2D(routes[oldroute][1], routes[oldroute][2], routes[rand][1], routes[rand][2]) > 250
	route = routes[rand]
	oldroute = rand
	local x, y, z = route[1], route[2], route[3]
	blip = createBlip(x, y, z, 0, 2, 255, 200, 0)
	marker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
	addEventHandler("onClientMarkerHit", marker, waitAtDelivery)
	triggerServerEvent("updateNextCheckpoint", localPlayer, vehicle, rand)
end

addEvent("loadNewCheckpointPizzaJob", true)
addEventHandler("loadNewCheckpointPizzaJob", getRootElement(), loadNewCheckpointPizzaJob)

function endPizza(thePlayer)
	if thePlayer == localPlayer then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		local id = getElementModel(vehicle) or 0
		if not vehicle or getVehicleController(vehicle) ~= localPlayer or not (pizza[id]) then
			outputChatBox("#FF9933You must be on a bike to complete deliveries.", 255, 0, 0, true ) -- Wrong car type.
		else
			local health = getElementHealth(vehicle)
			if health <= 700 then
				outputChatBox("This bike is damaged, fix it first.", 255, 194, 15)
			else
				triggerServerEvent("givePizzaMoney", localPlayer, vehicle)
				resetPizzaJob()
				displayPizzaJob(true)
			end
		end
	end
end
