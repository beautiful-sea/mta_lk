local validChairs = { [1720] = true, [2125] = true }
local unsolidObjects = { }
local chairOffsets = { [1720] = 1.3, [2125] = 1.3 }
local rotationOffsets = { [1720] = 0, [2125] = 90 }
local localPlayer = getLocalPlayer()
local sitting = false
local myChair = nil
local px, py, pz = nil
local chairPerson = { }

function isValidChair(obj)
	return validChairs[getElementModel(obj)]
end

function isValidObject(obj)
	return ( obj and isElement(obj) and getElementType(obj) == "object" and isValidChair(obj) )
end

function resourceStop(res)
	if ( res == getThisResource() ) then
		if ( sitting ) then
			attemptToStandUp()
		end
	end
end
addEventHandler("onClientResourceStop", getRootElement(), resourceStop)

function onRemotePlayerQuit()
	for k,v in ipairs(chairPerson) do
		if ( v == source ) then
			chairPerson[k] = nil
			break
		end
	end
end
addEventHandler("onClientPlayerQuit", getRootElement(), onRemotePlayerQuit)

function csit(x, y, z)
	for k,v in ipairs(getElementsByType("object")) do
		local ox, oy, oz = getElementPosition(v)
		if ( ox == x and oy == y and oz == z ) then
			chairPerson[v] = source
			attachElements(source, v, 0, 0, chairOffsets[getElementModel(v)])
			break
		end
	end
end
addEvent("csit", true)
addEventHandler("csit", getRootElement(), csit)

function cstand()
	for k,v in pairs(chairPerson) do
		if ( chairPerson[k] == source ) then
			detachElements(source, k)
			chairPerson[k] = nil
			break
		end
	end
end
addEvent("cstand", true)
addEventHandler("cstand", getRootElement(), cstand)

function resourceStart(res)
	if ( res == getThisResource() ) then
		for k,v in ipairs(getElementsByType("object")) do
			if ( unsolidObjects[getElementModel(v)] ) then
				setElementCollisionsEnabled(v, false)
			else
				setElementCollisionsEnabled(v, true)
			end
		end
	end
end
addEventHandler("onClientResourceStart", getRootElement(), resourceStart)

function attemptToSitOnChair(chair)
	if ( canISitOnChair(chair) ) then
		if ( chairPerson[chair] ~= nil ) then
			outputChatBox("That seat is already occupied!", 255, 0, 0)
		else
			px, py, pz = getElementPosition(localPlayer)
			local x, y, z = getElementPosition(chair)
			local rx, ry, rz = getElementRotation(chair)

			triggerServerEvent("sit", localPlayer, x, y, z, rz + rotationOffsets[getElementModel(chair)])
			sitting = true
			myChair = chair
			attachElements(localPlayer, chair, 0, 0, chairOffsets[getElementModel(chair)])
			call(getResourceFromName("social-system"), "toggleCursor")
			
			outputChatBox("You are now sitting down on a chair. Press M then click anywhere to stand up.", 255, 195, 14)
		end
	else
		outputChatBox("You are too far from that chair, get closer!", 255, 0, 0)
	end
end

function canISitOnChair(chair)
	local x, y, z = getElementPosition(localPlayer)
	local cx, cy, cz = getElementPosition(chair)
	
	return (getDistanceBetweenPoints3D(x, y, z, cx, cy, cz) < 3)
end

function attemptToStandUp()
	sitting = false
	myChair = nil
	triggerServerEvent("stand", localPlayer)
	detachElements(localPlayer, myChair)
	setElementPosition(localPlayer, px, py, pz)
	px, py, pz = nil
	call(getResourceFromName("social-system"), "toggleCursor")
end

function clickedChair(button, state, absX, absY, wx, wy, wz, chair)
	if ( button == "left" and state == "down" ) then
		if ( isValidObject(chair) and not sitting ) then
			attemptToSitOnChair(chair)
		elseif (sitting) then
			attemptToStandUp()
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickedChair)