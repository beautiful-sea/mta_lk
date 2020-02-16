mysql = exports.mysql

local null = mysql_null()
local toLoad = { }
local threads = { }
function smallid( ) -- finds the smallest ID in the SQL instead of auto increment
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM vehicles AS e1 LEFT JOIN vehicles AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		local id = tonumber(result["nextID"]) or 1
		return id
	end
	return false
end


-- /makeveh

function createPermVehicle(thePlayer, commandName, ...)
	if (exports.global:isPlayerSuperAdmin(thePlayer)) then
		local args = {...}
		if (#args < 7) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id/name] [color1] [color2] [Owner] [Faction Vehicle (1/0)] [Cost] [Tinted Windows] ", thePlayer, 255, 194, 14)
			outputChatBox("NOTE: If it is a faction vehicle, Username is the owner of the faction.", thePlayer, 255, 194, 14)
			outputChatBox("NOTE: If it is a faction vehicle, The cost is taken from the faction fund, rather than the player.", thePlayer, 255, 194, 14)
		else
			local vehicleID = tonumber(args[1])
			local col1, col2, userName, factionVehicle, cost, tint
			
			if not vehicleID then -- vehicle is specified as name
				local vehicleEnd = 1
				repeat
					vehicleID = getVehicleModelFromName(table.concat(args, " ", 1, vehicleEnd))
					vehicleEnd = vehicleEnd + 1
				until vehicleID or vehicleEnd == #args
				if vehicleEnd == #args then
					outputChatBox("Invalid Vehicle Name.", thePlayer, 255, 0, 0)
					return
				else
					col1 = tonumber(args[vehicleEnd])
					col2 = tonumber(args[vehicleEnd + 1])
					userName = args[vehicleEnd + 2]
					factionVehicle = tonumber(args[vehicleEnd + 3])
					cost = tonumber(args[vehicleEnd + 4])
					tint = tonumber(args[vehicleEnd + 5])
				end
			else
				col1 = tonumber(args[2])
				col2 = tonumber(args[3])
				userName = args[4]
				factionVehicle = tonumber(args[5])
				cost = tonumber(args[6])
				tint = tonumber(args[7])
			end
			
			local id = vehicleID
			
			local r = getPedRotation(thePlayer)
			local x, y, z = getElementPosition(thePlayer)
			x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
			y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )
			
			local targetPlayer, username = exports.global:findPlayerByPartialNick(thePlayer, userName)
			
			if targetPlayer then
				local dbid = getElementData(targetPlayer, "dbid")
				
				if (factionVehicle==1) then
					factionVehicle = tonumber(getElementData(targetPlayer, "faction"))
					local theTeam = getPlayerTeam(targetPlayer)
					
					if not exports.global:takeMoney(theTeam, cost) then
						outputChatBox("This faction cannot afford this vehicle.", thePlayer, 255, 0, 0)
						return
					end
				else
					factionVehicle = -1
					if not exports.global:takeMoney(targetPlayer, cost) then
						outputChatBox("This player cannot afford this vehicle.", thePlayer, 255, 0, 0)
						return
					elseif not exports.global:canPlayerBuyVehicle(targetPlayer) then
						outputChatBox("This player has too many cars.", thePlayer, 255, 0, 0)
						return
					elseif ( getVehicleType(id) == "Helicopter" or getVehicleType(id) == "Plane" ) and not exports.global:hasItem(targetPlayer, 78) then
						outputChatBox("The player has no Pilot Certificate.", thePlayer, 255, 0, 0)
						return
					elseif getVehicleType(id) == "BMX" then
						outputChatBox("Invalid Vehicle ID.", thePlayer, 255, 0, 0)
						return
					end
				end
				
				local letter1 = string.char(math.random(65,90))
				local letter2 = string.char(math.random(65,90))
				local plate = letter1 .. letter2 .. math.random(0, 9) .. " " .. math.random(1000, 9999)
				
				local veh = createVehicle(id, x, y, z, 0, 0, r, plate)
				if not (veh) then
					outputChatBox("Invalid Vehicle ID.", thePlayer, 255, 0, 0)
				else
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "Impounded", 0)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "handbrake", 0, false)

					local rx, ry, rz = getVehicleRotation(veh)
					setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
					
					setVehicleLocked(veh, true)

					setVehicleColor(veh, col1, col2, col1)

					setVehicleOverrideLights(veh, 1)
					setVehicleEngineState(veh, false)
					setVehicleFuelTankExplodable(veh, false)
					
					-- Set the vehicle armored if it is armored
					if (armoredCars[id]) then
						setVehicleDamageProof(veh, true)
					end

					local dimension = getElementDimension(thePlayer)
					local interior = getElementInterior(thePlayer)
					local ide = smallid()
					local insertid = mysql:query_insert_free("INSERT INTO vehicles SET model='" .. mysql:escape_string(id) .. "', id='" .. mysql:escape_string(ide) .. "',x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', color1='" .. mysql:escape_string(col1) .. "', color2='" .. mysql:escape_string(col2) .. "', faction='" .. mysql:escape_string(factionVehicle) .. "', owner='" .. mysql:escape_string(( factionVehicle == -1 and dbid or -1 )) .. "', plate='" .. mysql:escape_string(plate) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='0', currry='0', currrz='" .. mysql:escape_string(r) .. "', locked=1, interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "', tintedwindows='" .. mysql:escape_string(tint) .. "'")

					if (insertid) then
						exports.pool:allocateElement(veh, insertid)
						
						if (factionVehicle==-1) then
							exports.global:giveItem(targetPlayer, 3, tonumber(insertid))
						end
						
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "dbid", tonumber(insertid))
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 0, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldx", x, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldy", y, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldz", z, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "faction", factionVehicle)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "owner", factionVehicle == -1 and dbid or -1, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", 0, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "rent", 0, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "rentcost", 0, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "handbrake", 0, false)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "odometer", 0, true)
						if tint and tint == 1 then
							exports['anticheat-system']:changeProtectedElementDataEx(veh, "tinted", true, true)
						end
						
						setElementDimension(veh, dimension)
						setElementInterior(veh, interior)
						
						outputChatBox(getVehicleName(veh) .. " spawned with ID #" .. insertid .. ".", thePlayer, 255, 194, 14)
						
						local owner = ""
						if factionVehicle == -1 then
							owner = "Owner: " .. getPlayerName( targetPlayer )
						else
							owner = "Faction #" .. factionVehicle
						end
						
						exports.logs:logMessage("[MAKEVEH] " .. getPlayerName( thePlayer ) .. " created car #" .. insertid .. " (" .. getVehicleNameFromModel( id ) .. ") - " .. owner, 9)
						
						exports['vehicle-interiors']:add( veh )
					else
						destroyElement( veh )
					end
				end
			end
		end
	end
end
addCommandHandler("makeveh", createPermVehicle, false, false)

