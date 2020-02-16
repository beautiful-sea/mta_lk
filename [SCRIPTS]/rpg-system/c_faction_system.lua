gFactionWindow, gMemberGrid, gMOTDLabel, colName, colRank, colWage, colLastLogin, colLocation, colLeader, colOnline, gButtonKick, gButtonPromote, gButtonDemote, gButtonEditRanks, gButtonEditMOTD, gButtonInvite, gButtonLeader, gButtonQuit, gButtonExit, wConfirmQuit = nil
theMotd, theTeam, arrUsernames, arrRanks, arrLeaders, arrOnline, arrFactionRanks, arrLocations, arrFactionWages, arrLastLogin, membersOnline, membersOffline, gButtonRespawn = nil

local function checkF3( )
	if not f3state and getKeyState( "f3" ) then
		hideFactionMenu( )
	else
		f3state = getKeyState( "f3" )
	end
end

function showFactionMenu(motd, memberUsernames, memberRanks, memberLeaders, memberOnline, memberLastLogin, memberLocation, factionRanks, factionWages, factionTheTeam)
	if (gFactionWindow==nil) then
		invitedPlayer = nil
		arrUsernames = memberUsernames
		arrRanks = memberRanks
		arrLeaders = memberLeaders
		arrOnline = memberOnline
		arrLastLogin = memberLastLogin
		arrLocations = memberLocation
		arrFactionRanks = factionRanks
		arrFactionWages = factionWages
		
		if (motd) == nil then motd = "" end
		theMotd = motd
	
	
		local thePlayer = getLocalPlayer()
		theTeam = factionTheTeam
		local teamName = getTeamName(theTeam)
		local playerName = getPlayerName(thePlayer)

		gFactionWindow = guiCreateWindow(0.1, 0.25, 0.85, 0.525, tostring(teamName), true)
		guiWindowSetSizable(gFactionWindow, false)
		
		guiSetInputEnabled(true)
		
		-- Make members list
		gMemberGrid = guiCreateGridList(0.01, 0.075, 0.8, 0.85, true, gFactionWindow)
		
		colName = guiGridListAddColumn(gMemberGrid, "Name", 0.16)
		colRank = guiGridListAddColumn(gMemberGrid, "Rank", 0.13)
		colOnline = guiGridListAddColumn(gMemberGrid, "Status", 0.065)
		colLastLogin = guiGridListAddColumn(gMemberGrid, "Last Login", 0.17)
		colLeader = guiGridListAddColumn(gMemberGrid, "Level", 0.1)
		
		
		local factionType = tonumber(getElementData(theTeam, "type"))
		
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then
			colLocation = guiGridListAddColumn(gMemberGrid, "Location", 0.25)
			colWage = guiGridListAddColumn(gMemberGrid, "Wage ($)", 0.1)
		else
			colLocation = guiGridListAddColumn(gMemberGrid, "Location", 0.35)
		end
		
		
		local localPlayerIsLeader = nil
		local counterOnline, counterOffline = 0, 0
		
		for k, v in ipairs(memberUsernames) do
			local row = guiGridListAddRow(gMemberGrid)
			guiGridListSetItemText(gMemberGrid, row, colName, string.gsub(tostring(memberUsernames[k]), "_", " "), false, false)
			
			local theRank = tonumber(memberRanks[k])
			local rankName = factionRanks[theRank]
			guiGridListSetItemText(gMemberGrid, row, colRank, tostring(rankName), false, false)
			guiGridListSetItemData(gMemberGrid, row, colRank, tostring(theRank))
			
			local login = "Never"
			if (not memberLastLogin[k]) then
				login = "Never"
			else
				if (memberLastLogin[k]==0) then
					login = "Today"
				elseif (memberLastLogin[k]==1) then
					login = tostring(memberLastLogin[k]) .. " day ago"
				else
					login = tostring(memberLastLogin[k]) .. " days ago"
				end
			end
			guiGridListSetItemText(gMemberGrid, row, colLastLogin, login, false, false)
			guiGridListSetItemText(gMemberGrid, row, colLocation, memberLocation[k], false, false)

			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6)then
				local rankWage = factionWages[theRank]
				guiGridListSetItemText(gMemberGrid, row, colWage, tostring(rankWage), false, true)
			end
			
			if (memberOnline[k]) then
				guiGridListSetItemText(gMemberGrid, row, colOnline, "Online", false, false)
				counterOnline = counterOnline + 1
			else
				guiGridListSetItemText(gMemberGrid, row, colOnline, "Offline", false, false)
				counterOffline = counterOffline + 1
			end

			if (memberLeaders[k]) then
				guiGridListSetItemText(gMemberGrid, row, colLeader, "Leader", false, false)
			else
				guiGridListSetItemText(gMemberGrid, row, colLeader, "Member", false, false)
			end
			
			-- Check if this is the local player
			if (tostring(memberUsernames[k])==playerName) then
				localPlayerIsLeader = memberLeaders[k]
			end
		end
		
		membersOnline = counterOnline
		membersOffline = counterOffline
		
		-- Update the window title
		guiSetText(gFactionWindow, tostring(teamName) .. " (" .. counterOnline .. " of " .. (counterOnline+counterOffline) .. " Members Online)")
		
		-- Make the buttons
		if (localPlayerIsLeader) then
			gButtonKick = guiCreateButton(0.825, 0.076, 0.16, 0.06, "Kick Player", true, gFactionWindow)
			gButtonLeader = guiCreateButton(0.825, 0.1526, 0.16, 0.06, "Toggle Leader", true, gFactionWindow)
			gButtonPromote = guiCreateButton(0.825, 0.2292, 0.16, 0.06, "Promote Player", true, gFactionWindow)
			gButtonDemote = guiCreateButton(0.825, 0.3058, 0.16, 0.06, "Demote Player", true, gFactionWindow)
			
			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then
				gButtonEditRanks = guiCreateButton(0.825, 0.3824, 0.16, 0.06, "Edit Ranks & Wages", true, gFactionWindow)
			else
				gButtonEditRanks = guiCreateButton(0.825, 0.3824, 0.16, 0.06, "Edit Ranks", true, gFactionWindow)
			end
			
			gButtonEditMOTD = guiCreateButton(0.825, 0.459, 0.16, 0.06, "Edit MOTD", true, gFactionWindow)
			gButtonInvite = guiCreateButton(0.825, 0.5356, 0.16, 0.06, "Invite Player", true, gFactionWindow)
			gButtonRespawn = guiCreateButton(0.825, 0.6122, 0.16, 0.06, "Respawn Vehicles", true, gFactionWindow)
			
			local balance = exports.global:getMoney(factionTheTeam)
			local balanceLabel = guiCreateLabel(0.825, 0.7056, 0.16, 0.1, "Balance: \n" .. balance .. "$", true, gFactionWindow)
			guiLabelSetHorizontalAlign(balanceLabel, "center")
			guiSetFont(balanceLabel, "default-bold-small")
			
			addEventHandler("onClientGUIClick", gButtonKick, btKickPlayer, false)
			addEventHandler("onClientGUIClick", gButtonLeader, btToggleLeader, false)
			addEventHandler("onClientGUIClick", gButtonPromote, btPromotePlayer, false)
			addEventHandler("onClientGUIClick", gButtonDemote, btDemotePlayer, false)
			
			addEventHandler("onClientGUIClick", gButtonEditRanks, btEditRanks, false)
			addEventHandler("onClientGUIClick", gButtonEditMOTD, btEditMOTD, false)
			addEventHandler("onClientGUIClick", gButtonInvite, btInvitePlayer, false)
			addEventHandler("onClientGUIClick", gButtonRespawn, btRespawnVehicles, false)
		end
			gButtonQuit = guiCreateButton(0.825, 0.7834, 0.16, 0.06, "Leave Faction", true, gFactionWindow)
			gButtonExit = guiCreateButton(0.825, 0.86, 0.16, 0.06, "Exit Menu", true, gFactionWindow)
			gMOTDLabel = guiCreateLabel(0.015, 0.935, 0.95, 0.15, "MOTD: " .. motd, true, gFactionWindow)
			guiSetFont(gMOTDLabel, "default-bold-small")
			
			addEventHandler("onClientGUIClick", gButtonQuit, btQuitFaction, false)
			addEventHandler("onClientGUIClick", gButtonExit, hideFactionMenu, false)
			
			addEventHandler("onClientRender", getRootElement(), checkF3)
			f3state = getKeyState( "f3" )
	else
		hideFactionMenu()
	end
	showCursor(true)
