armoredCars = { [427]=true, [528]=true, [432]=true, [601]=true, [428]=true, [597]=true } -- Enforcer, FBI Truck, Rhino, SWAT Tank, Securicar, SFPD Car

local btrdiscountratio = 1.5

-- Bodywork repair
function bodyworkRepair(veh)
	if (veh) then
		local mechcost = 50
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford the parts to repair this vehicle's bodywork.", source, 255, 0, 0)
		else
			local health = getElementHealth(veh)
			fixVehicle(veh)
			setElementHealth(veh, health)
			exports.global:sendLocalMeAction(source, "repairs the vehicle's body work.")
		end
	else
		outputChatBox("You need to be in the vehicle you want to repair.", source, 255, 0, 0)
	end
end
addEvent("repairBody", true)
addEventHandler("repairBody", getRootElement(), bodyworkRepair)

-- Full Service
function serviceVehicle(veh)
	if (veh) then
		local mechcost = 100
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford the parts to service this vehicle.", source, 255, 0, 0)
		else
			fixVehicle(veh)
			if not getElementData(veh, "Impounded") or getElementData(veh, "Impounded") == 0 then
				exports['anticheat-system']:changeProtectedElementDataEx(veh, "enginebroke", 0, false)
				if armoredCars[ getElementModel( veh ) ] then
					setVehicleDamageProof(veh, true)
				else
					setVehicleDamageProof(veh, false)
				end
			end
			exports.global:sendLocalMeAction(source, "services the vehicle.")
		end
	else
		outputChatBox("You must be in the vehicle you want to service.", source, 255, 0, 0)
	end
end
addEvent("serviceVehicle", true)
addEventHandler("serviceVehicle", getRootElement(), serviceVehicle)

function changeTyre( veh, wheelNumber )
	if (veh) then
		local mechcost = 10
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford the parts to change this vehicle's tyres.", source, 255, 0, 0)
		else
			local wheel1, wheel2, wheel3, wheel4 = getVehicleWheelStates( veh )

			if (wheelNumber==1) then -- front left
				outputDebugString("Tyre 1 changed.")
				setVehicleWheelStates ( veh, 0, wheel2, wheel3, wheel4 )
			elseif (wheelNumber==2) then -- back left
				outputDebugString("Tyre 2 changed.")
				setVehicleWheelStates ( veh, wheel1, wheel2, 0, wheel4 )
			elseif (wheelNumber==3) then -- front right
				outputDebugString("Tyre 3 changed.")
				setVehicleWheelStates ( veh, wheel1, 0, wheel2, wheel4 )
			elseif (wheelNumber==4) then -- back right
				outputDebugString("Tyre 4 changed.")
				setVehicleWheelStates ( veh, wheel1, wheel2, wheel3, 0 )
			end
			exports.global:sendLocalMeAction(source, "replaces the vehicle's tyre.")
		end
	end
end
addEvent("tyreChange", true)
addEventHandler("tyreChange", getRootElement(), changeTyre)

function changePaintjob( veh, paintjob )
	if (veh) then
		local mechcost = 7500
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford to repaint this vehicle.", source, 255, 0, 0)
		else
			triggerEvent( "paintjobEndPreview", source, veh )
			if setVehiclePaintjob( veh, paintjob ) then
				local col1, col2 = getVehicleColor( veh )
				if col1 == 0 or col2 == 0 then
					setVehicleColor( veh, 1, 1, 1 )
				end
				exports.logs:logMessage("[/changePaintJob] " .. getPlayerName(source) .." / ".. getPlayerIP(source)  .." OR " .. getPlayerName(client)  .." / ".. getPlayerIP(client)  .." changed vehicle " .. getElementData(veh, "dbid") .. " their colors to " .. col1 .. "-" .. col2, 29)
				exports.global:sendLocalMeAction(source, "repaints the vehicle.")
			
				exports['savevehicle-system']:saveVehicleMods(veh)
			else
				outputChatBox("This car already has this paintjob.", source, 255, 0, 0)
			end
		end
	end
end
addEvent("paintjobChange", true)
addEventHandler("paintjobChange", getRootElement(), changePaintjob)

function changelight( veh, red,green,blue )
	if (veh) then
		local mechcost = 2000
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford to change lights of this vehicle.", source, 255, 0, 0)
		else
			triggerEvent( "lightEndPreview", source, veh )
		
			setVehicleHeadLightColor ( veh, red, green,blue)
	
			exports.logs:logMessage("[/changelight] " .. getPlayerName(source) .." / ".. getPlayerIP(source)  .." OR " .. getPlayerName(client)  .." / ".. getPlayerIP(client)  .." changed vehicle " .. getElementData(veh, "dbid") .. " their light colors to " .. red .. "-" .. green.."-"..blue, 29)
			exports.global:sendLocalMeAction(source, "changes lights of the vehicle.")
			exports['savevehicle-system']:saveVehicleMods(veh)
		end
	end
end
addEvent("lightchange", true)
addEventHandler("lightchange", getRootElement(), changelight)