-- /makecivveh
function createCivilianPermVehicle(thePlayer, commandName, ...)
	if (exports.global:isPlayerSuperAdmin(thePlayer)) then
		local args = {...}
		if (#args < 4) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id/name] [color1 (-1 for random)] [color2 (-1 for random)] [Job ID -1 for none]", thePlayer, 255, 194, 14)
			outputChatBox("Job 1 = Delivery Driver", thePlayer, 255, 194, 14)
			outputChatBox("Job 2 = Taxi Driver", thePlayer, 255, 194, 14)
			outputChatBox("Job 3 = Bus Driver", thePlayer, 255, 194, 14)
		else
			local vehicleID = tonumber(args[1])
			local col1, col2, job
			
			if not vehicleID then -- vehicle is specified as name
				local vehicleEnd = 1
				repeat
					vehicleID = getVehicleModelFromName(table.concat(args, " ", 1, vehicleEnd))
					vehicleEnd = vehicleEnd + 1
				until vehicleID or vehicleEnd == #args
				if vehicleEnd == #args then
					outputChatBox("Invalid Vehicle Name.", thePlayer, 255, 0, 0)
					return
				else
					col1 = tonumber(args[vehicleEnd])
					col2 = tonumber(args[vehicleEnd + 1])
					job = tonumber(args[vehicleEnd + 2])
				end
			else
				col1 = tonumber(args[2])
				col2 = tonumber(args[3])
				job = tonumber(args[4])
			end
			
			local id = vehicleID
			
			local r = getPedRotation(thePlayer)
			local x, y, z = getElementPosition(thePlayer)
			x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
			y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )
			
			local letter1 = string.char(math.random(65,90))
			local letter2 = string.char(math.random(65,90))
			local plate = letter1 .. letter2 .. math.random(0, 9) .. " " .. math.random(1000, 9999)

			local veh = createVehicle(id, x, y, z, 0, 0, r, plate)

			if not (veh) then
				outputChatBox("Invalid Vehicle ID.", thePlayer, 255, 0, 0)
			else
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "handbrake", 0, false)

				if (job>0) then
					toggleVehicleRespawn(veh, true)
					setVehicleRespawnDelay(veh, 60000)
					setVehicleIdleRespawnDelay(veh, 180000)
				end

				local rx, ry, rz = getVehicleRotation(veh)
				setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
				
				setVehicleLocked(veh, false)

				setVehicleColor(veh, col1, col2, col1)

				setVehicleOverrideLights(veh, 1)
				setVehicleEngineState(veh, false)
				setVehicleFuelTankExplodable(veh, false)
				
				local dimension = getElementDimension(thePlayer)
				local interior = getElementInterior(thePlayer)
				
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension, false)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior, false)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", job, job ~= 0)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "odometer", 0, true)
				
				-- Set the vehicle armored if it is armored
				if (armoredCars[id]) then
					setVehicleDamageProof(veh, true)
				end

				local insertid = mysql:query_insert_free("INSERT INTO vehicles SET job='" .. mysql:escape_string(job) .. "', model='" .. mysql:escape_string(id) .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', color1='" .. mysql:escape_string(col1) .. "', color2='" .. mysql:escape_string(col2) .. "', faction='-1', owner='-2', plate='" .. mysql:escape_string(plate) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='0', currry='0', currrz='" .. mysql:escape_string(r) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "'")
				
				if (insertid) then
					exports.pool:allocateElement(veh, insertid)
					
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "dbid", insertid)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", 100)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldx", x, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldy", y, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldz", z, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "faction", -1)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "owner", -2, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", job, job ~= 0)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "handbrake", 0, false)
					
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "vehicle:windowstat", 0, true)
					outputChatBox(getVehicleName(veh) .. " (Civilian) spawned with ID #" .. insertid .. ".", thePlayer, 255, 194, 14)
					
					exports.logs:logMessage("[MAKECIVVEH] " .. getPlayerName( thePlayer ) .. " created car #" .. insertid .. " (" .. getVehicleNameFromModel( id ) .. ")", 9)
					
					exports['vehicle-interiors']:add( veh )
				else
					destroyElement( veh )
				end
			end
		end
	end
end
addCommandHandler("makecivveh", createCivilianPermVehicle, false, false)

function loadAllVehicles(res)
	-- Reset player in vehicle states
	local players = exports.pool:getPoolElementsByType("player")
	for key, value in ipairs(players) do
		exports['anticheat-system']:changeProtectedElementDataEx(value, "realinvehicle", 0, false)
	end
	

	local result = mysql:query("SELECT id FROM `vehicles` ORDER BY `id` ASC")
	if result then
		while true do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			
			toLoad[tonumber(row["id"])] = true
			--loadOneVehicle(row)
		end
		mysql:free_result(result)
		
		for id in pairs( toLoad ) do
			
			local co = coroutine.create(loadOneVehicle)
			coroutine.resume(co, id, true)
			table.insert(threads, co)
		end
		setTimer(resume, 1000, 4)
	else
		outputDebugString( "loadAllVehicles failed" )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(), loadAllVehicles)

function resume()
	for key, value in ipairs(threads) do
		coroutine.resume(value)
	end
end

function reloadVehicle(id)
	local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
	if (theVehicle) then
		removeSafe(tonumber(id))
		exports['savevehicle-system']:saveVehicle(theVehicle)
		destroyElement(theVehicle)
		loadOneVehicle(id, false)
		return true
	end
	return false
end

function loadOneVehicle(id, hasCoroutine)
	if (hasCoroutine==nil) then
		hasCoroutine = false
	end
	
	local row = mysql:query_fetch_assoc("SELECT * FROM vehicles WHERE id = " .. mysql:escape_string(id) )
	if row then
		
		if (hasCoroutine) then
			coroutine.yield()
		end
		
		for k, v in pairs( row ) do
			if v == null then
				row[k] = nil
			else
				row[k] = tonumber(row[k]) or row[k]
			end
		end
		-- Spawn the vehicle
		local veh = createVehicle(row.model, row.currx, row.curry, row.currz, row.currrx, row.currry, row.currrz, row.plate)
		if veh then
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "dbid", row.id)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "rent", row.rent)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "rentcost", row.rentcost)
			exports.pool:allocateElement(veh, row.id)
			
			-- color and paintjob
			setVehicleColor(veh, row.color1, row.color2, row.color3 ,row.color21, row.color22, row.color23)
			setVehiclePaintjob(veh, row.paintjob)
			setVehicleHeadLightColor ( veh, row.lred, row.lgreen, row.lblue)

			-- Set the vehicle armored if it is armored
			if (armoredCars[row.model]) then
				setVehicleDamageProof(veh, true)
			end
			
			-- Cosmetics
			local upgrades = fromJSON(row["upgrades"])
			for slot, upgrade in ipairs(upgrades) do
				if upgrade and tonumber(upgrade) > 0 then
					addVehicleUpgrade(veh, upgrade)
				end
			end
			
			local panelStates = fromJSON(row["panelStates"])
			for panel, state in ipairs(panelStates) do
				setVehiclePanelState(veh, panel-1 , tonumber(state) or 0)
			end
			
			local doorStates = fromJSON(row["doorStates"])
			for door, state in ipairs(panelStates) do
				setVehicleDoorState(veh, door-1, tonumber(state) or 0)
			end
			
			local wheelStates = fromJSON(row["wheelStates"])
			setVehicleWheelStates(veh, tonumber(wheelStates[1]) , tonumber(wheelStates[2]) , tonumber( wheelStates[3]) , tonumber(wheelStates[4]) )
			
			-- lock the vehicle if it's locked
			setVehicleLocked(veh, row.owner ~= -2 and row.locked == 1)
			
			-- set the sirens on if it has some
			setVehicleSirensOn(veh, row.sirens == 1)

			-- job
			if row.job > 0 then
				toggleVehicleRespawn(veh, true)
				setVehicleRespawnDelay(veh, 60000)
				setVehicleIdleRespawnDelay(veh, 180000)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", row.job)
			else
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "job", 0, false)
			end
			
			setVehicleRespawnPosition(veh, row.x, row.y, row.z, row.rotx, row.roty, row.rotz)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {row.x, row.y, row.z, row.rotx, row.roty, row.rotz}, false)
			
			-- element data
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", row.fuel, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldx", row.currx, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldy", row.curry, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "oldz", row.currz, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "faction", tonumber(row.faction))
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "owner", tonumber(row.owner))
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "handbrake", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "vehicle:windowstat", 0, true)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "odometer", tonumber(row.odometer))
			
			-- impound shizzle
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "Impounded", tonumber(row.Impounded))
			if tonumber(row.Impounded) > 0 then
				setVehicleDamageProof(veh, true)
			end
			
			-- interior/dimension
			setElementDimension(veh, row.currdimension)
			setElementInterior(veh, row.currinterior)
			
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", row.dimension, false)
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", row.interior, false)
			
			-- lights
			setVehicleOverrideLights(veh, row.lights == 0 and 1 or row.lights )
			
			-- engine
			if row.hp <= 350 then
				setElementHealth(veh, 300)
				setVehicleDamageProof(veh, true)
				setVehicleEngineState(veh, false)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 0, false)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "enginebroke", 1, false)
			else
				setElementHealth(veh, row.hp)
				setVehicleEngineState(veh, row.engine == 1)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", row.engine, false)
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "enginebroke", 0, false)
			end
			setVehicleFuelTankExplodable(veh, false)
			
			-- handbrake
			if row.handbrake > 0 then
				setElementFrozen(veh, true)
			end
			
			local hasInterior, interior = exports['vehicle-interiors']:add( veh )
			if hasInterior and row.safepositionX and row.safepositionY and row.safepositionZ and row.safepositionRZ then
				addSafe( row.id, row.safepositionX, row.safepositionY, row.safepositionZ, row.safepositionRZ, interior )
			end
			
			if row.tintedwindows == 1 then
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "tinted", true, true)
			end
			exports['anticheat-system']:changeProtectedElementDataEx(veh, "elock", row.elock, false)
		end
	else
		outputDebugString("found", 1)
	end
