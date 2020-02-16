local mysql = exports.mysql

local priceCache = { }
local vehiclecount = { }

carshopPickup = createPickup(2763.0270996094,-1718.7581787109,13.555365562439, 3, 1239)
exports['anticheat-system']:changeProtectedElementDataEx(carshopPickup, "shopid", 1, false)

boatshopPickup = createPickup(715.35546875, -1705.5791015625, 2.4296875, 3, 1239)
exports['anticheat-system']:changeProtectedElementDataEx(boatshopPickup, "shopid", 2, false)

cheapcarshopPickup = createPickup( 1763.0270996094,-1718.7581787109,13.555365562439, 3, 1239)
exports['anticheat-system']:changeProtectedElementDataEx(cheapcarshopPickup, "shopid", 3, false)

rentcarshopPickup = createPickup( 1763.5720214844,-1712.7132568359,13.555365562439, 3, 1239)
exports['anticheat-system']:changeProtectedElementDataEx(rentcarshopPickup, "shopid", 4, false)

function pickupUse(thePlayer)
	if getElementData(source, "shopid") then
		if getElementData(thePlayer, "license.car") == 1 then
			triggerClientEvent(thePlayer, "showCarshopUI", thePlayer, getElementData(source, "shopid"))
		else
			outputChatBox("Você precisa de habilitação para comprar um carro.", thePlayer, 255, 0, 0)
		end
	end
	cancelEvent()
end
addEventHandler("onPickupHit", getResourceRootElement(), pickupUse)
function test(thePlayer)
	triggerClientEvent(thePlayer, "showCarshopUI", thePlayer, 4)
end
addCommandHandler("testgui",test)
local function copy( t )
	if type(t) == 'table' then
		local r = {}
		for k, v in pairs( t ) do
			r[k] = copy( v )
		end
		return r
	else
		return t
	end
end

local function countVehicles( )
	vehiclecount = {}
	for key, value in pairs( getElementsByType( "vehicle" ) ) do
		if isElement( value ) then
			local model = getElementModel( value )
			if vehiclecount[ model ] then
				vehiclecount[ model ] = vehiclecount[ model ] + 1
			else
				vehiclecount[ model ] = 1
			end
		end
	end
end


function buildPriceCache(shopID)
	priceCache[shopID] = { }
	if tonumber(shopID) == 4 then
		local activeShop = copy( g_shops[shopID] )
		for key, value in ipairs( activeShop ) do
			if value[1] and value[2] and vehiclecount[ value[1] ] then
				priceCache[shopID][ value[1] ] = value[1] 
			end
		end
		return
	end
	local activeShop = copy( g_shops[shopID] )
	for key, value in ipairs( activeShop ) do
		if value[1] and value[2] and vehiclecount[ value[1] ] then
			priceCache[shopID][ value[1] ] = value[2] + ( vehiclecount[ value[1] ] or 0 ) * 600
		end
	end
	
end

function buyCar(id, cost, col1, col2, x, y, z, rz, px, py, pz, prz, shopID)
	countVehicles()
	buildPriceCache(shopID)

	--[[if not(priceCache[shopID][id]) then
		exports.logs:logMessage("[CAR SHOP] " .. getPlayerIP(client).." \ ".. getPlayerName( client ) .. "  tried to buy an " .. getVehicleNameFromModel( id ) .. " at an non existing shop for $".. cost..")", 32)
		return
	end]]
	
	--[[if not (priceCache[shopID][id] == cost) then
		exports.logs:logMessage("[CAR SHOP] " .. getPlayerIP(client).." \ " .. getPlayerName( client ) .. "  tried to buy an " .. getVehicleNameFromModel( id ) .. " at shop ".. shopID .." for $".. cost..")", 32)
		return
	end]]
	if exports.global:hasMoney(client, cost) then
		if not ( getElementData(client, "loggedin") == 1 ) then
			name = getPlayerName(client)
			exports.global:sendMessageToAdmins("Possível abuso de bug de dinheiro no menu da loja de veículos "..name.." .")
			return
			
		end
		if shopID == 4 then
			for key, value in pairs( getElementsByType( "vehicle" ) ) do
				if isElement( value ) then
					if getElementData(value, "owner") == getElementData(client, "dbid") then
						if getElementData(value, "rent") == 1 then
							outputChatBox("Você já está alugando um veículo",client,250,255,0)
							return
						end
					end
				end
			end
		end
		if exports.global:canPlayerBuyVehicle(client) then
			
			outputChatBox("Você comprou " .. getVehicleNameFromModel(id) .. " de " .. cost .. "R$. Muito Bem!", client, 255, 194, 14)
			
			if shopID == 1 then
				outputChatBox("Você pode definir a posição de Spawn desses veículos estacionando-a e digitando /park", client, 255, 194, 14)
				outputChatBox("Veículos estacionados perto da concessionária ou ponto de ônibus serão excluídos sem aviso prévio.", client, 255, 0, 0)
			elseif shopID == 2 then
				outputChatBox("Você pode definir a posição de Spawn desses barcos estacionando-a e digitando /park", client, 255, 194, 14)
				outputChatBox("Os barcos estacionados perto da marina serão excluídos sem aviso prévio.", client, 255, 0, 0)
			end
			outputChatBox("Se você não usar /park dentro de uma hora, seu carro será EXCLUÍDO.", client, 255, 0, 0)
			outputChatBox("Pressione 'K' para desbloquear este veículo.", client, 255, 194, 14)
			makeCar(client, id, cost, col1, col2, x, y, z, rz, px, py, pz, prz,shopID)
		else
			outputChatBox("Você tentou comprar um carro, mas você já tem muitos veículos.", client, 255, 0, 0)
		end
		
		
	end
