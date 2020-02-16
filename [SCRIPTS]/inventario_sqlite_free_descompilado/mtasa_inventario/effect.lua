-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local sx,sy = guiGetScreenSize()

local timer
function setCameraShake(state,t)
	if not t then
		t = 500
	end
	if state then
		setCameraShakeLevel(60)
		if not isTimer(timer) then
			timer = setTimer(function()
				local level = getCameraShakeLevel()
				outputDebugString(level)
				if level - 1 > 0 then
					setCameraShakeLevel(level - 1)
				else
					killTimer(timer)
				end
			end, t, 0)
		end
	else
		if isTimer(timer) then
			killTimer(timer)
		end
		setCameraShakeLevel(0)
	end
end

function setDrogEffectNew(state)
	 if state == true then
		setFarClipDistance(120)
		local x,y,z = getElementPosition(localPlayer)
		setWindVelocity(x, y, z)
		setCameraGoggleEffect("nightvision")
		setGameSpeed(0.6)
		setCameraShake(true)
	 else
		setCameraShake(false)
		setGameSpeed(1)
		resetSkyGradient()
		resetFarClipDistance()
		setWindVelocity(0, 0, 0)
		setCameraTarget(localPlayer)
		setCameraGoggleEffect("normal")
	 end
end
addEvent("setDrogEffectNew", true)
addEventHandler("setDrogEffectNew", getRootElement(), setDrogEffectNew)

function destroyDrog()
	setDrogEffectNew(false)
	setCameraShakeLevel(0)
end
addEventHandler("onClientResourceStop", resourceRoot, destroyDrog)
addEventHandler("onClientPlayerSpawn", localPlayer, destroyDrog)

function setLSDEffect(state)
	 if state == true then
		setGameSpeed(1.2)
		timer1 = setTimer(function()
			if timeIn(10) then
				setSkyGradient(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255))
			end
		end,1000,0)
		setCameraShake(true)
	 elseif state == false then
		setGameSpeed(1)
		if timer1 then 
			killTimer(timer1) 
			timer1 = nil
		end
		resetSkyGradient()
		setCameraShake(false)
	 end
end
addEvent("setLSDEffect", true)
addEventHandler("setLSDEffect", getRootElement(), setLSDEffect)

function timeIn(Time)
	if math.random(0,100)<Time then
		return true
	else
		return false
	end
end

function destroyLSD()
	setLSDEffect(false)
end
addEventHandler("onClientResourceStop", resourceRoot, destroyLSD)
addEventHandler("onClientPlayerSpawn", localPlayer, destroyLSD)

function setKokainEffect(state)
	 if state == true then
		setCameraShake(true)
	 elseif state == false then
		setCameraTarget(localPlayer)
		if isElement(drog) then
			destroyElement(drog)
		end
		setCameraShake(false)
	 end
end
addEvent("setKokainEffect", true)
addEventHandler("setKokainEffect", getRootElement(), setKokainEffect)

function destroyKokain()
	setKokainEffect(false)
end
addEventHandler("onClientResourceStop", resourceRoot, destroyKokain)
addEventHandler("onClientPlayerSpawn", localPlayer, destroyKokain)

local alpha = 0
local spd = 0

function showCameraEffect(speed, typ)
	alpha = 255
	spd = speed
	if typ and typ == 1 then
	end
	addEventHandler("onClientRender", root, renderCameraEffect)
end
addEvent("showCameraEffect", true)
addEventHandler("showCameraEffect", root, showCameraEffect)

function renderCameraEffect()
	if alpha > spd then
		alpha = alpha - spd
	else
		alpha = 0
		removeEventHandler("onClientRender", root, renderCameraEffect)
	end
	dxDrawRectangle(0,0,sx,sy,tocolor ( 255, 255, 255, alpha ),true)
end

function setDrogEffect(state)
	 if state == true then
		setFarClipDistance(60)
		local x,y,z = getElementPosition(localPlayer)
		setWindVelocity(x, y, z)
		setCameraGoggleEffect("thermalvision")
		setGameSpeed(0.6)
		setCameraShake(true)
	 elseif state == false then
		setWindVelocity(0, 0, 0)
		setGameSpeed(1)
		resetSkyGradient()
		resetFarClipDistance()
		setCameraTarget(localPlayer)
		setCameraGoggleEffect("normal")
		setCameraShake(false)
	 end
end
addEvent("setDrogEffect", true)
addEventHandler("setDrogEffect", getRootElement(), setDrogEffect)

function destroyDrog2()
	setDrogEffect(false)
end
addEventHandler("onClientResourceStop", resourceRoot, destroyDrog2)
addEventHandler("onClientPlayerSpawn", localPlayer, destroyDrog2)

addEventHandler("onClientResourceStart", resourceRoot, function()
	setElementData(localPlayer, "char.alcoholLevel", 0)
end)

function setAlcoholLevel(state)
	if state then
		setCameraShakeLevel(100)
		if getElementData(localPlayer, "char.alcoholLevel") and getElementData(localPlayer, "char.alcoholLevel") < 5 then
			setElementData(localPlayer, "char.alcoholLevel", getElementData(localPlayer, "char.alcoholLevel") + 1)
		end
	else
		setCameraShakeLevel(0)
		setElementData(localPlayer, "char.alcoholLevel", 0)
	end
end

function setAlcoholEffect(state)
	 if state == true then
		setFarClipDistance(120)
		setCameraShake(true)
	 else
		resetFarClipDistance()
		setCameraTarget(localPlayer)
		setCameraShake(false)
	 end
end
addEvent("setAlcoholEffect", true)
addEventHandler("setAlcoholEffect", getRootElement(), setAlcoholEffect)

function destroyAlcohol()
	setAlcoholEffect(false)
end
addEventHandler("onClientResourceStop", resourceRoot, destroyAlcohol)
addEventHandler("onClientPlayerSpawn", localPlayer, destroyAlcohol)