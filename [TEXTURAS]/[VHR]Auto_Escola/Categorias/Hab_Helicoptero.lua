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

Heli_Teste = {}

function Teste_Heli (source)  
if getElementData(source, "DNL:Categoria(E)") == true then outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #ffffffVocê Ja Possui essa categoria.", source, 255,255,255,true) return end  
if getPlayerMoney(source) < 5000 then outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #ffffffVocê não tenho dinheiro suficiente para adiquirir essa categoria.", source, 255,255,255,true) return end  
 if Heli_Teste[source] and isElement( Heli_Teste[source] ) then destroyElement ( Heli_Teste[source] ) Heli_Teste[source] = nil end
    Heli_Teste[source] = createVehicle(487, -2055.46973, -195.60049, 35.32739 +2)
    setElementRotation(Heli_Teste[source], 0, 0, 0)
    setElementDimension(source, 0)
    setElementInterior(source, 0)
	takePlayerMoney(source, 5000)
	triggerClientEvent(source, "DNL:FecharCategorias", source) 
    setTimer( setCameraTarget, 1200, 1, source )
    setTimer ( fadeCamera, 50, 1, source,false, 1 )
    setTimer ( fadeCamera, 3000, 1, source, true, 3 ) 
    setTimer(setElementPosition, 1000, 1,source, -2055.46973, -195.60049, 35.32739)
	
  setTimer(function()
    setElementData(source, "Categoria", "E")	
    setElementData(source, "DNL:TestePratico", true)
    warpPedIntoVehicle ( source, Heli_Teste[source] )
	setElementData(source, "Hab:Heli", "1")
	setElementVisibleTo ( Marker_1_Heli, source, true )
	setElementVisibleTo ( Blip_01_Heli, source, true )
	triggerClientEvent(source, "DNL:TempoC(Helicóptero)", source) 
    outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #ffffffPasse em todos locais indicados no mapa.", source, 255,255,255,true)
    outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #ffffffApós Concluir o Teste Ganhará sua Carteira de Habilitação #00FF00(#FFFFFFE#00FF00)", source, 255,255,255,true)   
  end, 3000, 1)
  
end
addEvent("DNL:Teste(Helicóptero)", true)
addEventHandler("DNL:Teste(Helicóptero)", root, Teste_Heli)

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 1 ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_1_Heli = createMarker ( -1539.22852, 677.87262, 86.72421 -1, "ring", 5, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_1_Heli, root, false )

