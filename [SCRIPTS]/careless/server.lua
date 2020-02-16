mysql = exports.mysql
function savecj(source)
	local count = 0
	local index = {}
	local intfix
	while count ~= 18 do
		local clothest,clothesm = getPedClothes ( source, count )
		if not clothest then
			index[count]= -1
		else
			intfix, index[count] = getTypeIndexFromClothes ( clothest, clothesm )
			index[count] = tostring(index[count])
		end
		count = count + 1
	end
	local fat = getPedStat(source,21)
	local muscle = getPedStat(source,23)
	local cjindex = toJSON( { index[0],index[1],index[2],index[3],index[4],index[5],index[6],index[7],index[8],index[9],index[10],index[11],index[12],index[13],index[14],index[15],index[16],index[17]} )
	local result = mysql:query("SELECT * FROM customcj WHERE charid = '"..mysql:escape_string(getElementData(source,"dbid")).."'")
	if (mysql:num_rows(result)>0) then
		outputDebugString( "AdmMsg:[CJ] "..getPlayerName(source).." configurações salvas.")
		exports.global:sendMessageToAdmins("AdmMsg: [CJ] "..getPlayerName(source).." configurações salvas.")
		if mysql:query_free("UPDATE customcj SET `cjindex` = '"..mysql:escape_string(cjindex).."',`fat`='"..mysql:escape_string(fat).."',`muscle` = '"..mysql:escape_string(muscle).."' WHERE charid = '" .. mysql:escape_string(getElementData(source,"dbid")) .. "'") then
			outputChatBox("Configurações de skin atualizadas",source,22,222,222)
		end
	else
		local id = mysql:query_insert_free("INSERT INTO customcj SET charid='" .. mysql:escape_string(getElementData(source,"dbid")) .. "'")
		savecj(source)
	end
end
addCommandHandler("savecj",savecj)
function loadcj(source,type)
	local dimen = getElementDimension(source)
	setElementDimension(source,math.random(8,1000))
	local row = mysql:query_fetch_assoc("SELECT * FROM customcj WHERE charid = " .. mysql:escape_string(getElementData(source,"dbid")) )
	if row then
		local cjindex = fromJSON(row["cjindex"])
		local fat = tonumber(row["fat"])
		local muscle = tonumber(row["muscle"])
		setPedStat(source,21,fat)
		setPedStat(source,23,muscle)
		for slot, index in ipairs(cjindex) do
			if index == -1 then
				removePedClothes ( source, slot-1 )
			else
				local clothest,clothesm = getClothesByTypeIndex(slot-1 ,index)
				addPedClothes ( source, clothest,clothesm , slot-1 )
			end
		end
	end
	if not row or type == 3 then
		local count = 0
		while count ~= 18 do
			if count > 3 then
				removePedClothes ( source, count )
			end
			count= count+1
		end
		
		local clothest,clothesm = getClothesByTypeIndex(0 ,1)
		addPedClothes ( source, clothest,clothesm , 0 )
		local clothest,clothesm = getClothesByTypeIndex(1 ,0)
		addPedClothes ( source, clothest,clothesm , 1 )
		local clothest,clothesm = getClothesByTypeIndex(2 ,7)
		addPedClothes ( source, clothest,clothesm , 2 )
		local clothest,clothesm = getClothesByTypeIndex(3 ,6)
		addPedClothes ( source, clothest,clothesm , 3 )
	
		--savecj(source)
	end
	outputDebugString("Configurações CJ carregadas para " ..getPlayerName(source)..".")
	setElementDimension(source,dimen)
end
addCommandHandler("loadcj",loadcj)
function handlesave(type)
	if type == 1 then
		savecj(source)
	elseif type ==2 then
		loadcj(source)
	elseif type ==3 then
		loadcj(source,3)
	end
end
addEvent( "saveclothes", true )
addEventHandler( "saveclothes", getRootElement(), handlesave )

function addclothes(clothest,clothesm,count)
	if clothest and clothesm and count then
		addPedClothes ( source, clothest,clothesm , count )
	else
		removePedClothes( source,count)
	end
end
addEvent( "addclothes", true )
addEventHandler( "addclothes", getRootElement(), addclothes )
function setfat(source,command,value)
	if getElementDimension(source) == 0 then
		outputChatBox(" Você pode usar este comando dentro do interior",source,255,0,0)
		return
	end
	setPedStat ( source, 23, value )
	savecj(source)
end
addCommandHandler("setmuscle",setfat)
function setfat(source,command,value)
	if  getElementDimension(source) == 0 then
		outputChatBox(" Você pode usar este comando dentro do interior",source,255,0,0)
		return
	end
	setPedStat ( source, 21, value )
	savecj(source)
end
addCommandHandler("setfat",setfat)