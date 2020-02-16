--San MTA - 2017
--Csoki
if fileExists("client.lua") then
	fileDelete("client.lua")
end
if fileExists("client.luac") then
	fileDelete("client.luac")
end


local Screen = {guiGetScreenSize()}

local interface = exports["san_interface"]

local fpsC = "" --FPS Szinezés
local moneyK = "" --Pénz cucchoz
local font

local myriad = dxCreateFont( "fonts/myriadproregular.ttf",12) --FONT


local font = dxCreateFont( "fonts/icons.ttf",8) --Ikon Font


local framesPerSecond = 0
local framesDeltaTime = 0
local lastRenderTick = false
function renderFPS()
	local currentTick = getTickCount()
	lastRenderTick = lastRenderTick or currentTick
	framesDeltaTime = framesDeltaTime + (currentTick - lastRenderTick)
	lastRenderTick = currentTick
	framesPerSecond = framesPerSecond + 1
	if (framesDeltaTime >= 1000) then
		setElementData(localPlayer, "fps", framesPerSecond)
		framesDeltaTime = framesDeltaTime - 1000
		framesPerSecond = 0
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
function () 
	addEventHandler("onClientRender", root, renderFPS)
	setElementData(localPlayer, "fps", 100)
	setElementData(localPlayer,"togHUD",true)
	setElementData(localPlayer,"stamina",100)
end)

function renderHud()
if not getElementData(localPlayer,"loggedin") then return end
if not getElementData(localPlayer,"togHUD") then return end

if interface:getNode(1, "showing") then
local gethp = getElementHealth(localPlayer)
dxDrawRectangle(interface:getNode(1, "x")+20,interface:getNode(1, "y") , 224,11, tocolor(0,0,0,220))
dxDrawRectangle(interface:getNode(1, "x")+22, interface:getNode(1, "y")+2, gethp*2.2,7, tocolor(124, 197, 118,200))
dxDrawText("",interface:getNode(1, "x"), interface:getNode(1, "y")-2, interface:getNode(1, "x"), interface:getNode(1, "y")-2, tocolor (124, 197, 118,255), 1,font,"left","top",false,false,true,true)
end

if interface:getNode(2,"showing") then
local getarmor = getPedArmor(localPlayer)
dxDrawRectangle(interface:getNode(2, "x")+20, interface:getNode(2, "y"), 224,11, tocolor(0,0,0,220))
dxDrawRectangle(interface:getNode(2, "x")+22, interface:getNode(2, "y")+2, getarmor*2.2,7, tocolor(78,191,180,200))
dxDrawText("", interface:getNode(2, "x")+2, interface:getNode(2, "y"), interface:getNode(2, "x")+2, interface:getNode(2, "y"), tocolor ( 78,191,180,255  ), 1,font,"left","top",false,false,true,true)
end

if interface:getNode(3,"showing") then
local gethunger = tonumber(getElementData(localPlayer, "char:hunger")) or 0
local getszomjusag = tonumber(getElementData(localPlayer,"char:drink")) or 0
dxDrawRectangle(interface:getNode(3, "x")+20, interface:getNode(3, "y"), 224,11, tocolor(0,0,0,220))
dxDrawRectangle(interface:getNode(3, "x")+22, interface:getNode(3, "y")+2, gethunger*1.08,7, tocolor(185, 150, 68,250))
dxDrawRectangle(interface:getNode(3, "x")+22+110,interface:getNode(3, "y")+2,2,7,tocolor(0,0,0,255))
dxDrawRectangle(interface:getNode(3, "x")+22+112, interface:getNode(3, "y")+2, getszomjusag*1.08,7, tocolor(86, 185, 202,250))
dxDrawText("", interface:getNode(3, "x")+2, interface:getNode(3, "y"), interface:getNode(3, "x")+2, interface:getNode(3, "y"), tocolor ( 185, 150, 68,255  ), 1,font,"left","top",false,false,true,true)
end

