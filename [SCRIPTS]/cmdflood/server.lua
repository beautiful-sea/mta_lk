function commandexecuted( player, commandName, otherPlayer )
	if source then
		player = source
	end
	if not getElementData(player,"cmdflood") then
		setElementData(player,"cmdflood",0)
	elseif getElementData(player,"cmdflood")>= 5 then
		if exports.global:isPlayerHeadAdmin(player) then
			outputChatBox("Command flood failed to kick. #00ff00Reason: High level admin. Command:"..commandName,player,255,2,2,true) 
			return
		end
		outputChatBox("Cmdflood: Script kicked #ff0000"..getPlayerName(player).."#ffffff for command flood.",getRootElement(),255,255,255,true)
		exports.global:sendMessageToAdmins("AdmWarn: "..getPlayerName(player).." kicked for flooding command "..commandName)
		setElementData(player,"cmdflood",0)
		kickPlayer(player,"Command flood. Do not overuse commands.")
		return
	end
	setElementData(player,"cmdflood",getElementData(player,"cmdflood")+1)
	setTimer(reducecmd,4000,1,player)
end
addEventHandler("onPlayerChat",getRootElement(),commandexecuted)
newbie = { }
function resourcestart()
	local row = exports.mysql:query_fetch_assoc("SELECT * FROM commands" )
	if row then
		newbie = fromJSON(row["tablecommand"])
		for key, value in ipairs( newbie ) do
			addCommandHandler( value,commandexecuted,false,false)
		end
	end
end
addEventHandler("onResourceStart",getResourceRootElement(),resourcestart)
function reducecmd(player)
	if getElementData(player,"cmdflood")>=1 then
		setElementData(player,"cmdflood",getElementData(player,"cmdflood")-1)
	end
end
function checkcommand(player,command)
	if exports.global:isPlayerAdmin(player) then
		for key, value in ipairs( newbie ) do
			outputChatBox(key..". "..value,player,255,255,2)
		end
	end
end
addCommandHandler("checkcommands",checkcommand)
function addcommand(player,command,arg1)
	if exports.global:isPlayerAdmin(player) then
		for key, value in ipairs( newbie ) do
			if value == arg1 then
				outputChatBox("command already there",player,255,255,2)
				return
			end
		end
		table.insert(newbie,arg1)	
		local commands = toJSON( newbie )
		exports.mysql:query_free("UPDATE commands SET `tablecommand`='" .. exports.mysql:escape_string(commands) .."'")
		addCommandHandler(arg1,commandexecuted,false,false)
		outputChatBox("Command "..arg1.." added to list.",player,0,255,0)
	end
end
addCommandHandler("addcommand",addcommand)
function addcommand(player,command,arg1)
	if exports.global:isPlayerAdmin(player) then
		for key, value in ipairs( newbie ) do
			if value == arg1 then
				outputChatBox("Command deleted.",player,255,255,2)
				table.remove(newbie,key)
				removeCommandHandler(value)
				local commands = toJSON( newbie )
				exports.mysql:query_free("UPDATE commands SET `tablecommand`='" .. exports.mysql:escape_string(commands) .."'")
				return
			end
		end
		outputChatBox("No such command.",player,255,2,2)
	end
end
addCommandHandler("delcommand",addcommand)

function jetpack( thePlayer, commandName )
	if ( doesPedHaveJetPack ( thePlayer ) ) then    
		removePedJetPack ( thePlayer )    
		outputChatBox("Jetpack removed.",thePlayer,2,244,23)
    else
		if getElementData(thePlayer,"jetpack") ~= 1 then
			outputChatBox("You don't have any jetpack.",thePlayer,244,2,2)
			return
		elseif getElementData(thePlayer,"jetpack") == 2 then
			outputChatBox("Jetpack is not allowed right now.",thePlayer,255,2,2)
			return
		end
		givePedJetPack ( thePlayer )       
		outputChatBox("Jetpack enabled.",thePlayer,2,244,23)
    end
end
addCommandHandler ( "jetpackme", jetpack)

function givejetpack(thePlayer,commandName,targetPlayer,arg1)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) or not arg1 then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [0= Disabled, 1 = Enabled]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local arg1 = tonumber(arg1)
			if targetPlayer then
				if (getElementData(targetPlayer, "loggedin")==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					exports.mysql:query_free("UPDATE characters SET `jetpack` ='"..exports.mysql:escape_string(arg1).."' WHERE id = " .. exports.mysql:escape_string(getElementData( targetPlayer, "dbid" )) )	
					setElementData(targetPlayer,"jetpack",arg1)
					if arg1 == 1 then
						outputChatBox("You have been given a jetpack by "..getPlayerName(thePlayer)..". Press F1 to toggle.",targetPlayer,2,255,2)
						outputChatBox("You gave "..targetPlayerName.." a jetpack",thePlayer,2,244,2)
					elseif arg1 == 0 then
							if (exports.global:isPlayerHeadAdmin(thePlayer)) then
						outputChatBox("Your jetpack has been removed by "..getPlayerName(thePlayer)..".",targetPlayer,2,255,2)
						outputChatBox("You took jetpack of "..targetPlayerName..".",thePlayer,2,244,2)
						else 
							outputChatBox("Only head's can take a jetpack",thePlayer,255,0,0)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("givejetpack",givejetpack)