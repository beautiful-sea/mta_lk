function tele (thePlayer)
	setElementPosition ( thePlayer, 2350, -1020, 61 )
	outputChatBox (' #FFFFFF' .. getPlayerName(thePlayer) .. '#FFFFFF - Foi Para Favela De Paraisópolis #000000[ #90FF55 /favela #000000]', root, 255, 255, 255, true)
end
addCommandHandler ( "favela", tele )


blip_cv = createBlip (2424.75390625,-759.0361328125,115.559 ,23, 25, 255,  0,  0, 255)
setElementData(blip_cv,"blipName", "Favela da Rocinha")
