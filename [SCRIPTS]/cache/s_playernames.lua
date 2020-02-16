local mysql = exports.mysql
local charCache = {} 

local function secondArg( a, b )
	return b
end

local function makeName( a, b )
	-- find first and last name
	local ax, ay = a:sub( 1, a:find( "_" ) - 1 ), a:sub( secondArg( a:find( "_" ) ) + 1 )
	local bx, by = b:sub( 1, b:find( "_" ) - 1 ), b:sub( secondArg( b:find( "_" ) ) + 1 )
	
	if ay == by then
		return ax .. " & " .. bx .. " " .. by
	else
		return a .. " & " .. b
	end
end

function getCharacterName( id )
	if not charCache[ id ] then
		if not (id < 1) then
			local query = mysql:query_fetch_assoc("SELECT charactername, gender, marriedto FROM characters WHERE id = " .. mysql:escape_string(id) .. " LIMIT 1")
			if query then
				local name = query["charactername"]
				local gender = tonumber(query["gender"])
				local marriedto = tonumber(query["marriedto"])
				
				if name then
					if marriedto > 0 then
						local query = mysql:query_fetch_assoc("SELECT charactername FROM characters WHERE id = " .. mysql:escape_string(marriedto) .. " LIMIT 1")
						if query then
							local name2 = query["charactername"]
							if name2 ~= mysql_null( ) then
								if gender == 1 then
									name = makeName( name, name2 )
								else
									name = makeName( name2, name )
								end
							end
						end
					end
					charCache[ id ] = name:gsub("_", " ")
				end
			end
		else
			charCache[ id ] = false
		end
	end
	return charCache[ id ]
end

function clearCharacterName( id )
	charCache[ id ] = nil
end

function clearCharacterCache()
	charCache = { }
end