local warnings = {
	[20]=true,
	[15]=true,
	[10]=true,
	[7]=true,
	[5]=true,
	[2]=true,
}

setTimer ( function ( ) 
	for i, v in ipairs ( getElementsByType ( 'vehicle' ) ) do 

		if (getVehicleType(v) == "train") then return end

		local fuel = tonumber(getElementData ( v, "veh:fuel" ) or 0)
	--	if not fuel then
	--		setElementData ( v, "veh:fuel", 75 )
	--		fuel = 75
	--	end
		local speed = getVehicleSpeed ( v, "kph" )
		if ( fuel >= 1 and speed > 0 and getVehicleOccupant ( v ) ) then
			setElementData ( v, "veh:fuel", fuel - 1 )
			local fuel = fuel - 1
			if ( warnings[fuel] ) then
				--exports['NGMessages']:sendClientMessage ( "Atenção, seu combustível está ficando baixo, está em "..tostring(fuel).."%", getVehicleOccupant ( v ), 255, 0, 0 )
				
				exports.btc_hud:dm("Atenção, seu combustível está ficando baixo, está em "..tostring(fuel).."%", getVehicleOccupant ( v ), 255, 125, 0)
							
							
			end
		end
		
	end
end, 15000, 0 )


function getVehicleSpeed ( tp, md )
	local md = md or "kph"
	local sx, sy, sz = getElementVelocity ( tp )
	local speed = math.ceil( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 )
	local speed1 = math.ceil( ( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 ) / 1.61 )
	if ( md == "kph" ) then
		return speed;
	else
		return speed1;
	end
end