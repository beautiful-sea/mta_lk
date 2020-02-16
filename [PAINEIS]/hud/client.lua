local screenW,screenH = guiGetScreenSize() -- Адаптация hud под все экраны
local px,py = 1600,900 -- Эти значения не менять
local x,y = (screenW/px), (screenH/py)

local UniSans = dxCreateFont("files/UniSans.ttf", 12) -- Создание шрифта
local Bebas = dxCreateFont("files/Bebas.ttf", 20) -- Создание шрифта

function enableCustomHUD() -- Скрывает стандартный hud
	customHUDEnabled = not customHUDEnabled
	setPlayerHudComponentVisible("ammo", not customHUDEnabled)
	setPlayerHudComponentVisible("health", not customHUDEnabled)
	setPlayerHudComponentVisible("armour", not customHUDEnabled)
	setPlayerHudComponentVisible("breath", not customHUDEnabled)
	setPlayerHudComponentVisible("clock", not customHUDEnabled)	
	setPlayerHudComponentVisible("money", not customHUDEnabled)
	setPlayerHudComponentVisible("weapon", not customHUDEnabled)
	setPlayerHudComponentVisible("radio", not customHUDEnabled)
    setPlayerHudComponentVisible("wanted", not customHUDEnabled)
end

addCommandHandler("customhud", enableCustomHUD)
enableCustomHUD()

-------------------------------------------------- Hud

function dxHud(thePlayer)
    local money = getPlayerMoney(thePlayer) -- Деньги
    --local money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1 %2")  -- Деньги
    --local money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1 %2") -- Деньги
    
    local time = getRealTime() -- Создает функцию времени
    local hours = time.hour -- Часы
    local minutes = time.minute -- Минуты
    
    local FPS = getElementData(getLocalPlayer(),"FPS") -- ЕлементДата FPS
    local PING = getPlayerPing(getLocalPlayer()) -- Функция пинга
    
    dxDrawText(" R$"..money, x*935, y*290, x*1690, y*25, tocolor(255, 255, 255, 255), 0.95, UniSans, "center", "center", false, false, true, true, false)
    dxDrawText(hours..":"..minutes, x*1243, y*315, x*1690, y*25, tocolor(255, 255, 255, 255), 0.8, UniSans, "center", "center", false, false, true, true, false)
    dxDrawText(FPS.." FPS", x*1280, y*105, x*1690, y*25, tocolor(255, 255, 255, 255), 0.8, UniSans, "center", "center", false, false, true, true, false)
    
    
    Health = math.floor(getElementHealth(localPlayer)) -- Создание полоски здоровья
    dxDrawRectangle(1255*x, 75*y, 1.55*x*Health, (9.5/y)*y, tocolor(255,0,0,255), true)
    
    Armor = math.floor(getPedArmor(localPlayer)) -- Создание полоски брони

    if false then
        dxDrawRectangle(1255*x, 115*y, 1.55*x*Armor, (9.5/y)*y, tocolor(248,248,255,255), true)
    else
        dxDrawText("Sem colete",x*935, y*210, x*1690, y*25, tocolor(248,248,255,255), 0.95, UniSans, "center", "center", false, false, true, true, false)
    end
    dxDrawImage(1170*x, -1*y, 420*x, 225*y,"files/hud.png",0.0,0.0,0.0,tocolor(255,255,255,255), false)
end

function renderDxHud() -- Запуск hud при старте ресурса
	addEventHandler("onClientRender", getRootElement(), dxHud)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), renderDxHud)

function toggleHud() -- Скрытие худа по команде
	if isVisible then
		addEventHandler("onClientRender", root, dxHud)
	else
		removeEventHandler("onClientRender", root, dxHud)
	end
	isVisible = not isVisible
end
addCommandHandler("hud", toggleHud)

-- Вычисление FPS
local counter = 0
local starttick
local currenttick
addEventHandler("onClientRender", getRootElement(), function()
    if not starttick then
        starttick = getTickCount()
    end
    counter = counter + 1
    currenttick = getTickCount()
    if currenttick - starttick >= 1000 then
        setElementData(getLocalPlayer(),"FPS",counter)
        counter = 0
        starttick = false
    end
end)