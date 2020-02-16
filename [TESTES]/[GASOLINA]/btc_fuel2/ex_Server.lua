mysql = exports.mysql

-- ////////////////////////////////////
-- //			MYSQL				 //
-- ////////////////////////////////////
sqlUsername = exports.mysql:getMySQLUsername()
sqlPassword = exports.mysql:getMySQLPassword()
sqlDB = exports.mysql:getMySQLDBName()
sqlHost = exports.mysql:getMySQLHost()
sqlPort = exports.mysql:getMySQLPort()

handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)

function checkMySQL()
	if not (mysql_ping(handler)) then
		handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)
	end
end
setTimer(checkMySQL, 300000, 0)

function closeMySQL()
	if (handler) then
		mysql_close(handler)
		handler = nil
	end
end
local loadedPoints = 0
local fuelGun = {}

function playerAnimationToServer (localPlayer, animName, animtoName)
	setPedAnimation(localPlayer, animName, animtoName, -1, true, false, false, false)
end
addEvent("playerAnimationToServer", true)
addEventHandler("playerAnimationToServer", getRootElement(), playerAnimationToServer)


function syncPlayertoFuelGun(player, state)
	if not state then 
		fuelGun[player] = createObject(14463,0,0,0)
		exports.bone_attach:attachElementToBone(fuelGun[player],player,12,0,0,0.06,-180,0,0)
	else
		if isElement(fuelGun[player]) then 
			destroyElement(fuelGun[player])
		end
	end
end
addEvent("syncPlayertoFuelGun", true)
addEventHandler("syncPlayertoFuelGun", getRootElement(), syncPlayertoFuelGun)

function syncPlayereffect (player, state )
	triggerClientEvent(root, "createEffectstoClient", root, player , fuelGun[player], tostring(state) )
end
addEvent("syncPlayereffect", true)
addEventHandler("syncPlayereffect", getRootElement(), syncPlayereffect)

addEventHandler("onPlayerQuit",getRootElement(),function()
	if isElement(fuelGun[source]) then 
		destroyElement(fuelGun[source])
	end
end)

function createFuelPoint(x,y,z,r,player)
	x = tonumber(x)
	y = tonumber(y)
	z = tonumber(z)
	r = tonumber(r)

	local insertID = mysql:query( "INSERT INTO fuels SET position = '"..toJSON({x, y, z, r}).."'")
	if insertID then
		temp = createObject(3465, x, y, z, 0, 0, r)

		if isElement(temp) then
			setElementData(temp, "dbid", insertID)
			setElementData(temp, "isRefill", true)
			
			for k,v in ipairs(getElementsByType("player")) do
				outputChatBox("#D64541[Admin]:#7cc576 "..getPlayerName(player).." #ffffffcriou um ponto de gasolina | ID:#7cc576 "..insertID.."",v,255,255,255,true)
			end
		end
	end
end

addCommandHandler("createfuel", function(player)
	x,y,z = getElementPosition(player)
	_,_,r = getElementRotation(player)
	createFuelPoint(x,y+1,z,r,player)

end)

addCommandHandler("delfuel", function(player)
	
	local id = getNearestFuelPoint(player)
	if id ~= -1 and getElementData(id, "isRefill") then
		id = getElementData(id, "dbid")
	end
	if id == -1 then
		outputChatBox("#7cc576[btcMTA]: #ffffffNão há fonte perto de você", player, 0, 0, 0, true)
		return
	end

	local qh = mysql:query("DELETE FROM fuels WHERE id = '"..id.."'")
	
	if qh then
		for k,v in ipairs(getElementsByType("player")) do
			outputChatBox("#D64541[Admin]:#7cc576 "..getPlayerName(player).." #ffffffexcluiu um ponto de gasolina.",v,255,255,255,true)
		end
		
		for k,v in ipairs(getElementsByType("object")) do
			if getElementData(v, "isRefill") and getElementData(v, "dbid") == id then
				destroyElement(v)
			end
		end
	end
end)

function getNearestFuelPoint(ep)
	local pe = {getElementPosition(ep)}
	local dis = 2
	local dis2 = 0
	local obj = -1

	local type = "object"
	for key, value in ipairs(getElementsByType(type)) do
		local p2 = {getElementPosition(value)}
		dis2 = getDistanceBetweenPoints3D (pe[1], pe[2], pe[3], p2[1], p2[2], p2[3])

		if tonumber(dis2) < tonumber(dis)  then
			dis = dis2
			obj = value
		end
	end
	return obj
end

function loadFuelPoints(resource)
	if resource ~= getThisResource() then return end
	
	loadedPoints = 0
	local result =mysql_query(handler,"SELECT * FROM fuels")

	if result then
		local count = 0
		repeat
			row = mysql_fetch_assoc(result)
			if row then
				local id = tonumber(row["id"])
				local position = fromJSON(row["position"])

				local loadedPoint = createObject(3465, position[1], position[2], position[3], 0, 0, position[4])
				setElementData(loadedPoint, "dbid", id)

				--setElementData(loadedPoint, "ListrosGalao", 10)
				setElementData(loadedPoint, "isRefill", true)

				loadedPoints = loadedPoints + 1
			end
		until not row



		outputDebugString(loadedPoints .. " Ponto de reabastecimento carregado")
	end
end
addEventHandler("onResourceStart", resourceRoot, loadFuelPoints)

