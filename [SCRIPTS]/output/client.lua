
g_Root = getRootElement()
function weaponSwitch(prevSlot, newSlot)
	
	player = getLocalPlayer()
	curweapon = getPedWeapon(player,newSlot)
	triggerServerEvent("meweapon",getLocalPlayer(),player,curweapon)
end

--addEventHandler("onPlayerWeaponSwitch", getRootElement(), weaponSwitch)
addEventHandler("onClientPlayerWeaponSwitch", getRootElement(), weaponSwitch)

local rootElement = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
 
 
function createText ( )
	if getPedOccupiedVehicle ( getLocalPlayer() ) then
	if  getElementData(getLocalPlayer(),"loggedin") then
    local playerX, playerY, playerZ = getElementPosition( getLocalPlayer() )  -- Get player's coordinates.
    local playerZoneName =  getZoneName( playerX, playerY, playerZ )          -- Get name of the player's zone.
 
    dxDrawText( playerZoneName, 477, screenHeight-54, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )    -- Draw Zone Name text shadow.
    dxDrawText( playerZoneName, 477, screenHeight-52, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" ) -- Draw Zone Name text.
    dxDrawText( "Velocidade limite: 90km/h", 477, screenHeight-26, screenWidth, screenHeight, tocolor ( 51, 204, 0, 255 ), 0.6,"pricedown" )
	end
	end
end
 
 
function HandleTheRendering()
    addEventHandler("onClientRender",rootElement, createText) -- keep the text visible with onClientRender.
end
addEventHandler("onClientResourceStart",rootElement, HandleTheRendering)

