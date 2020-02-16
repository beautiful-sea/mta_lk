mysql = exports.mysql
friendname = {}
seen = {}
function getFrDetails(source)
		friendname = {}
		seen = {}
	local result = mysql:query("SELECT friend FROM friends WHERE id = '"..mysql:escape_string(getElementData(source,"gameaccountid")).."'")
		if (mysql:num_rows(result)>0) then
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				charid = tonumber(row["friend"])
				local resul = mysql:query("SELECT DATEDIFF(NOW(), lastlogin) as dayoff,lastlogin,username,country FROM accounts WHERE id = '"..mysql:escape_string(charid).."' ORDER BY dayoff DESC ")
				if (mysql:num_rows(resul)>0) then
					local row2 = mysql:fetch_assoc(resul)
					lastlogin = tonumber(row2["dayoff"])
					table.insert(friendname,1,row2["username"])
					table.insert(seen,1,lastlogin)
				end
			end
		end
		mysql:free_result( resul )
		mysql:free_result( result )
		triggerClientEvent(source,"setfriends",source,friendname,seen)
end
addEvent("getfrdetails",true)
addEventHandler("getfrdetails",getRootElement(),getFrDetails)

function getmsg(player,friendname)
		local result = mysql:query_fetch_assoc("SELECT * FROM accounts WHERE username = '" ..friendname.."'" )
			if result then
			local text = result["friendsmessage"]
			triggerClientEvent(source,"setfmsg",source,text)
			end
end
addEvent("getfrmsg",true)
addEventHandler("getfrmsg",getRootElement(),getmsg)

function delFriend(text,key,player)
		userid = getElementData(player,"gameaccountid")
		local result = mysql:query("SELECT * FROM accounts WHERE username='" .. text .. "'")
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				friendid  = tonumber(row["id"])
				delete = mysql:query_free("DELETE FROM friends WHERE id = " .. mysql:escape_string(userid) .. " AND friend = " .. mysql:escape_string(friendid) )
				
				if delete then
					triggerClientEvent(player,"doOutput",player,0,255,0,text.." deleted from your friend list.")
				end
				table.remove(friendname,key)
				table.remove(seen,key)
			end
		    getFrDetails(source)
end
addEvent("delfriend",true)
addEventHandler("delfriend",getRootElement(),delFriend)

function updatemsg(text,player)
		local result = mysql:query_free("UPDATE accounts SET friendsmessage = '" .. mysql:escape_string( text ) .. "' WHERE id = " .. mysql:escape_string(getElementData(player,"gameaccountid")) )
			if result then
				triggerClientEvent(player,"doOutput",player,0,255,0,"Your friend message updated.")
			end
end
addEvent("updatemsg",true)
addEventHandler("updatemsg",getRootElement(),updatemsg)




