mysql = exports.mysql

local unemployedPay = 150
local result = mysql:query_fetch_assoc( "SELECT value FROM settings WHERE name = 'welfare'" )
if result then
	if not result.value then
		mysql:query_free( "INSERT INTO settings (name, value) VALUES ('welfare', " .. unemployedPay .. ")" )
	else
		unemployedPay = tonumber( result.value ) or 150
	end
end
result = nil

-- EVENTS
addEvent("onPlayerJoinFaction", false)
addEventHandler("onPlayerJoinFaction", getRootElement(),
	function(theTeam)
		local id = getElementData(theTeam, "id")
		if id == 1 then
			exports.global:givePlayerAchievement(source, 2)
		elseif id == 2 then
			exports.global:givePlayerAchievement(source, 5)
		elseif id == 3 then
			exports.global:givePlayerAchievement(source, 6)
		end
	end
)

function loadAllFactions(res)
	-- work out how many minutes it is until the next hour
	local mins = getRealTime().minute
	local minutes = 60 - mins
	setTimer(payAllWages, 60000*minutes, 1, true)
	
	local result = mysql:query("SELECT * FROM factions ORDER BY id ASC")
	local counter = 0
	
	if result then
		while true do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			
			local id = tonumber(row.id)
			local name = row.name
			local money = tonumber(row.bankbalance)
			local factionType = tonumber(row.type)
			
			local theTeam = createTeam(tostring(name))
			exports.pool:allocateElement(theTeam, id)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "type", factionType)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "money", money)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "id", id)
			
			local factionRanks = {}
			local factionWages = {}
			for i = 1, 15 do
				factionRanks[i] = row['rank_'..i]
				factionWages[i] = tonumber(row['wage_'..i])
			end
			local motd = row.motd
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "ranks", factionRanks, false)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "wages", factionWages, false)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "motd", motd, false)
			
			counter = counter + 1
		end
		mysql:free_result(result)
		
		local citteam = createTeam("Citizen", 255, 255, 255)
		exports.pool:allocateElement(citteam, -1)
		
		-- set all players into their appropriate faction
		local players = exports.pool:getPoolElementsByType("player")
		for k, thePlayer in ipairs(players) do
			local username = getPlayerName(thePlayer)
			local safeusername = mysql:escape_string(username)
			
			local result = mysql:query_fetch_assoc("SELECT faction_id, faction_rank, faction_leader FROM characters WHERE charactername='" .. safeusername .. "' LIMIT 1")
			if result then
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionMenu", 0)
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "faction", tonumber(result.faction_id))
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionrank", tonumber(result.faction_rank))
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionleader", tonumber(result.faction_leader), false)
				
				setPlayerTeam(thePlayer, exports.pool:getElement("team", result.faction_id) or citteam)
			end
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(), loadAllFactions)

-- Bind Keys required
function bindKeys()
	local players = exports.pool:getPoolElementsByType("player")
	for k, arrayPlayer in ipairs(players) do
		if not(isKeyBound(arrayPlayer, "F3", "down", showFactionMenu)) then
			bindKey(arrayPlayer, "F3", "down", showFactionMenu)
		end
	end
end

function bindKeysOnJoin()
	bindKey(source, "F3", "down", showFactionMenu)
end
addEventHandler("onResourceStart", getResourceRootElement(), bindKeys)
addEventHandler("onPlayerJoin", getRootElement(), bindKeysOnJoin)

function showFactionMenu(source)
	local logged = getElementData(source, "loggedin")
	
	if (logged==1) then
		local menuVisible = getElementData(source, "factionMenu")
		
		if (menuVisible==0) then
			local factionID = getElementData(source, "faction")
			
			if (factionID~=-1) then
				local theTeam = getPlayerTeam(source)
				local query = mysql:query("SELECT charactername, faction_rank, faction_leader, DATEDIFF(NOW(), lastlogin) AS lastlogin FROM characters WHERE faction_ID='" .. factionID .. "' ORDER BY faction_rank DESC, charactername ASC")
				if query then
					
					local memberUsernames = {}
					local memberRanks = {}
					local memberLeaders = {}
					local memberOnline = {}
					local memberLastLogin = {}
					local memberLocation = {}
					local factionRanks = getElementData(theTeam, "ranks")
					local factionWages = getElementData(theTeam, "wages")
					local motd = getElementData(theTeam, "motd")
					
					if (motd == "") then motd = nil end
					
					local i = 1
					while true do
						local row = mysql:fetch_assoc(query)
						if not row then break end
						
						local playerName = row.charactername
						memberUsernames[i] = playerName
						memberRanks[i] = row.faction_rank
						
						if (tonumber(row.faction_leader)==1) then
							memberLeaders[i] = true
						else
							memberLeaders[i] = false
						end
						
						local login = ""
						
						memberLastLogin[i] = tonumber(row.lastlogin)
						
						
						local targetPlayer = getPlayerFromName(tostring(playerName))
						if (targetPlayer) then
							memberOnline[i] = true
							if getElementData(targetPlayer, "hideF3Location") then
								memberLocation[i] = "N/A"
							elseif getElementData(targetPlayer, "loggedin") == 1 then
								local zone, city = exports.global:getElementZoneName(targetPlayer)
								
								if(zone~=city) and (city~=nil) then
									memberLocation[i] = zone .. ", " .. city
								else
									memberLocation[i] = zone
								end
							else
								memberLocation[i] = "Not logged in"
							end
						else
							memberOnline[i] = false
							memberLocation[i] = "N/A"
						end
						i = i + 1
					end
					exports['anticheat-system']:changeProtectedElementDataEx(source, "factionMenu", 1)
					mysql:free_result(query)
					
					local theTeam = getPlayerTeam(source)
					triggerClientEvent(source, "showFactionMenu", getRootElement(), motd, memberUsernames, memberRanks, memberLeaders, memberOnline, memberLastLogin, memberLocation, factionRanks, factionWages, theTeam)
				end
			else
				outputChatBox("You are not in a faction.", source)
			end
		else
			triggerClientEvent(source, "hideFactionMenu", getRootElement())
		end
	end
end

