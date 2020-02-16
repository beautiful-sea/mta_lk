local mysql = exports.mysql
local serverRegFee = 3500

function pedTalk(state)
	if (state == 1) then
		exports.global:sendLocalText(source, "Gabrielle McCoy says: Welcome! Would you be registering new vehicle plates today?", nil, nil, nil, 10)
		outputChatBox("((The registration fee is $".. serverRegFee .. " per vehicle.))", source)
	elseif (state == 2) then
		exports.global:sendLocalText(source, "Gabrielle McCoy says: Sorry but the fee to register new plates is $" .. serverRegFee .. ". Please come back once you have the money.", nil, nil, nil, 10)
	elseif (state == 3) then
		exports.global:sendLocalText(source, "Gabrielle McCoy says: That is great! Lets get everything set up for you in our system.", nil, nil, nil, 10)
	elseif (state == 4) then
		exports.global:sendLocalText(source, "Gabrielle McCoy says: No? Well I hope you change your mind later. Have a nice day!", nil, nil, nil, 10)
	elseif (state == 5) then
		exports.global:sendLocalText(source, " *Gabrielle McCoy begins inputting the information into her computer.", 255, 51, 102)
		exports.global:sendLocalText(source, "Gabrielle McCoy says: Alright, you should be good to go. Have a nice day!", nil, nil, nil, 10)
	elseif (state == 6) then
		exports.global:sendLocalText(source, "Gabrielle McCoy says: Hmmm. According to our records, that is already a registered license plate.", nil, nil, nil, 10)
	end
end
addEvent("platePedTalk", true)
addEventHandler("platePedTalk", getRootElement(), pedTalk)

-- TODO: Check if the plate is in use. Get the money from the player!!
function setNewInfo(data, car)
	if (data) and (car) then
		local cquery = mysql:query_fetch_assoc("SELECT COUNT(*) as no FROM `vehicles` WHERE `plate`='".. mysql:escape_string(data).."'")
		if (tonumber(cquery["no"]) > 0) then
			triggerEvent("platePedTalk", source, 6)
		else
			local townerid = getElementData(source, "dbid")
			local tvehicle = exports.pool:getElement("vehicle", car)
			local owner = getElementData(tvehicle, "owner")
			if (townerid==owner) then
				if (checkPlate(data)) then
					local insertnplate = mysql:query_free("UPDATE vehicles SET plate='" .. mysql:escape_string(data) .. "' WHERE id = '" .. mysql:escape_string(car) .. "'")
					if (insertnplate) then
						if (exports.global:takeMoney(source, serverRegFee)) then
							exports['vehicle-system']:reloadVehicle(tonumber(car))
							triggerEvent("platePedTalk", source, 5)
						else
							triggerEvent("platePedTalk", source, 2)
						end
					else
						outputChatBox("ERROR VPS0-001. Please report on the mantis.", source, 255,0,0)
					end
				else
					outputChatBox("ERROR VPS0-003. Please report on the mantis.", source, 255,0,0)
				end
			end
		end
	else
		outputChatBox("ERROR VPS0-002. Please report on the mantis.", source, 255,0,0)
	end
end
addEvent("sNewPlates", true)
addEventHandler("sNewPlates", getRootElement(), setNewInfo)
