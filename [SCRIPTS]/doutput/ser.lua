function setelement()
	setElementData(getRootElement(),"tablerow",5566)
end
addEventHandler("onResourceStart",getResourceRootElement(),setelement)

function setelement()
	setElementData(source,"tablerow",5566)
end
addEventHandler("onPlayerJoin",getRootElement(),setelement)

function wnn(player,cmd,...)
	local text = table.concat({...}, " ")
	if exports.global:isPlayerAdmin(player) then
		triggerClientEvent(getRootElement(),"doOutput",getRootElement(),255,255,255,getPlayerName(player)..": "..text)
	end
end
addCommandHandler("wnn",wnn)


function joinmsg()
	triggerClientEvent(getRootElement(),"doOutput",getRootElement(),255,255,255,"SERVER: "..getPlayerName(source).." connected.")

end
addEventHandler("onPlayerJoin",getRootElement(),joinmsg)


function quitmsg(reason)
	triggerClientEvent(getRootElement(),"doOutput",getRootElement(),255,255,255,"SERVER: "..getPlayerName(source).." disconnected. Reason: ["..reason.."]")

end
addEventHandler("onPlayerQuit",getRootElement(),quitmsg)

function scriptOnPlayerWasted ( totalammo, killer, killerweapon, bodypart )

	local causeOfDeath = getWeaponNameFromID ( killerweapon ) 
	local killedPerson = getPlayerName ( source ) 
	if ( killer ) then 
	local killerPerson = getPlayerName ( killer ) 
		if ( killer == source ) then 
			text = "MORTE: "..killerPerson.." morreu ("..causeOfDeath..")" 
		else 
			text = "MORTE: "..killerPerson.." matou "..killedPerson.." ("..causeOfDeath..")"
		end
	else 
		  text =  "MORTE: "..killedPerson .. " morreu (" ..causeOfDeath..")"
	end
	triggerClientEvent(getRootElement(),"doOutput",getRootElement(),255,255,255,text)
end
addEventHandler ( "onPlayerWasted", getRootElement(), scriptOnPlayerWasted ) --add an event handler for onPlayerWasted