end
addEvent("buyCar", true)
addEventHandler("buyCar", getRootElement(), buyCar)
function tinyid( ) -- finds the smallest ID in the SQL instead of auto increment
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM vehicles AS e1 LEFT JOIN vehicles AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		local id = tonumber(result["nextID"]) or 1
		return id
	end
	return false
end


function makeCar(thePlayer, id, cost, col1, col2, x, y, z, rz, px, py, pz, prz, shopID,ids)
	if not exports.global:takeMoney(thePlayer, cost) then
		return
	end
	
	if not exports.global:canPlayerBuyVehicle(source) then
		return
	end
	
	local rx = 0
	local ry = 0
		
	setElementPosition(thePlayer, px, py, pz)
	setPedRotation(thePlayer, prz)
	
	local username = getPlayerName(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	
	local letter1 = string.char(math.random(65,90))
	local letter2 = string.char(math.random(65,90))
	local plate = letter1 .. letter2 .. math.random(0, 9) .. " " .. math.random(1000, 9999)
	local locked = 0
	local ids = tinyid()
	
		
	local insertid = mysql:query_insert_free("INSERT INTO vehicles SET model='" .. mysql:escape_string(id) .. "',id='" .. mysql:escape_string(ids) .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', color1='" .. mysql:escape_string(col1) .. "', color2='" .. mysql:escape_string(col2) .. "', faction='-1', owner='" .. mysql:escape_string(dbid) .. "', plate='" .. mysql:escape_string(plate) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='0', currry='0', currrz='" .. mysql:escape_string(rz) .. "', locked='" .. mysql:escape_string(locked) .. "'")
	local rent
	if (insertid) then
		local veh = call( getResourceFromName( "vehicle-system" ), "createShopVehicle", insertid, id, x, y, z, 0, 0, rz, plate)
		
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "Impounded", 0)
		
		setVehicleRespawnPosition(veh, x, y, z, 0, 0, rz)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, 0, 0, rz}, false)
		setVehicleLocked(veh, false)
		
		setVehicleColor(veh, col1, col2, col1, col2)
		
		setVehicleOverrideLights(veh, 1)
		setVehicleEngineState(veh, false)
		setVehicleFuelTankExplodable(veh, false)
		
		-- make sure it's an unique key
		call( getResourceFromName( "item-system" ), "deleteAll", 3, insertid )
		exports.global:giveItem( thePlayer, 3, insertid )
		
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldx", x, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldy", y, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldz", z, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "faction", -1)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "owner", dbid, false)
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", 0, false)
		if shopID == 4 then
			rent = 1
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "rent", 1, false)
			platetext = "Rented"..math.random(1,10000)..""
			local query = mysql:query_free("UPDATE vehicles SET rent ='" .. mysql:escape_string(rent) .. "',plate='" .. mysql:escape_string(platetext) .. "', rentcost='" .. mysql:escape_string(cost) .. "' WHERE id='" .. mysql:escape_string(insertid) .. "' LIMIT 1")
		else
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "rent", 0, false)
		end
		exports['vehicle-system']:reloadVehicle(insertid)
		if getVehicleType(veh) == "Boat" then
			exports.global:givePlayerAchievement(thePlayer, 27)
		elseif shopID == 4 then
		else
			exports.global:givePlayerAchievement(thePlayer, 17) -- my ride
		end
		
		exports.logs:logMessage("[CAR SHOP] " .. getPlayerName( thePlayer ) .. " bought car #" .. insertid .. " (" .. getVehicleNameFromModel( id ) .. ")", 9)
	end
end