end
addEvent("showFactionMenu", true)
addEventHandler("showFactionMenu", getRootElement(), showFactionMenu)

-- BUTTON EVENTS

-- RANKS/WAGES

lRanks = { }
tRanks = { }
tRankWages = { }
wRanks = nil
bRanksSave, bRanksClose = nil

function btEditRanks(button, state)
	if (source==gButtonEditRanks) and (button=="left") and (state=="up") then
		local factionType = tonumber(getElementData(theTeam, "type"))
		lRanks = { }
		tRanks = { }
		tRankWages = { }
		
		guiSetInputEnabled(true)
		
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then -- factions w/ wages
			local width, height = 400, 500
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)
			
			wRanks = guiCreateWindow(x, y, width, height, "Ranks & Wages", false)
			
			local y = 0.0525
			for i=1, 15 do
				lRanks[i] = guiCreateLabel(0.05, y+0.0025, 0.4, 0.1, "Rank #" .. i .. " Title & Wage: ", true, wRanks)
				guiSetFont(lRanks[i], "default-bold-small")
				tRanks[i] = guiCreateEdit(0.4, y, 0.3, 0.04, arrFactionRanks[i], true, wRanks)
				tRankWages[i] = guiCreateEdit(0.775, y, 0.2, 0.04, tostring(arrFactionWages[i]), true, wRanks)
				y = y + 0.05
			end
		else
			local width, height = 400, 500
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)
			
			wRanks = guiCreateWindow(x, y, width, height, "Ranks", false)
			
			local y = 0.0525
			for i=1, 15 do
				lRanks[i] = guiCreateLabel(0.05, y+0.0025, 0.4, 0.1, "Rank #" .. i .. " Title: ", true, wRanks)
				guiSetFont(lRanks[i], "default-bold-small")
				tRanks[i] = guiCreateEdit(0.3, y, 0.6, 0.04, arrFactionRanks[i], true, wRanks)
				y = y + 0.05
			end
		end
		
		bRanksSave = guiCreateButton(0.05, 0.825, 0.9, 0.075, "Save!", true, wRanks)
		bRanksClose = guiCreateButton(0.05, 0.925, 0.9, 0.075, "Close", true, wRanks)
		
		addEventHandler("onClientGUIClick", bRanksSave, saveRanks, false)
		addEventHandler("onClientGUIClick", bRanksClose, closeRanks, false)
	end
