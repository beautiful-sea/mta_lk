function showb(thePlayer)
triggerClientEvent(thePlayer,"showp",thePlayer)
  end
addEventHandler ( "onVehicleEnter", getRootElement(),showb)
function hideb(thePlayer)
triggerClientEvent(thePlayer,"hidep",thePlayer)
  end
addEventHandler ( "onVehicleExit", getRootElement(),hideb)