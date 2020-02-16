mysql = exports.mysql
function namec( thePlayer, commandName, r, g, b )
   	if exports.global:isPlayerAdmin(thePlayer) then
    setPlayerNametagColor ( thePlayer, r, g, b )
	end
end
addCommandHandler ( "tagcolor",namec)

smallweapon = {[22] = true,[23] = true,[24]=true,[0]=true,[22] = true,[28] = true,[29]=true,[32]=true}
largeweapon = {[25] = true ,[26] =true,[27] =true,[30]=true,[31]=true,[33]=true,[34]=true,[35]=true,[36]=true,[37]=true,[8]=true}
pocketweapon = {[43] = true,[41] = true,[17]=true,[18]=true,[4] = true,[44] = true,[16]=true}

function meweapon(player,curweapon)
	if not  getPedOccupiedVehicle (player) then
    
    weapon = getWeaponNameFromID ( curweapon )
		if curweapon == 0 or curweapon == 1  then
			return
		end
	 if (smallweapon[curweapon]) then 
		exports.global:sendLocalMeAction(player,"lifts up his shirt and grabs a "..weapon.." from the belt.")
	
	elseif (largeweapon[curweapon]) then
		exports.global:sendLocalMeAction(player,"takes a "..weapon.." from his back.")
	elseif (pocketweapon[curweapon]) then
		exports.global:sendLocalMeAction(player,"takes out a "..weapon.." from his pocket.")
	else
		
		exports.global:sendLocalMeAction(player,"takes out a "..weapon.." from his backpack.")
	end
	end
end

addEvent("meweapon",true)
addEventHandler("meweapon",getRootElement(),meweapon)

function hotwire(thePlayer)
		vehicle = getPedOccupiedVehicle(thePlayer)
	local fuel = getElementData(vehicle, "fuel")
	local broke = getElementData(vehicle, "enginebroke")
	if broke == 1 or fuel < 1  then
		outputChatBox("Engine is broken or out of fuel.",thePlayer,255,0,0)
		return
	end
	if vehicle and  getVehicleEngineState (vehicle) == false then
		question1(thePlayer)
		x,y,z = getElementPosition(thePlayer)
		setCameraMatrix(thePlayer,x,y,z+15,x,y,z)
	end
end
addCommandHandler ( "hotwire", hotwire )
function question1(thePlayer)
	vehicle = getPedOccupiedVehicle(thePlayer)
	outputChatBox("------------ 	QUESTION 1 	----------------",thePlayer,255,204,0)
	outputChatBox("What will be your next step? (/ans 1,2 or 3)",thePlayer,255,153,153)
	outputChatBox("1.Look under driver seat.",thePlayer,255,153,153)
	outputChatBox("2.Look under steering wheel.",thePlayer,255,153,153)
	outputChatBox("3.Look under dashboard.",thePlayer,255,153,153)
	setElementData(vehicle,"hotquestion",1)
end
function question2(thePlayer)
	vehicle = getPedOccupiedVehicle(thePlayer)
	outputChatBox("------------ 	QUESTION 2 	----------------",thePlayer,255,204,0)
	outputChatBox("What will be your next step? (/ans 1,2 or 3)",thePlayer,255,153,153)
	outputChatBox("1.Look for the two wires that are the same.Red colour.",thePlayer,255,153,153)
	outputChatBox("2.Look for the two wires that are the same.Yellow colour.",thePlayer,255,153,153)
	outputChatBox("3.Look for the two wires that are the same.Green colour.",thePlayer,255,153,153)
	setElementData(vehicle,"hotquestion",2)
	exports.global:sendLocalMeAction(thePlayer,"looks under steering wheel.")
end
function question3(thePlayer)
	vehicle = getPedOccupiedVehicle(thePlayer)
	outputChatBox("------------ 	QUESTION 3 	----------------",thePlayer,255,204,0)
	outputChatBox("What will be your next step? (/ans 1,2 or 3)",thePlayer,255,153,153)
	outputChatBox("1.Pull the red wire with full force.",thePlayer,255,153,153)
	outputChatBox("2.Twist them without stripping.",thePlayer,255,153,153)
	outputChatBox("3.Strip them and twist them 	 together.",thePlayer,255,153,153)
	setElementData(vehicle,"hotquestion",3)
	exports.global:sendLocalMeAction(thePlayer,"looks under steering wheel for red wire")
	
