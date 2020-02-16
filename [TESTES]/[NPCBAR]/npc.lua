  
addEventHandler ( "onResourceStart", root, 
function () 

end 
) 

function bot(thePlayer)
	bot1 = exports["slothbot"]:spawnBot (2467.765625,-963.2763671875,80.251037597656,80.072326660156,1) 
	exports["slothbot"]:setBotAttackEnabled ( bot1 , false )
	exports["slothbot"]:setBotFollow ( bot1 , thePlayer )
end

addCommandHandler("mkbot",bot)