if interface:getNode(4,"showing") then
dxDrawRectangle(interface:getNode(4, "x")+20, interface:getNode(4, "y"), 224,11, tocolor(0,0,0,220))
dxDrawRectangle(interface:getNode(4, "x")+22, interface:getNode(4, "y")+2, getElementData(localPlayer,"stamina")*2.2,7, tocolor(255,255,255,180))
dxDrawText("",interface:getNode(4, "x")+5,interface:getNode(4, "y"),interface:getNode(4, "x")+5, interface:getNode(4, "y"), tocolor ( 255,255,255,255  ), 1,font,"left","top",false,false,true,true)
end


-- Pénz Cucc --
if interface:getNode(5,"showing") then
local money = tonumber(getElementData(localPlayer,"char:money"))

if money == 0 then
	moneyK = "000000000#7cc576" .. money
elseif money <= 9 then
	moneyK = "00000000#7cc576" .. money
elseif money >= 10 and money <= 99 then
	moneyK = "00000000#7cc576" .. money
elseif money >= 100 and money <= 999 then
	moneyK = "0000000#7cc576" .. money
elseif money >= 1000 and money <= 9999 then
	moneyK = "000000#7cc576" .. money
elseif money >= 10000 and money <= 99999 then
	moneyK = "00000#7cc576" .. money
elseif money >= 100000 and money <= 999999 then
	moneyK = "0000#7cc576" .. money
elseif money >= 1000000 and money <= 9999999 then
	moneyK = "000#7cc576" .. money
elseif money >= 10000000 and money <= 99999999 then
	moneyK = "00#7cc576" .. money
elseif money >= 100000000 and money <= 999999999 then
	moneyK = "0#7cc576" .. money
elseif money >= 100000000 and money <= 999999999 then
	moneyK = "#7cc576" .. money
else 
	moneyK = "#7cc576" .. money
end
dxDrawText("R$ "..moneyK,interface:getNode(5, "x")+4,interface:getNode(5, "y")-4,interface:getNode(5, "x")+216,interface:getNode(5, "y")-4,tocolor(255,255,255,255),1,"pricedown","right","top",false,false,false,true)
end
-------------

if interface:getNode(6,"showing") then
local fps = getElementData(localPlayer,"fps")
if fps <= 10 then 
fpsC = "#FF0000"
elseif fps <= 30 then --FPS Szinezés
fpsC = "#CCCC00"
elseif fps >= 40 then
fpsC = "#7cc576"
end


dxDrawText(fps .."FPS",interface:getNode(6, "x")+1,interface:getNode(6, "y")-4,interface:getNode(6, "x")+70+1,interface:getNode(6, "y")-4,tocolor(0,0,0,255),1,"pricedown","right","top",false,false,false,true)
dxDrawText(fps .."FPS",interface:getNode(6, "x"),interface:getNode(6, "y")-5,interface:getNode(6, "x")+70,interface:getNode(6, "y")-5,tocolor(0,0,0,255),1,"pricedown","right","top",false,false,false,true)
dxDrawText(fps .."FPS",interface:getNode(6, "x"),interface:getNode(6, "y")-3,interface:getNode(6, "x")+70,interface:getNode(6, "y")-3,tocolor(0,0,0,255),1,"pricedown","right","top",false,false,false,true)
dxDrawText(fps .."FPS",interface:getNode(6, "x")-1,interface:getNode(6, "y")-4,interface:getNode(6, "x")+70-1,interface:getNode(6, "y")-4,tocolor(0,0,0,255),1,"pricedown","right","top",false,false,false,true)
dxDrawText(fpsC..fps .."FPS",interface:getNode(6, "x"),interface:getNode(6, "y")-4,interface:getNode(6, "x")+70,interface:getNode(6, "y")-4,tocolor(0,0,0,255),1,"pricedown","right","top",false,false,false,true)
end

