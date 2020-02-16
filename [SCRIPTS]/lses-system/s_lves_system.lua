mysql = exports.mysql

function playerDeath()
	if getElementData(source, "dbid") then
		local name = string.gsub(getPlayerName(source), "_", " ")
		setPlayerNametagText(source, tostring(name))
		exports['anticheat-system']:changeProtectedElementDataEx(source, "nameTint", 0)

		if getElementData(source, "adminjailed") then
			spawnPlayer(source, 263.821807, 77.848365, 1001.0390625, 270, getElementModel(source), 6, getElementData(source, "playerid")+65400, getPlayerTeam(source))
			setCameraInterior(source, 6)
			setCameraTarget(source)
			fadeCamera(source, true)
		elseif getElementData(source, "pd.jailtimer") then
		spawnPlayer (source, 225.779296875, 114.7578125, 999.015625,270,getElementModel(source),10,1,getPlayerTeam(source) )
			setCameraInterior(source,10)
			setCameraTarget(source)
			fadeCamera(source, true)
		elseif getElementData(source,"inevent") then
			spawnPlayer(source, 0, 0, 0, 270, getElementModel(source), 6, getElementData(source, "playerid")+65400, getPlayerTeam(source))
			
			exports.circus:quitevent(source)
			setCameraTarget(source)
		else

			setTimer(respawnPlayer,26000,1, source)
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), playerDeath)

function respawnPlayer(thePlayer)
	if (isElement(thePlayer)) then
		local cost = 0
		local faction = false
		if not exports.global:isPlayerSilverDonator(thePlayer) then
			local team = getPlayerTeam(thePlayer)
			if getTeamName(team) == "San Andreas Network" then
				_, cost = exports.global:takeMoney(team, math.random(10, 50), true)
				faction = getTeamName(team)
			else
				_, cost = exports.global:takeMoney(thePlayer, math.random(10, 50), true)
			end
		end
		
		local tax = exports.global:getTaxAmount()
		
		exports.global:giveMoney( getTeamFromName("Los Santos Emergency Services"), math.ceil((1-tax)*cost) )
		exports.global:giveMoney( getTeamFromName("Government of Los Santos"), math.ceil(tax*cost) )
			
		mysql:query_free("UPDATE characters SET deaths = deaths + 1 WHERE charactername='" .. mysql:escape_string(getPlayerName(thePlayer)) .. "'")

		setCameraInterior(thePlayer, 0)
		
		local text = ""
		if cost > 0 then
			text = text .. " Cost: " .. cost .. "$"
		end
		if faction then
			text = text .. ", paid by " .. faction .. "."
		end
		outputChatBox(text, thePlayer, 255, 255, 0)
		
		-- take all drugs
		local count = 0
		for i = 30, 43 do
			while exports.global:hasItem(thePlayer, i) do
				exports.global:takeItem(thePlayer, i)
				count = count + 1
			end
		end
		if count > 0 then
			outputChatBox("LSES Employee: We handed your drugs over to the LSPD Investigators.", thePlayer, 255, 194, 14)
		end
		
		local theSkin = getPedSkin(thePlayer)
		
		local theTeam = getPlayerTeam(thePlayer)
		
		local fat = getPedStat(thePlayer, 21)
		local muscle = getPedStat(thePlayer, 23)
		
		setPedStat(thePlayer, 21, fat)
		setPedStat(thePlayer, 23, muscle)

		spawnPlayer(thePlayer, 1183.291015625, -1323.033203125, 13.577140808105, 267.4580078125, theSkin, 0, 0, theTeam)
		
		fadeCamera(thePlayer, true, 6)
		triggerClientEvent(thePlayer, "fadeCameraOnSpawn", thePlayer)
	end
end

function deathRemoveWeapons(weapons, removedWeapons)
	setTimer(giveGunsBack,30000, 1, source, weapons, removedWeapons)	
end
addEvent("onDeathRemovePlayerWeapons", true)
addEventHandler("onDeathRemovePlayerWeapons", getRootElement(), deathRemoveWeapons)

function giveGunsBack(thePlayer, weapons, removedWeapons, removedWeapons2)
	outputChatBox("You have recieved treatment from the Los Santos Emergency Services.",thePlayer,255,50,50)
	if (removedWeapons~=nil) then
		if tonumber(getElementData(thePlayer, "license.gun")) == 0 and getElementData(getPlayerTeam(thePlayer),"type") ~= 2 then
		outputChatBox("LSES Employee: We have taken away weapons which you did not have a license for. (" .. removedWeapons .. ").", thePlayer, 255, 194, 14)
		else
			outputChatBox("LSES Employee: We have taken away weapons which you are not allowed to carry. (" .. removedWeapons .. ").", thePlayer, 255, 194, 14)
		end
	end
	if removedWeapons2 ~= nil then
		outputChatBox("LESES Employee: We have taken away your " .. removedWeapons2 .. " for safety purposes.", thePlayer, 255, 194, 14)
	end
	-- 28
	for key, value in ipairs(weapons) do
		local weapon = tonumber(weapons[key][1])
		local ammo = tonumber(weapons[key][2])
		local removed = tonumber(weapons[key][3])
		
		if (removed==0) then
			exports.global:giveWeapon(thePlayer, weapon, math.floor(ammo/2), false)
	
		else
			exports.global:takeWeapon(thePlayer, weapon)
			exports.logs:logMessage("[LSES Death] " .. getElementData(thePlayer, "gameaccountusername") .. "/" .. getPlayerName(thePlayer) .. " lost a weapon (" .. getWeaponNameFromID (weapon) .. "/".. tostring(ammo) .." ammo)", 28)
		end
	end
end