-- // CALL BACKS FROM CLIENT GUI
function callbackUpdateRanks(ranks, wages)
	local theTeam = getPlayerTeam(client)
	local factionID = getElementData(theTeam, "id")
	
	for key, value in ipairs(ranks) do
		ranks[key] = mysql:escape_string(ranks[key])
	end
	
	if (wages) then
		for key, value in ipairs(wages) do
			wages[key] = tonumber(wages[key]) or 0
			if wages[key]> 1500 then
				outputChatBox("Wage should not be more than 1500",source,255,5,5)
				return
			end
		end
		
		mysql:query_free("UPDATE factions SET wage_1='" .. wages[1] .. "', wage_2='" .. wages[2] .. "', wage_3='" .. wages[3] .. "', wage_4='" .. wages[4] .. "', wage_5='" .. wages[5] .. "', wage_6='" .. wages[6] .. "', wage_7='" .. wages[7] .. "', wage_8='" .. wages[8] .. "', wage_9='" .. wages[9] .. "', wage_10='" .. wages[10] .. "', wage_11='" .. wages[11] .. "', wage_12='" .. wages[12] .. "', wage_13='" .. wages[13] .. "', wage_14='" .. wages[14] .. "', wage_15='" .. wages[15] .. "' WHERE id='" .. factionID .. "'")
		exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "wages", wages, false)
	end
	
	mysql:query_free("UPDATE factions SET rank_1='" .. ranks[1] .. "', rank_2='" .. ranks[2] .. "', rank_3='" .. ranks[3] .. "', rank_4='" .. ranks[4] .. "', rank_5='" .. ranks[5] .. "', rank_6='" .. ranks[6] .. "', rank_7='" .. ranks[7] .. "', rank_8='" .. ranks[8] .. "', rank_9='" .. ranks[9] .. "', rank_10='" .. ranks[10] .. "', rank_11='" .. ranks[11] .. "', rank_12='" .. ranks[12] .. "', rank_13='" .. ranks[13] .. "', rank_14='" .. ranks[14] .. "', rank_15='" .. ranks[15] .. "' WHERE id='" .. factionID .. "'")
	exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "ranks", ranks, false)
	
	outputChatBox("Faction information updated successfully.", source, 0, 255, 0)
	showFactionMenu(source)
end
addEvent("cguiUpdateRanks", true )
addEventHandler("cguiUpdateRanks", getRootElement(), callbackUpdateRanks)


function callbackRespawnVehicles()
	local theTeam = getPlayerTeam(source)
	
	local factionCooldown = getElementData(theTeam, "cooldown")
	
	if not (factionCooldown) then
		local factionID = getElementData(theTeam, "id")
		
		for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
			local faction = getElementData(value, "faction")
			if (faction == factionID and not getVehicleOccupant(value, 0) and not getVehicleOccupant(value, 1) and not getVehicleOccupant(value, 2) and not getVehicleOccupant(value, 3) and not getVehicleTowingVehicle(value)) then
				respawnVehicle(value)
			end
		end
		
		-- Send message to everyone in the faction
		local teamPlayers = getPlayersInTeam(theTeam)
		local username = getPlayerName(source)
		for k, v in ipairs(teamPlayers) do
			outputChatBox(username .. " respawned all unoccupied faction vehicles.", v)
		end

		setTimer(resetFactionCooldown, 600000, 1, theTeam)
		exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "cooldown", true, false)
	else
		outputChatBox("You currently cannot respawn your factions vehicles, Please wait a while.", source, 255, 0, 0)
	end
end
addEvent("cguiRespawnVehicles", true )
addEventHandler("cguiRespawnVehicles", getRootElement(), callbackRespawnVehicles)

function resetFactionCooldown(theTeam)
	exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "cooldown")
end

function callbackUpdateMOTD(motd)
	local faction = tonumber(getElementData(source, "faction"))
	local theTeam = getPlayerTeam(source)
	
	if (faction~=-1) then
		if mysql:query_free("UPDATE factions SET motd='" .. tostring(mysql:escape_string(motd)) .. "' WHERE id='" .. faction .. "'") then
			outputChatBox("You changed your faction's MOTD to '" .. motd .. "'", source, 0, 255, 0)
			exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "motd", motd, false)
		else
			outputChatBox("Error 300000 - Report on Mantis.", source, 255, 0, 0)
		end
	end
end
addEvent("cguiUpdateMOTD", true )
addEventHandler("cguiUpdateMOTD", getRootElement(), callbackUpdateMOTD)

function callbackRemovePlayer(removedPlayerName)
	if mysql:query_free("UPDATE characters SET faction_id='-1', faction_leader='0', faction_rank='1', dutyskin = 0, duty = 0 WHERE charactername='" .. mysql:escape_string(removedPlayerName) .. "'") then
		local theTeam = getPlayerTeam(source)
		local theTeamName = "None"
		if (theTeam) then
			theTeamName = getTeamName(theTeam)
		end
		
		local username = getPlayerName(source)
		

		local removedPlayer = getPlayerFromName(removedPlayerName)
		if (removedPlayer) then -- Player is online
			if (getElementData(source, "factionMenu")==1) then
				triggerClientEvent(removedPlayer, "hideFactionMenu", getRootElement())
			end
			outputChatBox(username .. " removed you from the faction '" .. tostring(theTeamName) .. "'", removedPlayer)
			setPlayerTeam(removedPlayer, getTeamFromName("Citizen"))
			exports['anticheat-system']:changeProtectedElementDataEx(removedPlayer, "faction", -1)
			exports['anticheat-system']:changeProtectedElementDataEx(removedPlayer, "dutyskin", -1, false)
			exports['anticheat-system']:changeProtectedElementDataEx(removedPlayer, "factionleader", 0, false)
			if getElementData(removedPlayer, "duty") and getElementData(removedPlayer, "duty") > 0 then
				exports.global:takeAllWeapons(removedPlayer)
				exports['anticheat-system']:changeProtectedElementDataEx(removedPlayer, "duty", 0, false)
			end
		end
		
		-- Send message to everyone in the faction
		local teamPlayers = getPlayersInTeam(theTeam)
		for k, v in ipairs(teamPlayers) do
			if (v~=removedPlayer) then
				outputChatBox(username .. " kicked " .. removedPlayerName .. " from faction '" .. tostring(theTeamName) .. "'.", v)
			end
		end
	else
		outputChatBox("Failed to remove " .. removedPlayerName .. " from the faction, Contact an admin.", source, 255, 0, 0)
	end
