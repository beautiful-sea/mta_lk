-- [ Desenvolvido por: SRGRINGO MTA
-- [ Pagina: https://www.facebook.com/srgringomta/
-- [ Grupo: https://www.facebook.com/groups/mtaresourcesfree/
-- [ Discord: Avicii~#1634
-- [ Data de criação: 19.10.2019
local screenW, screenH = guiGetScreenSize()
local s = {guiGetScreenSize()}
local box = {600,400}
local panel = {s[1]/2 -box[1]/2,s[2]/2 - box[2]/2}
local painel = false
local font1 = dxCreateFont("fonts/Roboto.ttf",12)
local font = dxCreateFont("fonts/RobotoB.ttf",13)

addEventHandler("onClientClick", getRootElement(), function(button, state, _, _, _, _, _, veiculo)
	if button == "left" and state == "down" then
		if isElement(veiculo) then
		local x, y, z = getElementPosition(localPlayer)
		local ex, ey, ez = getElementPosition(veiculo)
		local repar = getElementData(localPlayer, "Reparando") or false
			if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 2 then
				if getElementType(veiculo) == "vehicle" then
				    if not getPedOccupiedVehicle(localPlayer ) then
					    if (getElementData(localPlayer, "SRG.Permitido") == true) and (painel == false) then
					    	if repar == false then
						    setElementFrozen (localPlayer, true )
						    setElementData(localPlayer, "SRG.Selecionado" , veiculo )
						    setElementData(localPlayer,"Abriu", true)
						    setTimer(function ()
						    	setElementData(localPlayer,"Abriu",false)
						    end,1000,1)
							painel = true
						end
					    else
					    end
					else
					end
				end
			end
		end
	end
end)

    function dxinfo()
        dxDrawRectangle(screenW * 0.4883, screenH * 0.7279, screenW * 0.1237, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawRectangle(screenW * 0.4597, screenH * 0.7279, screenW * 0.0249, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawText("Reparando veículo...", screenW * 0.4883, screenH * 0.7292, screenW * 0.6120, screenH * 0.7708, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("!", screenW * 0.4597, screenH * 0.7279, screenW * 0.4839, screenH * 0.7708, tocolor(254, 198, 27, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
end

function dxsus()
        dxDrawRectangle(screenW * 0.4883, screenH * 0.7279, screenW * 0.1237, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawRectangle(screenW * 0.4597, screenH * 0.7279, screenW * 0.0249, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawText("Veículo reparado com sucesso.", screenW * 0.4883, screenH * 0.7292, screenW * 0.6120, screenH * 0.7708, tocolor(255, 255, 255, 255), 0.90, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("!", screenW * 0.4597, screenH * 0.7279, screenW * 0.4839, screenH * 0.7708, tocolor(0, 255, 0, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
end

function dxsemkit()
        dxDrawRectangle(screenW * 0.4883, screenH * 0.7279, screenW * 0.1237, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawRectangle(screenW * 0.4597, screenH * 0.7279, screenW * 0.0249, screenH * 0.0430, tocolor(5, 0, 0, 255), false)
        dxDrawText("Sem kits reparo.", screenW * 0.4883, screenH * 0.7292, screenW * 0.6120, screenH * 0.7708, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("!", screenW * 0.4597, screenH * 0.7279, screenW * 0.4839, screenH * 0.7708, tocolor(255, 0, 0, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
end

function FRe()
addEventHandler("onClientRender", root, dxinfo)
    
            setTimer(function()
            	removeEventHandler("onClientRender", root, dxinfo)
            	addEventHandler("onClientRender", root, dxsus)
            	setTimer(function ()
            		removeEventHandler("onClientRender", root, dxsus)
            	end,2000,1)
            end,3000,1)
end
addEvent("L:CKIT", true)
addEventHandler("L:CKIT", getRootElement(), FRe)




function FSus()
addEventHandler("onClientRender", root, dxsemkit)
setTimer(function ()
	removeEventHandler("onClientRender",root,dxsemkit)
end,3000,1)
end
addEvent("L:SKIT", true)
addEventHandler("L:SKIT", getRootElement(), FSus)

painelkit = false
painelve = false
function dxcomprark()
local pmoney = convertNumber(getPlayerMoney(getLocalPlayer()))
local pkit = getElementData(localPlayer,"Kits:Reparo") or 0
        dxDrawRectangle(screenW * 0.4114, screenH * 0.3359, screenW * 0.1925, screenH * 0.3711, tocolor(4, 4, 4, 155), false)
        dxDrawText("KITS REPARO", screenW * 0.4114, screenH * 0.3372, screenW * 0.6032, screenH * 0.3724, tocolor(255, 255, 255, 255), 1.50, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Kit reparo:", screenW * 0.4158, screenH * 0.3919, screenW * 0.4729, screenH * 0.4115, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("R$500", screenW * 0.4766, screenH * 0.3919, screenW * 0.5337, screenH * 0.4115, tocolor(36, 248, 26, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Seu dinheiro:", screenW * 0.4158, screenH * 0.4245, screenW * 0.4729, screenH * 0.4440, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("R$"..pmoney, screenW * 0.4883, screenH * 0.4245, screenW * 0.5454, screenH * 0.4440, tocolor(36, 248, 26, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Seus kits:", screenW * 0.4158, screenH * 0.4570, screenW * 0.4729, screenH * 0.4766, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText(pkit, screenW * 0.4700, screenH * 0.4570, screenW * 0.5271, screenH * 0.4766, tocolor(36, 248, 26, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4378, screenH * 0.5469, screenW * 0.1281, screenH * 0.0404, C1, false)
        dxDrawText("Comprar", screenW * 0.4773, screenH * 0.5521, screenW * 0.5300, screenH * 0.5807, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4378, screenH * 0.5938, screenW * 0.1281, screenH * 0.0404, C2, false)
        dxDrawText("Jogar fora", screenW * 0.4773, screenH * 0.6003, screenW * 0.5300, screenH * 0.6289, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4378, screenH * 0.6419, screenW * 0.1281, screenH * 0.0404, C3, false)
        dxDrawText("Fechar", screenW * 0.4773, screenH * 0.6471, screenW * 0.5300, screenH * 0.6758, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)

    C1 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.4378, screenH * 0.5469, screenW * 0.1281, screenH * 0.0404) then
	C1 = tocolor(0, 100, 200, 255)
	end

	C2 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.4378, screenH * 0.5938, screenW * 0.1281, screenH * 0.0404) then
	C2 = tocolor(0, 100, 200, 255)
	end

	C3 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.4378, screenH * 0.6419, screenW * 0.1281, screenH * 0.0404) then
	C3 = tocolor(0, 100, 200, 255)
	end
end

function abrirlkit()
	local acr = getElementData(localPlayer, "Kits:Reparo") or 0
	if painelkit == false then
	   addEventHandler("onClientRender", root, dxcomprark) 
	   showCursor(true)
	   painelkit = true
	   setElementData(localPlayer,"Kits:Reparo", acr+0-0+0-0+0)
	end
	end	
addEvent ( "L:AbrirDx", true )
addEventHandler ( "L:AbrirDx", root, abrirlkit)

function verifidx()
	local kitr = getElementData(localPlayer, "Kits:Reparo") or 0
        dxDrawRectangle(screenW * 0.3968, screenH * 0.3815, screenW * 0.2218, screenH * 0.1641, tocolor(0, 0, 0, 203), false)
        dxDrawText("DESEJA CONTINUAR?", screenW * 0.3968, screenH * 0.3815, screenW * 0.6127, screenH * 0.4049, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        if kitr > 1 then
        dxDrawText("Você tem certeza que quer jogar "..kitr.." kits \nreparo fora?", screenW * 0.4122, screenH * 0.4180, screenW * 0.6259, screenH * 0.4440, tocolor(255, 255, 255, 255), 0.95, "default-bold", "left", "top", false, false, true, false, false)
        else
        dxDrawText("Você tem certeza que quer jogar "..kitr.." kit \nreparo fora?", screenW * 0.4122, screenH * 0.4180, screenW * 0.6259, screenH * 0.4440, tocolor(255, 255, 255, 255), 0.95, "default-bold", "left", "top", false, false, true, false, false)
        end
        dxDrawRectangle(screenW * 0.4092, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378, V1, false)
        dxDrawRectangle(screenW * 0.5293, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378, V2, false)
        dxDrawText("SIM", screenW * 0.4319, screenH * 0.4779, screenW * 0.4605, screenH * 0.5026, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "center", false, false, true, false, false)
        dxDrawText("NÃO", screenW * 0.5520, screenH * 0.4779, screenW * 0.5805, screenH * 0.5026, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "center", false, false, true, false, false)

    V1 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.4092, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378) then
	V1 = tocolor(0, 100, 200, 255)
	end

	V2 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.5293, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378) then
	V2 = tocolor(0, 100, 200, 255)
	end
end


function ObjetosDaLoja (_,state)
if painelkit == true then
if state == "down" then
if isCursorOnElement (screenW * 0.4378, screenH * 0.6419, screenW * 0.1281, screenH * 0.0404) then
removeEventHandler ( "onClientRender", root, dxcomprark )
showCursor ( false )
painelkit = false
elseif isCursorOnElement (screenW * 0.4378, screenH * 0.5469, screenW * 0.1281, screenH * 0.0404) then
	triggerServerEvent("L:ComprarK", localPlayer)
elseif isCursorOnElement (screenW * 0.4378, screenH * 0.5938, screenW * 0.1281, screenH * 0.0404) then
	painelkit = false
	painelve = true
	removeEventHandler ( "onClientRender", root, dxcomprark )
	addEventHandler("onClientRender", root, verifidx) 
end
end
end
end
addEventHandler ( "onClientClick", root, ObjetosDaLoja )

function ObjetosDaLoja2 (_,state)
if painelve == true then
if state == "down" then
if isCursorOnElement (screenW * 0.4092, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378) then
removeEventHandler ( "onClientRender", root, verifidx )
addEventHandler("onClientRender", root, dxcomprark) 
painelve = false
painelkit = true
setElementData(localPlayer,"Kits:Reparo",0)
triggerServerEvent("L:JogarFora", localPlayer)
elseif isCursorOnElement (screenW * 0.5293, screenH * 0.4727, screenW * 0.0710, screenH * 0.0378) then
removeEventHandler ( "onClientRender", root, verifidx )
addEventHandler("onClientRender", root, dxcomprark) 
painelve = false
painelkit = true
end
end
end
end
addEventHandler ( "onClientClick", root, ObjetosDaLoja2 )

addEventHandler("onClientRender",getRootElement(),function()
local screenW, screenH = guiGetScreenSize()
local pmoney = convertNumber(getPlayerMoney(getLocalPlayer()))
local pkit = getElementData(localPlayer,"Kits:Reparo") or 0
	if painel and not getPedOccupiedVehicle(localPlayer) then
        dxDrawRectangle(screenW * 0.5505, screenH * 0.4622, screenW * 0.1303, screenH * 0.2526, tocolor(9, 9, 9, 171), false)
        dxDrawImage(screenW * 0.6464, screenH * 0.4492, screenW * 0.0373, screenH * 0.0651, ":[LG7]Mecanico/icon.png", 0, 0, 0, tocolor(255, 255, 255, 235), false)
        dxDrawText("MECÂNICO", screenW * 0.5893, screenH * 0.4570, screenW * 0.6493, screenH * 0.5013, tocolor(255, 255, 255, 235), 1.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Kits reparo:", screenW * 0.5520, screenH * 0.5143, screenW * 0.6054, screenH * 0.5326, tocolor(255, 255, 255, 235), 1.00, "sans", "left", "top", false, false, false, false, false)
        if pkit > 0 then
        dxDrawText(pkit, screenW * 0.6083, screenH * 0.5143, screenW * 0.6618, screenH * 0.5326, tocolor(0, 255, 0, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
   		else
        	dxDrawText(pkit, screenW * 0.6083, screenH * 0.5143, screenW * 0.6618, screenH * 0.5326, tocolor(255, 0, 0, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
        end
        dxDrawText("Seu dinheiro:", screenW * 0.5520, screenH * 0.5391, screenW * 0.6054, screenH * 0.5573, tocolor(255, 255, 255, 235), 1.00, "sans", "left", "top", false, false, false, false, false)
        dxDrawText("$"..pmoney, screenW * 0.6186, screenH * 0.5404, screenW * 0.6764, screenH * 0.5573, tocolor(52, 244, 33, 255), 0.90, "sans", "left", "top", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.5652, screenH * 0.5794, screenW * 0.1040, screenH * 0.0339, Cor1, false)
        dxDrawText("Reparar", screenW * 0.5652, screenH * 0.5794, screenW * 0.6698, screenH * 0.6133, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.5652, screenH * 0.6263, screenW * 0.1040, screenH * 0.0339, Cor2, false)
        dxDrawText("Fechar", screenW * 0.5652, screenH * 0.6263, screenW * 0.6698, screenH * 0.6602, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)   end

        Cor1 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.5652, screenH * 0.5794, screenW * 0.1040, screenH * 0.0339) then
	Cor1 = tocolor(0, 100, 200, 255)
	end

	Cor2 = tocolor(0, 0, 0, 215)
    if isCursorOnElement (screenW * 0.5652, screenH * 0.6263, screenW * 0.1040, screenH * 0.0339) then
	Cor2 = tocolor(0, 100, 200, 255)
	end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state)
	local abr = getElementData(localPlayer, "Abriu") or false
	local acr = getElementData(localPlayer, "Kits:Reparo") or 0
	local veh = getElementData(localPlayer, "SRG.Selecionado")
	local p,s,g = getElementPosition(veh)
	if not painel then return end
    if button == "left" and state == "down" then
        if isInSlot(screenW * 0.5652, screenH * 0.6263, screenW * 0.1040, screenH * 0.0339) then
		    Fechar()
		elseif isInSlot(screenW * 0.5652, screenH * 0.5794, screenW * 0.1040, screenH * 0.0339) then
			if abr == false then
		    triggerServerEvent(":Reparar", localPlayer)
		    playSound3D( "somec.mp3", p,s,g, false )
    setSoundMaxDistance(vehiclesSirene, 100 )
    setSoundVolume (vehiclesSirene, 1)
    attachElements (vehiclesSirene, localPlayer, 0, 0, 0 )
            Fechar()
            setElementData(localPlayer,"Kits:Reparo", acr+0-0+0-0+0)
        	
        end
        end
    end
end)



function Fechar(element)
    if painel then
        painel = false
        showCursor(false)
		setElementFrozen(localPlayer, false)
		setElementData(localPlayer, "SRG.Selecionado" , nil )
		setElementData(localPlayer,"Abriu",false)
    end
end
function Fechar2(element)
    if painelkit then
        painelkit = false
        showCursor(false)
		setElementFrozen(localPlayer, false)
    end
end

local effect = {
	[1] = {},
}

function Start_Repair ()
    tick9 = getTickCount()
    setElementData(localPlayer, "Reparando", true)
    Sound = playSound( "Sound/sound.mp3")
    CreateFuredeira ()	
	setElementData(localPlayer, "Tempo", 100)
    addEventHandler("onClientRender", root, Dx_Repair) 
 setTimer(function()
    removeEventHandler("onClientRender", root, Dx_Repair) 
    playSoundFrontEnd(46)  
    stopSound(Sound)
    Delete_Furadeira()
    setElementData(localPlayer, "Reparando", false)
 end, 3000, 1)
end
addEvent ( "DNL:RepararStart", true )
addEventHandler ( "DNL:RepararStart", root, Start_Repair)

function RemTimer ()
local Timer = tonumber(getElementData ( localPlayer, "Tempo" )) or 0
  if getElementData(localPlayer, "Reparando", true) then
     setElementData(localPlayer, "Tempo", Timer -4)
  end
end
setTimer(RemTimer, 100,0)

function Loop ()
local Timer = tonumber(getElementData ( localPlayer, "Tempo" )) or 0
 if Timer < 0 then
     setElementData(localPlayer, "Tempo", 0)
 end
end
setTimer(Loop, 50,0)

function CreateFuredeira ()
local x, y, z = getElementPosition(localPlayer)
  if not isElement(effect[1][localPlayer]) then
     Furadeira = createObject (2961, x, y, z) 
     exports.bone_attach:attachElementToBone (Furadeira, localPlayer, 7, - 0.1, 0.2, 0.2, 180, 90, 90)        
     fx, fy, fz = getElementPosition(Furadeira)
	 rx, ry, rz = getElementRotation(Furadeira)
     effect[1][localPlayer] = createEffect( "prt_spark", fx, fy, fz,  rx, ry, rz)
     setElementData( localPlayer, "DNL:Delete_Furadeira", Furadeira ) -- Seta Element data no jogador e no Objeto
     setElementData( localPlayer, "DNL:Furadeira", true )
  end
end

function Delete_Furadeira( )
local Furadeira1 = getElementData( localPlayer, "DNL:Furadeira", true )
   if Furadeira1 then
	 if isElement(effect[1][localPlayer]) then
		destroyElement(effect[1][localPlayer])
		destroyElement( Furadeira )
		setElementData( localPlayer, "DNL:Furadeira", false )
	 end
   end
end

Txd = engineLoadTXD ( "Furadeira.txd" )
engineImportTXD ( Txd, 2961 )
Dff = engineLoadDFF ( "Furadeira.dff" )
engineReplaceModel ( Dff, 2961 )


function dxDrawBorder(x, y, w, h, radius, color)
	dxDrawRectangle(x - radius, y, radius, h, color)
	dxDrawRectangle(x + w, y, radius, h, color)
	dxDrawRectangle(x - radius, y - radius, w + (radius * 2), radius, color)
	dxDrawRectangle(x - radius, y + h, w + (radius * 2), radius, color)
end

function inBox(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(inBox(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end
end

function convertNumber ( number )   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end



function isCursorOnElement( x,y,w,h )
local mx,my = getCursorPosition ()
local fullx,fully = guiGetScreenSize()
cursorx,cursory = mx*fullx,my*fully
if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
return true
else
return false
end
end


--[[
         ><><><><><><><><><><><><><><><><><><><><
         ><               Ignora               ><
         ><><><><><><><><><><><><><><><><><><><><
--]]

function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
	
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
	
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
	
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
	
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
	
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
	
	return true
end