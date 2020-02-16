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

--[[
         ><><><><><><><><><><><><><><><><><><><><
         ><               Detran               ><
         ><><><><><><><><><><><><><><><><><><><><
--]]

Entrar = createMarker(1111.70715, -1796.76624, 16.59375 -1, "cylinder", 1.2, 0, 255, 0, 90)
Blip = createBlipAttachedTo ( Entrar, 36 )
setBlipVisibleDistance(Blip, 150)

Sair = createMarker(-2026.97485, -104.28124, 1035.17188 -1, "cylinder", 1.2, 0, 255, 0, 90)
setElementInterior(Sair, 3)

Marker_Categoria = createMarker(-2033.13196, -117.45327, 1035.17188 -1, "cylinder", 1.2, 0, 255, 0, 90)
setElementInterior(Marker_Categoria, 3)

Marker_Multas = createMarker(-2031.19666, -115.17245, 1035.17188 -1, "cylinder", 1.2, 0, 255, 0, 90)
setElementInterior(Marker_Multas, 3)

function Entrar_Detran (source)
setElementInterior(source, 3)
setElementPosition(source, -2029.55017, -105.98931, 1035.17188)
setElementDimension(source, 0)
end
addEventHandler("onMarkerHit", Entrar, Entrar_Detran)

function Sair_Detran (source)
setElementInterior(source, 0)
setElementPosition(source, 1109.35291, -1796.64258, 16.59375)
setElementDimension(source, 0)
end
addEventHandler("onMarkerHit", Sair, Sair_Detran)

function Abrir_Prova(source)
	local account = getPlayerAccount (source)
    --if isGuestAccount (account) then outputChatBox ( "#ff0000✘ #ffffffDetran #ff0000✘➺ #FFFFFFVocê não pode Fazer Prova Deslogado!", source, 255,255,255,true) return end
    if isElementWithinMarker(source, Marker_Categoria) then
		triggerClientEvent(source,"DNL:AbrirCategorias",source)	 
  end
end
addEventHandler( "onMarkerHit", Marker_Categoria, Abrir_Prova )

function PagarMultas(source)
	local account = getPlayerAccount (source)
    --if isGuestAccount (account) then outputChatBox ( "#ff0000✘ #ffffffDetran #ff0000✘➺ #FFFFFFVocê não pode Pagar Multas Deslogado!", source, 255,255,255,true) return end
    if isElementWithinMarker(source, Marker_Multas) then
		triggerClientEvent(source,"DNL:Abrir_Multas",source)	 
  end
end
addEventHandler( "onMarkerHit", Marker_Multas, PagarMultas )

-------- Carregar_Dados --------
function Carregar_Dados ()
  local Account = getPlayerAccount(source)
  local HabilitacaoA = getAccountData (Account, "DNL:Categoria(A)")
  local HabilitacaoB = getAccountData (Account, "DNL:Categoria(B)")
  local HabilitacaoC = getAccountData (Account, "DNL:Categoria(C)")
  local HabilitacaoD = getAccountData (Account, "DNL:Categoria(D)")
  local HabilitacaoE = getAccountData (Account, "DNL:Categoria(E)")
  setElementData(source, "DNL:Categoria(A)", HabilitacaoA) 
  setElementData(source, "DNL:Categoria(B)", HabilitacaoB) 
  setElementData(source, "DNL:Categoria(C)", HabilitacaoC) 
  setElementData(source, "DNL:Categoria(D)", HabilitacaoD) 
  setElementData(source, "DNL:Categoria(E)", HabilitacaoE) 
end
addEventHandler("onPlayerLogin", root, Carregar_Dados)

function carteira (source, cmd, pname)
local accountname = getAccountName(getPlayerAccount(source))
	if isObjectInACLGroup("user."..accountname, aclGetGroup("Everyone")) then -- Grupo permitido a usar o comando
	  local Player_2 = getPlayerFromPartialName(pname)
	   if isElement(Player_2) then
	   local Account = getPlayerAccount(Player_2)
	     setElementData(Player_2, "DNL:Categoria(A)", true)
	     setAccountData ( Account, "DNL:Categoria(A)", true)
		 
	     setElementData(Player_2, "DNL:Categoria(B)", true)
	     setAccountData ( Account, "DNL:Categoria(B)", true)
		 
	     setElementData(Player_2, "DNL:Categoria(C)", true)
	     setAccountData ( Account, "DNL:Categoria(C)", true)
		 
	     setElementData(Player_2, "DNL:Categoria(D)", true)
	     setAccountData ( Account, "DNL:Categoria(D)", true)
		 
	     setElementData(Player_2, "DNL:Categoria(E)", true)
	     setAccountData ( Account, "DNL:Categoria(E)", true)
	     else
		   outputChatBox ( "#ff0000✘ #ffffffERRO #ff0000✘➺ #ffffff O Jogador(a) Não Foi Encontrado!", source, 255,255,255,true)
	   end	
	   
       else
		 outputChatBox ( "#ff0000✘ #ffffffERRO #ff0000✘➺ #FFFFFFVocê não tem permissão para utilizar este comando!", source, 255,255,255,true)
	end	
end
addCommandHandler("carteira", carteira)

--------------------------------------------------------------------

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

--------------------------------------------------------------------