function Start_Id ( _, acc )
	if eventName == "onPlayerLogin" then
		setElementData ( source, "ID", getAccountID(acc) or "N/A" )
		outputChatBox ( "#ffffffNick: #00ff00 ( ".. getPlayerName(source) .." #00ff00) #ffffffID: #00ff00( "..(getAccountID(acc) or "N/A") .." )", root, 255,255,255,true)
	elseif eventName == "onPlayerLogout" then
		removeElementData( source, "ID" )
		outputChatBox ( "#ffffffNick: #00ff00 ( ".. getPlayerName(source) .." #00ff00) #ffffffDeslogou.", root, 255,255,255,true)
	elseif eventName == "onResourceStart" then
		for _, player in pairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				setElementData( source, "ID", getAccountID(acc) or "N/A" )
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, Start_Id)
addEventHandler("onPlayerLogout", root, Start_Id)
addEventHandler("onPlayerLogin", root, Start_Id)

function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end

function getnick(player, command, id, ...)
    if(id) then
        local playerID = tonumber(id)
		if(playerID) then
			local Player2 = getPlayerID(playerID)
			if(Player2) then	
				outputChatBox ( "#ffffff Nome do Jogador #00ff00" .. getPlayerName(Player2) .."", player, 255,255,255,true)
			else
				outputChatBox ( "#ffffff O Jogador(a) de ID: #00ff00( " .. id .. " ) #ffffffNão Foi Encontrado!", player, 255,255,255,true)
			end 
		else
			outputChatBox ( "#ffffff ID: #00ff00( " .. id .. " ) #ffffffInválido!", player, 255,255,255,true)
		end
	else
		outputChatBox ( "#ffffffUse /id #00ff00[#ffffffID#00ff00]", player, 255,255,255,true)
	end
end
addCommandHandler("id", getnick)