end
function question4(thePlayer)
	vehicle = getPedOccupiedVehicle(thePlayer)
	outputChatBox("------------ 	QUESTION 4 	----------------",thePlayer,255,204,0)
	outputChatBox("What will be your next step? (/ans 1,2 or 3)",thePlayer,255,153,153)
	outputChatBox("1.Touch the ignition and red wire until ignition has been achieved.",thePlayer,255,153,153)
	outputChatBox("2.Twist the ignition and red wire until ignition has been achieved.",thePlayer,255,153,153)
	outputChatBox("3.Pull the ignition and red wire until ignition has been achieved.",thePlayer,255,153,153)
	exports.global:sendLocalMeAction(thePlayer,"strips the red wire and twists them together.")
	setElementData(vehicle,"hotquestion",4)
end
	
function ans1(thePlayer,ops,op)
	vehicle = getPedOccupiedVehicle(thePlayer)
	question = 	getElementData(vehicle,"hotquestion")
	if  question ==nil then
		return
	end
	if question == 1 then
	if tonumber(op) == 1 then
		endwire(thePlayer)
	elseif tonumber(op) == 2 then
		question2(thePlayer)
	elseif  tonumber(op) == 3 then
		endwire(thePlayer)
	end
	elseif  question == 2 then
	if tonumber(op) == 1 then
		question3(thePlayer)
	elseif tonumber(op) == 2 then
		endwire(thePlayer)
	elseif  tonumber(op) == 3 then
		endwire(thePlayer)
	end
	elseif  question == 3 then
	if tonumber(op) == 1 then
		endwire(thePlayer)
	elseif tonumber(op) == 2 then
		endwire(thePlayer)
	elseif  tonumber(op) == 3 then
		question4(thePlayer)
	end
	elseif  question == 4 then
	if tonumber(op) == 1 then
		finishwire(thePlayer)
	elseif tonumber(op) == 2 then
		vehicle = getPedOccupiedVehicle(thePlayer)
		exports['anticheat-system']:changeProtectedElementDataEx(vehicle, "enginebroke", 1, false)
		outputChatBox("Engine broke down.",thePlayer,255,0,0)
	elseif  tonumber(op) == 3 then
		endwire(thePlayer)
	end
	end
end
addCommandHandler ( "ans", ans1)
function endwire(thePlayer)
			vehicle = getPedOccupiedVehicle(thePlayer)
			exports.global:sendLocalMeAction(thePlayer,"steps out of vehicle.")
			outputChatBox("You failed to hotwire this vehicle",thePlayer,255,0,0)
			removePedFromVehicle (thePlayer) 
			setElementData(vehicle,"hotquestion",0)
			setCameraTarget ( thePlayer )
end
function endwire2(thePlayer)
		if getElementData(source,"hotquestion") > 0 then
			exports.global:sendLocalMeAction(thePlayer,"steps out of vehicle.")
			outputChatBox("You failed to hotwire this vehicle",thePlayer,255,0,0) 
			setElementData(source,"hotquestion",0)
			setCameraTarget ( thePlayer )
		end
end
addEventHandler("onVehicleExit",getRootElement(),endwire2)
function finishwire(thePlayer)
	 vehicle = getPedOccupiedVehicle(thePlayer)
	setVehicleEngineState (vehicle,true)
	toggleControl(thePlayer, 'brake_reverse', true)
	outputChatBox("Engine turned on",thePlayer,0,255,0)
	 setCameraTarget (thePlayer)
end