end
addEvent("cguiKickPlayer", true )
addEventHandler("cguiKickPlayer", getRootElement(), callbackRemovePlayer)

function callbackToggleLeader(playerName, isLeader)
	
	if (isLeader) then -- Make player a leader
		local username = getPlayerName(source)
		if mysql:query_free("UPDATE characters SET faction_leader='1' WHERE charactername='" .. mysql:escape_string(playerName) .. "'") then

			-- Send message to everyone in the faction
			local theTeam = getPlayerTeam(source)
			local teamPlayers = getPlayersInTeam(theTeam)
			for k, v in ipairs(teamPlayers) do
				outputChatBox(username .. " promoted " .. playerName .. " to leader.", v)
			end
			
			local thePlayer = getPlayerFromName(playerName)
			if(thePlayer) then -- Player is online, tell them
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionleader", 1, true)
			end
		else
			outputChatBox("Failed to promote " .. removedPlayerName .. " to faction leader, Contact an admin.", source, 255, 0, 0)
		end
	else
		local username = getPlayerName(source)
		if mysql:query_free("UPDATE characters SET faction_leader='0' WHERE charactername='" .. mysql:escape_string(playerName) .. "'") then
			
			local thePlayer = getPlayerFromName(playerName)
			if(thePlayer) then -- Player is online, tell them
				if (getElementData(source, "factionMenu")==1) then
					triggerClientEvent(thePlayer, "hideFactionMenu", getRootElement())
				end
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionleader", 0, true)
			end
			
			-- Send message to everyone in the faction
			local theTeam = getPlayerTeam(source)
			local teamPlayers = getPlayersInTeam(theTeam)
			for k, v in ipairs(teamPlayers) do
				outputChatBox(username .. " demoted " .. playerName .. " to member.", v)
			end
		else
			outputChatBox("Failed to demote " .. removedPlayerName .. " from faction leader, Contact an admin.", source, 255, 0, 0)
		end
	end
end
addEvent("cguiToggleLeader", true )
addEventHandler("cguiToggleLeader", getRootElement(), callbackToggleLeader)

function callbackPromotePlayer(playerName, rankNum, oldRank, newRank)
	local username = getPlayerName(source)
	if mysql:query_free("UPDATE characters SET faction_rank='" .. rankNum .. "' WHERE charactername='" .. mysql:escape_string(playerName) .. "'") then
		local thePlayer = getPlayerFromName(playerName)
		if(thePlayer) then -- Player is online, set his rank
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionrank", rankNum)
		end
		
		-- Send message to everyone in the faction
		local theTeam = getPlayerTeam(source)
		if (theTeam) then
			local teamPlayers = getPlayersInTeam(theTeam)
			for k, v in ipairs(teamPlayers) do
				outputChatBox(username .. " promoted " .. playerName .. " from '" .. oldRank .. "' to '" .. newRank .. "'.", v)
			end
		end
	else
		outputChatBox("Failed to promote " .. removedPlayerName .. " in the faction, Contact an admin.", source, 255, 0, 0)
	end
end
addEvent("cguiPromotePlayer", true )
addEventHandler("cguiPromotePlayer", getRootElement(), callbackPromotePlayer)

function callbackDemotePlayer(playerName, rankNum, oldRank, newRank)
	local username = getPlayerName(source)
	local safename = mysql:escape_string(playerName)
	
	if mysql:query_free("UPDATE characters SET faction_rank='" .. rankNum .. "' WHERE charactername='" .. safename .. "'") then
		local thePlayer = getPlayerFromName(playerName)
		if(thePlayer) then -- Player is online, tell them
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionrank", rankNum)
		end
		
		-- Send message to everyone in the faction
		local theTeam = getPlayerTeam(source)
		if (theTeam) then
			local teamPlayers = getPlayersInTeam(theTeam)
			for k, v in ipairs(teamPlayers) do
				outputChatBox(username .. " demoted " .. playerName .. " from '" .. oldRank .. "' to '" .. newRank .. "'.", v)
			end
		end
	else
		outputChatBox("Failed to demote " .. removedPlayerName .. " in the faction, Contact an admin.", source, 255, 0, 0)
	end
end
addEvent("cguiDemotePlayer", true )
addEventHandler("cguiDemotePlayer", getRootElement(), callbackDemotePlayer)

function callbackQuitFaction()
	local username = getPlayerName(source)
	local safename = mysql:escape_string(username)
	local theTeam = getPlayerTeam(source)
	local theTeamName = getTeamName(theTeam)
	
	if mysql:query_free("UPDATE characters SET faction_id='-1', faction_leader='0', dutyskin = -1, duty = 0 WHERE charactername='" .. safename .. "'") then
		outputChatBox("You quit the faction '" .. theTeamName .. "'.", source)
		
		local newTeam = getTeamFromName("Citizen")
		setPlayerTeam(source, newTeam)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "faction", -1, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "dutyskin", -1, false)
		if getElementData(source, "duty") and getElementData(source, "duty") > 0 then
			exports.global:takeAllWeapons(source)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "duty", 0, false)
		end
		
		-- Send message to everyone in the faction
		if theTeam ~= newTeam then
			local teamPlayers = getPlayersInTeam(theTeam)
			for k, v in ipairs(teamPlayers) do
				if (v~=thePlayer) then
					outputChatBox(username .. " has quit the faction '" .. theTeamName .. "'.", v)
				end
			end
		end
	else
		outputChatBox("Failed to quit the faction, Contact an admin.", source, 255, 0, 0)
	end
end
addEvent("cguiQuitFaction", true )
addEventHandler("cguiQuitFaction", getRootElement(), callbackQuitFaction)

