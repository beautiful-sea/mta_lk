function getAdmins()
	local players = exports.pool:getPoolElementsByType("player")
	
	local admins = { }
	local count = 1
	
	for key, value in ipairs(players) do
		if isPlayerAdmin(value) and getPlayerAdminLevel(value) <= 6 then
			admins[count] = value
			count = count + 1
		end
	end
	return admins
end

function getStaff()
	local players = exports.pool:getPoolElementsByType("player")
	
	local admins = { }
	local count = 1
	
	for key, value in ipairs(players) do
		if isPlayerAdmin(value) or getElementData(value,"helper") >=1   then
			admins[count] = value
			count = count + 1
		end
	end
	return admins
end

function isPlayerAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 1
end

function isPlayerFullAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 2
end

function isPlayerSuperAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 3
end

function isPlayerHeadAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 5
end

function isPlayerLeadAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 4
end
function isPlayerOwner(thePlayer)
	return getPlayerAdminLevel(thePlayer) == 6
end


function getPlayerAdminLevel(thePlayer)
	return isElement( thePlayer ) and tonumber(getElementData(thePlayer, "adminlevel")) or 0
end

local titles = { "Trial Admin", "Admin", "Super Admin", "Lead Admin", "Head Admin", "Owner", nil, nil, nil, "Scripter" }
function getPlayerAdminTitle(thePlayer)
	local text = titles[getPlayerAdminLevel(thePlayer)] or "Player"
	
	local hiddenAdmin = getElementData(thePlayer, "hiddenadmin") or 0
	if (hiddenAdmin==1) then
		text = text .. " (Hidden)"
	end

	return text
end


local scripterAccounts = {
	et2 = true
}
function isPlayerScripter(thePlayer)
	return getElementType(thePlayer) == "console" or scripterAccounts[thePlayer] or scripterAccounts[ getElementData(thePlayer, "gameaccountusername") or "nobody" ] or false
end
