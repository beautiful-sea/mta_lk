backupBlip = false
backupPlayer = nil

function removeBackup(thePlayer, commandName)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if (backupPlayer~=nil) then
			
			for k,v in ipairs(getPlayersInTeam ( getTeamFromName("Los Santos Towing and Recovery") )) do
				triggerClientEvent(v, "destroyBackupBlip", backupBlip)
			end
			removeEventHandler("onPlayerQuit", backupPlayer, destroyBlip)
			removeEventHandler("savePlayer", backupPlayer, destroyBlip)
			backupPlayer = nil
			backupBlip = false
			outputChatBox("Backup system reset!", thePlayer, 255, 194, 14)
		else
			outputChatBox("Backup system did not need reset.", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("resettowbackup", removeBackup, false, false)

function backup(thePlayer, commandName)
	local duty = tonumber(getElementData(thePlayer, "duty"))
	local theTeam = getPlayerTeam(thePlayer)
	local factionType = getElementData(theTeam, "type")
	
	--if (factionType==3 or getTeamName(thePlayerTeam) == "Los Santos Towing and Recovery") then--Leaving this in in case of abuse.
		if (backupBlip == true) and (backupPlayer~=thePlayer) then -- in use
			outputChatBox("There is already a backup beacon in use.", thePlayer, 255, 194, 14)
		elseif (backupBlip == false) then -- make backup blip
			backupBlip = true
			backupPlayer = thePlayer
			for k,v in ipairs(getPlayersInTeam(getTeamFromName("Los Santos Towing and Recovery"))) do
				triggerClientEvent(v, "createBackupBlip", thePlayer)
				outputChatBox("A player requires a Tow Truck. Please respond ASAP!", v, 255, 194, 14)
			end

			addEventHandler("onPlayerQuit", thePlayer, destroyBlip)
			addEventHandler("savePlayer", thePlayer, destroyBlip)
			outputChatBox("You enabled your GPS Beacon for LST&R.", thePlayer, 0, 255, 0)
		elseif (backupBlip == true) and (backupPlayer==thePlayer) then -- in use by this player
			for key, v in ipairs(getPlayersInTeam(getTeamFromName("Los Santos Towing and Recovery"))) do
				triggerClientEvent(v, "destroyBackupBlip", getRootElement())
				outputChatBox("The player no longer requires a Tow Truck. Resume normal patrol", v, 255, 194, 14)
			end

			removeEventHandler("onPlayerQuit", thePlayer, destroyBlip)
			removeEventHandler("savePlayer", thePlayer, destroyBlip)
			backupPlayer = nil
			backupBlip = false
			outputChatBox("You disabled your GPS Beacon for LST&R.", thePlayer, 255, 0, 0)
		end
	--end
end
addCommandHandler("towtruck", backup, false, false)

function destroyBlip()
	local theTeam = getPlayerTeam(source)
	for key, value in ipairs(getPlayersInTeam(getTeamFromName("Los Santos Towing and Recovery"))) do
		outputChatBox("The unit no longer requires assistance. Resume normal patrol", value, 255, 194, 14)
	end
	for k,v in ipairs(getPlayersInTeam ( getTeamFromName("Los Santos Towing and Recovery") )) do
		triggerClientEvent(v, "destroyBackupBlip", backupBlip)
	end
	removeEventHandler("onPlayerQuit", source, destroyBlip)
	removeEventHandler("savePlayer", source, destroyBlip)
	backupPlayer = nil
	backupBlip = false
end