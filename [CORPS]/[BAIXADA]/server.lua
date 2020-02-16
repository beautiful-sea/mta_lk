marker_ponto = createMarker ( 2145.900, -1665.0998, 21.9812 , "cylinder", 1, 0,  255,  255, 100)

function baterPonto(thePlayer)
	if getPlayerSkin(thePlayer) == 305 or getPlayerSkin(thePlayer) == 303 then
		setPlayerSkin ( thePlayer, 7 )
		outputChatBox("#ffffffServiço finalizado.",thePlayer,255, 255, 255,true)
	else
		if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("baixada_patrao")) then
			setPlayerSkin ( thePlayer, 303 )
			outputChatBox("#ffffffCuidado com os cana!",thePlayer,255, 255, 255,true)
		elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("baixada_traficante")) then
			setPlayerSkin ( thePlayer, 305 )
			outputChatBox("#ffffffPartiu tráfico!",thePlayer,255, 255, 255,true)
		end
	end
	
end

addEventHandler("onMarkerHit",marker_ponto,baterPonto)