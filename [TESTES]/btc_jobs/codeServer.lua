local connection = exports["btc_mysql"]:getConnection()

addEvent("updateJobToServer", true)
addEventHandler("updateJobToServer", root, function (JobID)
	dbPoll ( dbQuery( connection, "UPDATE characters SET job='?' WHERE id = '?'", JobID, getElementData(source, "acc:id")), -1 )
end)


addEvent("trabalho", true)
addEventHandler("trabalho", root, function (a,b)
	exports.btc_employment:setPlayerJob(source, a, a, b,true)
end)



function demitir(player)
	if getElementData(player, "job") == "Mecânico" then return end

	--if not exports.btc_prison:isPlayerInJail(player) then
	exports.btc_infobox:addNotification(player, "Você foi demitido!", "success")
	--exports.btc_employment:resign(player, true, true)
	exports.btc_employment:setPlayerJob(player, "SemEmprego", "0",true)
	--exports.btc_employment:resign(player, false)
	local x,y,z = getElementPosition(player)
	exports.Script_futeis:setGPS(player, "Coordenada", x,y,z)
			  triggerClientEvent(player,"hudids",player)
			  
			  --exports['btc_items']:RemovePlayerDutyItems(player)
			  --exports['btc_items']:takePlayerItemToID(source, 55, 0)

end
addCommandHandler("demitir",demitir)