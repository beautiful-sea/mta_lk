local element = "object"
local enabled = false
local streamdistance = 50

local unstreamed = { }
local root = getRootElement()
local localPlayer = getLocalPlayer()

function checkStreamIn()
	if ( enabled ) then
		local x, y, z = getElementPosition(localPlayer)
		local playerdimension = getElementDimension (localPlayer)
		
		for key, value in pairs(unstreamed) do
			local vx, vy, vz = getElementPosition(key)
			local distx = x - vx
			local disty = y - vy
			
			if (distx < 0) then
				distx = distx - distx - distx
			end
			if (disty < 0) then
				disty = disty - disty - disty
			end
			
			if (distx < streamdistance) and (disty < streamdistance) then
				local dimension = unstreamed[key]
				unstreamed[key] = nil
				setElementDimension(key, dimension)
			end
		end
	end
end
setTimer(checkStreamIn, 2500, 0)

addEventHandler("onClientElementStreamOut", root,
	function ()
		if (getElementType(source) == element and enabled) then
			local dimension = getElementDimension(source)
			unstreamed[source] = dimension
			setElementDimension(source, 65535)
		end
	end
);

addEventHandler("onClientElementDestroy", root, 
	function ()
		if (getElementType(source) == element) then
			unstreamed[source] = nil
		end
	end
);


function streamerStart(resource)
	if (resource == getThisResource() and enabled) then
		for key, value in ipairs(getElementsByType(element)) do
			if (not isElementStreamedIn(value)) then
				local dimension = getElementDimension(value)
				unstreamed[value] = dimension
				setElementDimension(value, 65535)
			end
		end
	end
end
addEventHandler("onClientResourceStart", getRootElement(), streamerStart)

function streamerStop(resource)
	if (resource == getThisResource()) then
		for key, value in pairs(unstreamed) do
			local dimension = unstreamed[key]
			setElementDimension(key, dimension)
			unstreamed[key] = nil
		end
	end
end
addEventHandler("onClientResourceStop", getRootElement(), streamerStop)


--addCommandHandler("togglepatch", 
	function ()
		enabled = not enabled
		
		if (enabled) then
			streamerStart(getThisResource())
			outputChatBox("The fix is now enabled.", 0, 255, 0)
		else
			streamerStop(getThisResource())
			outputChatBox("The fix is now disabled.", 255, 0, 0)
		end
	end
);