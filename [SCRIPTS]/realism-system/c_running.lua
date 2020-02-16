local run = 0
local down = 0

addEventHandler( "onClientPreRender", getRootElement(), 
	function( slice )
		if ( not isPedInVehicle( getLocalPlayer( ) ) and getPedControlState( "sprint" ) ) or down > 0 then
			run = run + slice
			if run >= 40000 then
				if isPedOnGround( getLocalPlayer( ) ) then
					exports.global:applyAnimation(getLocalPlayer(), "FAT", "idle_tired", 2500, true, false, true)
					run = 19000
				else
					--toggleControl( 'sprint', false )
					--setTimer( toggleControl, 5000, 1, 'sprint', true )
					--outputChatBox("You are running too hard!",255,255,255,true)
				end
				
			end
			if not getPedControlState( "sprint" ) then
				down = math.max( 0, down - slice )
			else
				down = 500
			end
		else
			if run > 0 then
				run = math.max( 0, run - math.ceil( slice / 3 ) )
			end
		end
	end
)