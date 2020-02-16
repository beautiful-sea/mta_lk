wRightClick = nil
bInventory = nil
bCloseMenu = nil
ax, ay = nil
localPlayer = getLocalPlayer()
vehicle = nil

function requestInventory(button)
	if button=="left" and not getElementData(localPlayer, "exclusiveGUI") then
		if isVehicleLocked(vehicle) and vehicle ~= getPedOccupiedVehicle(localPlayer) then
			triggerServerEvent("onVehicleRemoteAlarm", vehicle)
			outputChatBox("Este veículo está trancado.", 255, 0, 0)
		elseif type(getElementData(vehicle, "Impounded")) == "number" and getElementData(vehicle, "Impounded") > 0 and not exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) then
			outputChatBox("Você precisa das chaves para abrir neste veículo.", 255, 0, 0)
		else
		outputChatBox("requestInventory")
			
			triggerServerEvent( "openFreakinInventory", localPlayer, vehicle, ax, ay )
		end
		hideVehicleMenu()
	end
end

function clickVehicle(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="vehicle") and (button=="right") and (state=="down") and not (wInventory) then
		local x, y, z = getElementPosition(localPlayer)
		
		if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
			if (wRightClick) then
				hideVehicleMenu()
			end
			showCursor(true)
			ax = absX
			ay = absY
			vehicle = element
			showVehicleMenu()
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickVehicle, true)

--Needs to be redone to run better
function isNotAllowedV(theVehicle)
	local vmodel = getElementModel(theVehicle)
	if (getVehicleType(vmodel) == "Plane") then
		return true
	end
	if (getVehicleType(vmodel) == "Helicopter") then
		return true
	end
	if (getVehicleType(vmodel) == "Boat") then
		return true
	end
	if (getVehicleType(vmodel) == "Train") then
		return true
	end
	if (getVehicleType(vmodel) == "Trailer") then
		return true
	end
	return false
end

function showVehicleMenu()
	local y = 0.10
	wRightClick = guiCreateWindow(ax, ay, 150, 200, getVehicleName(vehicle), false)
	
	lPlate = guiCreateLabel(0.05, y, 0.87, 0.1, "Placa: " .. getVehiclePlateText(vehicle), true, wRightClick)
	guiSetFont(lPlate, "default-bold-small")
	y = y + 0.1

	if (isVehicleImpounded(vehicle)) then
		lImpounded = guiCreateLabel(0.05, y, 0.87, 0.1, "Apreendido: Sim", true, wRightClick)
		guiSetFont(lImpounded, "default-bold-small")
		y = y + 0.1
	end
	
	if (hasVehicleWindows(vehicle)) then
		local windowState = isVehicleWindowUp(vehicle, true) and "Fechada" or "Aberta"
		lWindows = guiCreateLabel(0.05, y, 0.87, 0.1, "Janela: " .. windowState , true, wRightClick)
		guiSetFont(lWindows, "default-bold-small")
		y = y + 0.1
	end
	
	bInventory = guiCreateButton(0.05, y, 0.87, 0.1, "Inventario", true, wRightClick)
	addEventHandler("onClientGUIClick", bInventory, requestInventory, false)
	y = y + 0.14
	
	if ( getPedSimplestTask(localPlayer) == "TASK_SIMPLE_CAR_DRIVE" and getPedOccupiedVehicle(localPlayer) == vehicle ) or exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) or (getElementData(localPlayer, "faction") > 0 and getElementData(localPlayer, "faction") == getElementData(vehicle, "faction")) then
		bLockUnlock = guiCreateButton(0.05, y, 0.87, 0.1, "Lock/Unlock", true, wRightClick)
		addEventHandler("onClientGUIClick", bLockUnlock, lockUnlock, false)
		y = y + 0.14
	end

	if getElementDimension(localPlayer) >= 0 or getElementInterior(localPlayer) >= 0 or isNotAllowedV(vehicle) or getElementData(localPlayer, "faction") == 30 then
		if getElementData(localPlayer, "job") == 5 or getElementData(localPlayer, "faction") == 30 then -- Mechanic or BTR
			bFix = guiCreateButton(0.05, y, 0.87, 0.1, "Arrumar/Melhorar", true, wRightClick)
			addEventHandler("onClientGUIClick", bFix, openMechanicWindow, false)
			y = y + 0.14
		end
	end
	
	local vx,vy,vz = getElementVelocity(vehicle)
	if vx < 0.05 and vy < 0.05 and vz < 0.05 and not getPedOccupiedVehicle(localPlayer) and not isVehicleLocked(vehicle) then -- completely stopped
		local trailers = { [606] = true, [607] = true, [610] = true, [590] = true, [569] = true, [611] = true, [584] = true, [608] = true, [435] = true, [450] = true, [591] = true }
		if trailers[ getElementModel( vehicle ) ] then
			if exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) then
				bPark = guiCreateButton(0.05, y, 0.87, 0.1, "Estacionamento", true, wRightClick)
				addEventHandler("onClientGUIClick", bPark, parkTrailer, false)
				y = y + 0.14
			end
		else
			if exports.global:hasItem(localPlayer, 57) then -- FUEL CAN
				bFill = guiCreateButton(0.05, y, 0.87, 0.1, "Encha o tanque", true, wRightClick)
				addEventHandler("onClientGUIClick", bFill, fillFuelTank, false)
				y = y + 0.14
			end
		end
	end
	
	if (getElementModel(vehicle)==497) then -- HELICOPTER
		local players = getElementData(vehicle, "players")
		local found = false
		
		if (players) then
			for key, value in ipairs(players) do
				if (value==localPlayer) then
					found = true
				end
			end
		end
		
		if not (found) then
			bSit = guiCreateButton(0.05, y, 0.87, 0.1, "Sentar", true, wRightClick)
			addEventHandler("onClientGUIClick", bSit, sitInHelicopter, false)
		else
			bSit = guiCreateButton(0.05, y, 0.87, 0.1, "Levantar", true, wRightClick)
			addEventHandler("onClientGUIClick", bSit, unsitInHelicopter, false)
		end
		y = y + 0.14
	end
	
	local entrance = getElementData( vehicle, "entrance" )
	if entrance and not isPedInVehicle( localPlayer ) then
		bEnter = guiCreateButton(0.05, y, 0.87, 0.1, "Entrar", true, wRightClick)
		addEventHandler("onClientGUIClick", bEnter, enterInterior, false)
		y = y + 0.14

		bKnock = guiCreateButton(0.05, y, 0.87, 0.1, "Abrir", true, wRightClick)
		addEventHandler("onClientGUIClick", bKnock, knockVehicle, false)
		y = y + 0.14
	end
	
	bCloseMenu = guiCreateButton(0.05, y, 0.87, 0.1, "Fechar Menu", true, wRightClick)
	addEventHandler("onClientGUIClick", bCloseMenu, hideVehicleMenu, false)