end

function saveRanks(button, state)
	if (source==bRanksSave) and (button=="left") and (state=="up") then
		local found = false
		local isNumber = true
		for key, value in ipairs(tRanks) do
			if (string.find(guiGetText(tRanks[key]), ";")) or (string.find(guiGetText(tRanks[key]), "'")) then
				found = true
			end
		end
		
		local factionType = tonumber(getElementData(theTeam, "type"))
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then
			for key, value in ipairs(tRankWages) do
				if not (tostring(type(tonumber(guiGetText(tRankWages[key])))) == "number") then
					isNumber = false
				end
			end
		end
		
		if (found) then
			outputChatBox("Your ranks contain invalid characters, please ensure it does not contain characters such as '@.;", 255, 0, 0)
		elseif not (isNumber) then
			outputChatBox("Your wages are not numbers, please ensure you entered a number and no currency symbol.", 255, 0, 0)
		else
			local sendRanks = { }
			local sendWages = { }
			
			for key, value in ipairs(tRanks) do
				sendRanks[key] = guiGetText(tRanks[key])
			end
			
			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then
				for key, value in ipairs(tRankWages) do
					sendWages[key] = guiGetText(tRankWages[key])
				end
			end
			
			hideFactionMenu()
			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) then
				triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), sendRanks, sendWages)
			else
				triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), sendRanks)
			end
		end
	end
