--[[
/\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\/
										            Curta a Minha Página <3									        
 									     	https://www.facebook.com/danilinmtascr/		
								   
                        :::::::::      :::     ::::    ::: ::::::::::: :::        ::::::::::: ::::    ::: 
                        :+:    :+:   :+: :+:   :+:+:   :+:     :+:     :+:            :+:     :+:+:   :+: 
                        +:+    +:+  +:+   +:+  :+:+:+  +:+     +:+     +:+            +:+     :+:+:+  +:+ 
                        +#+    +:+ +#++:++#++: +#+ +:+ +#+     +#+     +#+            +#+     +#+ +:+ +#+ 
                        +#+    +#+ +#+     +#+ +#+  +#+#+#     +#+     +#+            +#+     +#+  +#+#+# 
                        #+#    #+# #+#     #+# #+#   #+#+#     #+#     #+#            #+#     #+#   #+#+# 
                        #########  ###     ### ###    #### ########### ########## ########### ###    #### 
                                        						
/\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\/
--]]

local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local x, y =  (screenW/resW), (screenH/resH)

local Font_1 = dxCreateFont("font/font.ttf", x*12)
local Font_2 = dxCreateFont("font/font1.ttf", x*10)
local Font_3 = dxCreateFont("font/fontNick.ttf", x*10)
local Font_4 = dxCreateFont("font/OpenSans-Bold.ttf", x*11)
local Font_6 = dxCreateFont("font/OpenSans-Bold.ttf", x*15)
local Font_7 = dxCreateFont("font/fontNick.ttf", x*13)

function getTimeLeft(timer)
  if isTimer(timer) then
    local ms = getTimerDetails(timer)
    local m = math.floor(ms/60000)
    local s = math.floor((ms-m*60000)/1000)
    if m < 10 then m = "0"..m end
    if s < 10 then s = "0"..s end
    return m..":"..s
 end
end


--[[
         ><><><><><><><><><><><><><><><
         ><       Abrir/Fechar       ><
         ><><><><><><><><><><><><><><><
--]]
function Abrir_Categorias ()
if isEventHandlerAdded("onClientRender", getRootElement(), Dx_TirarCNH) then return end
addEventHandler("onClientRender", root, Dx_TirarCNH)
ListaCategorias:SetVisible(true)
showCursor(true)
showChat(false)
end
addEvent("DNL:AbrirCategorias", true)
addEventHandler("DNL:AbrirCategorias", root, Abrir_Categorias)

function Fechar_Categorias ()
  if isEventHandlerAdded("onClientRender", getRootElement(), Dx_TirarCNH) then  
     removeEventHandler("onClientRender", root, Dx_TirarCNH)
     ListaCategorias:SetVisible(false)
     showCursor(false)
     showChat(true)
  end
end
addEvent("DNL:FecharCategorias", true)
addEventHandler("DNL:FecharCategorias", root, Fechar_Categorias)

function Dx_TirarCNH ()
        dxDrawRectangle(x*418, y*218, x*531, y*293, tocolor(0, 0, 0, 177), false) -- Fundo
        dxDrawRectangle(x*418, y*218, x*531, y*34, tocolor(0, 0, 0, 202), false) -- Cabecario        
		dxDrawLine(x*417, y*251, x*949, y*250, tocolor(0, 255, 0, 255), x*2, false) -- Line Enfeite
        dxDrawText("Auto Escola", x*646, y*223, x*720, y*243, tocolor(255, 255, 255, 255), x*1.00, Font_1, "left", "top", false, false, false, false, false)
		
        dxDrawImage(x*489, y*449, x*186, y*47, "Img/botao.png", 0, 0, 0, Corteste, false)	
        dxDrawText("Fazer Teste", x*544, y*463, x*622, y*484, tocolor(255, 255, 255, 255), x*1.00, Font_4, "left", "top", false, false, false, false, false)	
		Corteste = tocolor(0, 255, 0, 150)
      if isCursorOnElement ( x*489, y*449, x*186, y*47 ) then
		Corteste = tocolor(0, 255, 0, 255)
      end
		
        dxDrawImage(x*687, y*449, x*186, y*47, "Img/botao.png", 0, 0, 0, CorCancel, false)
        dxDrawText("Cancelar", x*752, y*463, x*809, y*484, tocolor(255, 255, 255, 255), x*1.00, Font_4, "left", "top", false, false, false, false, false)
		CorCancel = tocolor(255, 0, 0, 150)
      if isCursorOnElement ( x*687, y*449, x*186, y*47 ) then
		CorCancel = tocolor(255, 0, 0, 255)
      end
