mysql = exports.mysql
local noseatbelt =
{
	[448] = true, [461] = true, [462] = true, [463] = true, [481] = true, [509] = true, [510] = true, [521] = true, [522] = true, [581] = true, [586] = true, -- bikes
	[430] = true, [446] = true, [452] = true, [453] = true, [454] = true, [472] = true, [473] = true, [484] = true, [493] = true, [595] = true, -- boats
	[424] = true, [457] = true, [471] = true, [539] = true, [568] = true, [571] = true -- recreational vehicles
}
function throwPlayerThroughWindow(x, y, z)
if not getElementData ( source, "seatbelt",true) then
	exports['anticheat-system']:changeProtectedElementDataEx(source, "realinvehicle", 0, false)
	removePedFromVehicle(source, vehicle)
	--setElementPosition(source, x, y, z)
	setPedAnimation(source, "CRACK", "crckdeth2", 10000, true, false, false)
		 fadeCamera (source, false, 1.0, 0, 0, 0 )  
 	setTimer ( fadeCamera, 2000, 1,source, true, 2.0 )
	setTimer(setPedAnimation, 10005, 1, source)
end
end
addEvent("crashThrowPlayerFromVehicle", true)
addEventHandler("crashThrowPlayerFromVehicle", getRootElement(), throwPlayerThroughWindow)

function seats(player)
   if getPedOccupiedVehicle ( player ) then
	local veh = getPedOccupiedVehicle ( player )
	if noseatbelt[ getElementModel( veh ) ] then
		return
	end
	if not getElementData ( player, "seatbelt",true) then
		setElementData ( player, "seatbelt",true)
               
		exports.global:sendLocalMeAction(player, "reaches for their seatbelt and buckles it.")
	else
		
		setElementData ( player, "seatbelt" ,false)
		exports.global:sendLocalMeAction(player, "reaches for their seatbelt and unbuckles it.")
	end
end
end
addCommandHandler("seatbelt",seats)

function check(players)
	if  getElementData ( players,"seatbelt",true) then
		setElementData ( players, "seatbelt",false)
		exports.global:sendLocalMeAction(players, "reaches for their seatbelt and unbuckles it.")
		cancelEvent () 
		 
	end
end
addEventHandler ( "onVehicleStartExit", getRootElement(),check)

-- FIX FOR SEATBELT BUG
function check(players)
	if  getElementData ( players,"seatbelt",true) then
		setElementData ( players, "seatbelt",false)
		 
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(),check)

function checkbelt( thePlayer, commandName, targetPlayerName )
	local theTeam = getPlayerTeam(thePlayer)
	local factionType = getElementData(theTeam, "type")
	if (factionType==2) then
		if targetPlayerName then
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if targetPlayer then
				--if getEleamentData( targetPlayer, "loggedin" ) == 1 then
					if getElementData( targetPlayer,"seatbelt",true )  then
						outputChatBox(targetPlayerName.." is wearing his seatbelt.", thePlayer, 0, 255, 0 )
					else
						outputChatBox(targetPlayerName.." is not wearing his seatbelt.", thePlayer, 255, 255, 0 )
		
					end
				--else
					--outputChatBox( "Player is not logged in.", thePlayer, 255, 0, 0 )
				--end
			end
		else
			outputChatBox( "SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14 )
		end
	end
end
addCommandHandler("checkbelt",checkbelt)