end
addEventHandler("onClientRender", getRootElement(), renderHud)


-- Sprint --
function isElementMoving ( theElement )
    if isElement ( theElement ) then                    
        local x, y, z = getElementVelocity( theElement ) 
        return x ~= 0 or y ~= 0 or z ~= 0      
    end
 
    return false
end

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function checkMoving()
   if isElementMoving(localPlayer) and getElementSpeed(localPlayer) > 5.1 then
   	   if not getPedOccupiedVehicle(localPlayer) then
          local staminalevel = tonumber(getElementData(localPlayer, "stamina") or 100)
          if staminalevel >= 0.2 then
              setElementData(localPlayer, "stamina", staminalevel - 0.11)
              if getElementData(localPlayer, "stamina->animRequested") then
			     toggleAllControls(true, true, true)
          	     setElementData(localPlayer, "stamina->animRequested", false)
				 setPedAnimation(localPlayer, "", "")
              end
          else
          	  if not getElementData(localPlayer, "stamina->animRequested") then
				 toggleAllControls(false, true, false)
          	     setPedAnimation(localPlayer, "FAT", "idle_tired", 8000, true, false, true, false)
				 setElementData(localPlayer, "stamina->animRequested", true)
              end
          end
   	   end
   else
       if tonumber(getElementData(localPlayer, "stamina") or 100) < 25 then
       	   local staminalevel = tonumber(getElementData(localPlayer, "stamina") or 100)
		   if not getElementData(localPlayer, "stamina->animRequested") then
		      toggleAllControls(false, true, false)
		      setPedAnimation(localPlayer, "FAT", "idle_tired", 8000, true, false, true, false)
              setElementData(localPlayer, "stamina->animRequested", true)
		   end
           setElementData(localPlayer, "stamina", staminalevel + 0.11)
       else
       	   local staminalevel = tonumber(getElementData(localPlayer, "stamina") or 100)
       	   if staminalevel < 100 then
               setElementData(localPlayer, "stamina", staminalevel + 0.11)
               if getElementData(localPlayer, "stamina->animRequested") then
          	      setElementData(localPlayer, "stamina->animRequested", false)
				  toggleAllControls(true, true, true)
          	      setPedAnimation(localPlayer, "", "")
               end
           end
       end
   end
end
addEventHandler("onClientRender", root, checkMoving, true, "low")
------------



setPlayerHudComponentVisible("all",false)
setPlayerHudComponentVisible("crosshair",true)


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

