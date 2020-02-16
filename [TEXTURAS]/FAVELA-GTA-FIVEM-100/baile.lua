function tele (thePlayer)
	setElementPosition ( thePlayer, 2371, -650, 128 )
	outputChatBox (' #FFFFFF' .. getPlayerName(thePlayer) .. '#FFFFFF - Foi Para O Baile Da DZ7 #000000[ #90FF55 /dz7 #000000]', root, 255, 255, 255, true)
end
addCommandHandler ( "dz7", tele )


