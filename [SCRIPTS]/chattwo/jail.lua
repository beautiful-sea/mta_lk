--[[
Copyright (c) 2010 ShoDown Gaming.
This script may not be used without permission under any circumstance's.
]]
local text1 = ""
local text2 = ""
function updatechat()
	local result = exports.sql:query_assoc( "SELECT text FROM chat WHERE id = 1" )
	
	for key, valu in ipairs( result ) do
		text2 = valu.text
	end
	if text2~= text1 then
		outputChatBox("[@DMserver] "..text2,getRootElement(),255,255,255)
		text1= text2
	end
end
function onResourceStart(thisResource)
  	setTimer ( updatechat,1000, 0 )
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), onResourceStart )
function dm(source,command,...)
	local message = table.concat( { ... }, " " )
	if #message > 0 then
		message = getPlayerName(source)..": "..message
		outputChatBox(message,getRootElement(),22,222,222)
		exports.sql:query_free( "UPDATE chat SET text = '%s' WHERE id = 2", message )
	end
end
addCommandHandler("dm",dm)