end

function vehicleExploded()
	local job = getElementData(source, "job")
	
	if not job or job<=0 then
		setTimer(respawnVehicle, 60000, 1, source)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), vehicleExploded)

function vehicleRespawn(exploded)
	local id = getElementData(source, "dbid")
	local faction = getElementData(source, "faction")
	local job = getElementData(source, "job")
	local owner = getElementData(source, "owner")
	local windowstat = getElementData(source, "vehicle:windowstat")
	
	if (job>0) then
		toggleVehicleRespawn(source, true)
		setVehicleRespawnDelay(source, 60000)
		setVehicleIdleRespawnDelay(source, 180000)
		setElementFrozen(source, true)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "handbrake", 1, false)
	end
	
	-- Set the vehicle armored if it is armored
	local vehid = getElementModel(source)
	if (armoredCars[tonumber(vehid)]) then
		setVehicleDamageProof(source, true)
	else
		setVehicleDamageProof(source, false)
	end

	setVehicleFuelTankExplodable(source, false)
	setVehicleEngineState(source, false)
	setVehicleLandingGearDown(source, true)

	exports['anticheat-system']:changeProtectedElementDataEx(source, "enginebroke", 0, false)
	
	exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid", id)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "fuel", 100)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "engine", 0, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "vehicle:windowstat", windowstat, false)
	
	local x, y, z = getElementPosition(source)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "oldx", x, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "oldy", y, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "oldz", z, false)
	
	exports['anticheat-system']:changeProtectedElementDataEx(source, "faction", faction)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "owner", owner, false)
	
	setVehicleOverrideLights(source, 1)
	setElementFrozen(source, false)
	
	-- Set the sirens off
	setVehicleSirensOn(source, false)
	
	setVehicleLightState(source, 0, 0)
	setVehicleLightState(source, 1, 0)
	
	local dimension = getElementDimension(source)
	local interior = getElementInterior(source)
	
	setElementDimension(source, dimension)
	setElementInterior(source, interior)
	
	-- unlock civ vehicles
	if owner == -2 then
		setVehicleLocked(source, false)
		setElementFrozen(source, true)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "handbrake", 1, false)
	end
end
addEventHandler("onVehicleRespawn", getRootElement(), vehicleRespawn)

function setEngineStatusOnEnter(thePlayer, seat)
	if seat == 0 then
		local engine = getElementData(source, "engine")
		local model = getElementModel(source)
		if not (enginelessVehicle[model]) then
			if (engine==0) then
				toggleControl(thePlayer, 'brake_reverse', false)
				setVehicleEngineState(source, false)
			else
				toggleControl(thePlayer, 'brake_reverse', true)
				setVehicleEngineState(source, true)
			end
		else
			toggleControl(thePlayer, 'brake_reverse', true)
			
			setVehicleEngineState(source, true)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "engine", 1, false)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), setEngineStatusOnEnter)

function vehicleExit(thePlayer, seat)
	if (isElement(thePlayer)) then
		toggleControl(thePlayer, 'brake_reverse', true)
		-- For oldcar
		local vehid = getElementData(source, "dbid")
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "lastvehid", vehid, false)
	end
end
addEventHandler("onVehicleExit", getRootElement(), vehicleExit)

function destroyTyre(veh)
	local tyre1, tyre2, tyre3, tyre4 = getVehicleWheelStates(veh)
	
	if (tyre1==1) then
		tyre1 = 2
	end
	
	if (tyre2==1) then
		tyre2 = 2
	end
	
	if (tyre3==1) then
		tyre3 = 2
	end
	
	if (tyre4==1) then
		tyre4 = 2
	end
	
	if (tyre1==2 and tyre2==2 and tyre3==2 and tyre4==2) then
		tyre3 = 0
	end
	
	exports['anticheat-system']:changeProtectedElementDataEx(veh, "tyretimer")
	setVehicleWheelStates(veh, tyre1, tyre2, tyre3, tyre4)
end

function damageTyres()
	local tyre1, tyre2, tyre3, tyre4 = getVehicleWheelStates(source)
	local tyreTimer = getElementData(source, "tyretimer")
	
	if (tyretimer~=1) then
		if (tyre1==1) or (tyre2==1) or (tyre3==1) or (tyre4==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(source, "tyretimer", 1, false)
			local randTime = math.random(5, 15)
			randTime = randTime * 1000
			setTimer(destroyTyre, randTime, 1, source)
		end
	end
end
addEventHandler("onVehicleDamage", getRootElement(), damageTyres)

-- Bind Keys required
function bindKeys()
	local players = exports.pool:getPoolElementsByType("player")
	for k, arrayPlayer in ipairs(players) do
		if not(isKeyBound(arrayPlayer, "j", "down", toggleEngine)) then
			bindKey(arrayPlayer, "j", "down", toggleEngine)
		end
		
		if not(isKeyBound(arrayPlayer, "l", "down", toggleLights)) then
			bindKey(arrayPlayer, "l", "down", toggleLights)
		end
		
		if not(isKeyBound(arrayPlayer, "k", "down", toggleLock)) then
			bindKey(arrayPlayer, "k", "down", toggleLock)
		end
	end
end

function bindKeysOnJoin()
	bindKey(source, "j", "down", toggleEngine)
	bindKey(source, "l", "down", toggleLights)
	bindKey(source, "k", "down", toggleLock)
end
addEventHandler("onResourceStart", getResourceRootElement(), bindKeys)
addEventHandler("onPlayerJoin", getRootElement(), bindKeysOnJoin)

function toggleEngine(source, key, keystate)
	local veh = getPedOccupiedVehicle(source)
	local inVehicle = getElementData(source, "realinvehicle")

	if veh and inVehicle == 1 then
		local seat = getPedOccupiedVehicleSeat(source)
		
		if (seat == 0) then
			local model = getElementModel(veh)
			if not (enginelessVehicle[model]) then
				local engine = getElementData(veh, "engine")
				local vehID = getElementData(veh, "dbid")
				local vehKey = exports['global']:hasItem(source, 3, vehID)
				if engine == 0 then
					local vjob = tonumber(getElementData(veh, "job"))
					local job = getElementData(source, "job")
					local owner = getElementData(veh, "owner")
					local faction = tonumber(getElementData(veh, "faction"))
					local playerFaction = tonumber(getElementData(source, "faction"))
					if (vehKey) or (owner < 0) and (faction == -1) or (playerFaction == faction) and (faction ~= -1) or ((getElementData(source, "adminduty") or 0) == 1) then
						local fuel = getElementData(veh, "fuel")
						local broke = getElementData(veh, "enginebroke")
						if broke == 1 then
							exports.global:sendLocalMeAction(source, "attempts to start the engine but fails.")
							triggerClientEvent( source, "aoutput",source, "Engine Broken","Call a mechanic or LSTR worker to fix your vehicle." ,3 )
						elseif exports.global:hasItem(veh, 74) then
							while exports.global:hasItem(veh, 74) do
								exports.global:takeItem(veh, 74)
							end
							
							blowVehicle(veh)
						elseif fuel >= 1 then
							toggleControl(source, 'brake_reverse', true)
							
							setVehicleEngineState(veh, true)
							exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 1, false)
						elseif fuel < 1 then
							exports.global:sendLocalMeAction(source, "attempts to turn the engine on and fails.")
							--outputChatBox("This vehicle has no fuel.", source)
							triggerClientEvent( source, "aoutput",source, "Fuel Empty","Visit nearest gas station to refill your vehicle or call a mechanic. You can carry fuel cans with you to avoid such problems in future." ,3 )

						end
					else
						outputChatBox("Need vehicle keys.You can try hotwiring by /hotwire.", source, 255, 0, 0)
						--triggerClientEvent( source, "aoutput",source, "Need Vehicle Key","These metal boxes with wheels require keys to work." ,3 )

					end
				else
					toggleControl(source, 'brake_reverse', false)
					
					setVehicleEngineState(veh, false)
					exports['anticheat-system']:changeProtectedElementDataEx(veh, "engine", 0, false)
				end
			end
		end
	end