end

function closeRanks(button, state)
	if (source==bRanksClose) and (button=="left") and (state=="up") then
		if (wRanks) then
			destroyElement(wRanks)
			lRanks, tRanks, tRankWages, wRanks, bRanksSave, bRanksClose = nil, nil, nil, nil, nil, nil
			guiSetInputEnabled(false)
		end
	end
end

-- MOTD
wMOTD, tMOTD, bUpdate, bMOTDClose = nil
function btEditMOTD(button, state)
	if (source==gButtonEditMOTD) and (button=="left") and (state=="up") then
		if not (wMOTD) then
			local width, height = 300, 200
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)
			
			wMOTD = guiCreateWindow(x, y, width, height, "Message of the Day", false)
			tMOTD = guiCreateEdit(0.1, 0.2, 0.85, 0.1, tostring(theMotd), true, wMOTD)
			
			guiSetInputEnabled(true)
			
			bUpdate = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Update!", true, wMOTD)
			addEventHandler("onClientGUIClick", bUpdate, sendMOTD, false)
			
			bMOTDClose= guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close Window", true, wMOTD)
			addEventHandler("onClientGUIClick", bMOTDClose, closeMOTD, false)
		else
			guiBringToFront(wInvite)
		end
	end
end

function closeMOTD(button, state)
	if (source==bMOTDClose) and (button=="left") and (state=="up") then
		if (wMOTD) then
			destroyElement(wMOTD)
			wMOTD, tMOTD, bUpdate, bMOTDClose = nil, nil, nil, nil
		end
	end
end

function sendMOTD(button, state)
	if (source==bUpdate) and (button=="left") and (state=="up") then
		local motd = guiGetText(tMOTD)
		
		local found1 = string.find(motd, ";")
		local found2 = string.find(motd, "'")
		
		if (found1) or (found2) then
			outputChatBox("Your message contains invalid characters.", 255, 0, 0)
		else
			guiSetText(gMOTDLabel, "MOTD: " .. motd)
			theMOTD = motd -- Store it clientside
			triggerServerEvent("cguiUpdateMOTD", getLocalPlayer(), motd)
		end
	end
end

-- INVITE
wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil
function btInvitePlayer(button, state)
	if (source==gButtonInvite) and (button=="left") and (state=="up") then
		if not (wInvite) then
			local width, height = 300, 200
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)
			
			wInvite = guiCreateWindow(x, y, width, height, "Invite a Player", false)
			tInvite = guiCreateEdit(0.1, 0.2, 0.85, 0.1, "Partial Player Name", true, wInvite)
			addEventHandler("onClientGUIChanged", tInvite, checkNameExists)
					
			lNameCheck = guiCreateLabel(0.1, 0.325, 0.8, 0.3, "Player not found or multiple were found.", true, wInvite)
			guiSetFont(lNameCheck, "default-bold-small")
			guiLabelSetColor(lNameCheck, 255, 0, 0)
			guiLabelSetHorizontalAlign(lNameCheck, "center")
			
			guiSetInputEnabled(true)
			
			bInvite = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Invite!", true, wInvite)
			guiSetEnabled(bInvite, false)
			addEventHandler("onClientGUIClick", bInvite, sendInvite, false)
			
			bCloseInvite = guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close Window", true, wInvite)
			addEventHandler("onClientGUIClick", bCloseInvite, closeInvite, false)
		else
			guiBringToFront(wInvite)
		end
	end
end

function closeInvite(button, state)
	if (source==bCloseInvite) and (button=="left") and (state=="up") then
		if (wInvite) then
			destroyElement(wInvite)
			wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil, nil, nil, nil, nil, nil
		end
	end
end

