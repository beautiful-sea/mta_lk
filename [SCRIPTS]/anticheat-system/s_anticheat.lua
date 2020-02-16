function showSpeedToAdmins(velocity)
	kph = math.ceil(velocity * 1.609344)
	exports.global:sendMessageToAdmins("[Possible Speedhack/HandlingHack] " .. getPlayerName(client) .. ": " .. velocity .. "Mph/".. kph .." Kph")
end
addEvent("alertAdminsOfSpeedHacks", true)
addEventHandler("alertAdminsOfSpeedHacks", getRootElement(), showSpeedToAdmins)

function showDMToAdmins(kills)
	exports.global:sendMessageToAdmins("[Possible DeathMatching] " .. getPlayerName(client) .. ": " .. kills .. " kills in <=2 Minutes.")
end
addEvent("alertAdminsOfDM", true)
addEventHandler("alertAdminsOfDM", getRootElement(), showDMToAdmins)

-- [MONEY HACKS]
function scanMoneyHacks()
	local tick = getTickCount()
	local hackers = { }
	local hackersMoney = { }
	local counter = 0
	
	local players = exports.pool:getPoolElementsByType("player")
	for key, value in ipairs(players) do
		local logged = getElementData(value, "loggedin")
		if (logged==1) then
			if not (exports.global:isPlayerAdmin(value)) then -- Only check if its not an admin...
				
				local money = getPlayerMoney(value)
				local truemoney = exports.global:getMoney(value)
				if (money) then
					if (money~=truemoney) then
						counter = counter + 1
						hackers[counter] = value
						hackersMoney[counter] = (money-truemoney)
					end
				end
			end
		end
	end
	local tickend = getTickCount()

	local theConsole = getRootElement()
	for key, value in ipairs(hackers) do
		local money = hackersMoney[key]
		local accountID = getElementData(value, "gameaccountid")
		local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
		outputChatBox("AntiCheat: " .. targetPlayerName .. " was auto-banned for Money Hacks. (" .. tostring(money) .. "$)", getRootElement(), 255, 0, 51)
		
		--local ban = banPlayer(value, true, false, false, getRootElement(), "Money Hacks. (" .. tostring(money) .. "$)")
	end
end
setTimer(scanMoneyHacks, 3600000, 0) -- Every 60 minutes

-- [WEAPON HACKS]
-- wrapper functions
function giveSafeWeapon(player, weapon, ammo, ascurrent)
	if (isElement(player)) then
		triggerClientEvent(player, "giveSafeWeapon", player, weapon, ammo)
		return giveWeapon(player, weapon, ammo, ascurrent)
	end
end

function setSafeWeaponAmmo(player, weapon, ammo, inclip)
	triggerClientEvent(player, "setSafeWeaponAmmo", player, weapon, ammo)
	return setWeaponAmmo(player, weapon, ammo, inclip)
end

function takeAllWeaponsSafe(player)
	triggerClientEvent(player, "takeAllWeaponsSafe", player)
	return takeAllWeapons(player)
end

function takeWeaponSafe(player, weapon)
	triggerClientEvent(player, "takeWeaponSafe", player, weapon)
	return takeWeapon(player, weapon)
end

function notifyWeaponHacks(weapon, actualammo, expectedammo, strikes)
	-- take away the ammo
	if expectedammo == 0 then
		takeWeapon(client, weapon)
	else
		takeWeapon(client, weapon, actualammo - expectedammo)
	end
	
	-- tell people
	adminmsg = "[Weapon Hacks] " .. getPlayerName(client) .. " (" .. strikes .. " times) - " .. getWeaponNameFromID(weapon) .. " (" .. actualammo .. " ammo, expected " .. expectedammo .. ")"
	exports.global:sendMessageToAdmins(adminmsg)
	outputServerLog(adminmsg)
	exports.logs:logMessage(adminmsg, 12)
	
	--[[ TODO: Make sure it's working correctly before auto-banning people
	if strikes >= 3 then
		outputChatBox("ACBan: AntiCheat banned " .. getPlayerName(client) .. ". (Permanent)", getRootElement(), 255, 0, 51)
		
		reason = "Weapon Hacks. (" .. getWeaponNameFromID(weapon) .. ")"
		outputChatBox("ACBan: Reason: " .. reason .. ".", getRootElement(), 255, 0, 51)
		
		banPlayer(client, true, false, false, getRootElement(), reason)
	end]]
end
addEvent("notifyWeaponHacks", true)
addEventHandler("notifyWeaponHacks", getRootElement(), notifyWeaponHacks)