end

function lockUnlock(button, state)
	if (button=="left") then
		if getPedSimplestTask(localPlayer) == "TASK_SIMPLE_CAR_DRIVE" and getPedOccupiedVehicle(localPlayer) == vehicle then
			triggerServerEvent("lockUnlockInsideVehicle", localPlayer, vehicle)
		elseif exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) or (getElementData(localPlayer, "faction") > 0 and getElementData(localPlayer, "faction") == getElementData(vehicle, "faction")) then
			triggerServerEvent("lockUnlockOutsideVehicle", localPlayer, vehicle)
		end
		hideVehicleMenu()
	end
end

function parkTrailer(button, state)
	if (button=="left") then
		triggerServerEvent("parkVehicle", localPlayer, vehicle)
		hideVehicleMenu()
	end
end

function fillFuelTank(button, state)
	if (button=="left") then
		local _,_, value = exports.global:hasItem(localPlayer, 57)
		if value > 0 then
			triggerServerEvent("fillFuelTankVehicle", localPlayer, vehicle, value)
			hideVehicleMenu()
		else
			outputChatBox("Esta lata de combustível está vazia...", 255, 0, 0)
		end
	end
end

function openMechanicWindow(button, state)
	if (button=="left") then
		triggerEvent("openMechanicFixWindow", localPlayer, vehicle)
		hideVehicleMenu()
	end
end

function sitInHelicopter(button, state)
	if (button=="left") then
		triggerServerEvent("sitInHelicopter", localPlayer, vehicle)
		hideVehicleMenu()
	end
end

function unsitInHelicopter(button, state)
	if (button=="left") then
		triggerServerEvent("unsitInHelicopter", localPlayer, vehicle)
		hideVehicleMenu()
	end
end

function hideVehicleMenu()
	if (isElement(bCloseMenu)) then
		destroyElement(bCloseMenu)
	end
	bCloseMenu = nil

	if (isElement(wRightClick)) then
		destroyElement(wRightClick)
	end
	wRightClick = nil
	
	ax = nil
	ay = nil

	vehicle = nil

	showCursor(false)
	triggerEvent("cursorHide", getLocalPlayer())
end

function enterInterior()
	triggerServerEvent( "enterVehicleInterior", getLocalPlayer(), vehicle )
	hideVehicleMenu()
end

function knockVehicle()
	triggerServerEvent("onVehicleKnocking", getLocalPlayer(), vehicle)
	hideVehicleMenu()
end