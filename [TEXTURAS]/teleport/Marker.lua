
createObject(16150,-1129.2109375,-1619.14453125,76.3671875,0,0,271.13848876953
	)
local entrada = createMarker(2592.499, -1291.536, 34.955, 'cylinder', 1.0, 0, 255, 255, 0 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 2591.118, -1289.247, 24.555)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(2592.487, -1291.414, 24.555, 'cylinder', 1.0, 0, 255, 255, 0 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 2590.626, -1288.828, 34.955)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