function newbiechat(thePlayer, commandName,  ...)
		local logged = tonumber(getElementData(thePlayer, "loggedin"))
		local noobmuted = tonumber(getElementData(thePlayer,"noobmuted"))
		if getElementData(thePlayer,"noobtalked") == 1 then
				outputChatBox("You must wait 30 seconds before talking in newbie chat again",thePlayer,180,180,180)
					if noobtimer == nil then
						setElementData(thePlayer,"noobtalked",0)
					end
				return
		end
			setElementData(thePlayer,"noobtalked",1)
			noobtimer = setTimer(setElementData,30000,1,thePlayer,"noobtalked",0)

			if (logged==1) then
					if not (...) then
						outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 255, 255)
					elseif noobmuted == 1 then
						outputChatBox("You are banned from newbie this chat!", thePlayer, 255, 0, 0)
					else
						message = table.concat({...}, " ")
						local name = getPlayerName(thePlayer)
						local hours = getElementData(thePlayer,"hoursplayed")
					if tonumber(hours) < 10 then
						title = "Newbie"
					else
						title = "Player"
					end
					local hidden = getElementData(thePlayer, "hiddenadmin") or 0
					local helper = getElementData(thePlayer, "helper")
				
					
			if ( exports.global:isPlayerAdmin(thePlayer) ) then
				if (hidden == 1) or (exports.global:getPlayerAdminTitle(thePlayer) == "Player") then
					if not (exports.global:isPlayerBronzeDonator(thePlayer)) then
						title = "Bronze Donator"
					else
						title = exports.global:getPlayerDonatorTitle(thePlayer)
					end
				else
					title = exports.global:getPlayerAdminTitle(thePlayer)
				end
			elseif tonumber(helper) > 0 then
				title = "Helper"
			elseif ( exports.global:isPlayerBronzeDonator(thePlayer) ) then
				title = exports.global:getPlayerDonatorTitle(thePlayer)
			end
						exports.logs:logMessage("NewBieChat: " .. message .. ". ((" .. name .. "))", 2)
						for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
							if (getElementData(value, "loggedin")) == 1  then
								outputChatBox("** "..title.." " ..name..": " ..message ,value, 0, 204,255)
								
							end
						end	
				
			end
		
	end
end
addCommandHandler("n", newbiechat)

						
function makePlayerHelper(thePlayer, commandName, who, rank)
	if ( exports.global:isPlayerLeadAdmin(thePlayer) ) then
		if not (who) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name/ID] [Rank]", thePlayer, 255, 255, 255)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			
			if (targetPlayer) then
				local username = getPlayerName(thePlayer)
				local accountID = getElementData(targetPlayer, "gameaccountid")
				
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "helper", tonumber(rank))
				
				rank = tonumber(rank)
				

				
				local query = mysql:query_free("UPDATE accounts SET helper='" .. mysql:escape_string(tonumber(rank)) .. "' WHERE id = " ..accountID )
				outputChatBox("You set " .. targetPlayerName .. " has helper at " .. rank .. ".", thePlayer, 255, 255, 0)
		
				
				-- Fix for scoreboard & nametags
				local targetAdminTitle = exports.global:getPlayerAdminTitle(targetPlayer)

					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					outputChatBox(adminTitle .. " " .. username .. " set your gamemaster rank to " .. rank .. ".", targetPlayer, 255, 194, 14)
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. username .. " set " .. targetPlayerName .. " as helper.Level " ..rank)
				
			end
		end
	end
end
addCommandHandler("makehelper", makePlayerHelper, false, false)

