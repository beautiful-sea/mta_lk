mysql = exports.mysql

--TAX
tax = 15 -- percent
function getTaxAmount()
	return tax / 100
end
function setTaxAmount(new)
	tax = math.max( 0, math.min( 30, math.ceil( new ) ) )
	mysql:query_free("UPDATE settings SET value = " .. tax .. " WHERE name = 'tax'" )
end

--INCOME TAX
incometax = 10 -- percent
function getIncomeTaxAmount()
	return incometax / 100
end
function setIncomeTaxAmount(new)
	incometax = math.max( 0, math.min( 25, math.ceil( new ) ) )
	mysql:query_free("UPDATE settings SET value = " .. incometax .. " WHERE name = 'incometax'" )
end

-- load income and normal tax on startup
addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		local result = mysql:query("SELECT value FROM settings WHERE name = 'tax'" )
		if result then
			if mysql:num_rows( result ) == 0 then
				mysql:query_free("INSERT INTO settings (name, value) VALUES ('tax', " .. tax .. ")" )
			else
				local row = mysql:fetch_assoc(result)
				tax = tonumber( row["value"] ) or 15
			end
			mysql:free_result( result )
		end
		
		local result = mysql:query( "SELECT value FROM settings WHERE name = 'incometax'" )
		if result then
			if mysql:num_rows( result ) == 0 then
				mysql:query_free("INSERT INTO settings (name, value) VALUES ('incometax', " .. incometax .. ")" )
			else
				local row = mysql:fetch_assoc(result)
				incometax = tonumber( row["value"] ) or 10
			end
			mysql:free_result( result )
		end
	end
)

-- ////////////////////////////////////

function giveMoney(thePlayer, amount)
	amount = tonumber( amount ) or 0
	if amount == 0 then
		return true
	elseif thePlayer and isElement(thePlayer) and amount > 0 then
		amount = math.floor( amount )
		
		setElementData(thePlayer, "money", getMoney( thePlayer ) + amount )
		if getElementType(thePlayer) == "player" then
			mysql:query_free("UPDATE characters SET money = money + " .. amount .. " WHERE id = " .. getElementData( thePlayer, "dbid" ) )
			givePlayerMoney( thePlayer, amount )
		elseif getElementType(thePlayer) == "team" then
			mysql:query_free("UPDATE factions SET bankbalance = bankbalance + " .. amount .. " WHERE id = " .. getElementData( thePlayer, "id" ) )
		end
		return true
	end
	return false
end

function takeMoney(thePlayer, amount, rest)
	amount = tonumber( amount ) or 0
	if amount == 0 then
		return true, 0
	elseif thePlayer and isElement(thePlayer) and amount > 0 then
		amount = math.ceil( amount )
		
		local money = getMoney( thePlayer )
		if rest and amount > money then
			amount = money
		end
		
		if amount == 0 then
			return true, 0
		elseif hasMoney(thePlayer, amount) then
			setElementData(thePlayer, "money", money - amount )
			if getElementType(thePlayer) == "player" then
				mysql:query_free("UPDATE characters SET money = money - " .. amount .. " WHERE id = " .. getElementData( thePlayer, "dbid" ) )
				takePlayerMoney( thePlayer, amount )
			elseif getElementType(thePlayer) == "team" then
				mysql:query_free("UPDATE factions SET bankbalance = bankbalance - " .. amount .. " WHERE id = " .. getElementData( thePlayer, "id" ) )
			end
			return true, amount
		end
	end
	return false, 0
end

function setMoney(thePlayer, amount)
	amount = tonumber( amount ) or 0
	if thePlayer and isElement(thePlayer) and amount >= 0 then
		amount = math.floor( amount )
		
		setElementData(thePlayer, "money", amount )
		if getElementType(thePlayer) == "player" then
			mysql:query_free("UPDATE characters SET money = " .. amount .. " WHERE id = " .. getElementData( thePlayer, "dbid" ) )
			setPlayerMoney( thePlayer, amount )
		elseif getElementType(thePlayer) == "team" then
			mysql:query_free("UPDATE factions SET bankbalance = " .. amount .. " WHERE id = " .. getElementData( thePlayer, "id" ) )
		end
		return true
	end
	return false
end

function hasMoney(thePlayer, amount)
	amount = tonumber( amount ) or 0
	if thePlayer and isElement(thePlayer) and amount >= 0 then
		amount = math.floor( amount )
		
		return getMoney(thePlayer) >= amount
	end
	return false
end

function getMoney(thePlayer, nocheck)
	if not nocheck then
		checkMoneyHacks(thePlayer)
	end
	return getElementData(thePlayer, "money") or 0
end

function checkMoneyHacks(thePlayer)
	if not getMoney(thePlayer, true) or getElementType(thePlayer) ~= "player" then return end
	
	local safemoney = getMoney(thePlayer, true)
	local hackmoney = getPlayerMoney(thePlayer)

	if (safemoney~=hackmoney) then
		--banPlayer(thePlayer, getRootElement(), "Money Hacks: " .. hackmoney .. "$.")
		setPlayerMoney(thePlayer, safemoney)
		sendMessageToAdmins("Possível hack de dinheiro detectado: "..getPlayerName(thePlayer))
		return true
	else
		return false
	end
end