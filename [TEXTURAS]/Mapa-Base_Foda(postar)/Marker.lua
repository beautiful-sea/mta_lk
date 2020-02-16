local entrada = createMarker(1230.099609375, -1419.400390625 ,13.5, 'arrow', 1.0, 255, 165, 0, 255 )

  iniblit = createBlipAttachedTo(entrada, 30) 
function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1230, -1422.9000244141, 20.299999237061)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(1230.1999511719, -1419.4000244141, 20.299999237061, 'arrow', 1.0, 255, 0, 0, 255 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1230.4000244141, -1422.4000244141, 13.5)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


--============================================================================================


local entrada = createMarker(1228.3000488281, -1417.5, 20.299999237061, 'arrow', 1.0, 255, 165, 0, 255 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1225.38269, -1417.68982, 24.3553)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(1228.3000488281, -1417.5999755859, 24.39999961853, 'arrow', 1.0, 255, 0, 0, 255 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1224.3000488281, -1418.1999511719, 20.299999237061)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


--============================================================================================


local entrada = createMarker(1230.0999755859, -1419.4000244141, 24.39999961853, 'arrow', 1.0, 255, 165, 0, 255 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1230.1999511719, -1423.3000488281, 28.5)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(1230.3000488281, -1419.3000488281, 28.5, 'arrow', 1.0, 255, 0, 0, 255 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1230, -1422.6999511719, 24.39999961853)
        end
end
addEventHandler( "onMarkerHit", saida , sair )


--============================================================================================


local entrada = createMarker(1228.4000244141, -1417.4000244141, 13.5, 'arrow', 1.0, 255, 165, 0, 255 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1212.4000244141, -1417.5, -67.900001525879)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(1208.9000244141, -1417.3000488281, -67.900001525879, 'arrow', 1.0, 255, 0, 0, 255 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 1225.9000244141, -1417.5999755859, 13.5)
        end 
end
addEventHandler( "onMarkerHit", saida , sair )



