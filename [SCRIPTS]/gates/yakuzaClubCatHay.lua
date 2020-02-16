local Gate = {
	[1] = createObject(3051, 830.02246, -11.14160, 973.93, 0, 0, 316),
	[2] = createObject(3051, 831.21289, -11.13769, 973.93, 0, 0, 316),
}
local GateName = "Club Ying Yang"
exports.pool:allocateElement(Gate[1])
exports.pool:allocateElement(Gate[2])
setElementDimension(Gate[1], 649)
setElementDimension(Gate[2], 649)
setElementInterior(Gate[1], 10)
setElementInterior(Gate[2], 10)
local GatePass = "nonoobsuphere"
local open = false


local function ResetOpenState()
	open = false
end

local function closeDoor(thePlayer)
	moveObject(Gate[1], 800, 830.02246, -11.14160, 973.93, 0, 0, 0)
	moveObject(Gate[2], 800, 831.21289, -11.13769, 973.93, 0, 0, 0)
	setTimer(ResetOpenState, 800, 1)
end


-- Gate code / Using local functions to avoid 
local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(831.21289, -11.13769, 973.93, x, y, z)

	if (distance<=3) and (open==false) then
		if password == GatePass then
			moveObject(Gate[1], 800, 829.02246, -11.14160, 973.93, 0, 0, 0)
			moveObject(Gate[2], 800, 832.21289, -11.13769, 973.93, 0, 0, 0)
			setTimer(closeDoor, 3000, 1, thePlayer)
			open = true
		else
			outputChatBox("You need correct password, pal.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)