Blip_01_Heli = createBlipAttachedTo ( Marker_1_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_01_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker01_Heli (source)
  if getElementData ( source, "Hab:Heli") == "1" then
   if isElementWithinMarker(source, Marker_1_Heli) then
    if Heli_Teste[source] and isElement(Heli_Teste[source]) then
	   setElementVisibleTo ( Marker_1_Heli, source, false )
	   setElementVisibleTo ( Blip_01_Heli, source, false )
	   
	   setElementVisibleTo ( Marker_2_Heli, source, true )
	   setElementVisibleTo ( Blip_02_Heli, source, true )
	   setElementData(source, "Hab:Heli", "2")
	   outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(1/6)", source, 255,255,255,true)
   end
  end
 end
end
addEventHandler("onMarkerHit", Marker_1_Heli, Marker01_Heli)


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 2 ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_2_Heli = createMarker ( -1711.18372, 1254.92957, 69.77161 -1, "ring", 5, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_2_Heli, root, false )

Blip_02_Heli = createBlipAttachedTo ( Marker_2_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_02_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker02_Heli (source)
  if getElementData ( source, "Hab:Heli") == "2" then
   if isElementWithinMarker(source, Marker_2_Heli) then
    if Heli_Teste[source] and isElement(Heli_Teste[source]) then
	   setElementVisibleTo ( Marker_2_Heli, source, false )
	   setElementVisibleTo ( Blip_02_Heli, source, false )
	   
	   setElementVisibleTo ( Marker_3_Heli, source, true )
	   setElementVisibleTo ( Blip_03_Heli, source, true )
	   setElementData(source, "Hab:Heli", "3")
	   outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(2/6)", source, 255,255,255,true)
   end
  end
 end
end
addEventHandler("onMarkerHit", Marker_2_Heli, Marker02_Heli)


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 3 ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_3_Heli = createMarker ( -2502.74072, 309.99756, 99.66635 -1, "ring", 5, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_3_Heli, root, false )

Blip_03_Heli = createBlipAttachedTo ( Marker_3_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_03_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker03_Heli (source)
  if getElementData ( source, "Hab:Heli") == "3" then
   if isElementWithinMarker(source, Marker_3_Heli) then
    if Heli_Teste[source] and isElement(Heli_Teste[source]) then
	   setElementVisibleTo ( Marker_3_Heli, source, false )
	   setElementVisibleTo ( Blip_03_Heli, source, false )
	   
	   setElementVisibleTo ( Marker_4_Heli, source, true )
	   setElementVisibleTo ( Blip_04_Heli, source, true )
	   setElementData(source, "Hab:Heli", "4")
	   outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(3/6)", source, 255,255,255,true)
   end
  end
 end
end
addEventHandler("onMarkerHit", Marker_3_Heli, Marker03_Heli)


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 4 ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_4_Heli = createMarker ( -1707.19019, -768.44043, 109.44884 -1, "ring", 5, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_4_Heli, root, false )

Blip_04_Heli = createBlipAttachedTo ( Marker_4_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_04_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker04_Heli (source)
  if getElementData ( source, "Hab:Heli") == "4" then
   if isElementWithinMarker(source, Marker_4_Heli) then
    if Heli_Teste[source] and isElement(Heli_Teste[source]) then
	   setElementVisibleTo ( Marker_4_Heli, source, false )
	   setElementVisibleTo ( Blip_04_Heli, source, false )
	   
	   setElementVisibleTo ( Marker_5_Heli, source, true )
	   setElementVisibleTo ( Blip_05_Heli, source, true )
	   setElementData(source, "Hab:Heli", "5")
	   outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(4/6)", source, 255,255,255,true)
   end
  end
 end
end
addEventHandler("onMarkerHit", Marker_4_Heli, Marker04_Heli)


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 5 ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_5_Heli = createMarker ( -1807.61731, 368.57471, 24.02875 -1, "ring", 5, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_5_Heli, root, false )

Blip_05_Heli = createBlipAttachedTo ( Marker_5_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_05_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker05_Heli (source)
  if getElementData ( source, "Hab:Heli") == "5" then
   if isElementWithinMarker(source, Marker_5_Heli) then
    if Heli_Teste[source] and isElement(Heli_Teste[source]) then
	   setElementVisibleTo ( Marker_5_Heli, source, false )
	   setElementVisibleTo ( Blip_05_Heli, source, false )
	   
	   setElementVisibleTo ( Marker_6_Heli, source, true )
	   setElementVisibleTo ( Blip_6_Heli, source, true )
	   setElementData(source, "Hab:Heli", "6")
	   outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(5/6)", source, 255,255,255,true)
   end
  end
 end
end
addEventHandler("onMarkerHit", Marker_5_Heli, Marker05_Heli)


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Checkpoint 6 --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Marker_6_Heli = createMarker ( -2055.46973, -195.60049, 35.32739 -1, "cylinder", 8, 0, 255, 0, 95) -- Local Onde Finaliza O Emprego
setElementVisibleTo ( Marker_6_Heli, root, false )

Blip_6_Heli = createBlipAttachedTo ( Marker_6_Heli, 0 ) -- Blip De Entrega, "0" - Vermelho Padrao
setElementVisibleTo ( Blip_6_Heli, root, false ) -- Blip Visivel Apenas Para Jogadores Trabalhando

function Marker6_Heli (source)
  if getElementData ( source, "Hab:Heli") == "6" then
   if isElementWithinMarker(source, Marker_6_Heli) then
    if isPedInVehicle(source) then
     if Heli_Teste[source] and isElement(Heli_Teste[source]) then
     local HP_Veiculo = getElementHealth ( Heli_Teste[source] )
	     outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFVocê Chegou há um Checkpoint #00ff00(6/6)", source, 255,255,255,true)
      if HP_Veiculo < 800 then
	     outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFNão foi Desta Vez, Você danificou muito o veiculo e acabou fracassando.", source, 255,255,255,true)
      else
       local Account = getPlayerAccount(source)
       if isGuestAccount (Account) then outputChatBox ( "#ff0000✘ #ffffffERRO #ff0000✘➺ #FFFFFFVocê não está logado. Algo de errado aconteceu!", source, 255,255,255,true) return end
	     outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFParabéns, Você Conseguiu Sua Carteira de Habilitação #00ff00(#ffffffHelicóptero#00ff00)", source, 255,255,255,true)
	     playSoundFrontEnd ( source, 43 )
	     setElementData(source, "DNL:Categoria(E)", true)
	     setAccountData ( Account, "DNL:Categoria(E)", true)
      end
	     destroyElement ( Heli_Teste[source] )
	     Fim_Prova_Heli (source)	
	     setElementDimension(source, 0)
	     setElementVisibleTo ( Marker_6_Heli, source, false )
	     setElementVisibleTo ( Blip_6_Heli, source, false )
	     setElementData(source, "Hab:Heli", nil)
	     setElementData(source, "DNL:TestePratico", false)
	     triggerClientEvent(source, "DNL:KillTimer(Heli)", source) 
    end
   end
  end
 end
end
addCommandHandler("finalizar", Marker6_Heli)

function BlockExiVehicle ( source ) 			
  local Teste = getElementData( source, "DNL:TestePratico" )
  if Heli_Teste[source] and isElement( Heli_Teste[source] ) then  	
    if Teste == true then
    cancelEvent()
    outputChatBox ( "#00ff00✘ #ffffffINFO #00ff00✘➺ #ffffffVocê não pode sair do veiculo enquanto faz o teste.", source, 255, 255, 255, true )
    end
  end
end
addEventHandler ( "onVehicleStartExit", getRootElement(), BlockExiVehicle)

function QuitServer ( quitType )	
  if isElement( Heli_Teste[source] ) then
     destroyElement ( Heli_Teste[source] )
  end
end
addEventHandler ( "onPlayerQuit", getRootElement(), QuitServer )

function Mensagem_Marker6_Heli (source)
  if getElementData ( source, "Hab:Heli") == "6" then
	outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFDigite /finalizar e irá ganhar sua Habilitação", source, 255,255,255,true)
  end
end
addEventHandler("onMarkerHit", Marker_6_Heli, Mensagem_Marker6_Heli)


function TimerHeli ()
    Fim_Prova_Heli (source)	
    VisibleBlips (source)	
	setElementData(source, "Hab:Heli", nil)
	setElementData(source, "DNL:TestePratico", false)
	destroyElement ( Heli_Teste[source] )
	outputChatBox ( "#00ff00✘ #ffffffDetran #00ff00✘➺ #FFFFFFNão foi Desta Vez, Você não completou a prova no tempo Correto.", source, 255,255,255,true)
end
addEvent("DNL:Tempo(Heli)", true)
addEventHandler("DNL:Tempo(Heli)", root, TimerHeli)

function Fim_Prova_Heli (source)
setTimer(setElementPosition, 1000, 1,source, 1108.22571, -1796.48193, 16.59375)
setTimer( setCameraTarget, 1200, 1, source )
setTimer ( fadeCamera, 50, 1, source,false, 1 )
setTimer ( fadeCamera, 3000, 1, source, true, 3 ) 
setTimer(setElementDimension, 3000, 1, source, 0)	
setTimer(setElementInterior, 3000, 1, source, 0)	
showChat(source, true)  
setElementData(source, "Categoria", nil)	
end

function VisibleBlips (source)	
    setElementVisibleTo ( Marker_1_Heli, source, false )
	setElementVisibleTo ( Blip_01_Heli, source, false )
	
	setElementVisibleTo ( Marker_2_Heli, source, false )
	setElementVisibleTo ( Blip_02_Heli, source, false )
	
	setElementVisibleTo ( Marker_3_Heli, source, false )
	setElementVisibleTo ( Blip_03_Heli, source, false )
	
	setElementVisibleTo ( Marker_4_Heli, source, false )
	setElementVisibleTo ( Blip_04_Heli, source, false )
	
	setElementVisibleTo ( Marker_5_Heli, source, false )
	setElementVisibleTo ( Blip_05_Heli, source, false )
	
	setElementVisibleTo ( Marker_6_Heli, source, false )
	setElementVisibleTo ( Blip_6_Heli, source, false )
	
end