function callbackInvitePlayer(invitedPlayer)
	local faction = tonumber(getElementData(source, "faction"))

	local invitedPlayerNick = getPlayerName(invitedPlayer)
	local safename = mysql:escape_string(invitedPlayerNick)
	
	if mysql:query_free("UPDATE characters SET faction_leader = 0, faction_id = " .. faction .. ", faction_rank = 1, dutyskin = -1 WHERE charactername='" .. safename .. "'") then
		local theTeam = getPlayerTeam(source)
		local theTeamName = getTeamName(theTeam)
		
		local targetTeam = getPlayerTeam(invitedPlayer)
		if (targetTeam~=nil) and (getTeamName(targetTeam)~="Citizen") then
			outputChatBox("Player is already in a faction.", source, 255, 0, 0)
		else
			setPlayerTeam(invitedPlayer, theTeam)
			exports['anticheat-system']:changeProtectedElementDataEx(invitedPlayer, "faction", faction)
			outputChatBox("Player " .. invitedPlayerNick .. " is now a member of faction '" .. tostring(theTeamName) .. "'.", source, 0, 255, 0)
							
			if	(invitedPlayer) then
				triggerEvent("onPlayerJoinFaction", invitedPlayer, theTeam)
				exports['anticheat-system']:changeProtectedElementDataEx(invitedPlayer, "factionrank", 1)
				exports['anticheat-system']:changeProtectedElementDataEx(invitedPlayer, "dutyskin", -1, false)
				outputChatBox("You were set to Faction '" .. tostring(theTeamName) .. ".", invitedPlayer, 255, 194, 14)
			end
		end
	else
		outputChatBox("Player is already in a faction.", source, 255, 0, 0)
	end
end
addEvent("cguiInvitePlayer", true )
addEventHandler("cguiInvitePlayer", getRootElement(), callbackInvitePlayer)

-- // ADMIN COMMANDS
function createFaction(thePlayer, commandName, factionType, ...)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Faction Type 0=GANG, 1=MAFIA, 2=LAW, 3=GOV, 4=MED, 5=OTHER, 6=NEWS][Faction Name]", thePlayer, 255, 194, 14)
		else
			factionName = table.concat({...}, " ")
			factionType = tonumber(factionType)
			
			local theTeam = createTeam(tostring(factionName))
			if theTeam then
				if mysql:query_free("INSERT INTO factions SET name='" .. mysql:escape_string(factionName) .. "', bankbalance='0', type='" .. mysql:escape_string(factionType) .. "'") then
					local id = mysql:insert_id()
					exports.pool:allocateElement(theTeam, id)
					
					mysql:query_free("UPDATE factions SET rank_1='Dynamic Rank #1', rank_2='Dynamic Rank #2', rank_3='Dynamic Rank #3', rank_4='Dynamic Rank #4', rank_5='Dynamic Rank #5', rank_6='Dynamic Rank #6', rank_7='Dynamic Rank #7', rank_8='Dynamic Rank #8', rank_9='Dynamic Rank #9', rank_10='Dynamic Rank #10', rank_11='Dynamic Rank #11', rank_12='Dynamic Rank #12', rank_13='Dynamic Rank #13', rank_14='Dynamic Rank #14', rank_15='Dynamic Rank #15', motd='Welcome to the faction.' WHERE id='" .. id .. "'")
					outputChatBox("Faction " .. factionName .. " created with ID #" .. id .. ".", thePlayer, 0, 255, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "type", tonumber(factionType))
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "id", tonumber(id))
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "money", 0)
					
					local factionRanks = {}
					local factionWages = {}
					for i = 1, 15 do
						factionRanks[i] = "Dynamic Rank #" .. i
						factionWages[i] = 100
					end
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "ranks", factionRanks, false)
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "wages", factionWages, false)
					exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "motd", "Welcome to the faction.", false)
				else
					destroyElement(theTeam)
					outputChatBox("Error creating faction.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Faction '" .. tostring(factionName) .. "' already exists.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("makefaction", createFaction, false, false)

function adminRenameFaction(thePlayer, commandName, factionID, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (factionID) or not (...)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [Faction ID] [Faction Name]", thePlayer, 255, 194, 14)
		else
			factionID = tonumber(factionID)
			if factionID and factionID > 0 then
				local theTeam = exports.pool:getElement("team", factionID)
				if (theTeam) then
					local factionName = table.concat({...}, " ")
					mysql:query_free("UPDATE factions SET name='" .. mysql:escape_string(factionName) .. "' WHERE id='" .. factionID .. "'")
					
					setTeamName(theTeam, factionName)
					
					outputChatBox("Faction #" .. factionID .. " was renamed to " .. factionName .. ".", thePlayer, 0, 255, 0)
				else
					outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("renamefaction", adminRenameFaction, false, false)

function adminSetPlayerFaction(thePlayer, commandName, partialNick, factionID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		factionID = tonumber(factionID)
		if not (partialNick) or not (factionID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name/ID] [Faction ID (-1 for none)]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerNick = exports.global:findPlayerByPartialNick(thePlayer, partialNick)
			
			if targetPlayer then
				local theTeam = exports.pool:getElement("team", factionID)
				if not theTeam then
					outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
					return
				end
				
				if mysql:query_free("UPDATE characters SET faction_leader = 0, faction_id = " .. factionID .. ", faction_rank = 1, duty = 0, dutyskin = -1 WHERE id=" .. getElementData(targetPlayer, "dbid")) then
					setPlayerTeam(targetPlayer, theTeam)
					if factionID > 0 then
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "faction", factionID)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "factionrank", 1)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "dutyskin", -1, false)
						if getElementData(targetPlayer, "duty") and getElementData(targetPlayer, "duty") > 0 then
							exports.global:takeAllWeapons(targetPlayer)
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "duty", 0, false)
						end
						
						outputChatBox("Player " .. targetPlayerNick .. " is now a member of faction '" .. getTeamName(theTeam) .. "' (#" .. factionID .. ").", thePlayer, 0, 255, 0)
						
						triggerEvent("onPlayerJoinFaction", targetPlayer, theTeam)
						outputChatBox("You were set to Faction '" .. getTeamName(theTeam) .. ".", targetPlayer, 255, 194, 14)
						
						exports.logs:logMessage("[FACTION] " .. getPlayerName( thePlayer ) .. " set " .. getPlayerName( targetPlayer ) .. " to faction " .. getTeamName(theTeam) .. " (#" .. factionID .. ")", 15)
					else
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "faction", -1)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "factionrank", 1)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "dutyskin", -1, false)
						if getElementData(targetPlayer, "duty") and getElementData(targetPlayer, "duty") > 0 then
							exports.global:takeAllWeapons(targetPlayer)
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "duty", 0, false)
						end
						
						outputChatBox("Player " .. targetPlayerNick .. " was set to no faction.", thePlayer, 0, 255, 0)
						outputChatBox("You were removed from your faction.", targetPlayer, 255, 0, 0)
						
						exports.logs:logMessage("[FACTION] " .. getPlayerName( thePlayer ) .. " set " .. getPlayerName( targetPlayer ) .. " to no faction", 15)
					end
				end
			end
		end
	end
