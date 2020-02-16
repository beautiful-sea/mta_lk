local mysql = exports.mysql
local scriptVer = exports.global:getScriptVersion()
local salt = "vgrpkeyscotland"

-- Gay beta code
local hasBeta = { }



function UserLoggedOut()
	exports['anticheat-system']:changeProtectedElementDataEx(source, "loggedin", 0, true)
end
addEvent("player:loggedout", true)
addEventHandler("player:loggedout", getRootElement(), UserLoggedOut)

function UserLoggedOutAll()
	exports['anticheat-system']:changeProtectedElementDataEx(client, "loggedin", 0, true)
	exports['anticheat-system']:changeProtectedElementDataEx(client, "gameaccountloggedin", 0, true)
end
addEvent("accountplayer:loggedout", true)
addEventHandler("accountplayer:loggedout", getRootElement(), UserLoggedOutAll)

function informServerHasBeta()
	hasBeta[client] = true
end
addEvent("hasBeta", true)
addEventHandler("hasBeta", getRootElement(), informServerHasBeta)

function beta(thePlayer)
	if ( exports.global:isPlayerAdmin(thePlayer)) then
		local count = 0
		for k,v in pairs(hasBeta) do
			count = count + 1
		end
		exports.global:sendMessageToAdmins("> " .. count .. " pessoas estão jogando LK BETA.")
	end
end
addCommandHandler("beta", beta)

function playerQuit()
	hasBeta[source] = nil
end
addEventHandler("onPlayerQuit", getRootElement(), playerQuit)

function acceptBeta()
	redirectPlayer(client, "server.mta.vg", getServerPort(), getServerPassword())
end
addEvent("acceptBeta", true)
addEventHandler("acceptBeta", getRootElement(), acceptBeta)
-- end gay beta code

function sendSalt()
	triggerClientEvent(client, "sendSalt", source, salt, getPlayerIP(source), getElementData(getRootElement(), "account:motd"))
end
addEvent("getSalt", true)
addEventHandler("getSalt", getRootElement(), sendSalt)

function encrypt(str)
	local hash = 0
	for i = 1, string.len(str) do
		hash = hash + tonumber(string.byte(str, i, i))
	end
	
	if (hash==0) then
		return 0
	end
	hash = hash + 100000000
	return hash
end

function encryptSerial(str)
	local hash = md5(str)
	local rhash = "VGRP" .. string.sub(hash, 17, 20) .. string.sub(hash, 1, 2) .. string.sub(hash, 25, 26) .. string.sub(hash, 21, 2)
	return rhash
end

function resourceStart(resource)
	setGameType("Roleplay")
	setMapName("Los Santos")
	setRuleValue("Author", "sG Scripting Team")
	
	local motdresult = mysql:query_fetch_assoc("SELECT value FROM settings WHERE name='motd' LIMIT 1")
	exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:motd", motdresult["value" ], false )
	local amotdresult = mysql:query_fetch_assoc("SELECT value FROM settings WHERE name='amotd' LIMIT 1")
	exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:amotd", amotdresult["value" ], false )

	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		triggerEvent("playerJoinResourceStart", value, resource)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)
	
function onJoin()
	-- Set the user as not logged in, so they can't see chat or use commands
	exports['anticheat-system']:changeProtectedElementDataEx(source, "loggedin", 0)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountloggedin", 0, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountusername", "")
	exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountid", "")
	exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid", false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "adminlevel", 0)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "hiddenadmin", 0)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "globalooc", 1, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "muted", 0)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "loginattempts", 0, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "timeinserver", 0, false)
	setElementDimension(source, 9999)
	setElementInterior(source, 0)
	clearChatBox(source)
	exports.global:updateNametagColor(source)
end
addEventHandler("onPlayerJoin", getRootElement(), onJoin)
addEvent("playerJoinResourceStart", false)
addEventHandler("playerJoinResourceStart", getRootElement(), onJoin)

