addEvent("onPlayerBuyItemInTeleport",true)
addEventHandler("onPlayerBuyItemInTeleport",root,
function(price)
	takePlayerMoney(source, tonumber(price))
end)