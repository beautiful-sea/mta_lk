----------
--==================================================--
-------------------------CASA-------------------------
--==================================================--
createBlip(2583.096, -948.025, 83.889,39)
MarkerCAS = createMarker ( 2582.891, -947.91, 81.385, "arrow", 1.5, 255, 255, 255, 255 )
MarkerSAID = createMarker ( 1204.8193359375,-13.8525390625,1000.921875, "arrow", 1.5, 255, 255, 255, 255 ) 
setElementInterior(MarkerSAID, 2)

function IntSTAFF(thePlayer)
	if source == MarkerCAS then
		triggerClientEvent ( thePlayer, "jogadorEntrou", thePlayer )
		fadeCamera(thePlayer, false)
		setTimer( fadeCamera, 1000, 1, thePlayer, true)
		setTimer(setElementInterior, 1000, 1, thePlayer, 2)
		setTimer(setElementPosition, 1000, 1, thePlayer, 1204.9775390625,-11.529296875,1000.921875, true)
		setTimer(setPedRotation, 1000, 1, thePlayer, 0)
	end
end
addEventHandler("onMarkerHit", getRootElement(), IntSTAFF)

function SaidSTAFF(thePlayer)
	if source == MarkerSAID then
		triggerClientEvent ( thePlayer, "jogadorSaiu", thePlayer )
		fadeCamera(thePlayer, false)
		setTimer( fadeCamera, 1000, 1, thePlayer, true)
		setTimer(setElementInterior, 1000, 1, thePlayer, 0)
		setTimer(setElementPosition, 1000, 1, thePlayer, 2587.4423828125,-948.087890625,81.396446228027, true)
		setTimer(setPedRotation, 1000, 1, thePlayer, 135)
	end
end
addEventHandler("onMarkerHit", getRootElement(), SaidSTAFF)