end
--addEventHandler("onClientRender", root, Dx_TirarCNH)

Categorias = {
	{"Moto", 0, 800, "A"},
	{"Carro", 0, 1000, "B"},
	{"Caminhao", 0, 2000, "C"},
	{"Carreta", 0, 3000, "D"},
	{"Helicóptero", 0, 5000, "E"},
}

addEventHandler("onClientResourceStart", resourceRoot,
  function ()
    ListaCategorias = dxGridW:Create(x*424, y*258, x*519, y*177)
    ListaCategorias:AddColumn("Categoria", x*180)
    ListaCategorias:AddColumn("Level", x*177)
    ListaCategorias:AddColumn("Preço", x*155)
    ListaCategorias:AddColumn("Categoria", x*400)
    ListaCategorias:SetVisible(false)
	
	for i,v in ipairs (Categorias) do
			ListaCategorias:AddItem(1, tostring(v[1]))
			ListaCategorias:AddItem(2, tostring(v[2]))
			ListaCategorias:AddItem(3, tostring(v[3]))
			ListaCategorias:AddItem(4, tostring(v[4]))
	end
end)

--[[
         ><><><><><><><><><><><><><><><
         ><       Fazer_Teste        ><
         ><><><><><><><><><><><><><><><
--]]
function FazerCNH ( _,state )
  if isEventHandlerAdded("onClientRender", getRootElement(), Dx_TirarCNH) then  
   if state == "down" then
   
    if isCursorOnElement(x*687, y*449, x*186, y*47) then
	   Fechar_Categorias ()
	end
	
    if isCursorOnElement(x*489, y*449, x*186, y*47) then
       local SelectCategoria = ListaCategorias:GetSelectedItem()
       local Cat_Name = ListaCategorias:GetItemDetails(1, SelectCategoria)
       local Level_Cat = ListaCategorias:GetItemDetails(2, SelectCategoria)
       local Preco_Cat = ListaCategorias:GetItemDetails(3, SelectCategoria)
       local CategoriaVeh = ListaCategorias:GetItemDetails(3, SelectCategoria)
	   local Hab = getElementData(localPlayer, "DNL:Categoria("..CategoriaVeh.."")
	   local Level = tonumber(getElementData(localPlayer, "Level")) or 0
	   if SelectCategoria > -1 then  
        if Hab == false then
         if Level >= tonumber(Level_Cat) then
		    triggerServerEvent("DNL:Teste("..Cat_Name..")", root, localPlayer) 	
          else
            outputChatBox ( "#00ff00✘ #ffffffINFO #00ff00✘➺ #ffffffSeu Level é muito Baixo e Você Não Pode Fazer Esse Teste!", 255,255,255, true)
         end
		 
		 else
	       outputChatBox ( "#00ff00✘ #ffffffINFO #00ff00✘➺ #ffffffVocê Já Possui Essa Categoria!", 255,255,255, true)
        end
		
	    else				   
		  outputChatBox ( "#00ff00✘ #ffffffINFO #00ff00✘➺ #ffffffSelecione a Categoria que Deseja Fazer.", 255,255,255, true)
	   end
		 
    end
   end
  end
