spawnar = createMarker(1254.9000244141, -1419, 13.60000038147 -1, "cylinder", 3.0, 0, 0, 255, 78)--mude as cordenadas do maker de spawn
destruir = createMarker(1254.9000244141, -1423.5, 13.60000038147 -1, "cylinder", 3.0, 255, 0, 0, 78)--mude as cordenadas do maker de destruir

veh = {}
function spaw (source)
    if isElementWithinMarker(source, spawnar) then 
    if veh[source] and isElement( veh[source] ) then destroyElement ( veh[source] )
    veh[source] = nil
end
    local name = getPlayerName(source)
    veh[source] = createVehicle(598, 2711.4313964844,-1843.955078125,9.5124101638794, -0, 0, 159.99923706055)
    warpPedIntoVehicle ( source, veh[source] )
      outputChatBox("#FF4500[SERVER] #838B83A viatura da (corp) foi spawnada ao player "..name, player, 0,255,0,true)
end
end
addEventHandler("onMarkerHit", spawnar, spaw)

function dest (source)
    if veh[source] and isElement(veh[source]) then
    destroyElement (veh[source])
    local name = getPlayerName(source)
    outputChatBox("#FF4500[SERVER] #838B83A viatura da (corp) foi destruida!", player, 0,255,0,true)
end
end
addEventHandler("onMarkerHit", destruir, dest)