function sendInvite(button, state)
	if (source==bInvite) and (button=="left") and (state=="up") then
		local faction = tonumber(getElementData(invitedPlayer, "faction"))
		
		if (faction==-1) or not (faction) then
			triggerServerEvent("cguiInvitePlayer", getLocalPlayer(), invitedPlayer)
		else
			outputChatBox("This person is already a member of another faction. Ask them to leave first.", 255, 0, 0)
		end
	end
end

function checkNameExists(theEditBox)
	local found = nil
	local count = 0
	
	local players = getElementsByType("player")
	for key, value in ipairs(players) do
		local username = string.lower(tostring(getPlayerName(value)))
		if (string.find(username, string.lower(tostring(guiGetText(theEditBox))))) and (guiGetText(theEditBox)~="") then
			count = count + 1
			found = value
			break
		end
	end
	
	if (count>1) then
		guiSetText(lNameCheck, "Multiple Found.")
		guiLabelSetColor(lNameCheck, 255, 255, 0)
		guiMemoSetReadOnly(tInvite, true)
		guiSetEnabled(bInvite, false)
	elseif (count==1) then
		guiSetText(lNameCheck, "Player Found.")
		guiLabelSetColor(lNameCheck, 0, 255, 0)
		invitedPlayer = found
		guiMemoSetReadOnly(tInvite, false)
		guiSetEnabled(bInvite, true)
	elseif (count==0) then
		guiSetText(lNameCheck, "Player not found or multiple were found.")
		guiLabelSetColor(lNameCheck, 255, 0, 0)
		guiMemoSetReadOnly(tInvite, true)
		guiSetEnabled(bInvite, false)
	end
	guiLabelSetHorizontalAlign(lNameCheck, "center")
end

function btQuitFaction(button, state)
	if (button=="left") and (state=="up") and (source==gButtonQuit) then
		local numLeaders = 0
		local isLeader = false
		local localUsername = getPlayerName(getLocalPlayer())
		
		for k, v in ipairs(arrUsernames) do -- Find the player
			if (v==localUsername) then -- Found
				isLeader = arrLeaders[k]
			end
		end
		
		for k, v in ipairs(arrLeaders) do
			numLeaders = numLeaders + 1
		end
		
		if (numLeaders==1) and (isLeader) then
			outputChatBox("You must promote someone to lead this faction before quitting. You are the only leader.", 255, 0, 0)
		else
			local sx, sy = guiGetScreenSize() 
			wConfirmQuit = guiCreateWindow(sx/2 - 125,sy/2 - 50,250,100,"Leaving Confirmation", false)
			local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Do you really want to leave " .. getTeamName(theTeam) .. "?",true,wConfirmQuit)
			guiLabelSetHorizontalAlign (lQuestion,"center",true)
			local bYes = guiCreateButton(0.1,0.65,0.37,0.23,"Yes",true,wConfirmQuit)
			local bNo = guiCreateButton(0.53,0.65,0.37,0.23,"No",true,wConfirmQuit)
			addEventHandler("onClientGUIClick", getRootElement(), 
				function(button)
					if button=="left" and ( source == bYes or source == bNo ) then
						if source == bYes then
							hideFactionMenu()
							triggerServerEvent("cguiQuitFaction", getLocalPlayer())
						end
						if wConfirmQuit then
							destroyElement(wConfirmQuit)
							wConfirmQuit = nil
						end
					end
				end
			)
		end
	end
end

function btKickPlayer(button, state)
	if (button=="left") and (state=="up") and (source==gButtonKick) then
		local playerName = string.gsub(guiGridListGetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), 1), " ", "_")
			
		if (playerName==getPlayerName(getLocalPlayer())) then
			outputChatBox("You cannot kick yourself, quit instead.", thePlayer)
		elseif (playerName~="") then
			local row = guiGridListGetSelectedItem(gMemberGrid)
			guiGridListRemoveRow(gMemberGrid, row)
			
			local theTeamName = getTeamName(theTeam)
			
			outputChatBox("You removed " .. playerName .. " from the faction '" .. tostring(theTeamName) .. "'.", 0, 255, 0)
			triggerServerEvent("cguiKickPlayer", getLocalPlayer(), playerName)
		else
			outputChatBox("Please select a member to kick.")
		end
	end