addEvent("restoreJob", false)
function spawnCharacter(charname, version)
	exports.global:takeAllWeapons(client)
	exports.global:takeAllWeapons(source)
	takeAllWeapons(source)
	takeAllWeapons(client)
	source = client
	
	local id = getElementData(client, "gameaccountid")
	charname = string.gsub(tostring(charname), " ", "_")
	
	local safecharname = mysql:escape_string(charname)
	
	local data = mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. safecharname .. "' AND account='" .. mysql:escape_string(id) .. "' AND cked = 0")
	
	if (data) then
		local id = tonumber(data["id"])
		local currentid = getElementData(source, "dbid")
		if hasBeta[source] then
			if id == currentid then
				return
			elseif currentid then
				triggerEvent("savePlayer", source, "Mudar jogador", source)
			end
		end
		
		for key, value in ipairs(getElementsByType("player")) do
			if ( getElementData(value, "loggedin") == 1 and value ~= source and hasBeta[value] ) then
				triggerClientEvent(value, "onPlayerCharacterChange", source, charname)
			end
		end
		
		local x = tonumber(data["x"])
		local y = tonumber(data["y"])
		local z = tonumber(data["z"])
		
		local rot = tonumber(data["rotation"])
		local interior = tonumber(data["interior_id"])
		local dimension = tonumber(data["dimension_id"])
		local health = tonumber(data["health"])
		local armor = tonumber(data["armor"])
		local skin = tonumber(data["skin"])
		setPedSkin(source, skin)
		
		local money = tonumber(data["money"])
		local factionID = tonumber(data["faction_id"])
		local cuffed = tonumber(data["cuffed"])
		local radiochannel = tonumber(data["radiochannel"])
		local masked = tonumber(data["masked"])
		local duty = tonumber(data["duty"])
		local cellnumber = tonumber(data["cellnumber"])
		local fightstyle = tonumber(data["fightstyle"])
		local pdjail = tonumber(data["pdjail"])
		local pdjail_time = tonumber(data["pdjail_time"])
		local pdjail_station = tonumber(data["pdjail_station"])
		local job = tonumber(data["job"])
		local casualskin = tonumber(data["casualskin"])
		local weapons = tostring(data["weapons"])
		local ammo = tostring(data["ammo"])
		local carlicense = tonumber(data["car_license"])
		local gunlicense = tonumber(data["gun_license"])
		local bankmoney = tonumber(data["bankmoney"])
		local fingerprint = tostring(data["fingerprint"])
		local tag = tonumber(data["tag"])
		local hoursplayed = tonumber(data["hoursplayed"])
		local timeinserver = tonumber(data["timeinserver"])
		local restrainedobj = tonumber(data["restrainedobj"])
		local restrainedby = tonumber(data["restrainedby"])
		local factionrank = tonumber(data["faction_rank"])
		local dutyskin = tonumber(data["dutyskin"])
		local phoneoff = tonumber(data["phoneoff"])
		local blindfold = tonumber(data["blindfold"])
		local gender = tonumber(data["gender"])
		local cellphonesecret = tonumber(data["cellphonesecret"])
		local photos = tonumber(data["photos"])
		
		local age = data["age"]
		local race = tonumber(data["skincolor"])
		local weight = data["weight"]
		local height = data["height"]
		local desc = data["description"]
		local maxvehicles = tonumber(data["maxvehicles"])
		local factionleader = tonumber(data["faction_leader"])
		local d_addiction = tostring(data["d_addiction"])
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "chardescription", desc)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "age", age)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "weight", weight)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "height", height)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "race", race)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "maxvehicles", maxvehicles)
		
		-- LANGUAGES
		local lang1 = tonumber(data["lang1"])
		local lang1skill = tonumber(data["lang1skill"])
		local lang2 = tonumber(data["lang2"])
		local lang2skill = tonumber(data["lang2skill"])
		local lang3 = tonumber(data["lang3"])
		local lang3skill = tonumber(data["lang3skill"])
		local currentLanguage = tonumber(data["currlang"])
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.current", currentLanguage, false)
				
		if lang1 == 0 then
			lang1skill = 0
		end
		
		if lang2 == 0 then
			lang2skill = 0
		end
		
		if lang3 == 0 then
			lang3skill = 0
		end
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang1", lang1, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang1skill", lang1skill, false)
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang2", lang2, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang2skill", lang2skill, false)
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang3", lang3, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "languages.lang3skill", lang3skill, false)
		-- END OF LANGUAGES
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "timeinserver", timeinserver, false)
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid", tonumber(id))
		exports['item-system']:loadItems( source, true )
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "loggedin", 1)
		
		-- Check his name isn't in use by a squatter
		local playerWithNick = getPlayerFromName(tostring(charname))
		if isElement(playerWithNick) and (playerWithNick~=source) then
			kickPlayer(playerWithNick, getRootElement(), "Sessão duplicada.")
		end
		
		-- casual skin
		exports['anticheat-system']:changeProtectedElementDataEx(source, "casualskin", casualskin, false)
		
		-- bleeding
		exports['anticheat-system']:changeProtectedElementDataEx(source, "bleeding", 0, false)
		
		-- Set their name to the characters
		exports['anticheat-system']:changeProtectedElementDataEx(source, "legitnamechange", 1)
		setPlayerName(source, tostring(charname))
		local pid = getElementData(source, "playerid")
		local fixedName = string.gsub(tostring(charname), "_", " ")

		setPlayerNametagText(source, tostring(fixedName))
		exports['anticheat-system']:changeProtectedElementDataEx(source, "legitnamechange", 0)
		
		-- If their an admin change their nametag colour
		local adminlevel = getElementData(source, "adminlevel")
		local hiddenAdmin = getElementData(source, "hiddenadmin")
		local adminduty = getElementData(source, "adminduty")
		local muted = getElementData(source, "muted")
		local donator = getElementData(source, "donator")
		
		-- remove all custom badges
		exports['anticheat-system']:changeProtectedElementDataEx(source, "PDbadge")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "ESbadge")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "GOVbadge")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "SANbadge")
		
		exports.global:updateNametagColor(source)
		setPlayerNametagShowing(source, false)
		
		-- Server mess

		clearChatBox(source)
		local playerCount = getPlayerCount()

		outputChatBox("Você agora está jogando como " .. charname .. ".", source, 0, 255, 0)
		outputChatBox("Procurando por comandos? /helpcmds", source, 255, 194, 14)
		outputChatBox("Precisa de ajuda? /helpme", source, 255, 194, 14)
		outputChatBox("Confira o sistema de aluguel de veículos perto da prefeitura. Ícone de torta no mapa F11", source, 255, 255, 0)
		--outputChatBox("Ingame Players: "..playercount.." Vehicles:".. #exports.pool:getPoolElementsByType("vehicle").." Peds:".. #exports.pool:getPoolElementsByType("peds").."." , source, 0, 191, 255)
		
		-- freeze the player, will be unfrozen client-side when on ground/after 2 secs
		triggerClientEvent(source, "usedElevator", source)
		setPedFrozen(source, true)
		setPedGravity(source, 0)
		
		-- Load the character info
		spawnPlayer(source, x, y, z, rot, skin)
		setElementHealth(source, health)
		setPedArmor(source, armor)
		
		
		setElementDimension(source, dimension)
		setElementInterior(source, interior, x, y, z)
		setCameraInterior(source, interior)
		
		local motd = getElementData(getRootElement(), "account:motd")
		--outputChatBox("Command help:/helpcmds.", source, 255, 255, 0)
		
		if ((getElementData(source, "adminlevel") or 0) > 0) then
			local amotd = getElementData(getRootElement(), "account:amotd")
		--outputChatBox("Admin MOTD: " .. amotd, source, 135, 206, 250)
		end
		
		local timer = getElementData(source, "pd.jailtimer")
		if isTimer(timer) then
			killTimer(timer)
		end
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailserved")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailtime")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailtimer")
		exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailstation")
		
		-- ADMIN JAIL
		local jailed = getElementData(source, "adminjailed")
		local jailed_time = getElementData(source, "jailtime")
		local jailed_by = getElementData(source, "jailadmin")
		local jailed_reason = getElementData(source, "jailreason")
		
		if jailed then
			outputChatBox("Você ainda tem " .. jailed_time .. " minuto (s) para cumprir sua sentença de prisão administrativa.", source, 255, 0, 0)
			outputChatBox(" ", source)
			outputChatBox("Você foi preso por: " .. jailed_by .. ".", source, 255, 0, 0)
			outputChatBox("Razão: " .. jailed_reason, source, 255, 0, 0)
				
			local incVal = getElementData(source, "playerid")
				
			setElementDimension(source, 65400+incVal)
			setElementInterior(source, 6)
			setCameraInterior(source, 6)
			setElementPosition(source, 263.821807, 77.848365, 1001.0390625)
			setPedRotation(source, 267.438446)
			
			if jailed_time ~= 999 then
				local theTimer = setTimer(timerUnjailPlayer, 60000, 1, source)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailtime", jailed_time, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailtimer", theTimer)
			else
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailtime", "Unlimited", false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailtimer", true, false)
			end
			exports['anticheat-system']:changeProtectedElementDataEx(source, "jailserved", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "adminjailed", true)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "jailreason", jailed_reason, false)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "jailadmin", jailed_by, false)
			
			setElementInterior(source, 6)
			setCameraInterior(source, 6)
		elseif pdjail == 1 then -- PD JAIL
			outputChatBox("Você ainda tem " .. pdjail_time .. " minuto (s) para cumprir sua sentença de prisão estadual.", source, 255, 0, 0)
			
			local theTimer = setTimer(timerPDUnjailPlayer, 60000, 1, source)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailserved", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailtime", pdjail_time, false)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailtimer", theTimer, false)
			exports['anticheat-system']:changeProtectedElementDataEx(source, "pd.jailstation", pdjail_station, false)
		end
		
		-- FACTIONS
		local factionName = nil
		if (factionID~=-1) then
			local fresult = mysql:query("SELECT name FROM factions WHERE id='" .. mysql:escape_string(factionID) .. "'")
			if (mysql:num_rows(fresult)>0) then
				local row = mysql:fetch_assoc(fresult)
				factionName = row["name"]
			else
				factionName = "Citizen"
				factionID = -1
				outputChatBox("Sua facção foi excluída e você ficou sem facção.", source, 255, 0, 0)
				mysql:query_free("UPDATE characters SET faction_id='-1', faction_rank='1' WHERE id='" .. mysql:escape_string(id) .. "' LIMIT 1")
			end
			
			if (fresult) then
				mysql:free_result(fresult)
			end
		else
			factionName = "Citizen"
		end
		
		local theTeam = getTeamFromName(tostring(factionName))
		setPlayerTeam(source, theTeam)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "factionrank", factionrank)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "factionleader", factionleader, false)
		
		if factionID == 1 then
			exports.global:givePlayerAchievement(source, 2)
		elseif factionID == 2 then
			exports.global:givePlayerAchievement(source, 5)
		elseif factionID == 3 then
			exports.global:givePlayerAchievement(source, 6)
		end
		-- END FACTIONS
		
		-- number of friends etc
		local playercount = getPlayerCount()
		local maxplayers = getMaxPlayers()
		local percent = math.ceil((playercount/maxplayers)*100)
		
		local friends = mysql:query("SELECT friend FROM friends WHERE id = " .. mysql:escape_string(getElementData( source, "gameaccountid" )) )
		if friends then
			local ids = {}
			while true do
				local row = mysql:fetch_assoc(friends)
				if not row then break end
				ids[ tonumber( row["friend"] ) ] = true
			end
			
			exports['anticheat-system']:changeProtectedElementDataEx(source, "friends", ids, false)
		end
		mysql:free_result( friends )

		-- LAST LOGIN
		mysql:query_free("UPDATE characters SET lastlogin=NOW() WHERE id='" .. mysql:escape_string(id) .. "'")
			
		-- Player is cuffed
		if (cuffed==1) then
			toggleControl(source, "sprint", false)
			toggleControl(source, "fire", false)
			toggleControl(source, "jump", false)
			toggleControl(source, "next_weapon", false)
			toggleControl(source, "previous_weapon", false)
			toggleControl(source, "accelerate", false)
			toggleControl(source, "brake_reverse", false)
		end
			
		exports['anticheat-system']:changeProtectedElementDataEx(source, "adminlevel", tonumber(adminlevel))
		exports['anticheat-system']:changeProtectedElementDataEx(source, "loggedin", 1)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "businessprofit", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "hiddenadmin", tonumber(hiddenAdmin))
		exports['anticheat-system']:changeProtectedElementDataEx(source, "legitnamechange", 0)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "muted", tonumber(muted))
		exports['anticheat-system']:changeProtectedElementDataEx(source, "hoursplayed", hoursplayed)
		exports.global:setMoney(source, money)
		exports.global:checkMoneyHacks(source)
		
		exports['anticheat-system']:changeProtectedElementDataEx(source, "faction", factionID)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "factionMenu", 0)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "restrain", cuffed)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "tazed", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "cellnumber", cellnumber, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "cellphone.secret", cellphonesecret, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "calling", nil, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "calltimer", nil, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "phonestate", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "realinvehicle", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "duty", duty)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "job", job)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "license.car", carlicense)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "license.gun", gunlicense)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "bankmoney", bankmoney)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "fingerprint", fingerprint, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "tag", tag)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "dutyskin", dutyskin, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "phoneoff", phoneoff, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "blindfold", blindfold, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "gender", gender)
		
		if (restrainedobj>0) then
			exports['anticheat-system']:changeProtectedElementDataEx(source, "restrainedObj", restrainedobj, false)
		end
		
		if (restrainedby>0) then
			exports['anticheat-system']:changeProtectedElementDataEx(source, "restrainedBy", restrainedby, false)
		end
		
		if job == 1 then
			triggerClientEvent(source,"restoreTruckerJob",source)
		end
		triggerEvent("restoreJob", source)
		triggerClientEvent(source, "updateCollectionValue", source, photos)
		
		-- Let's give them their weapons
		--triggerEvent("syncWeapons", source, weapons, ammo)
		if (tostring(weapons)~=tostring(mysql_null())) and (tostring(ammo)~=tostring(mysql_null())) then -- if player has weapons saved
			for i=0, 12 do
				local tokenweapon = gettok(weapons, i+1, 59)
				local tokenammo = gettok(ammo, i+1, 59)
				
				if (not tokenweapon) or (not tokenammo) then
					break
				else
					exports.global:giveWeapon(source, tonumber(tokenweapon), tonumber(tokenammo), false)
				end
			end
		end
		
		-- Let's stick some blips on the properties they own
		local interiors = { }
		for key, value in ipairs(getElementsByType("pickup", getResourceRootElement(getResourceFromName("interior-system")))) do
			if isElement(value) and getElementDimension(value) == 0 then
				if getElementData(value, "name") then
					local inttype = getElementData(value, "inttype")
					local owner = tonumber(getElementData(value, "owner"))

					if owner == tonumber(id) then
						local x, y = getElementPosition(value)
						if (inttype ~= 2) then
							if inttype == 3 then inttype = 0 end
							interiors[#interiors+1] = { inttype, x, y }
						end
					end
				end
			end
		end
		
		triggerClientEvent(source, "createBlipsFromTable", source, interiors)
		
		-- Fight style
		setPedFightingStyle(source, tonumber(fightstyle))
		
		-- Achievement
		if not (exports.global:doesPlayerHaveAchievement(source, 38)) then
			exports.global:givePlayerAchievement(source, 38) -- Welcome to Los Santos
			triggerClientEvent(source, "showCityGuide", source)
		end
		
		-- Weapon stats
		setPedStat(source, 70, 999)
		setPedStat(source, 71, 999)
		setPedStat(source, 72, 999)
		setPedStat(source, 74, 999)
		setPedStat(source, 76, 999)
		setPedStat(source, 77, 999)
		setPedStat(source, 78, 999)
		setPedStat(source, 79, 999)
		
		toggleAllControls(source, true, true, true)
		setPedFrozen(source, false)
		
		-- blindfolds
		if (blindfold==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(source, "blindfold", 1)
			outputChatBox("Seu personagem está com os olhos vendados. Se essa foi uma ação do COO, entre em contato com um administrador via F2.", source, 255, 194, 15)
			--fadeCamera(player, false)
		else
			fadeCamera(source, true, 2)
			setTimer(blindfoldFix, 5000, 1, source)
		end
		
		-- impounded cars
		if exports.global:hasItem(source, 2) then -- phone
			local impounded = mysql:query_fetch_assoc("SELECT COUNT(*) as 'numbr'  FROM `vehicles` WHERE `owner` = " .. mysql:escape_string(id) .. " and `Impounded` > 0")
			if impounded then
				local amount = tonumber(impounded["numbr"]) or 0
				if amount > 0 then
					outputChatBox("((Reboque e recuperação de Los Santos)) #999 [SMS]: " .. amount .. " dos seus veículos estão apreendidos. Vá ao detran para liberá-los.", source, 120, 255, 80)
				end
			end
		end
		
		-- drug addictions
		if (tostring(d_addiction)~=tostring(mysql_null())) then
			local getdrug = split(d_addiction, string.byte(';'))
			for k, v in ipairs(getdrug) do
				exports['anticheat-system']:changeProtectedElementDataEx(source, "drug." ..k, tonumber(v))
			end
		end
		
		--if (version) and (version < getVersion().mta) then
		--	outputChatBox("You are using an Old Version of MTA! (V" .. version .. ").", source, 255, 0, 0)
		--	outputChatBox("We recommend you upgrade to V" .. getVersion().mta .. " to ensure full script compatability and improve your experience.", source, 255, 0, 0)
		--end
		
		if ( hasBeta[source] ) then
			outputChatBox("Você pode visitar o menu Home novamente pressionando Home.", source, 255, 194, 15)
		end
		
		triggerEvent("onCharacterLogin", source, charname, factionID)
		

		triggerClientEvent(source, "updateHudClock", source)
	else
		outputDebugString( "Spawn do jogador falhou: ")
	end
end
addEvent("onCharacterLogin", false)
addEvent("spawnCharacter", true)
addEventHandler("spawnCharacter", getRootElement(), spawnCharacter)

function blindfoldFix(player)
	fadeCamera(player, true, 2)
end

function timerUnjailPlayer(jailedPlayer)
	if(isElement(jailedPlayer)) then
		local timeServed = getElementData(jailedPlayer, "jailserved")
		local timeLeft = getElementData(jailedPlayer, "jailtime")
		local accountID = getElementData(jailedPlayer, "gameaccountid")
		
		if (timeServed) and (timeLeft) then
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailserved", timeServed+1)
			local timeLeft = timeLeft - 1
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailtime", timeLeft)
			local result
			if (timeLeft<=0) then
				mysql:query_free("UPDATE accounts SET adminjail_time='0', adminjail='0' WHERE id='" .. mysql:escape_string(accountID) .. "'")
				exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailtimer")
				exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "adminjailed")
				exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailreason")
				exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailtime")
				exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "jailadmin")
				setElementPosition(jailedPlayer, 1519.7177734375, -1697.8154296875, 13.546875)
				setPedRotation(jailedPlayer, 269.92446899414)
				setElementDimension(jailedPlayer, 0)
				setElementInterior(jailedPlayer, 0)
				setCameraInterior(jailedPlayer, 0)
				toggleControl(jailedPlayer,'next_weapon',true)
				toggleControl(jailedPlayer,'previous_weapon',true)
				toggleControl(jailedPlayer,'fire',true)
				toggleControl(jailedPlayer,'aim_weapon',true)
				
				local theTimer = getElementData(jailedPlayer, "jailtimer")
				killTimer(theTimer)
				
				outputChatBox("Seu tempo foi cumprido, Comporte-se da próxima vez!", jailedPlayer, 0, 255, 0)
				exports.global:sendMessageToAdmins("Adm: " .. getPlayerName(jailedPlayer) .. " cumpriu pena de prisão.")
			else
				mysql:query_free("UPDATE accounts SET adminjail_time='" .. mysql:escape_string(timeLeft) .. "' WHERE id='" .. mysql:escape_string(accountID) .. "'")
			end
		else
			if (isElement(jailedPlayer)) then
				local theTimer = getElementData(jailedPlayer, "jailtimer")
			
				if (theTimer) then
					killTimer(theTimer)
				end
			end
		end
	end
