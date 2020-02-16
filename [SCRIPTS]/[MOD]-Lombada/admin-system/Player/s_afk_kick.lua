function kickAFKPlayer()
	if not exports.global:isPlayerScripter(client) then
		if redirectPlayer (client,"217.18.70.176", tonumber(22003)) then
			outputDebugString ( "AFK kicker redirected player" )
		end
		
		--kickPlayer(client, getRootElement(), "Away From Keyboard")
	end
end
addEvent("AFKKick", true)
addEventHandler("AFKKick", getRootElement(), kickAFKPlayer)