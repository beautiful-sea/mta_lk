local gates =
{
	{ gate = createObject(5061, 1288.4888671875, -966.37219238281,35.207187652588, 0, 0, 270.095), offset = { 0, 0, 1.6, 0, 85, 0 }, dimension=0, interior=0 },
	{ gate = createObject(5061, 1287.7109375, -1006.1014404297, 31.340635299683, 0, 0, 270.4333), offset = { 0, 0, 2.9, 0, 0, 0 }, dimension=0, interior=0 },
	
	{ 	gate = createObject(3089, 2285.71484375, -1159.2504882813, 150.73489379883, 0, 0, 180), 
		gate2 = createObject(3089, 2282.8098144531, -1159.2448730469, 150.73489379883, 0, 0, 0),
		offset = { 0, 0, 0, 0, 0, -90 }, dimension=1660, interior=16 },
}

for _, gate in pairs(gates) do
	setElementInterior(gate.gate, gate.interior)
	setElementDimension(gate.gate, gate.dimension)
	if (isElement(gate.gate2)) then
		setElementInterior(gate.gate2, gate.interior)
		setElementDimension(gate.gate2, gate.dimension)
	end
end


local function resetBusy( shortestID )
	gates[ shortestID ].busy = nil
end

local function closeDoor( shortestID )
	gate = gates[ shortestID ]
	local nx, ny, nz = getElementPosition( gate.gate )
	moveObject( gate.gate, 2000, nx - gate.offset[1], ny - gate.offset[2], nz - gate.offset[3], -gate.offset[4], -gate.offset[5], -gate.offset[6] )
	if (gate.gate2) then
		local nx, ny, nz = getElementPosition( gate.gate2 )
		moveObject( gate.gate2, 2000, nx + gate.offset[1], ny + gate.offset[2], nz + gate.offset[3], gate.offset[4], gate.offset[5], gate.offset[6] )
	end
	gate.busy = true
	gate.timer = nil
	setTimer( resetBusy, 2000, 1, shortestID )
end

local function openDoor(thePlayer, commandName, pass)
	if exports.global:hasItem(thePlayer, 80, "Zaffa Incorporated RFID Card") then
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
				outputChatBox( "The door is already open!", thePlayer, 0, 255, 0 )
			else
				local nx, ny, nz = getElementPosition( shortest.gate )
				moveObject( shortest.gate, 2000, nx + shortest.offset[1], ny + shortest.offset[2], nz + shortest.offset[3], shortest.offset[4], shortest.offset[5], shortest.offset[6] )
				if (shortest.gate2) then
					local nx, ny, nz = getElementPosition( shortest.gate2 )
					moveObject( shortest.gate2, 2000, nx - shortest.offset[1], ny - shortest.offset[2], nz - shortest.offset[3], -shortest.offset[4], -shortest.offset[5], -shortest.offset[6] )
				end
				outputChatBox( "You opened the door!", thePlayer, 0, 255, 0 )
			end
			shortest.timer = setTimer( closeDoor, 6000, 1, shortestID )
		end
	end
end
addCommandHandler( "gate", openDoor)