end

function calculateAutoLoginHash(username)
	local hash = md5(salt .. username .. math.random(1,1000000) .. salt .. "b" .. math.random(10,99) .."ring-fuckyoudaniels")
	local hash2 = md5( math.random(1,1000000)..  math.random(1,1000000)..  math.random(1,1000000)..  math.random(1,1000000)..  math.random(1,1000000).. "vG")
	local finalhash = hash .. hash2
	mysql:query_free("UPDATE `accounts` SET `loginhash`='".. finalhash .."' WHERE `username`='".. mysql:escape_string(username) .."'")
	return finalhash
end

function loginPlayer(username, password, operatingsystem, hashPlease)
	local autologin = false
	local loginErrorCode = 1
	if (string.len(password)~=64) then
		password = md5(salt .. password)
	else
		autologin = true
		loginErrorCode = 6
	end	
	local safeusername = mysql:escape_string(username)
	local safepassword = mysql:escape_string(password)
	
	local query 
	if (autologin) then
		 query = "SELECT * FROM `accounts` WHERE `username`='" .. safeusername .. "' AND `loginhash`='" .. safepassword .. "'"
	else
		 query = "SELECT * FROM `accounts` WHERE `username`='" .. safeusername .. "' AND `password`='" .. safepassword .. "'"
	end
	
	local result = mysql:query(query)
	source = client
	if (mysql:num_rows(result)>0) then
		local data = mysql:fetch_assoc(result)
		triggerEvent("onPlayerLogin", source, username, password)
		for key, value in ipairs(getElementsByType("player")) do
			if ( getElementData(value, "loggedin") == 1 and value ~= source and hasBeta[value] ) then
				triggerClientEvent(value, "onPlayerAccountLogin", source, username)
			end
		end
		
		local id = tonumber(data["id"])
		
		local newhash = calculateAutoLoginHash(safeusername) -- make the autologin hash expire
		if (hashPlease) then -- send their new hash
			triggerClientEvent(source, "account:onAutoLoginHashReceive", source, newhash)
		end
		
		-- Check the account isn't already logged in
		local found = false
		for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
			local accid = tonumber(getElementData(value, "gameaccountid"))
			if (accid) then
				if (accid==id) and (value~=source) then
					found = true
					break
				end
			end
		end
		
		if not (found) then
			local admin = tonumber(data["admin"])
			local hiddenadmin = tonumber(data["hiddenadmin"])
			local adminduty = tonumber(data["adminduty"])
			local donator = tonumber(data["donator"])
			local adminjail = tonumber(data["adminjail"])
			local adminjail_time = tonumber(data["adminjail_time"])
			local adminjail_by = tostring(data["adminjail_by"])
			local adminjail_reason = data["adminjail_reason"]
			local banned = tonumber(data["banned"])
			local banned_by = data["banned_by"]
			local banned_reason = data["banned_reason"]
			local muted = tonumber(data["muted"])
			local donatorchat = tonumber(data["donatorchat"])
			local globalooc = tonumber(data["globalooc"])
			local blur = tonumber(data["blur"])
			local adminreports = tonumber(data["adminreports"])
			local pmblocked = tonumber(data["pmblocked"])
			local adblocked = tonumber(data["adblocked"])
			local newsblocked = tonumber(data["newsblocked"])
			local warns = tonumber(data["warns"])
			local chatbubbles = tonumber(data["chatbubbles"])
			local appstate = tonumber(data["appstate"])
			local liveusername = data["liveusername"]
			local steamusername = data["steamusername"]
			
			if ( admin <= 0 and hasBeta[client] and not exports.global:isPlayerScripter( username ) and donator <= 0 ) then -- non admin with beta? ban
				exports.global:sendMessageToAdmins("[Adm] " .. getPlayerName(client) .. " foi banido por executar um Sapphire Beta hackeado.")
				local ban = banPlayer(client, true, false, false, getRootElement(), "Hacked Beta.", 0)
				mysql:query_free("UPDATE accounts SET banned='1', banned_reason='Hacked Beta.', banned_by='Script' WHERE id='" .. mysql:escape_string(id) .. "'")
			end
			
			local country = tostring(exports.global:getPlayerCountry(source))
			exports['anticheat-system']:changeProtectedElementDataEx(source, "country", country)
			
			if tonumber(admin) == 0 then
				adminduty = 0
				hiddenadmin = 0
			end
			
			if ( liveusername ~= mysql_null() and hasBeta[source] ) then
				--callRemote("", xboxReturnExisting, tostring(liveusername), source)
			end
			
			if ( steamusername ~= mysql_null() and hasBeta[source] ) then
				--callRemote("http://valhallagaming.net/mtaucp/mta/lookup_steam.php", steamReturnExisting, tostring(steamusername), source)
			end
			
			if donator > 0 then -- check if they're a donator
				exports['anticheat-system']:changeProtectedElementDataEx(source, "pmblocked", pmblocked, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "tognews", newsblocked, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "disableAds", adblocked == 1, false)
			else -- no donator, set default things
				exports['anticheat-system']:changeProtectedElementDataEx(source, "pmblocked", 0, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "disableAds", false, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "tognews", 0, false)
			end
		
			
			exports['anticheat-system']:changeProtectedElementDataEx(source, "donatorlevel", tonumber(donator))
			exports['anticheat-system']:changeProtectedElementDataEx(source, "adminlevel", tonumber(admin))
			exports['anticheat-system']:changeProtectedElementDataEx(source, "hiddenadmin", tonumber(hiddenadmin))
			exports['anticheat-system']:changeProtectedElementDataEx(source, "donator", tonumber(donator))
			
			exports['anticheat-system']:changeProtectedElementDataEx(source, "blur", blur)
			setPlayerBlurLevel(source, blur == 0 and 0 or 38)
			
			if (appstate==0) then
				clearChatBox(source)
				outputChatBox("Enviar bug.Report no fórum ",source, 255, 194, 15)
				setTimer(kickPlayer, 30000, 1, source, getRootElement(), "Enviar bug do aplicativo")
			elseif (appstate==1) then
				clearChatBox(source)
				outputChatBox("Bug de aplicativo pendente.", source, 255, 194, 15)
				setTimer(kickPlayer, 30000, 1, source, getRootElement(), "Bug pendente do aplicativo .Relatório no forum")
			elseif (appstate==2) then
				clearChatBox(source)
				outputChatBox("Erro /relatório de aplicativo recusado", source, 255, 194, 15)
				setTimer(kickPlayer, 30000, 1, source, getRootElement(), "Reenviar bug do aplicativo")
			elseif (banned==1) then
				triggerClientEvent(source, "loginFail", source, 3)
			else
				exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountloggedin", 1, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountusername", username)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "gameaccountid", tonumber(id))
				exports['anticheat-system']:changeProtectedElementDataEx(source, "adminduty", tonumber(adminduty))
				exports['anticheat-system']:changeProtectedElementDataEx(source, "adminjailed", adminjail == 1, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailtime", tonumber(adminjail_time), false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailadmin", tostring(adminjail_by), false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "jailreason", tostring(adminjail_reason), false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "globalooc", tonumber(globalooc), false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "donatorchat", tonumber(donatorchat), false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "muted", tonumber(muted))
				exports['anticheat-system']:changeProtectedElementDataEx(source, "adminreports", adminreports, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "warns", warns, false)
				exports['anticheat-system']:changeProtectedElementDataEx(source, "chatbubbles", chatbubbles, false)
				
		outputChatBox("Fazendo login na sua conta...",source,255,0,0)

					--triggerClientEvent(source, "loginOK", source)
				-- backwards compatability
					triggerClientEvent(source, "hideUI", source)
					local playerid = getElementData(source, "playerid")

					spawnPlayer(source, 258.43417358398, -41.489139556885, 1002.0234375, 268.19247436523, 0, 14, 65000+playerid)
					fadeCamera(source, true)
			
				sendAccounts(source, id)

				--setTimer(sendAccounts, 15000, 1, source, id)
				
				-- Get login time & date
				local time = getRealTime()
				local days = time.monthday
				local months = (time.month+1)
				local years = (1900+time.year)
				
				local yearday = time.yearday
				local logindate = days .. "/" .. months .. "/" .. years
				
				local ip = getPlayerIP(source)
				
				mysql:query("UPDATE accounts SET lastlogin=NOW(), ip='" .. mysql:escape_string(ip) .. "', country='" .. mysql:escape_string(country) .. "', mtaserial='" .. mysql:escape_string(getPlayerSerial(source)) .. "' WHERE id='" .. mysql:escape_string(id) .. "'")
			end
		else
			triggerClientEvent(source, "loginFail", source, 2)
		end
	else
		local attempts = tonumber(getElementData(source, "loginattempts"))
		attempts = attempts + 1
		exports['anticheat-system']:changeProtectedElementDataEx(source, "loginattempts", attempts, false)
		
		if (attempts>=6) then
			outputChatBox("AVISO: Você digitou a senha errada 6 vezes. Tentar novamente pode resultar em um ban temporário.",source,255,0,0)
		elseif (attempts>=7) then
			kickPlayer(source, true, false, false, getRootElement(), "Muitas tentativas de login")
		else
			triggerClientEvent(source, "loginFail", source, loginErrorCode)
		end
	end
	
	if (result) then
		mysql:free_result(result)
	end