end

function btToggleLeader(button, state)
	if (button=="left") and (state=="up") and (source==gButtonLeader) then
		local playerName = string.gsub(guiGridListGetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), 1), " ", "_")
		local currentLevel = guiGridListGetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), 5)

		if (playerName==getPlayerName(getLocalPlayer())) then
			outputChatBox("You cannot un-leader yourself.", thePlayer)
		elseif (playerName~="") then
			local row = guiGridListGetSelectedItem(gMemberGrid)
			
			if (currentLevel=="Leader") then
				guiGridListSetItemText(gMemberGrid, row, tonumber(colLeader), "Member", false, false)
				guiGridListSetSelectedItem(gMemberGrid, 0, 0)
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, false) -- false = not leader
			else
				guiGridListSetItemText(gMemberGrid, row, tonumber(colLeader), "Leader", false, false)
				guiGridListSetSelectedItem(gMemberGrid, 0, 0)
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, true) -- true = leader
			end
		else
			outputChatBox("Please select a member to toggle leader on.")
		end
	end
end

function btPromotePlayer(button, state)
	if (button=="left") and (state=="up") and (source==gButtonPromote) then
		local row = guiGridListGetSelectedItem(gMemberGrid)
		local playerName = string.gsub(guiGridListGetItemText(gMemberGrid, row, 1), " ", "_")
		local currentRank = guiGridListGetItemText(gMemberGrid, row, 2)
		
		if (playerName~="") then
			local currRankNumber = tonumber( guiGridListGetItemData(gMemberGrid, row, colRank) )
			if (currRankNumber==15) then
				outputChatBox(playerName .. " is already at the highest rank.", 255, 0, 0)
			else
				guiGridListSetSelectedItem(gMemberGrid, 0, 0)
				guiGridListSetItemText(gMemberGrid, row, colRank, arrFactionRanks[currRankNumber+1], false, false)
				if colWage then
					guiGridListSetItemText(gMemberGrid, row, colWage, arrFactionWages[currRankNumber+1], false, true)
				end
				guiGridListSetItemData(gMemberGrid, row, colRank, tostring(currRankNumber+1))
				triggerServerEvent("cguiPromotePlayer", getLocalPlayer(), playerName, currRankNumber+1, arrFactionRanks[currRankNumber], arrFactionRanks[currRankNumber+1])
				guiGridListSetSelectedItem(gMemberGrid, row, colRank)
			end
		else
			outputChatBox("Please select a member to promote.")
		end
	end
end

function btDemotePlayer(button, state)
	if (button=="left") and (state=="up") and (source==gButtonDemote) then
		local row = guiGridListGetSelectedItem(gMemberGrid)
		local playerName = string.gsub(guiGridListGetItemText(gMemberGrid, row, 1), " ", "_")
		local currentRank = guiGridListGetItemText(gMemberGrid, row, 2)
		
		if (playerName~="") then
			local currRankNumber = tonumber( guiGridListGetItemData(gMemberGrid, row, colRank) )
			if (currRankNumber==1) then
				outputChatBox(playerName .. " is already at the lowest rank.", 255, 0, 0)
			else
				guiGridListSetSelectedItem(gMemberGrid, 0, 0)
				guiGridListSetItemText(gMemberGrid, row, colRank, arrFactionRanks[currRankNumber-1], false, false)
				if colWage then
					guiGridListSetItemText(gMemberGrid, row, colWage, arrFactionWages[currRankNumber-1], false, true)
				end
				guiGridListSetItemData(gMemberGrid, row, colRank, tostring(currRankNumber-1))
				triggerServerEvent("cguiDemotePlayer", getLocalPlayer(), playerName, currRankNumber-1, arrFactionRanks[currRankNumber], arrFactionRanks[currRankNumber-1])
				guiGridListSetSelectedItem(gMemberGrid, row, colRank)
			end
		else
			outputChatBox("Please select a member to demote.")
		end
	end
