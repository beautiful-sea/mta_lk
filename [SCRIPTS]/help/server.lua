mysql = exports.mysql
function readall(source)
		if getElementData(source,"rulesread") == 0  then
			mysql:query_free("UPDATE accounts SET `rulesread` = 1 WHERE id = '" .. mysql:escape_string(getElementData(source,"gameaccountid")) .. "'") 
			setElementData(source,"rulesread",1)
			setElementData(source,"forceread",0)
			outputChatBox("You read all details.",source,22,222,222)
		else 
			outputChatBox("You have already read all rules.",source,255,0,0)
		end
		
end
addEvent( "readall", true )
addEventHandler( "readall", getRootElement(), readall )

function readtest(player)
	outputChatBox(getElementData(player,"rulesread"))
	if getElementData(player,"rulesread") == 0  then
	setElementData(player,"rulesread",1)
	outputChatBox("rules read")
	else
	setElementData(player,"rulesread",0)
	outputChatBox("rules unread")
	end
end
addCommandHandler("readrule",readtest)


function forceread(thePlayer, commandName, targetPlayer)
	if exports.global:isPlayerAdmin(thePlayer) then
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
		mysql:query_free("UPDATE accounts SET `rulesread` = 0 WHERE id = '" .. mysql:escape_string(getElementData(targetPlayer,"gameaccountid")) .. "'") 
		setElementData(targetPlayer,"rulesread",0)
		setElementData(targetPlayer,"forceread",1)
		outputChatBox("Admin: "..getPlayerName(thePlayer).. " forced "..targetPlayerName.." to read F9 rules.",getRootElement(),255,0,0)
		triggerClientEvent(targetPlayer,"forceread",targetPlayer)
	end
end
addCommandHandler("fread",forceread)