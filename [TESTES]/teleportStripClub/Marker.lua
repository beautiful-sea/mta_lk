local entrada = createMarker(2582.85546875,-948.13037109375,81.385246276855, 'cylinder', 1.0, 0, 255, 255, 0 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 2600.5654296875,-1024.2928466797,1004.5531005859)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(2600.5139160156, -1027.7296142578, 1004.560546875, 'cylinder', 1.0, 0, 255, 255, 0 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 2585.82421875, -947.9716796875, 81.39249420166)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