end
addCommandHandler("setfaction", adminSetPlayerFaction, false, false)

function adminSetFactionLeader(thePlayer, commandName, partialNick, factionID)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		factionID = tonumber(factionID)
		if not (partialNick) or not (factionID)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name] [Faction ID]", thePlayer, 255, 194, 14)
		elseif factionID > 0 then
			local targetPlayer, targetPlayerNick = exports.global:findPlayerByPartialNick(thePlayer, partialNick)
			
			if targetPlayer then
				local theTeam = exports.pool:getElement("team", factionID)
				if not theTeam then
					outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
					return
				end
				
				if mysql:query_free("UPDATE characters SET faction_leader = 1, faction_id = " .. tonumber(factionID) .. ", faction_rank = 1, dutyskin = -1, duty = 0 WHERE id = " .. getElementData(targetPlayer, "dbid")) then
					setPlayerTeam(targetPlayer, theTeam)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "faction", factionID, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "factionrank", 1)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "dutyskin", -1, false)
					if getElementData(targetPlayer, "duty") and getElementData(targetPlayer, "duty") > 0 then
						exports.global:takeAllWeapons(targetPlayer)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "duty", 0, false)
					end
					
					outputChatBox("Player " .. targetPlayerNick .. " is now a leader of faction '" .. getTeamName(theTeam) .. "' (#" .. factionID .. ").", thePlayer, 0, 255, 0)
						
					triggerEvent("onPlayerJoinFaction", targetPlayer, theTeam)
					outputChatBox("You were set to the leader of Faction '" .. getTeamName(theTeam) .. ".", targetPlayer, 255, 194, 14)
					
					exports.logs:logMessage("[FACTIONLEADER] " .. getPlayerName( thePlayer ) .. " set " .. getPlayerName( targetPlayer ) .. " to factionleader of " .. getTeamName(theTeam) .. " (#" .. factionID .. ")", 15)
				else
					outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("setfactionleader", adminSetFactionLeader, false, false)

function adminSetFactionRank(thePlayer, commandName, partialNick, factionRank)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		factionRank = math.ceil(tonumber(factionRank) or -1)
		if not (partialNick) or not (factionRank)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name] [Faction Rank, 1-15]", thePlayer, 255, 194, 14)
		elseif factionRank >= 1 and factionRank <= 15 then
			local targetPlayer, targetPlayerNick = exports.global:findPlayerByPartialNick(thePlayer, partialNick)
			
			if targetPlayer then
				local theTeam = getPlayerTeam(targetPlayer)
				if not theTeam or getTeamName( theTeam ) == "Citizen" then
					outputChatBox("Player is not in a faction.", thePlayer, 255, 0, 0)
					return
				end
				
				if mysql:query_free("UPDATE characters SET faction_rank = " .. factionRank .. " WHERE id = " .. getElementData(targetPlayer, "dbid")) then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "factionrank", factionRank)
					
					outputChatBox("Player " .. targetPlayerNick .. " is now on rank " .. factionRank .. ".", thePlayer, 0, 255, 0)
					
					exports.logs:logMessage("[FACTIONRANK] " .. getPlayerName( thePlayer ) .. " set " .. getPlayerName( targetPlayer ) .. " to rank " .. factionRank, 15)
				else
					outputChatBox("Error #125151 - Report on Mantis.", thePlayer, 255, 0, 0)
				end
			end
		else
			outputChatBox( "Invalid Rank - valid ones are 1 to 15", thePlayer, 255, 0, 0 )
		end
	end
end
addCommandHandler("setfactionrank", adminSetFactionRank, false, false)

