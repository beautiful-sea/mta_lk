function getPaid(collectionValue)
	exports.global:giveMoney(source, tonumber(collectionValue/4))
	
	local gender = getElementData(source, "gender")
	local genderm = "his"
	if (gender == 1) then
		genderm = "her"
	end
	
	exports.global:sendLocalMeAction(source,"hands " .. genderm .. " collection of photographs to the woman behind the desk.")
	exports.global:sendLocalText(source, "Mark Smith says: Thank you. These should make the morning edition. Keep up the good work.", nil, nil, nil, 10)
	exports.global:sendMessageToAdmins("SANNews: " .. tostring(getPlayerName(source)) .. " sold photos for $" .. collectionValue/4 .. ".")
	exports.logs:logMessage(tostring(getPlayerName(source)) .. " sold photos for $" .. collectionValue/4 .. ".", 10)
	updateCollectionValue(0)
end
addEvent("submitCollection", true)
addEventHandler("submitCollection", getRootElement(), getPaid)


function info()
	exports.global:sendLocalText(source, "Mark Smith says: Hello, Sir. I'm taking the photos of only authorised News Photographers", nil, nil, nil, 10)
	exports.global:sendLocalText(source, "If you wish to join visit city hall and take this job.", nil, nil, nil, 10)
end
addEvent("sellPhotosInfo", true)
addEventHandler("sellPhotosInfo", getRootElement(), info)

function updateCollectionValue(value)
	mysql:query_free("UPDATE characters SET photos = " .. mysql:escape_string((tonumber(value) or 0)) .. " WHERE id = " .. mysql:escape_string(getElementData(source, "dbid")) )
end
addEvent("updateCollectionValue", true)
addEventHandler("updateCollectionValue", getRootElement(), updateCollectionValue)

addEvent("getCollectionValue", true)
addEventHandler("getCollectionValue", getRootElement(),
	function()
		if getElementData( source, "loggedin" ) == 1 then
			local result = mysql:query_fetch_assoc("SELECT photos FROM characters WHERE id = " .. mysql:escape_string(getElementData(source, "dbid")) )
			if result then
				triggerClientEvent( source, "updateCollectionValue", source, tonumber( result["photos"] ) )
			end
		end
	end
)

function sanAD()
	if (exports.global:hasItem(source, 2)) then
		exports['anticheat-system']:changeProtectedElementDataEx(source, "sanAdvert", 1)
		exports['global']:sendLocalText(source, " *Mark Smith hands " .. getPlayerName(source):gsub("_"," ") .. " an Advertisement form.", 255, 51, 102)
		exports['global']:sendLocalText(source, "Mark Smith says: Please fill out that form and turn it back in once completed.", 255, 255, 255, 10)
		outputChatBox("You can now use /ad to place your ad.", source)
	else
		exports['global']:sendLocalText(source, "Mark Smith says: Sorry but you need a cellphone inorder to be contacted.", 255, 255, 255, 10)
	end
end
addEvent("cSANAdvert", true)
addEventHandler("cSANAdvert", getRootElement(), sanAD)