function makePlayerHelper(thePlayer, commandName, who)
	if ( exports.global:isPlayerAdmin(thePlayer) ) or tonumber(getElementData(thePlayer,"helper")) > 0 then
		if not (who) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Playername]", thePlayer, 255, 255, 255)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			
			if (targetPlayer) then
				local username = getPlayerName(thePlayer)
				local accountID = getElementData(targetPlayer, "gameaccountid")
				local noobmuted = getElementData(targetPlayer,"noobmuted")
				if getElementData(targetPlayer,"noobmuted") == 1 then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "noobmuted", 0)
					mysql:query_free("UPDATE accounts SET noobmuted='0' WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "gameaccountid")) )
				
					outputChatBox(getPlayerName(thePlayer).." unbanned " .. targetPlayerName .. " from newbie chat.",getRootElement(), 255, 255, 255)
				else
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "noobmuted", 1)
				
				outputChatBox(getPlayerName(thePlayer).." banned " .. targetPlayerName .. " from newbie chat.",getRootElement(), 255, 255, 255)
				mysql:query_free("UPDATE accounts SET noobmuted='1' WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "gameaccountid")) )
				end
				
			end
		end
	end
end
addCommandHandler("muten", makePlayerHelper)


function adminDuty(thePlayer, commandName)

	if getElementData(thePlayer,"helper") > 0 then
		local helperduty = getElementData(thePlayer, "helperduty")
		local username = getPlayerName(thePlayer)
		
		
		if helperduty then	
			
			setElementData(thePlayer, "helperduty", false)
			outputChatBox("You went off gamemaster duty.", thePlayer, 255, 0, 0)
			exports.global:sendMessageToAdmins("HelperDuty: " .. username .. " went off duty.")
		else
			setElementData(thePlayer, "helperduty", true)
			outputChatBox("You went on gamemaster duty.", thePlayer, 0, 255, 0)
			exports.global:sendMessageToAdmins("HelperDuty: " .. username .. " came on duty.")
		end
		--mysql:query_free("UPDATE accounts SET adminduty=" .. mysql:escape_string(getElementData(thePlayer, "adminduty")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")) )
		exports.global:updateNametagColor(thePlayer)
	else
		outputChatBox("you are not helper",thePlayer,255,255,255)
	end
end
addCommandHandler("helperduty", adminDuty)
addCommandHandler("gmduty", adminDuty)

function gmchat(thePlayer, commandName, ...)
		if getElementData(thePlayer,"gmdisabled") == 1 and not exports.global:isPlayerAdmin(thePlayer) then
				triggerClientEvent(thePlayer,"doOutput",thePlayer,255,255,255,"Gamemaster chat is currently disabled")
				return
		end
	if getElementData(thePlayer,"helper")  > 0 or exports.global:isPlayerAdmin(thePlayer)  then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local title = "Lvl "..getElementData(thePlayer,"helper").." GM"
			local hidden = getElementData(thePlayer, "hiddenadmin") or 0

			if ( exports.global:isPlayerAdmin(thePlayer) ) then
				if (hidden == 1) or (exports.global:getPlayerAdminTitle(thePlayer) == "Player") then
						title = "Lvl "..getElementData(thePlayer,"helper").." GM"
				else
					title = exports.global:getPlayerAdminTitle(thePlayer)
				end
			end
			for key, value in ipairs(getElementsByType("player")) do
				if getElementData(value,"helper") > 0  or exports.global:isPlayerAdmin(value)  then
						outputChatBox("[GM] " .. title .. " " .. getPlayerName(thePlayer) .. ": " .. message, value, 255, 204, 255)	
				end
			end
		end
	else 
			outputChatBox("you are not helper",thePlayer,255,255,255)
	end
end
addCommandHandler("gm", gmchat)

function toggm(thePlayer)
		if exports.global:isPlayerAdmin(thePlayer) then
			if not getElementData(thePlayer,"gmdisabled") then
				setElementData(getRootElement(),"gmdisabled",0)
			
			end
			if  getElementData(thePlayer,"gmdisabled") == 0 then
				setElementData(getRootElement(),"gmdisabled",1)
				outputChatBox("GM chat disabled",thePlayer,255,0,0)
			elseif  getElementData(thePlayer,"gmdisabled") == 1 then
				setElementData(getRootElement(),"gmdisabled",0)
				outputChatBox("GM chat enabed",thePlayer,255,255,0)
			end
		end
end
addCommandHandler("toggm",toggm)
		
function gmann(thePlayer)
	if exports.global:isPlayerLeadAdmin(thePlayer) then
	id = 1

		if mysql:query_free("DELETE FROM vehicles WHERE rent = " .. mysql:escape_string(id) .. "") then

		outputChatBox("Deleted",thePlayer,0,204,255)
		end
	end

end
addCommandHandler("delrented", gmann)