end
addEventHandler ( "onClientClick", root, FazerCNH )
		
		
function Dx_Praticando ()
  local Veiculo = getPedOccupiedVehicle(localPlayer)    
  if ( getElementHealth( Veiculo ) >= 1000 ) then
    Life = 100
  else
    Life = math.floor(getElementHealth( Veiculo )/10)
  end	
        exports["Blur"]:dxDrawBluredRectangle(x*519, y*608, x*328, y*140, tocolor(255, 255, 255, 255))
        dxDrawRectangle(x*519, y*608, x*328, y*140, tocolor(0, 0, 0, 160), false) -- Fundo 
        dxDrawLine(x*519, y*610, x*847, y*610, tocolor(0, 255, 0, 255), x*4, false) -- Line Enfeite
        dxDrawText("Tempo", x*656, y*620, x*716, y*644, tocolor(255, 255, 255, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)
        dxDrawText("Life Veiculo", x*652, y*678, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_3, "left", "top", false, false, false, false, false)
        dxDrawRectangle(x*573, y*696, x*220, y*42, tocolor(0, 0, 0, 160), false)
        dxDrawRectangle(x*573, y*696, x*220/100*Life, y*42, tocolor(0, 255, 0, 160), false)  
	
	if getElementData(localPlayer, "Categoria") == "A" then
        dxDrawText(""..getTimeLeft(Tempo_Moto[localPlayer]).."", x*665, y*645, x*704, y*668, tocolor(0, 255, 0, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)      
		dxDrawText(""..Life.."", x*669, y*705, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_7, "left", "top", false, false, false, false, false)	

	elseif getElementData(localPlayer, "Categoria") == "B" then
        dxDrawText(""..getTimeLeft(Tempo_Carro[localPlayer]).."", x*665, y*645, x*704, y*668, tocolor(0, 255, 0, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)      
		dxDrawText(""..Life.."", x*669, y*705, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_7, "left", "top", false, false, false, false, false)

	elseif getElementData(localPlayer, "Categoria") == "C" then
        dxDrawText(""..getTimeLeft(Tempo_Caminhao[localPlayer]).."", x*665, y*645, x*704, y*668, tocolor(0, 255, 0, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)      
		dxDrawText(""..Life.."", x*669, y*705, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_7, "left", "top", false, false, false, false, false)
	
	elseif getElementData(localPlayer, "Categoria") == "D" then
        dxDrawText(""..getTimeLeft(Tempo_Carreta[localPlayer]).."", x*665, y*645, x*704, y*668, tocolor(0, 255, 0, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)      
		dxDrawText(""..Life.."", x*669, y*705, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_7, "left", "top", false, false, false, false, false)

	elseif getElementData(localPlayer, "Categoria") == "E" then
        dxDrawText(""..getTimeLeft(Tempo_Heli[localPlayer]).."", x*665, y*645, x*704, y*668, tocolor(0, 255, 0, 255), x*1.00, Font_6, "left", "top", false, false, false, false, false)      
		dxDrawText(""..Life.."", x*669, y*705, x*719, y*692, tocolor(255, 255, 255, 255), x*1.00, Font_7, "left", "top", false, false, false, false, false)
	end
	
end

Tempo_Moto = {}
Tempo_Carro = {}
Tempo_Caminhao = {}
Tempo_Carreta = {}
Tempo_Heli = {}

--[[
         ><><><><><><><><><><><><><><><
         ><        Tempo_Moto       ><
         ><><><><><><><><><><><><><><><
--]]
function Tempo_MotoC ()    
	setPedCanBeKnockedOffBike ( localPlayer, false )
	addEventHandler("onClientRender", root, Dx_Praticando)
    Tempo_Moto[localPlayer] = setTimer(function()
	    triggerServerEvent("DNL:Tempo(Moto)", localPlayer) 
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	    setPedCanBeKnockedOffBike ( localPlayer, true )
    end, 90000, 2)  
end
addEvent("DNL:TempoC(Moto)", true)
addEventHandler("DNL:TempoC(Moto)", root, Tempo_MotoC)

function SucessidoMoto ()	
    if isTimer(Tempo_Moto[localPlayer]) then
		killTimer(Tempo_Moto[localPlayer])
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	    setPedCanBeKnockedOffBike ( localPlayer, true )
	end
end
addEvent("DNL:KillTimer(Moto)", true)
addEventHandler("DNL:KillTimer(Moto)", root, SucessidoMoto)

--[[
         ><><><><><><><><><><><><><><><
         ><        Tempo_Carro       ><
         ><><><><><><><><><><><><><><><
--]]
function Tempo_CarroC ()    
	addEventHandler("onClientRender", root, Dx_Praticando)
    Tempo_Carro[localPlayer] = setTimer(function()
	    triggerServerEvent("DNL:Tempo(Carro)", localPlayer) 
	    removeEventHandler("onClientRender", root, Dx_Praticando)
    end, 95000, 2)  
end
addEvent("DNL:TempoC(Carro)", true)
addEventHandler("DNL:TempoC(Carro)", root, Tempo_CarroC)

function SucessidoCarro ()	
    if isTimer(Tempo_Carro[localPlayer]) then
		killTimer(Tempo_Carro[localPlayer])
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	end
end
addEvent("DNL:KillTimer(Carro)", true)
addEventHandler("DNL:KillTimer(Carro)", root, SucessidoCarro)

--[[
         ><><><><><><><><><><><><><><><
         ><      Tempo_Caminhao      ><
         ><><><><><><><><><><><><><><><
--]]
function Tempo_CaminhaosC ()    
	addEventHandler("onClientRender", root, Dx_Praticando)
    Tempo_Caminhao[localPlayer] = setTimer(function()
	    triggerServerEvent("DNL:Tempo(Caminhao)", localPlayer) 
	    removeEventHandler("onClientRender", root, Dx_Praticando)
    end, 900000, 2)  
end
addEvent("DNL:TempoC(Caminhao)", true)
addEventHandler("DNL:TempoC(Caminhao)", root, Tempo_CaminhaosC)

function SucessidoCaminhao ()	
    if isTimer(Tempo_Caminhao[localPlayer]) then
		killTimer(Tempo_Caminhao[localPlayer])
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	end
end
addEvent("DNL:KillTimer(Caminhao)", true)
addEventHandler("DNL:KillTimer(Caminhao)", root, SucessidoCaminhao)

--[[
         ><><><><><><><><><><><><><><><
         ><      Tempo_Carreta       ><
         ><><><><><><><><><><><><><><><
--]]
function Tempo_CarretaC ()    
	addEventHandler("onClientRender", root, Dx_Praticando)
    Tempo_Carreta[localPlayer] = setTimer(function()
	    triggerServerEvent("DNL:Tempo(Carreta)", localPlayer) 
	    removeEventHandler("onClientRender", root, Dx_Praticando)
    end, 1850000, 2)  
end
addEvent("DNL:TempoC(Carreta)", true)
addEventHandler("DNL:TempoC(Carreta)", root, Tempo_CarretaC)

function SucessidoCarreta ()	
    if isTimer(Tempo_Carreta[localPlayer]) then
		killTimer(Tempo_Carreta[localPlayer])
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	end
end
addEvent("DNL:KillTimer(Carreta)", true)
addEventHandler("DNL:KillTimer(Carreta)", root, SucessidoCarreta)


--[[
         ><><><><><><><><><><><><><><><
         ><        Tempo_Heli        ><
         ><><><><><><><><><><><><><><><
--]]
function Tempo_HeliC ()    
	addEventHandler("onClientRender", root, Dx_Praticando)
    Tempo_Heli[localPlayer] = setTimer(function()
	    triggerServerEvent("DNL:Tempo(Heli)", localPlayer) 
	    removeEventHandler("onClientRender", root, Dx_Praticando)
    end, 4400000, 2)  
end
addEvent("DNL:TempoC(Helicóptero)", true)
addEventHandler("DNL:TempoC(Helicóptero)", root, Tempo_HeliC)

function SucessidoHeli ()	
    if isTimer(Tempo_Heli[localPlayer]) then
		killTimer(Tempo_Heli[localPlayer])
	    removeEventHandler("onClientRender", root, Dx_Praticando)
	end
end
addEvent("DNL:KillTimer(Heli)", true)
addEventHandler("DNL:KillTimer(Heli)", root, SucessidoHeli)

                                   --=============================--
                                   ------------- IGNORA ------------
                                   --=============================--
				
addEventHandler ( "onClientPlayerDamage",root,
function ()
    if getElementData(source,"DNL:TestePratico") then
        cancelEvent()
    end
end)
				   
function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end

	return false
end

local x,y = guiGetScreenSize()
function isCursorOnElement(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end
