local Gate = {
	[1] = createObject(2930,1416.9755859375, -1253.1787109375, 15.128608703613,0,0,90),
}

local GateName = "Little Tokyo Gate"
exports.pool:allocateElement(Gate[1])
local open = false
local rotationoff = 86


local function ResetOpenState()
	open = false
end

local function closeDoor()
	moveObject(Gate[1], 1000, 1416.9755859375, -1253.1787109375, 15.128608703613,0,0,-rotationoff)
	setTimer(ResetOpenState, 1000, 1)
	rotationoff = 86
end

local function useDoor(thePlayer, commandName, password)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(1416.9755859375, -1253.1787109375, 15.128608703613, x, y, z)

	if (distance<=20) and (open==false) then
		if password == "akiraishawt" then
			
			
			if (y > -1253.1787109375) then
				rotationoff = -rotationoff
			end
		
			moveObject(Gate[1], 1000, 1416.9755859375, -1253.1787109375, 15.128608703613,0,0,rotationoff)
			setTimer(closeDoor, 5000, 1)
			open = true
		else
			outputChatBox("Wrong password, pal.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)