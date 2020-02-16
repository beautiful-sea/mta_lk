mysql = exports.mysql

function loadAllpickups(res)
	local result = mysql:query("SELECT  x, y, z, dimension, interior, pickuptype,model FROM dropmoney")
	
	local counter = 0
	
	while true do
		local row = exports.mysql:fetch_assoc(result)
		if not (row) then
			break
		end
		
		local id = tonumber(row["id"])
		local x = tonumber(row["x"])
		local y = tonumber(row["y"])
		local z = tonumber(row["z"])
			
		local dimension = tonumber(row["dimension"])
		local interior = tonumber(row["interior"])
		local pickuptype = tonumber(row["pickuptype"])
		
		local model = tonumber(row["model"])
		pickup5 = createPickup (x ,y,z,pickuptype,model)
		setElementDimension(pickup5,dimension)
		setElementInterior(pickup5,interior)
		setPickupRespawnInterval (pickup5,999999999999999999999999999999999999 )

		counter = counter + 1
	end
	mysql:free_result(result)
end
addEventHandler("onResourceStart", getResourceRootElement(), loadAllpickups)

function dropmoney(thePlayer, commandName, cash,id)
	if not cash then
		outputChatBox( "SYNTAX: /" .. commandName .. " money", thePlayer, 255, 194, 14 )
	end
	mon = getPlayerMoney(thePlayer)
	if not exports.global:takeMoney(thePlayer,cash) then
	 	outputChatBox("You don't have enough money",thePlayer,255,0,0)
			return
	end

  if (tonumber(cash) >= 100 and tonumber(cash) <= 5000) then
   	 local x,y,z = getElementPosition (thePlayer)
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
	local serial = getPlayerSerial (thePlayer)
	local name = getPlayerName(thePlayer)
  	pickup2 = createPickup (x ,y-2.5,z, 3, 1212)
	setElementDimension(pickup2,dimension)
	setElementInterior(pickup2,interior)
	pickuptype =  getPickupType(pickup2)
	setPickupRespawnInterval (pickup2,99999999999999999999999)
	local id = mysql:query_insert_free("INSERT INTO dropmoney SET   x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y-2.5) .. "', z='" .. mysql:escape_string(z) .. "', dimension='" .. mysql:escape_string(dimension) .. "', interior='" .. mysql:escape_string(interior) .. "', pickuptype='" .. mysql:escape_string(pickuptype) .. "',serial='" .. mysql:escape_string(serial) .. "',charname='" .. mysql:escape_string(name) .. "',value='" .. mysql:escape_string(cash) .. "',  model=1212")
	exports.global:sendLocalMeAction(thePlayer," takes out his wallet and throws $"..cash.." nearby.")
	--exports.global:takeMoney(thePlayer,cash)			
  	
	exports.logs:logMessage("[PICKUP DROP] " .. name .. "/".. getElementData(thePlayer, "gameaccountusername") .." dropped  $".. cash..".", 33)
	
   else
		outputChatBox("Enter amount between 100$ - $5000",thePlayer,255,0,0)

  end
end
--addCommandHandler("drop",dropmoney)
function moneyPickupUse (thePlayer)
	local result = mysql:query("SELECT  id,value,x, y, z, dimension, interior, pickuptype,model,serial,charname FROM dropmoney")
	while true do
		local row = exports.mysql:fetch_assoc(result)
		if not (row) then
			break
		end

		local currentserial = getPlayerSerial(thePlayer)
		local currentname = getPlayerName(thePlayer)
		local id = tonumber(row["id"])
		local x = tonumber(row["x"])
		local y = tonumber(row["y"])
		local z = tonumber(row["z"])
		local value = tonumber(row["value"])	
		local charname = tostring(row["charname"])
		local oldserial = tostring(row["serial"])
		

		if  charname ~= currentname then
			
		if oldserial == currentserial  then
			outputChatBox("WARNING:Do not use money pickups for stat transfer.It can lead to perm ban",thePlayer,255,0,0)
			exports.global:sendMessageToAdmins("[Possible Stat Transfer from money pickup] " .. currentname .. ": tried to pickup $ "..value.." from same account.")
			exports.logs:logMessage("[STAT TRANSFER THREAT] " .. currentname .. "/".. getElementData(thePlayer, "gameaccountusername") .." tried to pick up  ".. value.." on same serial,account.", 33)
			cancelEvent()
			return
		end
		end
		x1, y1, z1 = getElementPosition ( thePlayer )
		x2, y2,z2 = getElementPosition ( source )
	if getDistanceBetweenPoints3D ( x1, y1, z1,  x2,  y2,  z2 ) <=2 then
    		exports.global:giveMoney(thePlayer,value)
   		 outputChatBox ("You've picked up $"..value, thePlayer, 133, 250, 133, false)
   		 destroyElement (source)
		mysql:query_free("DELETE FROM dropmoney WHERE id='" .. mysql:escape_string(id) .. "' LIMIT 1")
		exports.logs:logMessage("[PICKUP PICKED] " .. currentname .. "/".. getElementData(thePlayer, "gameaccountusername") .." picked up  $".. value..".", 33)

		exports.global:sendLocalMeAction(thePlayer," bends down and picks up $"..value..".")
	end


	end

end
addEventHandler ("onPickupUse",getRootElement(), moneyPickupUse)