end
addEvent("onPlayerLogin", false)
addEvent("attemptLogin", true)
addEventHandler("attemptLogin", getRootElement(), loginPlayer)

function userregister(username, password, operatingsystem, hashPlease)
	local safeusername = mysql:escape_string(username)
	local safepassword = mysql:escape_string(password)

	local autologin = false
	local loginErrorCode = 1
	if (string.len(password)~=64) then
		password = md5(salt .. password)
	else
		autologin = true
		loginErrorCode = 6
	end	
	local result = mysql:query("SELECT username FROM accounts WHERE username='" .. safeusername .. "'")
	if (mysql:num_rows(result)>0) then -- Name is already taken
		outputChatBox("Usuário em uso.",source,255,0,0)
		return 
	end
--outputChatBox("Account registered successfully!.Username: "..safeusername.." Password: "..safepassword.."  Remember it",source,0,255,0)
	
	triggerClientEvent(source,"inforeg",source)
triggerClientEvent( getRootElement(), "aoutput",getRootElement(), "Server","*"..safeusername.." registrou uma conta no servidor.")
	
	local safeusername = mysql:escape_string(username)
	local safepassword = mysql:escape_string(password)
	local id = mysql:query_insert_free("INSERT INTO accounts SET username='" .. safeusername .. "', loginhash='" .. safepassword .. "',password='".. safepassword.."'")
				