end

function reselectItem(grid, row, col)
	guiGridListSetSelectedItem(grid, row, col)
end

function hideFactionMenu()
	showCursor(false)
	guiSetInputEnabled(false)
	
	if (gFactionWindow) then
		destroyElement(gFactionWindow)
	end
	
	gFactionWindow, gMemberGrid = nil
	triggerServerEvent("factionmenu:hide", getLocalPlayer())
	
	if (wInvite) then
		destroyElement(wInvite)
		wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil, nil, nil, nil, nil, nil
	end
	
	if (wMOTD) then
		destroyElement(wMOTD)
		wMOTD, tMOTD, bUpdate, bMOTDClose = nil, nil, nil, nil
	end
	
	if (wRanks) then
		destroyElement(wRanks)
		lRanks, tRanks, tRankWages, wRanks, bRanksSave, bRanksClose = nil, nil, nil, nil, nil, nil
	end
	
	-- Clear variables (should reduce lag a tiny bit clientside)
	gFactionWindow, gMemberGrid, gMOTDLabel, colName, colRank, colWage, colLastLogin, colLocation, colLeader, colOnline, gButtonKick, gButtonPromote, gButtonDemote, gButtonEditRanks, gButtonEditMOTD, gButtonInvite, gButtonLeader, gButtonQuit, gButtonExit = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	theMotd, theTeam, arrUsernames, arrRanks, arrLeaders, arrOnline, arrFactionRanks, arrLocations, arrFactionWages, arrLastLogin, membersOnline, membersOffline = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	removeEventHandler("onClientRender", getRootElement(), checkF3)
end
addEvent("hideFactionMenu", true)
addEventHandler("hideFactionMenu", getRootElement(), hideFactionMenu)

-- ADMIN GUI's
wFactionList, bFactionListClose = nil
function showFactionList(factions)
	if not (wFactionList) then
		wFactionList = guiCreateWindow(0.15, 0.15, 0.7, 0.7, "Faction List", true)
		local gridFactions = guiCreateGridList(0.025, 0.1, 0.95, 0.775, true, wFactionList)
		
		local colID = guiGridListAddColumn(gridFactions, "ID", 0.1)
		local colName = guiGridListAddColumn(gridFactions, "Faction Name", 0.6)
		local colPlayers = guiGridListAddColumn(gridFactions, "Players", 0.14)
		local colType = guiGridListAddColumn(gridFactions, "Type", 0.14)
		
		for key, value in pairs(factions) do
			local factionID = factions[key][1]
			local factionName = tostring(factions[key][2])
			local factionType = tonumber(factions[key][3])
			local factionPlayers = factions[key][4]
			
			-- Parse the type
			if (factionType==0) then
				factionType = "Gang"
			elseif (factionType==1) then
				factionType = "Mafia"
			elseif (factionType==2) then
				factionType = "Law"
			elseif (factionType==3) then
				factionType = "Government"
			elseif (factionType==4) then
				factionType = "Medical"
			elseif (factionType==5) then
				factionType = "Other"
			elseif (factionType==6) then
				factionType = "News"
			end
			
			local row = guiGridListAddRow(gridFactions)
			guiGridListSetItemText(gridFactions, row, colID, factionID, false, true)
			guiGridListSetItemText(gridFactions, row, colName, factionName, false, false)
			guiGridListSetItemText(gridFactions, row, colPlayers, factionPlayers, false, false)
			guiGridListSetItemText(gridFactions, row, colType, factionType, false, false)
		end

		bFactionListClose = guiCreateButton(0.025, 0.9, 0.95, 0.1, "Close", true, wFactionList)
		addEventHandler("onClientGUIClick", bFactionListClose, closeFactionList, false)
	else
		guiSetInputEnabled(false)
		destroyElement(wFactionList)
		wFactionList = nil
	end
end
addEvent("showFactionList", true)
addEventHandler("showFactionList", getRootElement(), showFactionList)

