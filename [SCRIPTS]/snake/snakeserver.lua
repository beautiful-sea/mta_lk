mysql = exports.mysql
function startSnake (player)
	if getElementType(player) == "player" then
		triggerClientEvent(player, "startSnakeC", player)
	end
end

function stopSnake (player)
	if getElementType(player) == "player" then
		triggerClientEvent(player, "stopSnakeC", player)
	end
end

function snakeupdate(score,type)
	local acc = getElementData( source, "gameaccountusername" )
	local tsnake,hsnake
	--mysql:query_free("UPDATE accounts SET totalsnake = totalsnake + '"..mysql:escape_string(score).."' WHERE username='" .. mysql:escape_string(acc) .. "'")
	local result = mysql:query("SELECT totalsnake,highsnake FROM accounts WHERE username ='".. mysql:escape_string(acc) .. "'")
	
	while true do
		local row = exports.mysql:fetch_assoc(result)
		if not (row) then
			break
		end
		
		tsnake = tonumber(row["totalsnake"])
		hsnake = tonumber(row["highsnake"])
		
	end
	if score > hsnake then
		mysql:query_free("UPDATE accounts SET highsnake = '"..mysql:escape_string(score).."' WHERE username='" .. mysql:escape_string(acc) .. "'")
	end
	if type == 2 then
		mysql:query_free("UPDATE accounts SET totalsnake = totalsnake + '"..mysql:escape_string(score).."' WHERE username='" .. mysql:escape_string(acc) .. "'")
		outputChatBox("Your total score is "..tsnake+score.." now.",source,233,233,233)
	end
	mysql:free_result(result)
end
addEvent("updatescore", true )
addEventHandler("updatescore", getRootElement(), snakeupdate)