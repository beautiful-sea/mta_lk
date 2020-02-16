-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local connection = exports["mtasa_sqlite"]:getConnection()

function loadServerBins()
	--local result = dbQuery(connection,"SELECT * FROM lixeira")
	local result = dbPoll(dbQuery(connection, "SELECT * FROM lixeira"), -1)
	--local handler = dbPoll(result, -1)
	if (result) then
		for i, row in ipairs(result) do
			loadOneBin(row["id"])
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadServerBins)

function loadOneBin(id)
	local Query = dbPoll (dbQuery(connection,"SELECT * FROM lixeira WHERE id=?",id),-1)
	if (Query) then
		for i, ertek in ipairs(Query) do
			kuka_pos = fromJSON(ertek["pos"]) or "[[ 0,0,0,0,0,0,0,0 ]]"
			
			kuka = createObject(1359,kuka_pos[1],kuka_pos[2],kuka_pos[3]-0.3,kuka_pos[4],kuka_pos[5],kuka_pos[6])
			setElementInterior(kuka,kuka_pos[7])
			setElementDimension(kuka,kuka_pos[8])
			setElementData(kuka,"isTrash",true)
			setElementData(kuka,"trashID",id)
		end
	end
end

addCommandHandler("criarlixeira",
	function(playerSource, cmd)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
			local x,y,z = getElementPosition(playerSource)
			local rx,ry,rz = getElementRotation(playerSource)
			local int = getElementInterior(playerSource)
			local Dim = getElementDimension(playerSource)
			
			local Query,rows,beszurid = dbQuery(connection,"INSERT INTO lixeira ( pos ) VALUES ( '"..toJSON({x, y, z, rx, ry, rz, int ,Dim}).."' )")
			local beszurasQueryEredmeny, _, beszurid = dbPoll ( Query, -1 )
			if beszurasQueryEredmeny then
				outputChatBox("#4169E1[SERVER NAME]:#ffffff Você criou uma lixeira com sucesso - ID: #4169E1("..beszurid..")",playerSource,255,255,255,true)
				loadOneBin(beszurid)
			end
		end
	end
)

addCommandHandler("removerlixeira",
	function(playerSource, cmd)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
			local x, y, _ = getElementPosition(playerSource)
			local kukashape = createColCircle ( x,y,3 )
			local kukaszam = 0
			for _,v in ipairs(getElementsWithinColShape(kukashape,"object")) do
				local idlixeira = getElementData(v,"trashID")
				kukaszam = kukaszam + 1
				destroyElement(kukashape)
				if idlixeira >= 1 then 
					destroyElement(v)
				end
				dbPoll(dbQuery(connection,"DELETE FROM lixeira WHERE id = '?'",idlixeira),-1)
				outputChatBox("#4169E1[SERVER NAME]:#ffffff Lixeira excluída com sucesso - ID: #4169E1("..idlixeira..")",playerSource,255,255,255,true)
				return
			end
			if(kukaszam == 0) then
				destroyElement(kukashape)
				outputChatBox("#ff0000[Error]:#ffffff Não há uma lixeira perto de você", playerSource,255,255,255,true)
			end
		end
	end
)


addCommandHandler("itemlist",
	function(playerSource, cmd)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
            triggerClientEvent("itemlist:command", playerSource)
		end
	end
)