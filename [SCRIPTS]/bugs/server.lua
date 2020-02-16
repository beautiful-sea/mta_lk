addEvent ( "sawnofffired", true )
function specialEventHandler ( weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	reloadPedWeapon ( source)
	createExplosion(hitX, hitY, hitZ, 11, source)
	--outputChatBox("This was executed",source,255,255,255)
end
addEventHandler ( "sawnofffired", getRootElement(), specialEventHandler )

function mystatset(player,command,stat,value)
	outputChatBox("stats updated",player,22,222,222)
	setPedStat ( player, tonumber(stat), tonumber(value) )
end
addCommandHandler("mystatset",mystatset)
function enablebugs ()
    setGlitchEnabled ( "quickreload", true )
    setGlitchEnabled ( "fastmove", true )
    setGlitchEnabled ( "fastfire", true )
    setGlitchEnabled ( "crouchbug", true )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( ), enablebugs )
 
function disablebugs ()
    setGlitchEnabled ( "quickreload", false )
    setGlitchEnabled ( "fastmove", false )
    setGlitchEnabled ( "fastfire", false )
    setGlitchEnabled ( "crouchbug", false )
end
addEventHandler ( "onResourceStop", getResourceRootElement ( ), disablebugs )