--Videókártya rész.
local stat = dxGetStatus()
local bit = nil
function vgaDraw()
	if not getElementData(localPlayer,"loggedin") then return end
	if not getElementData(localPlayer,"togHUD") then return end
	if not interface:getNode(10,"showing") then return end
	if stat["Setting32BitColor"] then
		bit = 32
	else
		bit = 16
	end
	dxDrawText(stat["VideoCardName"].."\nVRAM:"..stat["VideoMemoryFreeForMTA"].."/"..stat["VideoCardRAM"].."MB, FONT:"..stat["VideoMemoryUsedByFonts"].."MB,\nTEXTURE:"..stat["VideoMemoryUsedByTextures"].."MB, RTARGET:"..stat["VideoMemoryUsedByRenderTargets"].."MB,\nRATIO:"..stat["SettingAspectRatio"]..", SIZE:"..Screen[1].."x"..Screen[2].."x"..bit,interface:getNode(10, "x")-1,interface:getNode(10, "y"),sx,sy,tocolor(0,0,0,255),0.9,myriad,"left",nil,nil,nil,nil,true)	
	dxDrawText(stat["VideoCardName"].."\nVRAM:"..stat["VideoMemoryFreeForMTA"].."/"..stat["VideoCardRAM"].."MB, FONT:"..stat["VideoMemoryUsedByFonts"].."MB,\nTEXTURE:"..stat["VideoMemoryUsedByTextures"].."MB, RTARGET:"..stat["VideoMemoryUsedByRenderTargets"].."MB,\nRATIO:"..stat["SettingAspectRatio"]..", SIZE:"..Screen[1].."x"..Screen[2].."x"..bit,interface:getNode(10, "x"),interface:getNode(10, "y")-1,sx,sy,tocolor(0,0,0,255),0.9,myriad,"left",nil,nil,nil,nil,true)	
	dxDrawText(stat["VideoCardName"].."\nVRAM:"..stat["VideoMemoryFreeForMTA"].."/"..stat["VideoCardRAM"].."MB, FONT:"..stat["VideoMemoryUsedByFonts"].."MB,\nTEXTURE:"..stat["VideoMemoryUsedByTextures"].."MB, RTARGET:"..stat["VideoMemoryUsedByRenderTargets"].."MB,\nRATIO:"..stat["SettingAspectRatio"]..", SIZE:"..Screen[1].."x"..Screen[2].."x"..bit,interface:getNode(10, "x"),interface:getNode(10, "y")+1,sx,sy,tocolor(0,0,0,255),0.9,myriad,"left",nil,nil,nil,nil,true)		dxDrawText(stat["VideoCardName"].."\nVRAM:"..stat["VideoMemoryFreeForMTA"].."/"..stat["VideoCardRAM"].."MB, FONT:"..stat["VideoMemoryUsedByFonts"].."MB,\nTEXTURE:"..stat["VideoMemoryUsedByTextures"].."MB, RTARGET:"..stat["VideoMemoryUsedByRenderTargets"].."MB,\nRATIO:"..stat["SettingAspectRatio"]..", SIZE:"..Screen[1].."x"..Screen[2].."x"..bit,interface:getNode(10, "x")+1,interface:getNode(10, "y"),sx,sy,tocolor(0,0,0,255),0.9,myriad,"left",nil,nil,nil,nil,true)	
	dxDrawText("#7cc576"..stat["VideoCardName"].."\n#FFFFFFVRAM:"..stat["VideoMemoryFreeForMTA"].."/"..stat["VideoCardRAM"].."MB, FONT:"..stat["VideoMemoryUsedByFonts"].."MB,\nTEXTURE:"..stat["VideoMemoryUsedByTextures"].."MB, RTARGET:"..stat["VideoMemoryUsedByRenderTargets"].."MB,\nRATIO:"..stat["SettingAspectRatio"]..", SIZE:"..Screen[1].."x"..Screen[2].."x"..bit,interface:getNode(10, "x"),interface:getNode(10, "y"),sx,sy,tocolor(255,255,255,255),0.9,myriad,"left",nil,nil,nil,nil,true)
end
addEventHandler("onClientRender",getRootElement(),vgaDraw)


setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local hunger = getElementData(localPlayer, "char:hunger")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		if hunger > 7 then
            random = math.random(2, 10)
            setElementData(localPlayer, "char:hunger", hunger - random)
        elseif hunger ~= 0 and hunger <= 7 then
            setElementData(localPlayer, "char:hunger", 0)
        else
            outputChatBox("#7cc576[BGOMTA]: #ffffffVocê está com fome. Se você não comer, pode morrer!",255,255,255,true)
            setElementHealth(localPlayer, getElementHealth(localPlayer) - 5)
        end
    end
end, 1000*60*4, 0)
setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local drink = getElementData(localPlayer, "char:drink")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		if drink > 7 then
            random = math.random(2, 10)
            setElementData(localPlayer, "char:drink", drink - random)
        elseif drink ~= 0 and drink <= 7 then
            setElementData(localPlayer, "char:drink", 0)
        else
            outputChatBox("#7cc576[BGOMTA]: #ffffffSedento Se você não bebe, você pode morrer!",255,255,255,true)
            setElementHealth(localPlayer, getElementHealth(localPlayer) - 5)
        end
    end
end, 1000*60*4, 0)