end
addEvent("attemptRegister", true)
addEventHandler("attemptRegister", getRootElement(), userregister)


pendingResult = { }
function displayRetrieveDetailsResult(result, player)
	if (player) and (pendingResult[player] ~= nil) then
		pendingResult[player] = nil
		if ( result == 0 ) then
			outputChatBox("Informações sobre como recuperar seu nome de usuário e senha foram enviadas para o seu endereço de email.", player, 0, 255, 0)
		else
			outputChatBox("Este serviço está indisponível no momento.", player, 255, 0, 0)
		end
	end
end

function checkTimeout(player)
	if ( pendingResult[player] ) then
		pendingResult[player] = nil
		outputChatBox("[TIMEOUT] Este serviço está indisponível no momento.", player, 255, 0, 0)
	end
end

function retrieveDetails(email)
	local safeEmail = mysql:escape_string(tostring(email))
	
	local result = mysql:query("SELECT id FROM accounts WHERE email='" .. safeEmail .. "'")
	
	if (mysql:num_rows(result)>0) then
		local row = mysql:fetch_assoc(result)
		local id = tonumber(row["id"])
		callRemote("http://", displayRetrieveDetailsResult, id)
		outputChatBox("Entrando em contato com o servidor da conta ... Aguarde ...", source, 255, 194, 15)
		
		pendingResult[source] = true
		setTimer(checkTimeout, 10000, 1, source)
	else
		outputChatBox("E-mail inválido.", source, 255, 0, 0)
	end
	mysql:free_result(result)
end
addEvent("retrieveDetails", true)
addEventHandler("retrieveDetails", getRootElement(), retrieveDetails)