function adminDeleteFaction(thePlayer, commandName, factionID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (factionID)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [Faction ID]", thePlayer, 255, 194, 14)
		else
			factionID = tonumber(factionID)
			if factionID and factionID > 0 then
				local theTeam = exports.pool:getElement("team", factionID)
				
				if (theTeam) then
					if factionID == 57 then
						outputChatBox("So you did it! HA! Logged. Now stop deleting factions needed for the script. -Mount", thePlayer, 255, 0, 0)
						exports.logs:logMessage("[BANKFACTION] " .. getPlayerName( thePlayer ) .. " tried to delete faction " .. getTeamName(theTeam) .. " (#" .. factionID .. ")", 15)
					else
						mysql:query_free("DELETE FROM factions WHERE id='" .. factionID .. "'")
						
						outputChatBox("Faction #" .. factionID .. " was deleted.", thePlayer, 0, 255, 0)
						exports.logs:logMessage("[FACTION] " .. getPlayerName( thePlayer ) .. " deleted faction " .. getTeamName(theTeam) .. " (#" .. factionID .. ")", 15)
						local civTeam = getTeamFromName("Citizen")
						for key, value in pairs( getPlayersInTeam( theTeam ) ) do
							setPlayerTeam( value, civTeam )
							exports['anticheat-system']:changeProtectedElementDataEx( value, "faction", -1 )
						end
						destroyElement( theTeam )
					end
				else
					outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Invalid Faction ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("delfaction", adminDeleteFaction, false, false)

function adminShowFactions(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local result = mysql:query("SELECT id, name, type, (SELECT COUNT(*) FROM characters c WHERE c.faction_id = f.id) AS members FROM factions f ORDER BY id ASC")
		
		
		
		if result then
			local factions = { }
			
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				
				table.insert( factions, { row.id, row.name, row.type, ( getTeamFromName( row.name ) and #getPlayersInTeam( getTeamFromName( row.name ) ) or "?" ) .. " / " .. row.members } )
			end
			
			mysql:free_result(result)
			triggerClientEvent(thePlayer, "showFactionList", getRootElement(), factions)
		else
			outputChatBox("Error 300001 - Report on forums.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("showfactions", adminShowFactions, false, false)

function setFactionMoney(thePlayer, commandName, factionID, amount)
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (factionID) or not (amount)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [Faction ID] [Money]", thePlayer, 255, 194, 14)
		else
			factionID = tonumber(factionID)
			if factionID and factionID > 0 then
				local theTeam = exports.pool:getElement("team", factionID)
				amount = tonumber(amount)
				
				if (theTeam) then
					exports.global:setMoney(theTeam, amount)
					outputChatBox("Set faction '" .. getTeamName(theTeam) .. "'s money to " .. amount .. " $.", thePlayer, 255, 194, 14)
				else
					outputChatBox("Invalid faction ID.", thePlayer, 255, 194, 14)
				end
			else
				outputChatBox("Invalid faction ID.", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("setfactionmoney", setFactionMoney, false, false)

function setFactionBudget(thePlayer, commandName, factionID, amount)
	if getPlayerTeam(thePlayer) == getTeamFromName("Government of Los Santos") and getElementData(thePlayer, "factionrank") >= 10 then
		local amount = tonumber( amount )
		if not factionID or not amount or amount < 0 then
			outputChatBox("SYNTAX: /" .. commandName .. " [Faction ID] [Money]", thePlayer, 255, 194, 14)
		else
			factionID = tonumber(factionID)
			if factionID and factionID > 0 then
				local theTeam = exports.pool:getElement("team", factionID)
				amount = tonumber(amount)
				
				if (theTeam) then
					if getElementData(theTeam, "type") >= 2 and getElementData(theTeam, "type") <= 6 then
						if exports.global:takeMoney(getPlayerTeam(thePlayer), amount) then
							exports.global:giveMoney(theTeam, amount)
							outputChatBox("You added $" .. amount .. " to the budget of '" .. getTeamName(theTeam) .. "' (Total: " .. exports.global:getMoney(theTeam) .. ").", thePlayer, 255, 194, 14)
							mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. -getElementData(getPlayerTeam(thePlayer), "id") .. ", " .. -getElementData(theTeam, "id") .. ", " .. amount .. ", '', 8)" )
						else
							outputChatBox("You can't afford this.", thePlayer, 255, 194, 14)
						end
					else
						outputChatBox("You can't set a budget for that faction.", thePlayer, 255, 194, 14)
					end
				else
					outputChatBox("Invalid faction ID.", thePlayer, 255, 194, 14)
				end
			else
				outputChatBox("Invalid faction ID.", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("setbudget", setFactionBudget, false, false)

function setTax(thePlayer, commandName, amount)
	if getPlayerTeam(thePlayer) == getTeamFromName("Government of Los Santos") and getElementData(thePlayer, "factionrank") >= 10 then
		local amount = tonumber( amount )
		if not amount or amount < 0 or amount > 30 then
			outputChatBox("SYNTAX: /" .. commandName .. " [0-30%]", thePlayer, 255, 194, 14)
		else
			exports.global:setTaxAmount(amount)
			outputChatBox("New Tax is " .. amount .. "%", thePlayer, 0, 255, 0)
		end
	end
end
addCommandHandler("settax", setTax, false, false)

function setIncomeTax(thePlayer, commandName, amount)
	if getPlayerTeam(thePlayer) == getTeamFromName("Government of Los Santos") and getElementData(thePlayer, "factionrank") >= 10 then
		local amount = tonumber( amount )
		if not amount or amount < 0 or amount > 25 then
			outputChatBox("SYNTAX: /" .. commandName .. " [0-25%]", thePlayer, 255, 194, 14)
		else
			exports.global:setIncomeTaxAmount(amount)
			outputChatBox("New Income Tax is " .. amount .. "%", thePlayer, 0, 255, 0)
		end
	end
end
addCommandHandler("setincometax", setIncomeTax, false, false)

function setWelfare(thePlayer, commandName, amount)
	if getPlayerTeam(thePlayer) == getTeamFromName("Government of Los Santos") and getElementData(thePlayer, "factionrank") >= 10 then
		local amount = tonumber( amount )
		if not amount or amount <= 0 then
			outputChatBox("SYNTAX: /" .. commandName .. " [Money]", thePlayer, 255, 194, 14)
		elseif mysql:query_free( "UPDATE settings SET value = " .. unemployedPay .. " WHERE name = 'welfare'" ) then
			unemployedPay = amount
			outputChatBox("New Welfare is $" .. unemployedPay .. "/payday", thePlayer, 0, 255, 0)
		else
			outputChatBox("Error 129314 - Report on Mantis.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("setwelfare", setWelfare, false, false)

function getTax(thePlayer)
	outputChatBox( "Welfare: $" .. unemployedPay, thePlayer, 255, 194, 14 )
	outputChatBox( "Tax: " .. ( exports.global:getTaxAmount(thePlayer) * 100 ) .. "%", thePlayer, 255, 194, 14 )
	outputChatBox( "Income Tax: " .. ( exports.global:getIncomeTaxAmount(thePlayer) * 100 ) .. "%", thePlayer, 255, 194, 14 )
end
addCommandHandler("gettax", getTax, false, false)

-- /////////////// WAGES
local governmentIncome = 0

local rentVehicles = {}
local taxVehicles = {}
local vehicleCount = {}
local taxHouses = {}

local rc = 10
local bike = 15
local low = 25
local offroad = 35
local sport = 100
local van = 50
local bus = 75
local truck = 200
local boat = 300 -- except dinghy
local heli = 500
local plane = 750
local race = 75
local vehicleTaxes = {
	offroad, low, sport, truck, low, low, 1000, truck, truck, 200, -- dumper, stretch
	low, sport, low, van, van, sport, truck, heli, van, low,
	low, low, low, van, low, 1000, low, truck, van, sport, -- hunter
	boat, bus, 1000, truck, offroad, van, low, bus, low, low, -- rhino
	van, rc, low, truck, 500, low, boat, heli, bike, 0, -- monster, tram
	van, sport, boat, boat, boat, truck, van, 10, low, van, -- caddie
	plane, bike, bike, bike, rc, rc, low, low, bike, heli,
	van, bike, boat, 20, low, low, plane, sport, low, low, -- dinghy
	sport, bike, van, van, boat, 10, 75, heli, heli, offroad, -- baggage, dozer
	offroad, low, low, boat, low, offroad, low, heli, van, van,
	low, rc, low, low, low, offroad, sport, low, van, bike,
	bike, plane, plane, plane, truck, truck, low, low, low, plane,
	plane * 10, bike, bike, bike, truck, van, low, low, truck, low, -- hydra
	10, 20, offroad, low, low, low, low, 0, 0, offroad, -- forklift, tractor, 2x train
	low, sport, low, van, truck, low, low, low, rc, low,
	low, low, van, plane, van, low, 500, 500, race, race, -- 2x monster
	race, low, race, heli, rc, low, low, low, offroad, 0, -- train trailer
	0, 10, 10, offroad, 15, low, low, 3*plane, truck, low,-- train trailer, kart, mower, sweeper, at400
	low, bike, van, low, van, low, bike, race, van, low,
	0, van, 2*plane, plane, rc, boat, low, low, low, offroad, -- train trailer, andromeda
	low, truck, race, sport, low, low, low, low, low, van,
	low, low
}
function payWage(player, pay, faction, tax)
	local governmentIncome = 0
	local bankmoney = getElementData(player, "bankmoney")
	local interestrate = 0.004
	local noWage = pay == 0
	
	-- DONATOR PERKS
	local donator = getElementData(player, "donatorlevel")
	local donatormoney = 0 
	if (donator==1) then
		donatormoney = donatormoney + 25
		interestrate = interestrate + 0.001
	elseif (donator==2) then
		donatormoney = donatormoney + 50
		interestrate = interestrate + 0.002
	elseif (donator==3) then
		donatormoney = donatormoney + 75
		interestrate = interestrate + 0.003
	elseif (donator==4) then
		donatormoney = donatormoney + 100
		interestrate = interestrate + 0.004
	elseif (donator==5) then
		donatormoney = donatormoney + 125
		interestrate = interestrate + 0.005
	elseif (donator==6) then
		donatormoney = donatormoney + 150
		interestrate = interestrate + 0.006
	elseif (donator==7) then
		donatormoney = donatormoney + 250
		interestrate = interestrate + 0.006
	end
	
	local interest = math.ceil(interestrate * bankmoney)
	local capped = false
	if (interest >  99999) then
		capped = true
		interest = 100000
	end
	
	mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (-57, " .. getElementData(player, "dbid") .. ", " .. interest .. ", 'BANKINTEREST', 6)" )
	
	local incomeTax = exports.global:getIncomeTaxAmount()
	
	-- business money
	local profit = getElementData(player, "businessprofit")
	exports['anticheat-system']:changeProtectedElementDataEx(player, "businessprofit", 0, false)
	bankmoney = bankmoney + math.max( 0, pay ) + interest + profit + donatormoney

	
	-- rentable houses
	local rent = 0
	local rented = nil -- store id in here
	local dbid = tonumber(getElementData(player, "dbid"))
	for key, value in ipairs(getElementsByType("pickup", getResourceRootElement(getResourceFromName("interior-system")))) do
		local owner = tonumber(getElementData(value, "owner"))
		if (owner) and (owner == dbid) and (getElementData(value, "name")) and (tonumber(getElementData(value, "inttype")) == 3) and (tonumber(getElementData(value, "cost")) > 0) then
			rent = rent + tonumber(getElementData(value, "cost"))
			rented = tonumber(getElementData(value, "dbid"))
		end
	end
	
	if not faction then
		if pay >= 0 then
			governmentIncome = governmentIncome - pay
			mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (-3, " .. getElementData(player, "dbid") .. ", " .. pay .. ", 'STATEBENEFITS', 6)" )
		else
			pay = 0
		end
	else
		if pay >= 0 then
			local teamid = getElementData(player, "faction")
			if teamid <= 0 then
				teamid = 0
			else
				teamid = -teamid
			end
			mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. teamid .. ", " .. getElementData(player, "dbid") .. ", " .. pay .. ", 'WAGE', 6)" )
		else
			pay = 0
		end
	end
	
	if tax > 0 then
		pay = pay - tax
		bankmoney = bankmoney - tax
		governmentIncome = governmentIncome + tax
		mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. getElementData(player, "dbid") .. ", -3, " .. tax .. ", 'INCOMETAX', 6)" )
	end
	
	local vtax = taxVehicles[ getElementData(player, "dbid") ] or 0
	if vtax > 0 then
		vtax = math.min( vtax, bankmoney )
		bankmoney = bankmoney - vtax
		
		if vtax > pay+profit+interest+donatormoney then
			exports.global:givePlayerAchievement(player, 19)
		end
		
		mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. getElementData(player, "dbid") .. ", -3, " .. vtax .. ", 'VEHICLETAX', 6)" )

		
		governmentIncome = governmentIncome + vtax
	end
	
	local renttax = rentVehicles[ getElementData(player, "dbid") ] or 0
	if renttax > 0 then
		renttax = math.min( renttax, bankmoney )
		bankmoney = bankmoney - renttax
		
		if renttax > pay+profit+interest+donatormoney then
			exports.global:givePlayerAchievement(player, 19)
		end
		
		mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. getElementData(player, "dbid") .. ", -3, " .. renttax .. ", 'VEHICLERENT', 6)" )

		
		governmentIncome = governmentIncome + renttax
	end
	local ptax = taxHouses[ getElementData(player, "dbid") ] or 0
	if ptax > 0 then
		ptax = math.floor( ptax * 0.6 )
		ptax = math.min( ptax, bankmoney )
		bankmoney = bankmoney - ptax
		governmentIncome = governmentIncome + ptax
		mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. getElementData(player, "dbid") .. ", -3, " .. ptax .. ", 'PROPERTYTAX', 6)" )
	end
	
	if (rent > 0) then
		if (rent > bankmoney)   then
			rent = -1
			call( getResourceFromName( "interior-system" ), "publicSellProperty", player, rented, false, true )
		else
			exports.global:givePlayerAchievement(player, 11)
			bankmoney = bankmoney - rent
			
			-- gov shouldnt get anything of this
			--governmentIncome = governmentIncome + rent
			mysql:query_free( "INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. getElementData(player, "dbid") .. ", 0, " .. rent .. ", 'HOUSERENT', 6)" )
		end
	end

	-- save the bankmoney
	exports['anticheat-system']:changeProtectedElementDataEx(player, "bankmoney", bankmoney)
	
	local grossincome = pay+profit+interest+donatormoney-rent-vtax-ptax-renttax
		
	-- let the client tell them the (bad) news
	triggerClientEvent(player, "cPayDay", player, faction, noWage and -1 or pay, profit, interest, donatormoney, tax, incomeTax, vtax, ptax, rent, grossincome,renttax)
	return governmentIncome
end

function payAllWages(timer)
	if timer then
		local mins = getRealTime().minute
		local minutes = 60 - mins
		if (minutes < 15) then
			minutes = minutes + 60
		end
		setTimer(payAllWages, 60000*minutes, 1, true)
	end
	
	-- collect all vehicle info
	taxVehicles = {}
	rentVehicles = {}
	vehicleCount = {}
	for _, veh in pairs(getElementsByType("vehicle")) do
		if isElement(veh) then
			local owner, faction = tonumber(getElementData(veh, "owner")) or 0, tonumber(getElementData(veh, "faction")) or 0
			local rent, rentcost = tonumber(getElementData(veh, "rent")) or 0, tonumber(getElementData(veh, "rentcost")) or 0
			if rent==1 then
				rentVehicles[owner] = ( rentVehicles[owner] or 0 ) + rentcost
			elseif faction < 0 and owner > 0 then -- non-faction vehicles
				taxVehicles[owner] = ( taxVehicles[owner] or 0 ) + ( vehicleTaxes[getElementModel(veh)-399] or 25 )
				vehicleCount[owner] = ( vehicleCount[owner] or 0 ) + 1
				if vehicleCount[owner] > 3 then -- $50 for having too much vehicles, per vehicle more than 3
					taxVehicles[owner] = taxVehicles[owner] + 50
				end
			end
		end
	end
	
	-- count all player props
	taxHouses = { }
	for _, property in pairs( getElementsByType( "pickup", getResourceRootElement( getResourceFromName( "interior-system" ) ) ) ) do
		if getElementData( property, "cost" ) and getElementData( property, "owner" ) > 0 and getElementData( property, "inttype" ) < 2  then -- owned, not rented houses
			taxHouses[ getElementData( property, "owner" ) ] = ( taxHouses[ getElementData( property, "owner" ) ] or 0 ) + 0.005 * getElementData( property, "cost" )
		end
	end
	
	local players = exports.pool:getPoolElementsByType("player")
	
	local govAmount = exports.global:getMoney(getTeamFromName("Government of Los Santos"))
	
	for key, value in ipairs(players) do
		local logged = getElementData(value, "loggedin")
		local timeinserver = getElementData(value, "timeinserver")
		
		-- Pay Check tooltip
		if(getResourceFromName("tooltips-system"))then
			triggerClientEvent(value,"tooltips:showHelp", getRootElement(),12)
		end
		
		if (logged==1) and (timeinserver>=60) then
			mysql:query_free( "UPDATE characters SET jobcontract = jobcontract - 1 WHERE id = " .. getElementData( value, "dbid" ) .. " AND jobcontract > 0" )
			if getElementData(value, "license.car") and getElementData(value, "license.car") < 0 then
				exports['anticheat-system']:changeProtectedElementDataEx(value, "license.car", getElementData(value, "license.car") + 1)
				mysql:query_free( "UPDATE characters SET car_license = car_license + 1 WHERE id = " .. getElementData( value, "dbid" ) )
			end
			if getElementData(value, "license.gun") and getElementData(value, "license.gun") < 0 then
				exports['anticheat-system']:changeProtectedElementDataEx(value, "license.gun", getElementData(value, "license.gun") + 1)
				mysql:query_free( "UPDATE characters SET gun_license = gun_license + 1 WHERE id = " .. getElementData( value, "dbid" ) )
			end
			local playerFaction = getElementData(value, "faction")
			if (playerFaction~=-1) then -- In a faction
				local theTeam = getPlayerTeam(value)
				local factionType = getElementData(theTeam, "type")
				
				if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then -- Factions with wages
					local username = getPlayerName(value)
					
					local factionRank = getElementData(value, "factionrank")
					local rankWageresult = mysql:query_fetch_assoc("SELECT wage_" .. factionRank .. " FROM factions WHERE id='" .. playerFaction .. "'")
					local rankWage = tonumber( rankWageresult['wage_' .. factionRank] )
					
					local taxes = 0
					if not exports.global:takeMoney(theTeam, rankWage) then
						rankWage = -1
					else
						local incomeTax = exports.global:getIncomeTaxAmount()
						taxes = math.ceil( incomeTax * rankWage )
					end
					
					govAmount = govAmount + payWage( value, rankWage, true, taxes )
				else
					if unemployedPay >= govAmount then
						unemployedPay = -1
					end
					
					govAmount = govAmount + payWage( value, unemployedPay, false, 0 )
				end
			else
				if unemployedPay >= govAmount then
					unemployedPay = -1
				end
				
				govAmount = govAmount + payWage( value, unemployedPay, false, 0 )
			end
			
			exports['anticheat-system']:changeProtectedElementDataEx(value, "timeinserver", timeinserver-60, false)

			local hoursplayed = getElementData(value, "hoursplayed") or 0
			exports['anticheat-system']:changeProtectedElementDataEx(value, "hoursplayed", hoursplayed+1, false)
			mysql:query_free( "UPDATE characters SET hoursplayed = hoursplayed + 1, bankmoney = " .. getElementData( value, "bankmoney" ) .. " WHERE id = " .. getElementData( value, "dbid" ) )
		elseif (logged==1) and (timeinserver) and (timeinserver<60) then
			outputChatBox("You have not played long enough to recieve a payday. (You require another " .. 60-timeinserver .. " Minutes of play.)", value, 255, 0, 0)
		end
	end
	
	-- Store the government money
	exports.global:setMoney(getTeamFromName("Government of Los Santos"), govAmount)
end


function adminDoPayday(thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (exports.global:isPlayerLeadAdmin(thePlayer)) then
			payAllWages(false)
		end
	end
end
addCommandHandler("dopayday", adminDoPayday)

function timeSaved(thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local timeinserver = getElementData(thePlayer, "timeinserver")
		
		if (timeinserver>60) then
			timeinserver = 60
		end
		
		outputChatBox("You currently have " .. timeinserver .. " Minutes played.", thePlayer, 255, 195, 14)
		outputChatBox("You require another " .. 60-timeinserver .. " Minutes to obtain a payday.", thePlayer, 255, 195, 14)
	end
end
addCommandHandler("timesaved", timeSaved)

function hideFactionMenu()
	exports['anticheat-system']:changeProtectedElementDataEx(source, "factionMenu", 0, true)
end
addEvent("factionmenu:hide", true)
addEventHandler("factionmenu:hide", getRootElement(), hideFactionMenu)