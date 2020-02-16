mysql = exports.mysql

function removeplayer( )
	playerid = getElementData (source, "playerid" ) or 0
	delete = mysql:query_free("DELETE FROM ucp WHERE id='" .. mysql:escape_string(playerid) .. "' LIMIT 1")
end
addEventHandler( "onPlayerQuit", getRootElement(),removeplayer)

function updateplayer(oldNick, newNick)
	playerid = getElementData (source, "playerid" ) or 0
	update = mysql:query_free("UPDATE ucp SET name= '"..newNick.."' WHERE id ='"..playerid.."'")
end
addEventHandler( "onPlayerChangeNick", getRootElement(),updateplayer)

function addplayer( )
	playerid = getElementData (source, "playerid" ) or 0
	playername = getPlayerName(source)
	playerping = getPlayerPing(source)
	local result = mysql:query("SELECT * FROM ucp WHERE id='"..playerid.."' ")
		if (mysql:num_rows(result)>0) then	return	end
	local id = mysql:query_insert_free("INSERT INTO ucp SET id='" .. playerid .. "', name='" .. playername .. "', ping='" .. playerping .. "'")

end
addEventHandler( "onPlayerJoin",getRootElement(),addplayer)

function refreshp( )
	delete = mysql:query_free("DELETE FROM ucp")
	if delete then
		outputDebugString("Deleted")
	end
	players = getElementsByType("player")
	for k,v in ipairs(players) do 
	playerid = getElementData (v, "playerid" ) or 0
	playername = getPlayerName(v)
	playerping = getPlayerPing(v)
	local result = mysql:query("SELECT * FROM ucp WHERE id='"..playerid.."' ")
	local id = mysql:query_insert_free("INSERT INTO ucp SET id='" .. playerid .. "', name='" .. playername .. "', ping='" .. playerping .. "'")
	end
	
end
--addCommandHandler("refreshsb",refreshp)
addEventHandler( "onResourceStart",getResourceRootElement(),refreshp)