function sendAccounts(thePlayer, id, isChangeChar)
	exports['anticheat-system']:changeProtectedElementDataEx(thePlayer,"loggedin",0)
	exports.global:updateNametagColor(thePlayer)
	exports.global:takeAllWeapons(thePlayer)
	local accounts = { }

	local result = mysql:query("SELECT id, charactername, cked, lastarea, age, gender, faction_id, faction_rank, skin, DATEDIFF(NOW(), lastlogin) as llastlogin FROM characters WHERE account='" .. mysql:escape_string(id) .. "'  ORDER BY cked ASC, lastlogin DESC")
	if (mysql:num_rows(result)>0) then
		if (isChangeChar) then
			triggerEvent("savePlayer", source, "Alterar personagem", source)
			
		end
		
		local i = 1

		while true do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			accounts[i] = { }
			accounts[i][1] = tonumber(row["id"])
			accounts[i][2] = row["charactername"]
			
			if (tonumber(row["cked"]) or 0) > 0 then
				accounts[i][3] = 1
			end
			
			accounts[i][4] = row["lastarea"]
			accounts[i][5] = tonumber(row["age"])
			accounts[i][6] = tonumber(row["gender"])
			
			local factionID = tonumber(row["faction_id"])
			local factionRank = tonumber(row["faction_rank"])
			
			if (factionID<1) or not (factionID) then
				accounts[i][7] = nil
				accounts[i][8] = nil
			else
				factionResult = mysql:query_fetch_assoc("SELECT name, rank_" .. mysql:escape_string(factionRank) .. " as rankname FROM factions WHERE id='" .. mysql:escape_string(tonumber(factionID)) .. "'")

				if (factionResult) then
					accounts[i][7] = factionResult["name"]
					accounts[i][8] = factionResult["rankname"]
					
					if (string.len(accounts[i][7])>53) then
						accounts[i][7] = string.sub(accounts[i][7], 1, 32) .. "..."
					end
				else
					accounts[i][7] = nil
					accounts[i][8] = nil
				end
			end
			accounts[i][9] = tonumber(row["skin"])
			accounts[i][10] = tonumber(row["llastlogin"])
			i = i + 1
		end
		
	end
	
	if (result) then
		mysql:free_result(result)
	end
	
	local playerid = getElementData(thePlayer, "playerid")

	if ( hasBeta[thePlayer] ) then
		spawnPlayer(thePlayer, 1409.9384765625, -808.51953125, 91.859375, 172.96313476563, 0, 0, 65000+playerid)
		toggleAllControls(source, false, true, true)
		setPedFrozen(source, true)
	else
		local playerid = getElementData(thePlayer, "playerid")
		spawnPlayer(thePlayer, 258.43417358398, -41.489139556885, 1002.0234375, 268.19247436523, 0, 14, 65000+playerid)
	end
	
	local emailresult = mysql:query_fetch_assoc("SELECT email FROM accounts WHERE id = '" .. mysql:escape_string(id) .. "'")
	
	if ( emailresult) then
		local hasEmail = emailresult["email"]
		
		if ( hasEmail == mysql_null() ) then
			triggerClientEvent(thePlayer, "showCharacterSelection", thePlayer, accounts, false, true)
		else
			triggerClientEvent(thePlayer, "showCharacterSelection", thePlayer, accounts)
		end
	else
		triggerClientEvent(thePlayer, "showCharacterSelection", thePlayer, accounts)
	end
	
	if ( hasBeta[thePlayer] ) then
		requestAchievements(thePlayer)
	end
end
addEvent("sendAccounts", true)
addEventHandler("sendAccounts", getRootElement(), sendAccounts)

function storeEmail(email)
	local accountid = getElementData(client, "gameaccountid")
	local safeemail = mysql:escape_string(email)
	mysql:query_free("UPDATE accounts SET email = '" .. safeemail .. "' WHERE id = '" .. mysql:escape_string(accountid) .. "'")
end
addEvent("storeEmail", true)
addEventHandler("storeEmail", getRootElement(), storeEmail)

function requestFriends(player)
	local accid = getElementData(player, "gameaccountid")
	local result = mysql:query("SELECT f.friend as friend, a.username as username, a.friendsmessage as friendsmessage, a.country as country FROM friends f LEFT JOIN accounts a ON f.friend = a.id WHERE f.id = " .. mysql:escape_string(accid) .. " ORDER BY a.lastlogin DESC" )
	if result then
		local friends = { }
		while true do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			
			local id = tonumber( row["friend"] )
			local account = row["username"]
			
			if account == mysql_null( ) then --
				mysql:query_free("DELETE FROM friends WHERE id = " .. mysql:escape_string(id) .. " OR friend = " .. mysql:escape_string(id) )
			else
				table.insert( friends, { id, account, row["friendsmessage"], row["country"] } )
			end
		end
		
		mysql:free_result( result )
		
		local friendsmessage = ""
		local result = mysql:query_fetch_assoc("SELECT friendsmessage FROM accounts WHERE id = " .. mysql:escape_string(accid) )
		if result then
			friendsmessage = result["friendsmessage"]
			if friendsmessage == mysql_null( ) then
				friendsmessage = ""
			end
		else
			outputDebugString( "Falha no carregamento da mensagem de amigo: ")
		end
		triggerClientEvent( player, "returnFriends", player, friends, friendsmessage )
	else
		outputDebugString( "Falha no carregamento de amigos: " )
		outputChatBox("Error 600000 - Não foi possível recuperar a lista de amigos.", player, 255, 0, 0)
	end
	requestAccount(player)
end

function requestAccount(player)
	local accid = getElementData(player, "gameaccountid")
	local result = mysql:query_fetch_assoc("SELECT mtausername FROM accounts WHERE id = " .. mysql:escape_string(tonumber(accid)))
	
	if ( result ) then
		local mtausername = result["mtausername"]
		
		if ( mtausername == mysql_null() ) then
			triggerClientEvent(player, "storeAccountInformation", player)
		else
			triggerClientEvent(player, "storeAccountInformation", player, tostring(mtausername))
		end
	else
		outputDebugString( "Falha no carregamento das informações da conta: " )
		outputChatBox("Error 600001 - Não foi possível recuperar as informações da conta.", source, 255, 0, 0)
	end
end