function closeFactionList(button, state)
	if (source==bFactionListClose) and (button=="left") and (state=="up") then
		guiSetInputEnabled(false)
		destroyElement(wFactionList)
		wFactionList, bFactionListClose = nil, nil
	end
end

function resourceStopped()
	showCursor(false)
	guiSetInputEnabled(false)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), resourceStopped)

function btRespawnVehicles(button, state)
	if (button=="left") then
		hideFactionMenu()
		triggerServerEvent("cguiRespawnVehicles", getLocalPlayer())
	end
end

function cPayDay(faction, pay, profit, interest, donatormoney, tax, incomeTax, vtax, ptax, rent, grossincome,renttax)
	local sound = playSound("mission_accomplished.mp3")
	setSoundVolume(sound, 0.5)
	
	-- output payslip
	outputChatBox("-------------------------- PAY SLIP --------------------------", 255, 194, 14)
		
	-- state earnings/money from faction
	if not (faction) then
		if (pay + tax > 0) then
			outputChatBox("    State Benefits: #00FF00" .. pay+tax .. "$", 255, 194, 14, true)
		end
	else
		if (pay + tax > 0) then
			outputChatBox("    Wage Paid: #00FF00" .. pay+tax .. "$", 255, 194, 14, true)
		end
	end
	
	-- business profit
	if (profit > 0) then
		outputChatBox("    Business Profit: #00FF00" .. profit .. "$", 255, 194, 14, true)
	end
	
	-- bank interest
	if (interest > 0) then
		outputChatBox("    Bank Interest: #00FF00" .. interest .. "$ (" .. ("%.1f"):format(math.min( 1, .4 + getElementData( getLocalPlayer(),"donatorlevel" ) * 0.1 )) .. "%)",255, 194, 14, true)
	end
	
	-- donator money (nonRP)
	if (donatormoney > 0) then
		outputChatBox("    Donator Money: #00FF00" .. donatormoney .. "$", 255, 194, 14, true)
	end
	
	-- Above all the + stuff
	-- Now the - stuff below
	
	-- income tax
	if (tax > 0) then
		outputChatBox("    Income Tax of " .. (incomeTax*100) .. "%: #FF0000" .. tax .. "$", 255, 194, 14, true)
	end
	
	if (vtax > 0) then
		outputChatBox("    Vehicle Tax: #FF0000" .. vtax .. "$", 255, 194, 14, true)
	end
	
	if (ptax > 0) then
		outputChatBox("    Property Expenses: #FF0000" .. ptax .. "$", 255, 194, 14, true )
	end
	
	if (rent > 0) then
		outputChatBox("    Appartment Rent: #FF0000" .. rent .. "$", 255, 194, 14, true)
	end
	if (renttax > 0) then
		outputChatBox("    Vehicle Rent: #FF0000" .. renttax .. "$", 255, 194, 14, true)
	end
	outputChatBox("------------------------------------------------------------------", 255, 194, 14)
	
	if (grossincome > 0) then
		outputChatBox("  Gross Income: #00FF00" .. grossincome .. "$",255, 194, 14, true)
		outputChatBox("  Remark(s): Transfered to your bank account.", 255, 194, 14)
	else
		outputChatBox("  Gross Income: #FF0000" .. grossincome .. "$", 255, 194, 14, true)
		outputChatBox("  Remark(s): Taking from your bank account.", 255, 194, 14)
	end
	
	
	if (pay + tax == 0) then
		if not (faction) then
			outputChatBox("    The government could not afford to pay you your state benefits.", 255, 0, 0)
		else
			outputChatBox("    Your employer could not afford to pay your wages.", 255, 0, 0)
		end
	end
	
	if (rent == -1) then
		outputChatBox("    You were evicted from your appartment, as you can't pay the rent any longer.", 255, 0, 0)
	end
	
	outputChatBox("------------------------------------------------------------------", 255, 194, 14)
	-- end of output payslip
	
	triggerEvent("updateWaves", getLocalPlayer())
end
addEvent("cPayDay", true)
addEventHandler("cPayDay", getRootElement(), cPayDay)