function changeVehicleUpgrade( veh, upgrade, name, cost )
	if (veh) then
		local mechcost = cost
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:hasMoney( source, mechcost ) then
			outputChatBox("You can't afford to add " .. name .. " to this vehicle.", source, 255, 0, 0)
		else
			for i = 0, 16 do
				if upgrade == getVehicleUpgradeOnSlot( veh, i ) then
					outputChatBox("This car already has this upgrade.", source, 255, 0, 0)
					return
				end
			end
			if addVehicleUpgrade( veh, upgrade ) then
				exports.global:takeMoney(source, cost)
				exports.logs:logMessage("[changeVehicleUpgrade] " .. getPlayerName(source) .."/ " .. getPlayerIP(source)  .. " OR " .. getPlayerName(client)  .."/ " .. getPlayerIP(client)  .. "  changed vehicle " .. getElementData(veh, "dbid") .. ": added " .. name .. " to the vehicle.", 29)
				exports.global:sendLocalMeAction(source, "added " .. name .. " to the vehicle.")
				exports['savevehicle-system']:saveVehicleMods(veh)
			else
				outputChatBox("Failed to apply the car upgrade.", source, 255, 0, 0)
			end
		end
	end
end
addEvent("changeVehicleUpgrade", true)
addEventHandler("changeVehicleUpgrade", getRootElement(), changeVehicleUpgrade)

function changeVehicleColour(veh, col1, col2, col3 ,col21, col22, col23)
	if (veh) then
		local mechcost = 100
		if (getElementData(source,"faction")==30) then
			mechcost = mechcost / btrdiscountratio
		end
		if not exports.global:takeMoney(source, mechcost) then
			outputChatBox("You can't afford to repaint this vehicle.", source, 255, 0, 0)
		else
			exCol1, exCol2, exCol3 = getVehicleColor ( veh )
			
			if not col1 then col1 = exCol1 end
			if not col2 then col2 = exCol2 end
			if not col3 then col3 = exCol3 end
			setVehicleColor ( veh, col1, col2, col3, col21, col22, col23)
			exports.logs:logMessage("[repaintVehicle] " .. getPlayerName(source) .." ".. getPlayerIP(source) .." OR ".. getPlayerName(client) .."/"..getPlayerIP(client)  .." changed vehicle " .. getElementData(veh, "dbid") .. " colors to ".. col1 .. "-" .. col2, 29)
			exports.global:sendLocalMeAction(source, "repaints the vehicle.")
			exports['savevehicle-system']:saveVehicleMods(veh)
		end
	end
end
addEvent("repaintVehicle", true)
addEventHandler("repaintVehicle", getRootElement(), changeVehicleColour)

--Installing and Removing vehicle tinted windows
function changeVehicleTint(veh, stat)
	if veh and stat then
		if stat == 1 then
			local leader = tonumber(getElementData(source, "factionleader"))
			if leader == 1 then
				local mechcost = 10000
				if (getElementData(source,"faction")==30) then
					mechcost = mechcost / 2
				end
				if not exports.global:takeMoney(source, mechcost) then
					outputChatBox("You can't afford to add Tint to this vehicle.", source, 255, 0, 0)
				else
					local vehID = getElementData(veh, "dbid")
					exports.global:sendLocalMeAction(source, "begins to placing tint on the windows.")

					local query = mysql:query_free("UPDATE vehicles SET tintedwindows = '1' WHERE id='" .. mysql:escape_string(vehID) .. "'")
					if query then
						for i = 0, getVehicleMaxPassengers(veh) do
							local player = getVehicleOccupant(veh, i)
							if (player) then
								triggerEvent("setTintName", veh, player)
							end
						end
						
						exports['anticheat-system']:changeProtectedElementDataEx(veh, "tinted", true, true)
						outputChatBox("You have added tint to the vehicle windows.", source)
						exports.global:sendLocalMeAction(source, "adds tint to the windows.")
						
						exports.logs:logMessage("[ADD TINT-BTR] " .. getPlayerName(source):gsub("_"," ") .. " has added tint to vehicle #" .. vehID .. " - " .. getVehicleName(veh) .. ".", 9)
					else
						outputChatBox("There was an issues adding the tint. Please report on mantis", source, 255, 0, 0)				
					end
				end
			else
				outputChatBox("Faction Leaders Only!", source, 255, 0, 0)
			end
		elseif stat == 2 then
			local mechcost = 2000
			if (getElementData(source,"faction")==30) then
				mechcost = mechcost / 2
			end
			if not exports.global:takeMoney(source, mechcost) then
				outputChatBox("You can't afford to add tint to this vehicle.", source, 255, 0, 0)
			else
				local vehID = getElementData(veh, "dbid")
				exports.global:sendLocalMeAction(source, "begins to remove tint from the windows.")
			
				local query = mysql:query_free("UPDATE vehicles SET tintedwindows = '0' WHERE id='" .. mysql:escape_string(vehID) .. "'")
				if query then
					for i = 0, getVehicleMaxPassengers(veh) do
						local player = getVehicleOccupant(veh, i)
						if (player) then
							triggerEvent("resetTintName", veh, player)
						end
					end

					exports['anticheat-system']:changeProtectedElementDataEx(veh, "tinted", false, true)
					outputChatBox("You have cleared the tint from the vehicle windows.", source)
					exports.global:sendLocalMeAction(source, "removed tint to the windows.")
					
					exports.logs:logMessage("[REMOVED TINT-BTR] " .. getPlayerName(source):gsub("_"," ") .. " has removed tint from vehicle #" .. vehID .. " - " .. getVehicleName(veh) .. ".", 9)
				else
					outputChatBox("There was an issues removing the tint. Please report on mantis", source, 255, 0, 0)
				end
			end
		end
	end
end
addEvent("tintedWindows", true)
addEventHandler("tintedWindows", getRootElement(), changeVehicleTint)