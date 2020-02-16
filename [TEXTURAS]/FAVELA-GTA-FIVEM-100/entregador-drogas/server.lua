
local pizza = {
	{2295.654296875,-1058.5703125,49.404296875},
	{2295.654296875,-1058.5703125,49.404296875}
}

addEventHandler("onResourceStart",resourceRoot,
	function ()
		local pizPed = createPed(293,pizza[1][1],pizza[1][2],pizza[1][3],20)
		setPedFrozen ( pizPed, true )
		local pizBli = createBlip(pizza[1][1],pizza[1][2],pizza[1][3],90)
		pizMar = createMarker(pizza[2][1],pizza[2][2],pizza[2][3],"cylinder",1,255,255,0)
		setElementAlpha ( pizMar,0 )
		for _,v in pairs (getElementsByType("player")) do
			setElementData(v,"pizzaDone",0)
			setElementData(v,"pizzaOccupent",false)
		end
	end
	)

addEventHandler("onMarkerHit",root,
	function (p)
		if source == pizMar then
			triggerClientEvent(p,"onPizzaHit",resourceRoot)
		end
	end
	)

addEvent("onDone",true)
addEventHandler("onDone",root,
	function ()
		local money = math.random(1000,2500)
		givePlayerMoney(client,money)
	end
	)

addEventHandler("onResourceStop",resourceRoot,
	function ()
		for _,v in pairs (getElementsByType("player")) do
			setElementData(v,"pizzaDone",0)
			setElementData(v,"pizzaOccupent",false)
		end
	end
	)