end

function toggleLock(source, key, keystate)
	local veh = getPedOccupiedVehicle(source)
	local inVehicle = getElementData(source, "realinvehicle")
	
	if (veh) and (inVehicle==1) then
		triggerEvent("lockUnlockInsideVehicle", source, veh)
	elseif not veh then
		if getElementDimension(source) >= 19000 then
			local vehicle = exports.pool:getElement("vehicle", getElementDimension(source) - 20000)
			if vehicle and exports['vehicle-interiors']:isNearExit(source, vehicle) then
				local model = getElementModel(vehicle)
				local owner = getElementData(vehicle, "owner")
				local dbid = getElementData(vehicle, "dbid")
				
				if (owner ~= -2) then
					if ( getElementData(vehicle, "Impounded") or 0 ) == 0 then
						local locked = isVehicleLocked(vehicle)
						if (locked) then
							setVehicleLocked(vehicle, false)
							exports.global:sendLocalMeAction(source, "destrancou o veículo.")
						else
							setVehicleLocked(vehicle, true)
							exports.global:sendLocalMeAction(source, "trancou o veículo.")
						end
					else
						outputChatBox("(( Você não pode trancar veículos apreendidos. ))", source, 255, 195, 14)
					end
				else
					outputChatBox("(( Você não pode trancar veículos do governo. ))", source, 255, 195, 14)
					end
					return
				end
			end
			if not triggerEvent("lockUnlockHouse", source) then
				local x, y, z = getElementPosition(source)
				local nearbyVehicles = exports.global:getNearbyElements(source, "vehicle", 30)

				if #nearbyVehicles < 1 then return end

				local found = nil
				local shortest = 31
				for i, veh in ipairs(nearbyVehicles) do
					local dbid = tonumber(getElementData(veh, "dbid"))
					local distanceToVehicle = getDistanceBetweenPoints3D(x, y, z, getElementPosition(veh))
					if shortest > distanceToVehicle and ( getElementData(source, "adminduty") == 1 or exports.global:hasItem(source, 3, dbid) or (getElementData(source, "faction") > 0 and getElementData(source, "faction") == getElementData(veh, "faction")) ) then
						shortest = distanceToVehicle
						found = veh
					end
				end

				if found then
					triggerEvent("lockUnlockOutsideVehicle", source, found)
				end
			end
		end
	end

	function checkLock(thePlayer, seat, jacked)
		local locked = isVehicleLocked(source)

		if (locked) and not (jacked) then
			cancelEvent()
			outputChatBox("The door is locked.", thePlayer)
		end
	end
	addEventHandler("onVehicleStartExit", getRootElement(), checkLock)

	function toggleLights(source, key, keystate)
		local veh = getPedOccupiedVehicle(source)
		local inVehicle = getElementData(source, "realinvehicle")

		if (veh) and (inVehicle==1) then
			local model = getElementModel(veh)
			if not (lightlessVehicle[model]) then
				local lights = getVehicleOverrideLights(veh)
				local seat = getPedOccupiedVehicleSeat(source)

				if (seat==0) then
					if (lights~=2) then
						setVehicleOverrideLights(veh, 2)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "lights", 1, false)
					elseif (lights~=1) then
						setVehicleOverrideLights(veh, 1)
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "lights", 0, false)
					end
				end
			end
		end
	end

	--/////////////////////////////////////////////////////////
	--Fix for spamming keys to unlock etc on entering
	--/////////////////////////////////////////////////////////

	-- bike lock fix
	function checkBikeLock(thePlayer)
		if (isVehicleLocked(source)) and (getVehicleType(source)=="Bike" or getVehicleType(source)=="Boat" or getVehicleType(source)=="BMX" or getVehicleType(source)=="Quad" or getElementModel(source)==568 or getElementModel(source)==571 or getElementModel(source)==572 or getElementModel(source)==424) then
			if not getElementData(thePlayer, "interiormarker") then
				outputChatBox("That vehicle is locked.", thePlayer, 255, 194, 15)
			end
			cancelEvent()
		end
	end
	addEventHandler("onVehicleStartEnter", getRootElement(), checkBikeLock)

	function setRealInVehicle(thePlayer)
		if isVehicleLocked(source) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "realinvehicle", 0, false)
			removePedFromVehicle(thePlayer)
			setVehicleLocked(source, true)
		else
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "realinvehicle", 1, false)

			-- 0000464: Car owner message. 
			local owner = getElementData(source, "owner")
			local faction = getElementData(source, "faction")
			local carName = getVehicleName(source)
			if(owner and faction)then
				if owner < 0 and faction and faction == -1 then
					outputChatBox("(( Veículo: " .. carName .. " Dono: Governo ))", thePlayer, 255, 204, 153)
				elseif (faction==-1) and (owner>0) then
					local ownerName = exports['cache']:getCharacterName(owner)

					if ownerName then
						if getElementData(source,"rent") ==0 then
							outputChatBox("(( Veículo: " .. carName .. " dono: " .. ownerName .. ". ))", thePlayer, 255, 204, 153)
						else
							outputChatBox("(( Veículo: " .. carName .. " Alugado por: " .. ownerName .. ". ))", thePlayer, 255, 204, 153)
						end
						if (getElementData(source, "Impounded") > 0) then
							local output = getRealTime().yearday-getElementData(source, "Impounded")
							outputChatBox("(( Este " .. carName .. " foi apreendido por: " .. output .. (output == 1 and " Day." or " Days.") .. " ))", thePlayer, 51, 102, 153)
						end
					end
				end
			end
		end
	end
	addEventHandler("onVehicleEnter", getRootElement(), setRealInVehicle)


	function setRealInVehicle(thePlayer)
		if isVehicleLocked(source) then
			local owner = getElementData(source, "owner")
			
			local faction = getElementData(source, "faction")
			local carName = getVehicleName(source)
			if owner < 0 and faction == -1 then
				outputChatBox("(( Veículo: " .. carName .. " Dono: Governo ))", thePlayer,  255, 204, 153)
			elseif (faction==-1) and (owner>0) then
				local ownerName = exports['cache']:getCharacterName(owner)

				if ownerName then
					if getElementData(source,"rent") ==0 then
						outputChatBox("(( Veículo: " .. carName .. " Dono: " .. ownerName .. ". ))", thePlayer, 255, 204, 153)
					else
						outputChatBox("(( Veículo: " .. carName .. " Alugado Por: " .. ownerName .. ". ))", thePlayer, 255, 204, 153 )
					end
					if (getElementData(source, "Impounded") > 0) then
						local output = getRealTime().yearday-getElementData(source, "Impounded")
						outputChatBox("(( Este " .. carName .. " foi alugado por: " .. output .. (output == 1 and " Day." or " Days.") .. " ))", thePlayer, 51, 102, 153)
					end
				end
			end
		end

	end
	addEventHandler("onVehicleStartEnter", getRootElement(), setRealInVehicle)

	function vipvehicle(thePlayer)
		if not isVehicleLocked(source) then
			local owner = getElementData(source, "owner")
			if (owner == 5844) and ( exports.global:isPlayerBronzeDonator(thePlayer) or exports.global:isPlayerAdmin(thePlayer) )  then
			elseif (owner == 5844) then
				outputChatBox("Este veículo é apenas para membros VIP.",thePlayer,22,222,222)
				cancelEvent()
				return
			end
		end
	end
	addEventHandler("onVehicleStartEnter", getRootElement(), vipvehicle)
	function setRealNotInVehicle(thePlayer)
		local locked = isVehicleLocked(source)

		if not (locked) then
			if (thePlayer) then
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "realinvehicle", 0, false)
			end
		end
	end
	addEventHandler("onVehicleStartExit", getRootElement(), setRealNotInVehicle)

	-- Faction vehicles removal script
	function removeFromFactionVehicle(thePlayer)
		local faction = getElementData(thePlayer, "faction")
		local vfaction = tonumber(getElementData(source, "faction"))
		local CanTowDriverEnter = (call(getResourceFromName("tow-system"), "CanTowTruckDriverVehPos", thePlayer) == 2)
		if (vfaction~=-1) then
			local seat = getPedOccupiedVehicleSeat(thePlayer)
			local factionName = "this faction"
			for key, value in ipairs(exports.pool:getPoolElementsByType("team")) do
				local id = tonumber(getElementData(value, "id"))
				if (id==vfaction) then
					factionName = getTeamName(value)
					break
				end
			end
			--	if (faction~=vfaction) and (seat==0) then
				--		if (CanTowDriverEnter) then
					--			outputChatBox("(( Vehicle: " .. getVehicleName(source) .. " Faction: '" .. factionName .. "'. ))", thePlayer,255, 204, 153)
					--			exports['anticheat-system']:changeProtectedElementDataEx(source, "enginebroke", 1, false)
					--			setVehicleDamageProof(source, true)
					--			setVehicleEngineState(source, false)
					--			return
					--		end
					--		outputChatBox("Only member of '" .. factionName .. "' are allowed to drive this vehicle.", thePlayer, 255, 0, 0)		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "realinvehicle", 0, false)
					--	removePedFromVehicle(thePlayer)
					--		local x, y, z = getElementPosition(thePlayer)
					--		setElementPosition(thePlayer, x, y, z)
					--		outputChatBox("(( Vehicle: " .. getVehicleName(source) .. "  Faction: '" .. factionName .. "'. ))", thePlayer, 255, 204, 153)
					--			if not exports['global']:isPlayerAdmin(thePlayer) then
						--			exports['global']:sendMessageToAdmins("[AdmWarn] " .. getPlayerName(thePlayer):gsub("_"," ") .. " has entered a " .. getVehicleName(source) .. "(#" .. getElementData(source, "dbid") .. ") belonging to " .. factionName .. ".")
						--			end

					end
					local Impounded = getElementData(source,"Impounded")
					if (Impounded and Impounded > 0) then
						exports['anticheat-system']:changeProtectedElementDataEx(source, "enginebroke", 1, false)
						setVehicleDamageProof(source, true)
						setVehicleEngineState(source, false)
					end
					if (CanTowDriverEnter) then -- Nabs abusing
						return
					end
					local vjob = tonumber(getElementData(source, "job"))
					local job = getElementData(thePlayer, "job")
					local seat = getPedOccupiedVehicleSeat(thePlayer)

					if (vjob>0) and (seat==0) then
						if (job~=vjob) then
							if (vjob==1) then
								triggerClientEvent( thePlayer, "aoutput",thePlayer, "Job Vehicle","Você não é um motorista de entrega. Visite a prefeitura para fazer este trabalho ('C' no mapa F11) " ,3 )
								--outputChatBox("You are not a delivery driver. Visit city hall to obtain this job.", thePlayer, 255, 0, 0)
							elseif (vjob==2) then
								triggerClientEvent( thePlayer, "aoutput",thePlayer, "Job Vehicle","Você não é motorista de táxi. Visite a prefeitura para fazer este trabalho ('C' F11 no mapa) " ,3 )
								--outputChatBox("You are not a taxi driver. Visit city hall to obtain this job.", thePlayer, 255, 0, 0)
							elseif (vjob==3) then
								triggerClientEvent( thePlayer, "aoutput",thePlayer, "Job Vehicle","Você não é motorista de ônibus. Visite a prefeitura para fazer este trabalho ('C' F11 no mapa) " ,3 )
								--outputChatBox("You are not a bus driver. Visit city hall to obtain this job.", thePlayer, 255, 0, 0)
							end
							exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "realinvehicle", 0, false)
							removePedFromVehicle(thePlayer)
							local x, y, z = getElementPosition(thePlayer)
							setElementPosition(thePlayer, x, y, z)
						end
					end
				end
				--addEventHandler("onVehicleStartEnter", getRootElement(), removeFromFactionVehicle)

				-- engines dont break down
				function doBreakdown()
					if exports.global:hasItem(source, 74) then
						while exports.global:hasItem(source, 74) do
							exports.global:takeItem(source, 74)
						end

						blowVehicle(source)
					else
						local health = getElementHealth(source)
						local broke = getElementData(source, "enginebroke")

						if (health<=350) and (broke==0 or broke==false) then
							setElementHealth(source, 300)
							setVehicleDamageProof(source, true)
							setVehicleEngineState(source, false)
							exports['anticheat-system']:changeProtectedElementDataEx(source, "enginebroke", 1, false)
							exports['anticheat-system']:changeProtectedElementDataEx(source, "engine", 0, false)

							local player = getVehicleOccupant(source)
							if player then
								toggleControl(player, 'brake_reverse', false)
							end
						end
					end
				end
				addEventHandler("onVehicleDamage", getRootElement(), doBreakdown)

				------------------------------------------------
				-- SELLS A VEHICLE
				------------------------------------------------
				function sellVehicle(thePlayer, commandName, targetPlayerName)
					-- can only sell vehicles outdoor, in a dimension is property
					if isPedInVehicle(thePlayer) then
						if not targetPlayerName then
							outputChatBox("SYNTAX: /" .. commandName .. " [Nome do Jogador / id]", thePlayer, 255, 194, 14)
								outputChatBox("Vende o veículo em que você está para o jogador.", thePlayer, 255, 194, 14)
								outputChatBox("Peça ao comprador para usar /pay para receber o dinheiro do veículo.", thePlayer, 255, 194, 14)
								else
									local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
									if targetPlayer and getElementData(targetPlayer, "dbid") then
										local px, py, pz = getElementPosition(thePlayer)
										local tx, ty, tz = getElementPosition(targetPlayer)
										if getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz) < 20 then
											local theVehicle = getPedOccupiedVehicle(thePlayer)
											if theVehicle then
												local vehicleID = getElementData(theVehicle, "dbid")
												if getElementData(theVehicle,"rent")== 1 then
													outputChatBox("Você não pode vender um veículo alugado.",thePlayer,255,2,2)
													return
												end
												if getElementData(theVehicle, "owner") == getElementData(thePlayer, "dbid") or exports.global:isPlayerSuperAdmin(thePlayer) then
													if getElementData(targetPlayer, "dbid") ~= getElementData(theVehicle, "owner") then
														if exports.global:hasSpaceForItem(targetPlayer, 3) then
															if exports.global:canPlayerBuyVehicle(targetPlayer) then
																local query = mysql:query_free("UPDATE vehicles SET owner = '" .. mysql:escape_string(getElementData(targetPlayer, "dbid")) .. "' WHERE id='" .. mysql:escape_string(vehicleID) .. "'")
																if query then
																	exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "owner", getElementData(targetPlayer, "dbid"))

																	exports.global:takeItem(thePlayer, 3, vehicleID)
																	exports.global:giveItem(targetPlayer, 3, vehicleID)

																	exports.logs:logMessage("[VENDA] Carro #" .. vehicleID .. " foi vendido por " .. getPlayerName(thePlayer):gsub("_", " ") .. " para " .. targetPlayerName, 9)

																	outputChatBox("Você vendeu seu " .. getVehicleName(theVehicle) .. " para " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
																	outputChatBox((getPlayerName(thePlayer):gsub("_", " ")) .. " vendeu a você " .. getVehicleName(theVehicle) .. ".", targetPlayer, 0, 255, 0)
																else
																	outputChatBox("Error 09001 - Report on Forums.", thePlayer, 255, 0, 0)
																end
															else
																outputChatBox(targetPlayerName .. " já tem muitos veículos.", thePlayer, 255, 0, 0)
																outputChatBox((getPlayerName(thePlayer):gsub("_", " ")) .. " tentou vender-lhe um carro, mas você já tem muitos carros.", targetPlayer, 255, 0, 0)
															end
														else
															outputChatBox(targetPlayerName .. " não tem espaço para as chaves do veículo.", thePlayer, 255, 0, 0)
																outputChatBox((getPlayerName(thePlayer):gsub("_", " ")) .. "tentou vender um carro para você, mas você não tem espaço para uma chave.", targetPlayer, 255, 0, 0)
															end
														else
															outputChatBox("Você não pode vender seu próprio veículo para si mesmo.", thePlayer, 255, 0, 0)
														end
													else
														outputChatBox("Este veículo não é seu.", thePlayer, 255, 0, 0)
													end
												else
													outputChatBox("Você deve estar em um veículo.", thePlayer, 255, 0, 0)
												end
											else
												outputChatBox("Você está muito longe de " .. targetPlayerName .. ".", thePlayer, 255, 0, 0)
											end
										end
									end
								end
							end
							addCommandHandler("sell", sellVehicle)
							addEvent("sell",true)
							addEventHandler("sell",getRootElement(),sellVehicle)

							function lockUnlockInside(vehicle)
								local model = getElementModel(vehicle)
								local owner = getElementData(vehicle, "owner")
								local dbid = getElementData(vehicle, "dbid")

								if (owner ~= -2) then
									if ( getElementData(vehicle, "Impounded") or 0 ) == 0 then
										if not locklessVehicle[model] or exports.global:hasItem( source, 3, dbid ) then
											if (getElementData(source, "realinvehicle") == 1) then
												local locked = isVehicleLocked(vehicle)
												local seat = getPedOccupiedVehicleSeat(source)
												if seat == 0 or exports.global:hasItem( source, 3, dbid ) then
													if (locked) then
														setVehicleLocked(vehicle, false)
														exports.global:sendLocalMeAction(source, "destrancou o veículo.")
													else
														setVehicleLocked(vehicle, true)
														exports.global:sendLocalMeAction(source, "trancou o veículo.")
													end
												end
											end
										end
									else
										outputChatBox("((Você não pode bloquear veículos apreendidos. ))", source, 255, 195, 14)
									end
								else
									outputChatBox("(( Você não pode trancar veículos do governo. ))", source, 255, 195, 14)
									end

								end
								addEvent("lockUnlockInsideVehicle", true)
								addEventHandler("lockUnlockInsideVehicle", getRootElement(), lockUnlockInside)


								local storeTimers = { }

								function lockUnlockOutside(vehicle)
									if (not source or exports.global:isPlayerAdmin(source)) or ( getElementData(vehicle, "Impounded") or 0 ) == 0 then
										local dbid = getElementData(vehicle, "dbid")

										exports.global:applyAnimation(source, "GHANDS", "gsign3LH", 2000, false, false, false)

										if (isVehicleLocked(vehicle)) then
											setVehicleLocked(vehicle, false)
											exports.global:sendLocalMeAction(source, "destravou o veículo. ((" .. getVehicleName(vehicle) .. "))")

											if not (exports.global:hasItem(source, 3, dbid) or (getElementData(source, "faction") > 0 and getElementData(source, "faction") == getElementData(vehicle, "faction"))) then
												exports.logs:logMessage("[VEICULO-DESTRANCADO] Veículo #" .. dbid .. " foi destrancado por " .. getPlayerName(source), 21)
											end
										else
											setVehicleLocked(vehicle, true)
											exports.global:sendLocalMeAction(source, "travou o veículo. ((" .. getVehicleName(vehicle) .. "))")

											if not (exports.global:hasItem(source, 3, dbid) or (getElementData(source, "faction") > 0 and getElementData(source, "faction") == getElementData(vehicle, "faction"))) then
												exports.logs:logMessage("[VEICULO-TRANCADO] Veículo #" .. dbid .. " foi trancado por " .. getPlayerName(source), 21)
											end
										end

										if (storeTimers[vehicle] == nil) or not (isTimer(storeTimers[vehicle])) then
											storeTimers[vehicle] = setTimer(storeVehicleLockState, 180000, 1, vehicle, dbid)
										end
									end
								end
								addEvent("lockUnlockOutsideVehicle", true)
								addEventHandler("lockUnlockOutsideVehicle", getRootElement(), lockUnlockOutside)

								function storeVehicleLockState(vehicle, dbid)
									if (isElement(vehicle)) then
										local locked = isVehicleLocked(vehicle)
										local state = 0

										if (locked) then state = 1
										elseif (not locked) then state = 0 end

										local query = mysql:query_free("UPDATE vehicles SET locked='" .. mysql:escape_string(state) .. "' WHERE id='" .. mysql:escape_string(dbid) .. "' LIMIT 1")

										storeTimers[vehicle] = nil
									end
								end

								function fillFuelTank(veh, fuel)
									local currFuel = getElementData(veh, "fuel")
									local engine = getElementData(veh, "engine")
									if (math.ceil(currFuel)==100) then
										outputChatBox("O veículo já está cheio.", source)
									elseif (fuel==0) then
										outputChatBox("A gasolina acabou", source, 255, 0, 0)
									elseif (engine==1) then
										outputChatBox("Você não pode abastecer veículos em movimento. Por favor, desligue o motor primeiro.", source, 255, 0, 0)
									else
										local fuelAdded = fuel

										if (fuelAdded+currFuel>100) then
											fuelAdded = 100 - currFuel
										end

										outputChatBox("You added " .. math.ceil(fuelAdded) .. " litres of petrol to your car from your fuel can.", source, 0, 255, 0 )

										local gender = getElementData(source, "gender")
										local genderm = "dele"
										if (gender == 1) then
											genderm = "dela"
										end
										exports.global:sendLocalMeAction(source, "preencher " .. genderm .. " veículo de um pequeno depósito de gasolina.")

										exports.global:takeItem(source, 57, fuel)
										exports.global:giveItem(source, 57, math.ceil(fuel-fuelAdded))

										exports['anticheat-system']:changeProtectedElementDataEx(veh, "fuel", currFuel+fuelAdded, false)
										triggerClientEvent(source, "syncFuel", veh, currFuel+fuelAdded)
										--triggerClientEvent(source, "setClientFuel", source, currFuel+fuelAdded)
									end
								end
								addEvent("fillFuelTankVehicle", true)
								addEventHandler("fillFuelTankVehicle", getRootElement(), fillFuelTank)

								function getYearDay(thePlayer)
									local time = getRealTime()
									local currYearday = time.yearday

									outputChatBox("Year day is " .. currYearday, thePlayer)
								end
								addCommandHandler("yearday", getYearDay)

								function removeNOS(theVehicle)
									removeVehicleUpgrade(theVehicle, getVehicleUpgradeOnSlot(theVehicle, 8))
									exports.global:sendLocalMeAction(source, "remove o NOS do " .. getVehicleName(theVehicle) .. ".")
									end
									addEvent("removeNOS", true)
									addEventHandler("removeNOS", getRootElement(), removeNOS)

									-- /VEHPOS /PARK
									local destroyTimers = { }
									function createShopVehicle(dbid, ...)
										local veh = createVehicle(unpack({...}))
										exports.pool:allocateElement(veh, dbid)

										exports['anticheat-system']:changeProtectedElementDataEx(veh, "dbid", dbid)
										exports['anticheat-system']:changeProtectedElementDataEx(veh, "requires.vehpos", 1, false)
										local timer = setTimer(checkVehpos, 3600000, 1, veh, dbid)
										table.insert(destroyTimers, {timer, dbid})

										exports['vehicle-interiors']:add( veh )

										return veh
									end

									function checkVehpos(veh, dbid)
										local requires = getElementData(veh, "requires.vehpos")

										if (requires) then
											if (requires==1) then
												local id = tonumber(getElementData(veh, "dbid"))

												if (id==dbid) then
													exports.logs:logMessage("[VEHPOS DELETE] car #" .. id .. " was deleted", 9)
													destroyElement(veh)
													local query = mysql:query_free("DELETE FROM vehicles WHERE id='" .. mysql:escape_string(id) .. "' LIMIT 1")

													call( getResourceFromName( "item-system" ), "clearItems", veh )
													call( getResourceFromName( "item-system" ), "deleteAll", 3, id )
												end
											end
										end
									end
									-- VEHPOS
									local PershingSquareCol = createColRectangle( 1420, -1775, 130, 257 )
									local HospitalCol = createColRectangle( 1166, -1384, 52, 92 )

									function setVehiclePosition(thePlayer, commandName)
										local veh = getPedOccupiedVehicle(thePlayer)
										if not veh or getElementData(thePlayer, "realinvehicle") == 0 then
											outputChatBox("You are not in a vehicle.", thePlayer, 255, 0, 0)
										else
											if call( getResourceFromName("tow-system"), "cannotVehpos", thePlayer ) then
												outputChatBox("Only Los Santos Towing and Recovery is allowed to park their vehicles on the Impound Lot.", thePlayer, 255, 0, 0)
											elseif isElementWithinColShape( thePlayer, HospitalCol ) and getElementData( thePlayer, "faction" ) ~= 2 and not exports.global:isPlayerAdmin(thePlayer) then
												outputChatBox("Only Los Santos Emergency Service is allowed to park their vehicles in front of the Hospital.", thePlayer, 255, 0, 0)
											elseif isElementWithinColShape( thePlayer, PershingSquareCol ) and getElementData( thePlayer, "faction" ) ~= 1  and not exports.global:isPlayerAdmin(thePlayer) then
												outputChatBox("Only Los Santos Police Department is allowed to park their vehicles on Pershing Square.", thePlayer, 255, 0, 0)
											else
												local playerid = getElementData(thePlayer, "dbid")
												local playerfl = getElementData(thePlayer, "factionleader")
												local playerfid = getElementData(thePlayer, "faction")
												local owner = getElementData(veh, "owner")
												local dbid = getElementData(veh, "dbid")
												local carfid = getElementData(veh, "faction")
												local x, y, z = getElementPosition(veh)
												local TowingReturn = call(getResourceFromName("tow-system"), "CanTowTruckDriverVehPos", thePlayer) -- 2 == in towing and in col shape, 1 == colshape only, 0 == not in col shape
												if (owner==playerid and TowingReturn == 0) or (exports.global:hasItem(thePlayer, 3, dbid)) or (TowingReturn == 2) or (exports.global:isPlayerAdmin(thePlayer) and exports.logs:logMessage("[AVEHPOS] " .. getPlayerName( thePlayer ) .. " parked car #" .. dbid .. " at " .. x .. ", " .. y .. ", " .. z, 9)) then
													if (dbid<0) then
														outputChatBox("This vehicle is not permanently spawned.", thePlayer, 255, 0, 0)
													else
														if (call(getResourceFromName("tow-system"), "CanTowTruckDriverGetPaid", thePlayer)) then
															-- pd has to pay for this impound
															exports.global:giveMoney(getTeamFromName("Los Santos Towing and Recovery"), 75)
															exports.global:takeMoney(getTeamFromName("Los Santos Police Department"), 75)
														end
														exports['anticheat-system']:changeProtectedElementDataEx(veh, "requires.vehpos")
														local rx, ry, rz = getVehicleRotation(veh)

														local interior = getElementInterior(thePlayer)
														local dimension = getElementDimension(thePlayer)
														zone = getZoneName(x,y,z)
														local query = mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(rx) .. "', currry='" .. mysql:escape_string(ry) .. "', currrz='" .. mysql:escape_string(rz) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "' WHERE id='" .. mysql:escape_string(dbid) .. "'")
														setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
														exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
														exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior)
														exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension)
														outputChatBox("Vehicle spawn position set at "..zone.."."	, thePlayer,0,255,0)

														for key, value in ipairs(destroyTimers) do
															if (tonumber(destroyTimers[key][2]) == dbid) then
																local timer = destroyTimers[key][1]

																if (isTimer(timer)) then
																	killTimer(timer)
																	table.remove(destroyTimers, key)
																end
															end
														end

														if ( getElementData(veh, "Impounded") or 0 ) > 0 then
															local owner = getPlayerFromName( exports['cache']:getCharacterName( getElementData( veh, "owner" ) ) )
															if isElement( owner ) and exports.global:hasItem( owner, 2 ) then
																outputChatBox("((Los Santos Towing & Recovery)) #999 [SMS]: Your " .. getVehicleName(veh) .. " has been impounded. Head over to the Impound to release it.", owner, 120, 255, 80)
															end
														end
													end
												end
											end
										end
									end
									addCommandHandler("vehpos", setVehiclePosition, false, false)
									addCommandHandler("park", setVehiclePosition, false, false)
									addEvent("vehpos",true)
									addEventHandler("vehpos",getRootElement(),setVehiclePosition)

									function setVehiclePosition2(thePlayer, commandName, vehicleID)
										if exports.global:isPlayerAdmin( thePlayer ) then
											local vehicleID = tonumber(vehicleID)
											if not vehicleID or vehicleID < 0 then
												outputChatBox( "SYNTAX: /" .. commandName .. " [vehicle id]", thePlayer, 255, 194, 14 )
											else
												local veh = exports.pool:getElement("vehicle", vehicleID)
												if veh then
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "requires.vehpos")
													local x, y, z = getElementPosition(veh)
													local rx, ry, rz = getVehicleRotation(veh)

													local interior = getElementInterior(thePlayer)
													local dimension = getElementDimension(thePlayer)

													local query = mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(rx) .. "', currry='" .. mysql:escape_string(ry) .. "', currrz='" .. mysql:escape_string(rz) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "' WHERE id='" .. mysql:escape_string(vehicleID) .. "'")
													setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension)
													outputChatBox("Vehicle spawn position for #" .. vehicleID .. " set.", thePlayer)

													for key, value in ipairs(destroyTimers) do
														if (tonumber(destroyTimers[key][2]) == vehicleID) then
															local timer = destroyTimers[key][1]

															if (isTimer(timer)) then
																killTimer(timer)
																table.remove(destroyTimers, key)
															end
														end
													end

													if ( getElementData(veh, "Impounded") or 0 ) > 0 then
														local owner = getPlayerFromName( exports['cache']:getCharacterName( getElementData( veh, "owner" ) ) )
														if isElement( owner ) and exports.global:hasItem( owner, 2 ) then
															outputChatBox("((Los Santos Towing & Recovery)) #999 [SMS]: Your " .. getVehicleName(veh) .. " has been impounded. Head over to the Impound to release it.", owner, 120, 255, 80)
														end
													end
													exports.logs:logMessage("[AVEHPOS] " .. getPlayerName( thePlayer ) .. " parked car #" .. vehicleID .. " at " .. x .. ", " .. y .. ", " .. z, 9)
												else
													outputChatBox("Vehicle not found.", thePlayer, 255, 0, 0 )
												end
											end
										end
									end
									addCommandHandler("avehpos", setVehiclePosition2, false, false)
									addCommandHandler("apark", setVehiclePosition2, false, false)

									function setVehiclePosition3(veh)
										if call( getResourceFromName("tow-system"), "cannotVehpos", source ) then
											outputChatBox("Only Los Santos Towing and Recovery is allowed to park their vehicles on the Impound Lot.", source, 255, 0, 0)
										elseif isElementWithinColShape( source, HospitalCol ) and getElementData( source, "faction" ) ~= 2 and not exports.global:isPlayerAdmin(source) then
											outputChatBox("Only Los Santos Emergency Service is allowed to park their vehicles in front of the Hospital.", source, 255, 0, 0)
										elseif isElementWithinColShape( source, PershingSquareCol ) and getElementData( source, "faction" ) ~= 1  and not exports.global:isPlayerAdmin(source) then
											outputChatBox("Only Los Santos Police Department is allowed to park their vehicles on Pershing Square.", source, 255, 0, 0)
										else
											local playerid = getElementData(source, "dbid")
											local owner = getElementData(veh, "owner")
											local dbid = getElementData(veh, "dbid")
											local x, y, z = getElementPosition(veh)
											local TowingReturn = call(getResourceFromName("tow-system"), "CanTowTruckDriverVehPos", source) -- 2 == in towing and in col shape, 1 == colshape only, 0 == not in col shape
											if (owner==playerid and TowingReturn == 0) or (exports.global:hasItem(source, 3, dbid)) or (TowingReturn == 2) or (exports.global:isPlayerAdmin(source) and exports.logs:logMessage("[AVEHPOS] " .. getPlayerName( source ) .. " parked car #" .. dbid .. " at " .. x .. ", " .. y .. ", " .. z, 9)) then
												if (dbid<0) then
													outputChatBox("This vehicle is not permanently spawned.", source, 255, 0, 0)
												else
													if (call(getResourceFromName("tow-system"), "CanTowTruckDriverGetPaid", source)) then
														-- pd has to pay for this impound
														exports.global:giveMoney(getTeamFromName("Los Santos Towing and Recovery"), 75)
														exports.global:takeMoney(getTeamFromName("Los Santos Police Department"), 75)
													end
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "requires.vehpos")
													local rx, ry, rz = getVehicleRotation(veh)

													local interior = getElementInterior(source)
													local dimension = getElementDimension(source)

													local query = mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(rx) .. "', currry='" .. mysql:escape_string(ry) .. "', currrz='" .. mysql:escape_string(rz) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "' WHERE id='" .. mysql:escape_string(dbid) .. "'")
													setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior)
													exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension)
													outputChatBox("Vehicle spawn position set.", source)

													for key, value in ipairs(destroyTimers) do
														if (tonumber(destroyTimers[key][2]) == dbid) then
															local timer = destroyTimers[key][1]

															if (isTimer(timer)) then
																killTimer(timer)
																table.remove(destroyTimers, key)
															end
														end
													end

													if ( getElementData(veh, "Impounded") or 0 ) > 0 then
														local owner = getPlayerFromName( exports['cache']:getCharacterName( getElementData( veh, "owner" ) ) )
														if isElement( owner ) and exports.global:hasItem( owner, 2 ) then
															outputChatBox("((Los Santos Towing & Recovery)) #999 [SMS]: Your " .. getVehicleName(veh) .. " has been impounded. Head over to the Impound to release it.", owner, 120, 255, 80)
														end
													end
												end
											else
												outputChatBox( "You can't park this vehicle.", source, 255, 0, 0 )
											end
										end
									end
									addEvent( "parkVehicle", true )
									addEventHandler( "parkVehicle", getRootElement( ), setVehiclePosition3 )

									function setVehiclePosition4(thePlayer, commandName)
										local veh = getPedOccupiedVehicle(thePlayer)
										if not veh or getElementData(thePlayer, "realinvehicle") == 0 then
											outputChatBox("You are not in a vehicle.", thePlayer, 255, 0, 0)
										else
											local playerid = getElementData(thePlayer, "dbid")
											local playerfl = getElementData(thePlayer, "factionleader")
											local playerfid = getElementData(thePlayer, "faction")
											local owner = getElementData(veh, "owner")
											local dbid = getElementData(veh, "dbid")
											local carfid = getElementData(veh, "faction")
											if (playerfl == 1) and (playerfid==carfid) then
												exports['anticheat-system']:changeProtectedElementDataEx(veh, "requires.vehpos")

												local x, y, z = getElementPosition(veh)
												local rx, ry, rz = getVehicleRotation(veh)

												local interior = getElementInterior(thePlayer)
												local dimension = getElementDimension(thePlayer)

												local query = mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(rx) .. "', currry='" .. mysql:escape_string(ry) .. "', currrz='" .. mysql:escape_string(rz) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "' WHERE id='" .. mysql:escape_string(dbid) .. "'")
												setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
												exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
												exports['anticheat-system']:changeProtectedElementDataEx(veh, "interior", interior)
												exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", dimension)
												outputChatBox("Vehicle spawn position for #" .. dbid .. " set.", thePlayer)

												for key, value in ipairs(destroyTimers) do
													if (tonumber(destroyTimers[key][2]) == dbid) then
														local timer = destroyTimers[key][1]

														if (isTimer(timer)) then
															killTimer(timer)
															table.remove(destroyTimers, key)
														end
													end
												end

												if ( getElementData(veh, "Impounded") or 0 ) > 0 then
													local owner = getPlayerFromName( exports['cache']:getCharacterName( getElementData( veh, "owner" ) ) )
													if isElement( owner ) and exports.global:hasItem( owner, 2 ) then
														outputChatBox("((Los Santos Towing & Recovery)) #999 [SMS]: Your " .. getVehicleName(veh) .. " has been impounded. Head over to the Impound to release it.", owner, 120, 255, 80)
													end
												end
											end
										end
									end
									addCommandHandler("fvehpos", setVehiclePosition4, false, false)
									addCommandHandler("fpark", setVehiclePosition4, false, false)

									function quitPlayer ( quitReason )
										if (quitReason == "Timed out") then -- if timed out
											if (isPedInVehicle(source)) then -- if in vehicle
												local vehicleSeat = getPedOccupiedVehicleSeat(source)
												if (vehicleSeat == 0) then	-- is in driver seat?
													local theVehicle = getPedOccupiedVehicle(source)
													local dbid = tonumber(getElementData(theVehicle, "dbid"))
													if (exports.global:hasItem(source, 3, dbid)) then -- has the player a key for this vehicle?
														if not isVehicleLocked(theVehicle) then -- check if the vehicle aint locked already
															local passenger1 = getVehicleOccupant( theVehicle , 1 )
															local passenger2 = getVehicleOccupant( theVehicle , 2 )
															local passenger3 = getVehicleOccupant( theVehicle , 3 )
															if (passenger1 == false) then -- Nobody in passenger seat 1
																if (passenger2 == false) then -- check seat 2
																	if (passenger3 == false) then -- and finally check seat 3
																		lockUnlockOutside(theVehicle)
																		local engine = getElementData(theVehicle, "engine")
																		if engine == 1 then -- stop the engine when its running
																			setVehicleEngineState(theVehicle, false)
																			exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "engine", 0, false)
																		end
																		exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "handbrake", 1, false)
																		setElementFrozen(theVehicle, true)
																	end
																end
															end
														end
													end
												end
											end
										end
									end
									addEventHandler("onPlayerQuit",getRootElement(), quitPlayer)

									function detachVehicle(thePlayer)
										if isPedInVehicle(thePlayer) and getPedOccupiedVehicleSeat(thePlayer) == 0 then
											local veh = getPedOccupiedVehicle(thePlayer)
											if getVehicleTowedByVehicle(veh) then
												detachTrailerFromVehicle(veh)
												outputChatBox("The trailer was detached.", thePlayer, 0, 255, 0)
											else
												outputChatBox("There is no trailer...", thePlayer, 255, 0, 0)
											end
										end
									end

									safeTable = {}

									function addSafe( dbid, x, y, z, rz, interior )
										local tempobject = createObject(2332, x, y, z, 0, 0, rz)
										setElementInterior(tempobject, interior)
										setElementDimension(tempobject, dbid + 20000)
										safeTable[dbid] = tempobject
									end

									function removeSafe( dbid )
										if safeTable[dbid] then
											destroyElement(safeTable[dbid])
											safeTable[dbid] = nil
										end
									end

									function getSafe( dbid )
										return safeTable[dbid]
									end
