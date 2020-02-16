mysql = exports.mysql
infom = createMarker( 298.705078125, 85.462890625, 1029.3762207031,"cylinder",5,255,255,0,0)
setElementInterior(infom,3)
setElementDimension(infom,2)
 
 
function fineMoney(thePlayer, commandName, target, money,...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (target) or not (money)  then
			outputChatBox("SYNTAX: /" .. commandName .. " [PPlayer Nick/Id] [Money] [reason]", thePlayer, 255, 255, 2555)
		else
			local reason = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			
			if targetPlayer then
				bankban = getElementData(targetPlayer,"bankmoney")
				if exports.global:hasMoney(targetPlayer,money) then
					exports.logs:logMessage("[FINE] " .. getPlayerName(thePlayer):gsub("_", " ") .. " fined " .. targetPlayerName .. " to $" .. money, 23)
					exports.global:takeMoney(targetPlayer, money)
				else
					mysql:query_free("UPDATE characters SET bankmoney = bankmoney- " .. money .. " WHERE id = " .. getElementData(targetPlayer, "dbid" ) )
					setElementData(targetPlayer,"bankmoney",bankban - money)
				end
				outputChatBox("Admin "..username.." fined " .. targetPlayerName .. " $" .. money .. ".",getRootElement(),255,50,50)
				outputChatBox("Reason: " .. reason,getRootElement(),255,50,50)
			end
		end
	end
end
addCommandHandler("fine",fineMoney, false, false)

function info(markerHit,matchingDimension) 
	if matchingDimension	then
   		--outputChatBox("Press 'M' then right click to interact with peds.",markerHit,255,255,255)
		triggerClientEvent(markerHit,"aoutput",markerHit,"Info","Press 'M' then right click to interact with peds")
	end
	
end
addEventHandler("onMarkerHit",infom,info)

function serialcheck(source)
	if getElementData(source,"seriallock") == true then
		outputChatBox("TEST ",source,22,222,222)
	end
end
--addCommandHandler("serialcheck",serialcheck)
local mysql = exports.mysql
function topHandler ( type )
	local text = " "
	local accounts = { }
	local x
	if type == 2 then
		text = " Top 13 Bank Balance \n"
		local result = mysql:query("SELECT charactername,bankmoney FROM characters WHERE charactername <> 'Mohamad_Metz' ORDER BY bankmoney DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["bankmoney"])
				accounts[i][2] = row["charactername"]
				i = i + 1
			end
		end
	elseif type == 5 then
		text = " Top 13 Hours Played \n"
		local result = mysql:query("SELECT charactername,hoursplayed FROM characters ORDER BY hoursplayed DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["hoursplayed"])
				accounts[i][2] = row["charactername"]
				i = i + 1
			end
		end
 	elseif type == 3 then
		text = " Top 13 Characters Deaths \n"
		local result = mysql:query("SELECT charactername,deaths FROM characters ORDER BY deaths DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["deaths"])
				accounts[i][2] = row["charactername"]
				i = i + 1
			end
		end
	 elseif type == 7 then
		text = " Top 13 Admin report handlers \n"
		local result = mysql:query("SELECT username,adminreports FROM accounts ORDER BY adminreports DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["adminreports"])
				accounts[i][2] = row["username"]
				i = i + 1
			end
		end
	elseif type == 9 then
		text = " Top 13 High scores in snake game\n(Admins are excluded from the top list) \n"
		local result = mysql:query("SELECT username,highsnake FROM accounts WHERE admin = 0 ORDER BY highsnake DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["highsnake"])
				accounts[i][2] = row["username"]
				i = i + 1
			end
		end
	elseif type == 13 then
		text = " Top 13 Total scores in snake game\n(Admins should not jail them to get in tops) \n"
		local result = mysql:query("SELECT username,totalsnake FROM accounts ORDER BY totalsnake DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["totalsnake"])
				accounts[i][2] = row["username"]
				i = i + 1
			end
		end
	elseif type == 12 then
		text = " Top 13 Distance travelled (in KM)\n"
		local result = mysql:query("SELECT odometer,owner,model FROM vehicles WHERE owner> 0 AND faction = -1 ORDER BY odometer DESC LIMIT 13")
		if (mysql:num_rows(result)>0) then
		
			local i = 1

			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				accounts[i] = { }
				accounts[i][1] = tonumber(row["odometer"])/1000 
				charid = tonumber(row["owner"])
				modelid = tonumber(row["model"])
				local resul = mysql:query("SELECT charactername FROM characters WHERE id = '"..mysql:escape_string(charid).."'")
				if (mysql:num_rows(resul)>0) then
					local row2 = mysql:fetch_assoc(resul)
					accounts[i][2] = row2["charactername"].."( "..getVehicleNameFromModel(modelid)..")"
				end
				i = i + 1
			end
		end
	elseif type==8 then
		triggerClientEvent(source,"helpcmds",source)
		x=2
	end
	for key, value in pairs(accounts) do
		local charname = string.gsub(tostring(accounts[key][2]), "_", " ")
		local bank = accounts[key][1]
		if type ==2 then
			text = text.." \n "..key.. ". "..charname.."      $"..bank.. ""
		else
			text = text.." \n "..key.. ". "..charname.."      "..bank.. ""
		end
	end
	triggerClientEvent(source,"topsclient",source,text,x)
	
end
addEvent( "tops", true )
addEventHandler( "tops", getRootElement(), topHandler )
function seriallock(lock)
	if lock == true then
		if mysql:query_free("UPDATE accounts SET `seriallock` = 1 WHERE id = '" .. mysql:escape_string(getElementData(source,"gameaccountid")) .. "'") then
			outputChatBox("Serial lock enabled",source,22,222,222)
			setElementData(source,"seriallock",true)
		end
	else
		if mysql:query_free("UPDATE accounts SET `seriallock` = 0 WHERE id = '" .. mysql:escape_string(getElementData(source,"gameaccountid")) .. "'") then
			setElementData(source,"seriallock",false)
			outputChatBox("Serial lock disabled",source,22,222,222)
		end
	end
end
addEvent( "seriallock", true )
addEventHandler( "seriallock", getRootElement(), seriallock )
function stats()
	local charname = getPlayerName(source)
	local ip = getPlayerIP(source)
	local serial = getPlayerSerial(source)

	local text = " Name "..charname.." \n IP :"..ip.." \n Serial: "..serial 
	local noofjails = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 0")
	local noofkicks = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 1")
	local noofbans = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 2")
	local noofwarns = mysql:query_fetch_assoc("SELECT COUNT(*) as numbr  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 4")
	local noofjails = tonumber(noofjails["numbr"]) or 0
	local noofkicks = tonumber(noofkicks["numbr"]) or 0
	local noofbans = tonumber(noofbans["numbr"]) or 0
	local noofwarns = tonumber(noofwarns["numbr"]) or 0
	local text = text .."\n ~~~ Admin stats ~~~\nJails: "..noofjails.."\nKicks: "..noofkicks.."\nBans: "..noofbans.."\nWarns: "..noofwarns.."\nReports: "..tonumber(getElementData(source, "adminreports"))
	triggerClientEvent(source,"topsclient",source,text)
	
end
addEvent( "stats", true )
addEventHandler( "stats", getRootElement(), stats )
function showstats(source,command)
	if (exports.global:isPlayerAdmin(source)) then 
		local noofjails = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 0")
		local noofkicks = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 1")
		local noofbans = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 2")
		local noofwarns = mysql:query_fetch_assoc("SELECT COUNT(*) as numbr  FROM adminhistory WHERE admin = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."' AND action = 4")
		local noofjails = tonumber(noofjails["numbr"]) or 0
		local noofkicks = tonumber(noofkicks["numbr"]) or 0
		local noofbans = tonumber(noofbans["numbr"]) or 0
		local noofwarns = tonumber(noofwarns["numbr"]) or 0
		outputChatBox(getPlayerName(source).." displayed his admin stats: ",getRootElement(),255,204,0)
		outputChatBox("Jails: "..noofjails..", Kicks: "..noofkicks..", Bans: "..noofbans..", Warns: "..noofwarns..", Reports: "..tonumber(getElementData(source, "adminreports"))..".",getRootElement(),255,204,0)
	end
end
addCommandHandler("showstats",showstats)
--[[function newuser(player)
	local result = mysql:query("SELECT username FROM accounts DESC LIMIT 13")
	outputChatBox("*"..username..".",player,255,0,0)
end

addCommandHandler( "users",newuser)]]
function commit(player)
	local jailTimer = getElementData(player, "pd.jailtimer")
	if (jailTimer) or getElementData(player,"adminjailed") then
		triggetClientEvent(player,"doOutput",player,255,255,255,"You can't use this command in jail")
	else
		name = getPlayerName(player)
		setElementFrozen(player,true)
		outputChatBox("You will spawn at hospital in 10 seconds.",player,0,204,0)
		setTimer(setElementPosition,10000,1,player,1177.7822265625, -1323.583984375, 14.0877)
		setTimer(setElementFrozen,10000,1,player,false)
		setTimer(setElementInterior,10000,1,player,0)
		setTimer(setElementDimension,10000,1,player,0)
		outputChatBox(name.." used bug fix(/bugfix).",getRootElement(),255,204,0)
	end
end

--addCommandHandler("bugfix", commit)
--addEvent( "killp", true )
--addEventHandler( "killp", getRootElement(), commit )

local catext=""
function ca(admin,command,player,type)
	if not ( exports.global:isPlayerLeadAdmin ( admin ) )  then
		return
		outputChatBox("You can't use this command",admin,255,204,0)
	end
	local tplayer, targetPlayerName = exports.global:findPlayerByPartialNick(admin, player)
	if (tplayer) then
		serial = getPlayerSerial(tplayer)
		id = getElementData(tplayer,"gameaccountid")
		if serial == "283AE72B219F0C9EF43F498430274854" then
			 result = mysql:query("SELECT username,id FROM accounts WHERE id = '"..mysql:escape_string(id).."'")
		else	
			 result = mysql:query("SELECT username,id FROM accounts WHERE mtaserial = '"..mysql:escape_string(serial).."'")
		end
		
		if (mysql:num_rows(result)>0) then
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				local id = tonumber(row["id"])
				local account = row["username"]
				catext= account..": "
				local resul = mysql:query("SELECT charactername FROM characters WHERE account = "..mysql:escape_string(id))
				if (mysql:num_rows(resul)>0) then
					while true do
						local row = mysql:fetch_assoc(resul)
						if not row then break end
						local charn = tonumber(row["id"])
						local charname = row["charactername"]
						catext= catext..""..charname..", "
					end
				end
			if tonumber(type) == 1 then
				
				outputChatBox(catext,getRootElement(),255,204,0)
			else
				outputChatBox(catext,admin,255,204,0)
			end
			
				
			end
		end
	end
	if tonumber(type) == 1 then
					outputChatBox(getPlayerName(admin).." displayed "..targetPlayerName.."'s acccounts and characters.",getRootElement(),255,50,0)
			end
end
addCommandHandler("caa", ca)
function cao(thePlayer,commandname,type,...)
	if  ( exports.global:isPlayerLeadAdmin ( thePlayer ) )  then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Full Player Name]", thePlayer, 255, 194, 14)
		else
			local accountid
			local targetPlayer = table.concat({...}, "_")
			local result = mysql:query("SELECT account FROM characters WHERE charactername='" .. mysql:escape_string(tostring(targetPlayer)) .. "'")
			if (mysql:num_rows(result)>1) then
				outputChatBox("Too many results - Please enter a more exact name.", thePlayer, 255, 0, 0)
			elseif (mysql:num_rows(result)==0) then
				outputChatBox("Player does not exist.", thePlayer, 255, 0, 0)
			else
				while true do
					local row = mysql:fetch_assoc(result)
					if not row then break end
					accountid = tonumber(row["account"])
				end
			
				local serial
				local res = mysql:query("SELECT mtaserial FROM accounts WHERE id = '" .. mysql:escape_string(accountid) .. "'")
				if (mysql:num_rows(res)>0) then
					while true do
						local row = mysql:fetch_assoc(res)
						if not row then break end
						serial = row["mtaserial"]
					end
				end
				outputChatBox(serial,thePlayer,22,222,222)
			
				local re = mysql:query("SELECT username,id FROM accounts WHERE mtaserial = '"..mysql:escape_string(serial).."'")
				if (mysql:num_rows(re)>0) then
					while true do
						local row = mysql:fetch_assoc(re)
						if not row then break end
						local id = tonumber(row["id"])
						local account = row["username"]
						catext= account..": "
						local resul = mysql:query("SELECT charactername FROM characters WHERE account = "..mysql:escape_string(id))
						if (mysql:num_rows(resul)>0) then
							while true do
								local row = mysql:fetch_assoc(resul)
								if not row then break end
								local charn = tonumber(row["id"])
								local charname = row["charactername"]
								catext= catext..""..charname..", "
							end
						end
						if tonumber(type) == 1 then
					
							outputChatBox(catext,getRootElement(),255,204,0)
						else	
							outputChatBox(catext,thePlayer,22,222,222)
						end
						
					end
					
				end
				if tonumber(type) == 1 then
					outputChatBox(getPlayerName(thePlayer).." displayed "..targetPlayer.."s acccounts and characters.",getRootElement(),255,50,0)
				end
			end
		end
	end
end
addCommandHandler("caoipairs",cao)
--[[function helpann(player)
	if (exports.global:isPlayerAdmin(player)) then
	outputChatBox("Admin "..getPlayerName(player).." is available for help,/report.",getRootElement(),0,255,0)
	end
end
addCommandHandler("ha",helpann)]]--
function scriptWave ( thePlayer, command, height )
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if height then 
			local oldHeight = getWaveHeight()
			height = tonumber ( height )
			success = setWaveHeight ( height )
			if ( success ) then
				outputChatBox ( "You set wave height to "..height,thePlayer,2,255,2 )
				exports.global:sendMessageToAdmins("AdmCmd: "..getPlayerName(thePlayer).." set wave height to "..height)
				exports.logs:logMessage(getPlayerName(thePlayer):gsub("_", " ") .. " set wave height to "..height, 22)
			else
				outputChatBox ( "Invalid number.",thePlayer,255,2,2 )
			end
		else
			outputChatBox("/setwave height",thePlayer,255,2,2)
		end
	end
end
addCommandHandler ( "setwave", scriptWave )
function helpann(player)
	money = getElementData( player, "bankmoney" )  + getPlayerMoney(player)
	outputChatBox("[OOC]#FF7700"..getPlayerName(player).."#00FF00 has got #ffff00$"..money,getRootElement(),0,255,0,true)
end
--addCommandHandler("showmoney",helpann)
function maxplayers(player)
	outputChatBox("Maximum players was "..maxplayers..".",player,244,244,244)
end
addCommandHandler("maxplayers11",maxplayers)

maxplayers=getPlayerCount()
function join()
	if getPlayerCount()> maxplayers then
		maxplayers=getPlayerCount()
	end
end
addEventHandler("onPlayerJoin",getRootElement(),join)

function movingmsg(p,c,...)
	if  getElementData(p,"loggedin") then
		message = table.concat({...}, " ")
		setElementData(getRootElement(),"movingmsg",message)
		outputChatBox("Moving msg set to "..message,p,255,9,245)
		triggerClientEvent("resetxm",getRootElement(),getRootElement())
	end
end
--addCommandHandler ("movingmsg",movingmsg)

function weaponwipe(p,c,...)
	if  exports.global:isPlayerHeadAdmin(p) then
		count = -50
		while count~= 0 do
		delete = mysql:query_free("DELETE FROM worlditems WHERE itemid = " .. mysql:escape_string(count))
		delete = mysql:query_free("DELETE FROM items WHERE itemid = " .. mysql:escape_string(count))
		outputChatBox(count,p)
		count = count + 1
		end
		if delete then 
			outputChatBox("Weapons wiped.Now restart resource",p)
		end
	end
end
--addCommandHandler ("weaponwipe",weaponwipe)