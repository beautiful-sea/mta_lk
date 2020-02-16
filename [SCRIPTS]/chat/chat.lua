

-- getPlayerName with spaces instead of _ for player names
local _getPlayerName = getPlayerName
local getPlayerName = function( x ) return _getPlayerName( x ):gsub( "_", " " ) end

-- addCommandHandler supporting arrays as command names (multiple commands with the same function)
local addCommandHandler_ = addCommandHandler
      addCommandHandler  = function( commandName, fn, restricted, caseSensitive )
	-- add the default command handlers
	if type( commandName ) ~= "table" then
		commandName = { commandName }
	end
	for key, value in ipairs( commandName ) do
		if key == 1 then
			addCommandHandler_( value, fn, restricted, caseSensitive )
		else
			addCommandHandler_( value,
				function( player, ... )
					-- check if he has permissions to execute the command, default is not restricted (aka if the command is restricted - will default to no permission; otherwise okay)
					if hasObjectPermissionTo( player, "command." .. commandName[ 1 ], not restricted ) then
						fn( player, ... )
					end
				end
			)
		end
	end
end

-- returns all players within <range> units away <from>
local function getPlayersInRange( from, range )
	local x, y, z = getElementPosition( from )
	local dimension = getElementDimension( from )
	local interior = getElementInterior( from )
	
	local t = { }
	for key, value in ipairs( getElementsByType( "player" ) ) do
		if getElementDimension( value ) == dimension and getElementInterior( value ) == interior then
			local distance = getDistanceBetweenPoints3D( x, y, z, getElementPosition( value ) )
			if distance < range then
				t[ value ] = distance
			end
		end
	end
	if getElementType( from ) == "player" then
		local vehicle = getPedOccupiedVehicle( from )
		if vehicle then
			local passengers = getVehicleMaxPassengers( vehicle )
			if type( passengers ) == 'number' then
				for seat = 0, passengers do
					local value = getVehicleOccupant( vehicle, seat )
					if value then
						t[ value ] = 0
					end
				end
			end
		end
	end
	return t
end

-- calculate chat colors based on distance
local function calculateColor( color, color2, distance, range )
	return color - math.floor( ( color - color2 ) * ( distance / range ) )
end

local function calculateColors( r, r2, g, g2, b, b2, distance, range )
	if range <= 0 then
		range = 0.01
	end
	return calculateColor( r, r2, distance, range ), calculateColor( g, g2, distance, range ), calculateColor( b, b2, distance, range )
end

-- sends a ranged message
local function localMessage( from, message, r, g, b, range, r2, g2, b2 )
	range = range or 20
	r2 = r2 or r
	g2 = g2 or g
	b2 = b2 or b
	
	for player, distance in pairs( getPlayersInRange( from, range ) ) do
		outputChatBox( message, player, calculateColors( r, r2, g, g2, b, b2, distance, range ) )
	end
end

local function localizedMessage( from, prefix, message, r, g, b, range, r2, g2, b2 )
	if type( range ) == 'table' then
		r2 = r
		g2 = g
		b2 = b
	else
		range = range or 20
		r2 = r2 or r
		g2 = g2 or g
		b2 = b2 or b
	end
	
	local language = exports.players:getCurrentLanguage( from )
	local skill = exports.players:getLanguageSkill( from, language )
	if language and skill then
		if #message >= 4 and message:sub( 1, 1 ) == "#" and exports.players:isValidLanguage( message:sub( 2, 3 ) ) and message:sub( 4, 4 ) == " " then
			language = message:sub( 2, 3 )
			skill = exports.players:getLanguageSkill( from, language )
			if not skill then
				outputChatBox( "(( You do not speak " .. exports.players:getLanguageName( language ) .. ". ))", from, 255, 0, 0 )
				return
			else
				-- it's a language the player speaks!
				message = message:sub( 5 )
			end
		end
		prefix = " [" .. exports.players:getLanguageName( language ) .. "]" .. prefix
		
		for player, distance in pairs( type( range ) == "table" and range or getPlayersInRange( from, range ) ) do
			if type( range ) == "table" then
				player = distance
				distance = 0
			end
			local new = message
			if from ~= player then
				-- check how much the player should understand
				local playerSkill = exports.players:getLanguageSkill( player, language )
				if not playerSkill then
					playerSkill = 0
				else
					if playerSkill < 1000 then
						-- increase skill - long messages give more skill!
						if math.random( math.max( 1, math.ceil( playerSkill * 30 / #message ) ) ) == 1 then
							if exports.players:increaseLanguageSkill( player, language ) then
								playerSkill = playerSkill + 1
							end
						end
					end
					playerSkill = math.floor( ( 2 * playerSkill + skill ) / 3 ) 
				end
				
				-- make a part not understandable
				local scramble = #message - math.floor( #message * playerSkill / 875 ) -- a bit tolerancy - max is 1000 actually, but we want people with pretty good languages to understand us fully
				if scramble > 0 then
					new = ""
					for i = 1, scramble do
						local char = message:sub( i, i )
						if char >= "a" and char <= "z" then
							new = new .. string.char( math.random( string.byte( "a" ), string.byte( "z" ) ) )
						elseif char >= "A" and char <= "Z" then
							new = new .. string.char( math.random( string.byte( "A" ), string.byte( "Z" ) ) )
						else
							new = new .. char
						end
					end
					
					new = new .. message:sub( scramble + 1 )
				end
			end
			
			outputChatBox( prefix .. new, player, calculateColors( r, r2, g, g2, b, b2, distance, type( range ) == "table" and 1 or range ) )
		end
	else
		outputChatBox( "(( Pressione 'L' para selecionar um idioma. ))", from, 255, 0, 0 )
	end
end
function localizedMessage2( from, prefix, message, r, g, b, range, r2, g2, b2 )
	if type( range ) == 'table' then
		r2 = r
		g2 = g
		b2 = b
	else
		range = range or 20
		r2 = r2 or r
		g2 = g2 or g
		b2 = b2 or b
	end
	if #message >= 4 and message:sub( 1, 1 ) == "#"  and message:sub( 4, 4 ) == " " then
		message = message:sub( 5 )
	end
	prefix = "" .. prefix
		
	for player, distance in pairs( type( range ) == "table" and range or getPlayersInRange( from, range ) ) do
		if type( range ) == "table" then
			player = distance
			distance = 0
		end
		local new = message
		outputChatBox( prefix .. new, player, calculateColors( r, r2, g, g2, b, b2, distance, type( range ) == "table" and 1 or range ) )
	end

end



