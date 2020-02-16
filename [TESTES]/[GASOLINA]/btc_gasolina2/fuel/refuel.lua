local fuelPrice = nil
local createBlips = true
local BuyCan = { }
local sx, sy = guiGetScreenSize ( )

setTimer ( function ( )

local fuelBlips = { }
for i, v in pairs ( fuelLocations ) do 
	if ( blip and createBlips ) then
		fuelBlips[i] = createBlip ( x, y, z, 55, 55, 255, 255, 255, 255, 0, 370 )
		setElementData(fuelBlips[i],"blipName", "Posto de gasolina")
	end
end
end, 500, 1 )

--[[
-- buy fuel cans
function openBuyWindow ( )
	BuyCan.window = guiCreateWindow((sx/2-359/2), (sy/2-193/2), 359, 193, "Galão de combustível", false)
	guiWindowSetSizable(BuyCan.window, false)
	BuyCan.Image = guiCreateStaticImage(10, 28, 100, 142, "fuel/fuel_icon.png", false, BuyCan.window)
	BuyCan.Label = guiCreateLabel(128, 28, 215, 85, "Você gostaria de comprar um Galão de combustível por R$250\n\nGalão de combustível reabastecem 10% de um combustível de veículos no local.", false, BuyCan.window)
	guiLabelSetHorizontalAlign ( BuyCan.Label, "left", true )
	BuyCan.Buy = guiCreateButton(249, 134, 94, 36, "Comprar Galão", false, BuyCan.window)
	BuyCan.Close = guiCreateButton(149, 134, 94, 36, "Fechar", false, BuyCan.window)
	showCursor ( true )
	
	addEventHandler ( "onClientGUIClick", BuyCan.Close, closeBuyWindow )
	addEventHandler ( "onClientGUIClick", BuyCan.Buy, onClientBuyFuelCan )
end

function closeBuyWindow ( )
	if ( isElement ( BuyCan.Close ) ) then
		removeEventHandler ( "onClientGUIClick", BuyCan.Buy, closeBuyWindow )
		destroyElement ( BuyCan.Close )
	end if ( isElement ( BuyCan.Buy ) ) then
		removeEventHandler ( "onClientGUIClick", BuyCan.Buy, onClientBuyFuelCan )
		destroyElement ( BuyCan.Buy )
	end if ( isElement ( BuyCan.window ) ) then
		destroyElement ( BuyCan.window )
	end
	showCursor ( false )
end

function onClientBuyFuelCan ( )
	if ( getPlayerMoney ( ) < 250 ) then
		return 
		--exports.NGMessages:sendClientMessage ( "You don't have enough money for a fuel can", 255, 0, 0 ),
		exports.GTIhud:dm("Você não tem dinheiro suficiente para uma lata de combustível.", 255, 125, 0)
	end

	local userItems = getElementData ( localPlayer, "galao" ) or 0
	
	if userItems >= 20 then 
	setElementData ( localPlayer, "galao", 20 )
	exports.GTIhud:dm("você não pode mais comprar galão ( limite de galão 20 )", 0, 255, 0)
	return 
	end
		
	setElementData ( localPlayer, "galao", userItems + 1 )
	exports.GTIhud:dm("Você comprou uma lata de combustível por R$: 250. Pressione ( B ) abra sua mochila para usá-lo em um veículo.", 255, 125, 0)
	triggerServerEvent ( "NGFuel:takeMoney", localPlayer, 250 )
end
]]--
