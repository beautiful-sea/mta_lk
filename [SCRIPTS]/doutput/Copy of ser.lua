otext = { }
function insert(player,text)
		table.insert(otext,text)
		setElementData(player,"otext",otext)
end
addEvent("addtext",true)
addEventHandler("addtext",getRootElement(),insert)


function remove(player,text)
	table.remove(otext,1)
	setElementData(player,"otext",otext)
end
addEvent("removetext",true)
addEventHandler("removetext",getRootElement(),remove)

function reset()
	otext = { }
	setElementData(player,"otext",otext)
end
addEventHandler("onPlayerQuit",getRootElement(),reset)

function rreset()
	otext = { }
	setElementData(getRootElement(),"otext",otext)
end
addEventHandler("onResourceStart",getResourceRootElement(),rreset)

function checktale(player)
	for key, value in ipairs( otext ) do
		outputChatBox(key,player,255,255,255)
	end
end
addCommandHandler("checkt",checktale)

