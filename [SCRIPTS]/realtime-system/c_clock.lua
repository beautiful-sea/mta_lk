function updateHudClock()
	-- 			watch											cellphone                                      PDA
	if exports.global:hasItem(getLocalPlayer(), 17) or exports.global:hasItem(getLocalPlayer(), 2) or exports.global:hasItem(getLocalPlayer(), 96) then
		setPlayerHudComponentVisible("clock", true)
	else
		setPlayerHudComponentVisible("clock", false)
	end
end
addEvent ( "updateHudClock", true )
addEventHandler ( "updateHudClock", getRootElement(), updateHudClock )