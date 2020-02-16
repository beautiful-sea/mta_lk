local pdgates = 
{
	{
		{ createObject(1495,285.148,145.57,1026.1857910156,0,0,0), 90 }
	},
	{
		{ createObject(1495,292.52,116.18,1031.99,0,0,180), -90 }
	},
	{
		{ createObject(1495,290.61,122.61,1026.18,0,0,0), -90 }
	}
}

for _, group in pairs(pdgates) do
	for _, gate in ipairs(group) do
		setElementInterior(gate[1],3)
		setElementDimension(gate[1], 4)
		setElementInterior(gate[2],3)
		setElementDimension(gate[2], 4)
		setElementInterior(gate[3],3)
		setElementDimension(gate[3], 4)
	end
end

local function resetBusy( shortestID )
	pdgates[ shortestID ].busy = nil
end

local function closeDoor( shortestID )
	group = pdgates[ shortestID ]
	for _, gate in ipairs(group) do
		local nx, ny, nz = getElementPosition( gate[1] )
		moveObject( gate[1], 1000, nx, ny, nz, 0, 0, -gate[2] )
	end
	group.busy = true
	group.timer = nil
	setTimer( resetBusy, 1000, 1, shortestID )
end

local function openDoor(thePlayer)
	if getElementDimension(thePlayer) == 4 and getElementInterior(thePlayer) == 3 and exports.global:hasItem(thePlayer, 65) then
		local shortest, shortestID, dist = nil, nil, 5
		local px, py, pz = getElementPosition(thePlayer)
		
		for id, group in pairs(pdgates) do
			for _, gate in ipairs(group) do
				local d = getDistanceBetweenPoints3D(px,py,pz,getElementPosition(gate[1]))
				if d < dist then
					shortest = group
					shortestID = id
					dist = d
				end
			end
		end
		
		if shortest then
			if shortest.busy then
				return
			elseif shortest.timer then
				killTimer( shortest.timer )
				shortest.timer = nil
				outputChatBox( "The door is already open!", thePlayer, 0, 255, 0 )
			else
				for _, gate in ipairs(shortest) do
					local nx, ny, nz = getElementPosition( gate[1] )
					moveObject( gate[1], 1000, nx, ny, nz, 0, 0, gate[2] )
				end
				outputChatBox( "You opened the door!", thePlayer, 0, 255, 0 )
			end
			shortest.timer = setTimer( closeDoor, 5000, 1, shortestID )
		end
	end
end
addCommandHandler( "gate", openDoor)