function requestAchievements(player)
	-- Get achievements
	local gameAccountID = getElementData(player, "gameaccountid")
	local aresult = mysql:query("SELECT achievementid, date FROM achievements WHERE account='" .. mysql:escape_string(gameAccountID) .. "'")
	
	local achievements = { }
	
	if aresult then
		while true do
			local row = mysql:fetch_assoc(aresult)
			if not row then break end
			
			achievements[#achievements+1] = { tonumber( row["achievementid"] ), row["date"] }
		end

	end
	mysql:free_result(aresult)
	triggerClientEvent(player, "returnAchievements", player, achievements)
	
	if ( hasBeta[player] ) then
		requestFriends(player)
	end
end

function getAchievements()
	requestAchievements(client)
end
addEvent("requestAchievements", true)
addEventHandler("requestAchievements", getRootElement(), getAchievements)

function deleteCharacterByName(charname)
	
	local fixedName = mysql:escape_string(string.gsub(tostring(charname), " ", "_"))

	local accountID = getElementData(client, "gameaccountid")
	local result = mysql:query_fetch_assoc("SELECT id FROM characters WHERE charactername='" .. fixedName .. "' AND account='" .. mysql:escape_string(accountID) .. "' LIMIT 1")
	local charid = tonumber(result["id"])
	
	if charid then -- not ck'ed
		-- delete all in-game vehicles
		for key, value in pairs( getElementsByType( "vehicle" ) ) do
			if isElement( value ) then
				if getElementData( value, "owner" ) == charid then
					call( getResourceFromName( "item-system" ), "deleteAll", 3, getElementData( value, "dbid" ) )
					destroyElement( value )
				end
			end
		end
		mysql:query_free("DELETE FROM vehicles WHERE owner = " .. mysql:escape_string(charid) )

		-- logs the deletion of the characters
		local accountUsername = getElementData(client, "gameaccountusername")
		exports.logs:logMessage("[DELETE CHARACTER] #" .. accountID .. "-" .. accountUsername .. " has deleted character #" .. charid .. "-" .. charname .. ".", 31)

		-- un-rent all interiors
		local old = getElementData( client, "dbid" )
		exports['anticheat-system']:changeProtectedElementDataEx( client, "dbid", charid )
		local result = mysql:query("SELECT id FROM interiors WHERE owner = " .. mysql:escape_string(charid) .. " AND type != 2" )
		if result then
			while true do
				local row = mysql:fetch_assoc()
				if not row then break end
				
				local id = tonumber(row["id"])
				call( getResourceFromName( "interior-system" ), "publicSellProperty", client, id, false, false )
			end
		end
		exports['anticheat-system']:changeProtectedElementDataEx( client, "dbid", old )
		
		-- get rid of all items
		mysql:query_free("DELETE FROM items WHERE type = 1 AND owner = " .. mysql:escape_string(charid) )
		
		-- finally delete the character
		mysql:query_free("DELETE FROM characters WHERE id='" .. mysql:escape_string(charid) .. "' AND account='" .. mysql:escape_string(accountID) .. "' LIMIT 1")
	end
	--sendAccounts(client, accountID)
	--showChat(client, true)
end
addEvent("deleteCharacter", true)
addEventHandler("deleteCharacter", getRootElement(), deleteCharacterByName)


function clearChatBox(thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
	outputChatBox(" ", thePlayer)
end
addCommandHandler("clearchat", clearChatBox) -- Users can now clear their chat if they wish

function declineTOS()
	kickPlayer(client, getRootElement(), "Declined TOS")
end
addEvent("declineTOS", true)
addEventHandler("declineTOS", getRootElement(), declineTOS)

function doesCharacterExist(charname)
	charname = string.gsub(tostring(charname), " ", "_")
	local safecharname = mysql:escape_string( charname)
	
	local result = mysql:query("SELECT charactername FROM characters WHERE charactername='" .. safecharname .. "'")
	
	if (mysql:num_rows(result)>0) then
		triggerClientEvent(client, "characterNextStep", source, true)
	else
		triggerClientEvent(client, "characterNextStep", source, false)
	end
	
	mysql:free_result(result)
end
addEvent("doesCharacterExist", true)
addEventHandler("doesCharacterExist", getRootElement(), doesCharacterExist)

function resetNick(oldNick, newNick)
	exports['anticheat-system']:changeProtectedElementDataEx(client, "legitnamechange", 1)
	setPlayerName(client, oldNick)
	exports['anticheat-system']:changeProtectedElementDataEx(client, "legitnamechange", 0)
	exports.global:sendMessageToAdmins("Adm: " .. tostring(oldNick) .. " tentou mudar o nome para " .. tostring(newNick) .. ".")
end

addEvent("resetName", true )
addEventHandler("resetName", getRootElement(), resetNick)

function createCharacter(name, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language)
	source = client
	local charname = string.gsub(tostring(name), " ", "_")
	local safecharname = mysql:escape_string(charname)
	description = string.gsub(tostring(description), "'", "")
	
	local result = mysql:query("SELECT charactername FROM characters WHERE charactername='" .. safecharname .. "'")

	local accountID = getElementData(source, "gameaccountid")
	local accountUsername = getElementData(source, "gameaccountusername")

	local npid = nil
	if (mysql:num_rows(result)>0) then -- Name is already taken
		triggerEvent("onPlayerCreateCharacter", source, charname, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language, false)
		if (hasBeta[client]) then
			triggerClientEvent(client, "charCreateFail", client)
		end
		return
	else
		
		-- /////////////////////////////////////
		-- TRANSPORT
		-- /////////////////////////////////////
		local x, y, z, r, lastarea = 0, 0, 0, 0, "Unknown"
		
		if (transport==1) then
			x, y, z = 1742.1884765625, -1861.3564453125, 13.577615737915
			r = 0.98605346679688
			lastarea = "Unity Bus Station"
		else
			x, y, z = 1685.583984375, -2329.4443359375, 13.546875
			r = 0.79379272460938
			lastarea = "Los Santos International"
		end
		
		local salt = "fingerprintscotland"
		local fingerprint = md5(salt .. safecharname)
		
		local id = mysql:query_insert_free("INSERT INTO characters SET charactername='" .. safecharname .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotation='" .. mysql:escape_string(r) .. "', faction_id='-1', transport='" .. mysql:escape_string(transport) .. "', gender='" .. mysql:escape_string(gender) .. "', skincolor='" .. mysql:escape_string(skincolour) .. "', weight='" .. mysql:escape_string(weight) .. "', height='" .. mysql:escape_string(height) .. "', muscles='" .. mysql:escape_string(muscles) .. "', fat='" .. mysql:escape_string(fatness) .. "', description='" .. mysql:escape_string(description) .. "', account='" .. mysql:escape_string(accountID) .. "', skin='" .. mysql:escape_string(skin) .. "', lastarea='" .. mysql:escape_string(lastarea) .. "', age='" .. mysql:escape_string(age) .. "', fingerprint='" .. mysql:escape_string(fingerprint) .. "', lang1=" .. mysql:escape_string(language) .. ", lang1skill=100, currLang=1" )
		
		if (id) then
			exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid", id, false)
			exports.global:giveItem( source, 16, skin )
			exports.global:giveItem( source, 17, 1 )
			exports.global:giveItem( source, 18, 1 )
			exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid")

			-- CELL PHONE
			local cellnumber = id+15000
			local update = mysql:query_free("UPDATE characters SET cellnumber='" .. mysql:escape_string(cellnumber) .. "' WHERE charactername='" .. safecharname .. "'")
			npid = tonumber(id)
			if (update) then
				triggerEvent("onPlayerCreateCharacter", source, charname, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language, true)
			else
				outputChatBox("Error 100003 - Relatório em fóruns.", source, 255, 0, 0)
			end
			
			if (hasBeta[client]) then
				triggerClientEvent(client, "charCreateSuccess", client, npid)
			end
		else
			triggerEvent("onPlayerCreateCharacter", source, charname, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language, false)
		end
	end
	--exports.logs:logMessage("[CREATE CHARACTER] #" .. accountID .. "-" .. accountUsername .. " has created a character by the name " .. charname:gsub("_"," ") .. "-#" .. npid, 31)
	sendAccounts(source, accountID)
	
	mysql:free_result(result)
end
addEvent("onPlayerCreateCharacter", false)
addEvent("createCharacter", true)
addEventHandler("createCharacter", getRootElement(), createCharacter)

function serverToggleBlur(enabled)
	if (enabled) then
		exports['anticheat-system']:changeProtectedElementDataEx(client, "blur", 1)
		setPlayerBlurLevel(client, 38)
	else
		exports['anticheat-system']:changeProtectedElementDataEx(client, "blur", 0)
		setPlayerBlurLevel(client, 0)
	end
	mysql:query_free("UPDATE accounts SET blur=" .. mysql:escape_string(getElementData( client, "blur" )) .. " WHERE id = " .. mysql:escape_string(getElementData( client, "gameaccountid" )) )
end
addEvent("updateBlurLevel", true)
addEventHandler("updateBlurLevel", getRootElement(), serverToggleBlur)

function cmdToggleBlur(thePlayer, commandName)
	local blur = getElementData(thePlayer, "blur")
	
	if (blur==0) then
		outputChatBox("Vehicle blur enabled.", thePlayer, 255, 194, 14)
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "blur", 1)
		setPlayerBlurLevel(thePlayer, 38)
	elseif (blur==1) then
		outputChatBox("Vehicle blur disabled.", thePlayer, 255, 194, 14)
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "blur", 0)
		setPlayerBlurLevel(thePlayer, 0)
	end
	mysql:query_free("UPDATE accounts SET blur=" .. mysql:escape_string(( 1 - blur )) .. " WHERE id = " .. mysql:escape_string(getElementData( thePlayer, "gameaccountid" )) )
end
addCommandHandler("toggleblur", cmdToggleBlur)

function cguiSetNewPassword(oldPassword, newPassword)
	
	local gameaccountID = getElementData(client, "gameaccountid")
	
	local safeoldpassword = mysql:escape_string(oldPassword)
	local safenewpassword = mysql:escape_string(newPassword)
	
	local query = mysql:query("SELECT username FROM accounts WHERE id='" .. mysql:escape_string(gameaccountID) .. "' AND password=MD5('" .. salt .. safeoldpassword .. "')")
	
	if not (query) or (mysql:num_rows(query)==0) then
		outputChatBox("Sua senha atual digitada estava incorreta.", client, 255, 0, 0)
	else
		local update = mysql:query_free("UPDATE accounts SET password=MD5('" .. salt .. safenewpassword .. "') WHERE id='" .. mysql:escape_string(gameaccountID) .. "'")

		if (update) then
			outputChatBox("Você alterou sua senha para '" .. newPassword .. "'", client, 0, 255, 0)
		else
			outputChatBox("Error 100004 - Relatório em fóruns.", client, 255, 0, 0)
		end
	end
	mysql:free_result(query)
end
addEvent("cguiSavePassword", true)
addEventHandler("cguiSavePassword", getRootElement(), cguiSetNewPassword)

function timerPDUnjailPlayer(jailedPlayer)
	if(isElement(jailedPlayer)) then
		local timeServed = getElementData(jailedPlayer, "pd.jailserved", false) or 0
		local timeLeft = getElementData(jailedPlayer, "pd.jailtime", false) or 0
		local username = getPlayerName(jailedPlayer)
		if not username then
			local theTimer = getElementData(jailedPlayer, "pd.jailtimer")
			if isTimer(theTimer) then
				killTimer(theTimer)
			end
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailtimer")
			return
		end
		exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailserved", timeServed+1, false)
		local timeLeft = timeLeft - 1
		exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailtime", timeLeft, false)

		if (timeLeft<=0) then
			fadeCamera(jailedPlayer, false)
			mysql:query_free("UPDATE characters SET pdjail_time='0', pdjail='0', pdjail_station='0' WHERE charactername='" .. mysql:escape_string(username) .. "'")
			local station = getElementData(jailedPlayer, "pd.jailstation") or 1
			setElementDimension(jailedPlayer, station <= 4 and 1 or 10583)
			setElementInterior(jailedPlayer, 10)
			setCameraInterior(jailedPlayer, 10)
			
			
			setElementPosition(jailedPlayer, 241.3583984375, 115.232421875, 1003.2257080078)
			setPedRotation(jailedPlayer, 270)
				
			local theTimer = getElementData(jailedPlayer, "pd.jailtimer")
			if (theTimer) then
				killTimer(theTimer)
			end
				
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailserved", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailtime", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailtimer")
			exports['anticheat-system']:changeProtectedElementDataEx(jailedPlayer, "pd.jailstation")
			fadeCamera(jailedPlayer, true)
			outputChatBox("Seu horário foi cumprido.", jailedPlayer, 0, 255, 0)
		else
			mysql:query_free("UPDATE characters SET pdjail_time='" .. mysql:escape_string(timeLeft) .. "' WHERE charactername='" .. mysql:escape_string(username) .. "'")
		end
	end
end

function sendEditingInformation(charname)
	local result = mysql:query_fetch_assoc("SELECT description, age, weight, height, gender FROM characters WHERE charactername='" .. mysql:escape_string(charname:gsub(" ", "_")) .. "'")
	local description = tostring(result["description"])
	local age = tostring(result["age"])
	local weight = tostring(result["weight"])
	local height = tostring(result["height"])
	local gender = tonumber(result["gender"])
	
	triggerClientEvent(client, "sendEditingInformation", client, height, weight, age, description, gender)
end
addEvent("requestEditCharInformation", true)
addEventHandler("requestEditCharInformation", getRootElement(), sendEditingInformation)

function updateEditedCharacter(charname, height, weight, age, description)
	mysql:query_free("UPDATE characters SET description='" .. mysql:escape_string(description) .. "', height=" .. mysql:escape_string(height) .. ", weight=" .. mysql:escape_string(weight) .. ", age=" .. mysql:escape_string(age) .. " WHERE charactername='" .. mysql:escape_string(charname:gsub(" ", "_")) .. "'")
end
addEvent("updateEditedCharacter", true)
addEventHandler("updateEditedCharacter", getRootElement(), updateEditedCharacter)


---------------------------------
-- XBOX LIVE LOOKUPS
---------------------------------
function xboxReturn(result, player, gamertag, status, activity, lastgame, level )
	local result = tonumber(result)
	if ( result == 0 ) then
		if ( isElement(player) ) then
			triggerClientEvent(player, "CxboxFail", player)
		end
	else
		if ( isElement(player) ) then
			-- sql update
			mysql:query_free("UPDATE accounts SET liveusername='" .. mysql:escape_string(gamertag) .. "' WHERE username='" .. getElementData(player, "gameaccountusername") .. "' LIMIT 1")
			triggerClientEvent(player, "CxboxSuccess", player, gamertag, status, activity, lastgame, level)
		end
	end
end

function xboxReturnExisting(result, player, gamertag, status, activity, lastgame, level )
	local result = tonumber(result)

	if ( result == 0 ) then
		if ( isElement(player) ) then
			mysql:query_free("UPDATE accounts SET liveusername=NULL WHERE username='" .. getElementData(player, "gameaccountusername") .. "' LIMIT 1")
		end
	else
		if ( isElement(player) ) then
			triggerClientEvent(player, "CxboxSuccess", player, gamertag, status, activity, lastgame, level)
		end
	end
end

function updateAccountXbox(username)
	callRemote("http://", xboxReturn, username, client)
end
addEvent("SupdateXbox", true)
addEventHandler("SupdateXbox", getRootElement(), updateAccountXbox)


---------------------------------
-- STEAM LOOKUPS
---------------------------------
-- STATES:
-- 0 = Service Unavailable
-- 1 = Invalid Username
-- 2 = OK, but profile is private
-- 3 = OK
function steamReturn(result, player, name, nickname, online, state, game, timeplayed)
	local result = tonumber(result)
	if ( result == 0 ) then
		if ( isElement(player) ) then
			triggerClientEvent(player, "CsteamDown", player)
		end
	elseif ( result == 1 ) then
		if ( isElement(player) ) then
			triggerClientEvent(player, "CsteamFail", player)
		end
	else
		if ( isElement(player) ) then
			-- sql update
			mysql:query_free("UPDATE accounts SET steamusername='" .. mysql:escape_string(name) .. "' WHERE username='" .. getElementData(player, "gameaccountusername") .. "' LIMIT 1")
			
			if ( result == 3 ) then
				triggerClientEvent(player, "CsteamSuccess", player, name, nickname, online, state, game, timeplayed)
			else
				triggerClientEvent(player, "CsteamSuccess", player, name, nickname, online)
			end
		end
	end
end

function steamReturnExisting(result, player, name, nickname, online, state, game, timeplayed)
	local result = tonumber(result)
	if ( result == 0 ) then
		if ( isElement(player) ) then
			triggerClientEvent(player, "CsteamDown", player)
		end
	elseif ( result == 1 ) then
		if ( isElement(player) ) then
			mysql:query_free("UPDATE accounts SET steamusername=NULL WHERE username='" .. getElementData(player, "gameaccountusername") .. "' LIMIT 1")
		end
	else
		if ( isElement(player) ) then
			if ( result == 3 ) then
				triggerClientEvent(player, "CsteamSuccess", player, name, nickname, online, state, game, timeplayed)
			else
				triggerClientEvent(player, "CsteamSuccess", player, name, nickname, online)
			end
		end
	end
end

function updateAccountSteam(username)
	--callRemote("http://valhallagaming.net/mtaucp/mta/lookup_steam.php", steamReturn, username, client)
end
addEvent("SupdateSteam", true)
addEventHandler("SupdateSteam", getRootElement(), updateAccountSteam)