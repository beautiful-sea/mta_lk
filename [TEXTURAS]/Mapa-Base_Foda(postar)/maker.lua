
basemark = createMarker ( 1215.0203857422,  -1466.80622744141 ,  23.155363845825 , "cylinder",  2.0,  0,   0,   255,  255 )




function spawnSkin (thePlayer) 
	if getElementType(thePlayer) == "player" then
       setPedSkin ( thePlayer, 265 )
       outputChatBox ("voce ganhou uma skin" , thePlayer)
    end
end


addEventHandler ("onMarkerHit" ,basemark, spawnSkin  )