local gates =
{
	{ gate = createObject( 969,1682.46252441,-1949.327026367,7.22220659,0,0,0 ), offset = { -4,0, 0, 0, 0, 0 } },
	{ gate = createObject( 969,822.6,-1352.426147,-1.30,0,0,317 ), offset = { 0,0,-4, 0, 0, 0 } } 
}
mark1 = createMarker (830.45, -1357.33, 0.58, "cylinder", 1.5, 255, 255, 0, 0 )
mark2 = createMarker (1691.6123046875, -1948.1142578125, 8.24749374, "cylinder", 1.5, 255, 255, 0, 0 )
mark3 = createMarker (1689.4345703125, -1951.630859375, 8.2, "cylinder", 1.5, 255, 255, 0, 0 )
mark4 = createMarker (825.892578125, -1358.01171875, -0.5078125, "cylinder", 1.5, 255, 255, 0, 0 )
mark5 = createMarker (1754.50390625, -1935.767578125, 20.293449401, "cylinder",6, 255, 255, 0,0 )

ped1 =  createPed ( 71, 829.4208984375, -1359.095703125, -0.5078125)
ped2 =  createPed ( 71, 1692.0517578125, -1949.6142578125, 8.2479238)
setPedRotation (ped1,316.24 )
setPedRotation (ped1,1.277)
	
local function resetBusy( shortestID )
	gates[ shortestID ].busy = nil
end

local function closeDoor(shortestID )
	gate = gates[ shortestID ]
	local nx, ny, nz = getElementPosition( gate.gate )
	moveObject( gate.gate, 1000, nx - gate.offset[1], ny - gate.offset[2], nz - gate.offset[3], -gate.offset[4], -gate.offset[5], -gate.offset[6] )
	gate.busy = true
	gate.timer = nil
	setTimer( resetBusy, 1000, 1, shortestID )
	
end

local function openDoor(thePlayer)
		local shortest, shortestID, dist = nil, nil, 10
		local px, py, pz = getElementPosition(thePlayer)
		
		for id, gate in pairs(gates) do
			local d = getDistanceBetweenPoints3D(px,py,pz,getElementPosition(gate.gate))
			if d < dist then
				shortest = gate
				shortestID = id
				dist = d
			end
		end
		
		if shortest then
			if shortest.busy then
				return
			elseif shortest.timer then
				killTimer( shortest.timer )
				shortest.timer = nil
				outputChatBox( "The gate is already open!", thePlayer, 0, 255, 0 )
			else
				local nx, ny, nz = getElementPosition( shortest.gate )
				moveObject( shortest.gate, 1000, nx + shortest.offset[1], ny + shortest.offset[2], nz + shortest.offset[3], shortest.offset[4], shortest.offset[5], shortest.offset[6] )
				local message="presses a button on keypad reading 'Open Gate'."
				exports.chat:localizedMessage2(thePlayer, "Station guard ", message, 255, 51, 102, 13 )
				
			end
			shortest.timer = setTimer( closeDoor, 5000, 1, shortestID )
		end
	
end
--addCommandHandler("gate",openDoor)

function enter(player)
	if isElementWithinMarker(player,mark1) or isElementWithinMarker(player,mark2) then
		outputChatBox("The railway tracks are under construction. Please come later!",player,250,2,2)

		--if exports.global:takeMoney(player,10) then
			--openDoor(player)
		--else
			--outputChatBox("You need more cash!",player,255,0,0)
		--end
	end
end
addCommandHandler("pass",enter)
function exit(player)
		openDoor(player)
end
addEventHandler( "onMarkerHit",mark3, exit )
addEventHandler( "onMarkerHit",mark4, exit )

function kill(player)
		killPed(player)
		outputChatBox("You died by hitting electric barrier",player,255,255,255)
end
addEventHandler( "onMarkerHit",mark5, kill )



function MarkerHit( hitElement, matchingDimension )
        if getElementType( hitElement ) == "player" then
		local message="You need a pass to enter station.This will cost 10$ ((/pass))"
		exports.chat:localizedMessage2(hitElement, "Station guard: ", message, 255, 255, 255, 13 )	
         end
end
addEventHandler( "onMarkerHit",mark1, MarkerHit )
addEventHandler( "onMarkerHit",mark2, MarkerHit )