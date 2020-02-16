-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local connection = exports["mtasa_sqlite"]:getConnection()

function loadServerSafes()
	local result = dbPoll(dbQuery(connection, "SELECT * FROM cofres"), -1)
	if (result) then
		for i, row in ipairs(result) do
			loadOneSafe(row["id"])
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadServerSafes)

function loadOneSafe(id)
	local Query = dbPoll (dbQuery(connection,"SELECT * FROM cofres WHERE id=?",id),-1)
	if (Query) then
		for i, ertek in ipairs(Query) do
			safePos = fromJSON(ertek["pos"]) or "[[ 0,0,0,0,0,0,0,0 ]]"
			
			safe = createObject(2332,safePos[1],safePos[2],safePos[3]-0.52,safePos[4],safePos[5],safePos[6])
			setElementInterior(safe,safePos[7])
			setElementDimension(safe,safePos[8])
			setElementDoubleSided(safe,true)
			setElementData(safe,"szef",true)
			setElementData(safe,"ID",id)
			setElementData(safe,"safe.using",false)
		end
	end
end

function addSafeToServer(playerSource)
local accName = getAccountName ( getPlayerAccount ( playerSource ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
	local x,y,z = getElementPosition(playerSource)
	local rx,ry,rz = getElementRotation(playerSource)
	local int = getElementInterior(playerSource)
	local Dim = getElementDimension(playerSource)	
	local Query,rows,idcofre = dbQuery(connection,"INSERT INTO cofres ( pos ) VALUES ( '"..toJSON({x, y, z, rx, ry, rz, int ,Dim}).."' )")
	local beszurasQueryEredmeny, _, idcofre = dbPoll ( Query, -1 )
	if beszurasQueryEredmeny then
		outputChatBox("#4169E1[SERVER NAME]:#ffffff Você criou um cofre com sucesso #4169E1("..idcofre..")", playerSource, 255,255,255, true)
		giveItem(playerSource, 129, idcofre, 1, 0)
		loadOneSafe(idcofre)
	    end	
	end
end
addEvent("addSafeToServer", true)
addEventHandler("addSafeToServer", root, addSafeToServer)
addCommandHandler("criarcofre", addSafeToServer)

addCommandHandler("removercofre",
	function(playerSource, cmd)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
			local x, y, _ = getElementPosition(playerSource)
			local safeShape = createColCircle ( x,y,3 )
			local szefszam = 0
			for _,v in ipairs(getElementsWithinColShape ( safeShape, "object" ) ) do
				if getElementData(v,"szef") == true then
					local safeID = getElementData(v,"ID")
					szefszam = szefszam + 1
					destroyElement(safeShape)
					if safeID >= 1 then 
						destroyElement(v)
					end
					dbPoll ( dbQuery( connection, "DELETE FROM cofres WHERE id = '?'", safeID), -1 )
					outputChatBox("#4169E1[SERVER NAME]:#ffffff Você deletou um cofre com sucesso #4169E1("..safeID..")",playerSource, 255,255,255,true)
					return
				end
			end
			if(szefszam == 0) then
				destroyElement(safeShape)
				outputChatBox("#ff0000[Error]:#ffffff Nenhum cofre encontrado", playerSource,255,255,255,true)
			end
		end
	end
)

function getNearbySafes(playerSource)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
		local x, y, _ = getElementPosition(playerSource)
		local shape = createColCircle(x,y,3)
		local nearSafeCount = 0
		for _,v in ipairs(getElementsWithinColShape(shape,"object")) do
			if getElementData(v,"szef") == true then
				if getElementInterior(playerSource) == getElementInterior(v) then
					if getElementDimension(playerSource) == getElementDimension(v) then
						nearSafeCount = nearSafeCount + 1
						outputChatBox("#4169E1[SERVER NAME]:#ffffff Cofres perto de voce ID: #4169E1"..getElementData(v,"ID").."", playerSource,255,255,255, true)
					end
				end
			end
		end
		if(nearSafeCount == 0) then
			outputChatBox("#ff0000[Error]:#ffffff Você não está perto de nenhum cofre", playerSource,255,255,255, true)
		end
	end
end
addCommandHandler("cofresproximos",getNearbySafes,false,false)

addCommandHandler("movercofre",function(playerSource, cmd, safeID)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
		local x,y,z = getElementPosition(playerSource)
		local rx,ry,rz = getElementRotation(playerSource)
		local int = getElementInterior(playerSource)
		local Dim = getElementDimension(playerSource)
		safeID = tonumber(safeID)
		if safeID then
			for k,v in ipairs(getElementsByType("object")) do
				if getElementData(v,"szef") == true and safeID == getElementData(v,"ID") then
					dbExec(connection, "UPDATE cofres SET pos = ? WHERE id = ?",toJSON({x, y, z, rx, ry, rz, int ,Dim}), safeID)
					setElementPosition(v,x,y,z - 0.52)
					setElementRotation(v,rx,ry,rz)
					setElementInterior(v,int)
					setElementDimension(v,Dim)
					outputChatBox("#4169E1[SERVER NAME]:#ffffff Você moveu com segurança um cofre para a sua posição", playerSource,255,255,255, true)
				end
			end
		else
			outputChatBox("#4169E1[Use]:#ffffff /"..cmd.." [Cofre ID]", playerSource,255,255,255, true)
		end
	end
end)

addCommandHandler("ircofre",function(playerSource, cmd, safeID)
		local accName = getAccountName ( getPlayerAccount ( playerSource ) )
        if isObjectInACLGroup ("user."..accName, aclGetGroup ("Admin") ) then
		safeID = tonumber(safeID)
		if safeID then
			for k,v in ipairs(getElementsByType("object")) do
				if getElementData(v,"szef") and safeID == getElementData(v,"ID") then
					local x,y,z = getElementPosition(v)
					local rx,ry,rz = getElementRotation(v)
					local int = getElementInterior(v)
					local Dim = getElementDimension(v)
					
					setElementPosition(playerSource,x,y,z + 0.52)
					setElementRotation(playerSource,rx,ry,rz)
					setElementInterior(playerSource,int)
					setElementDimension(playerSource,Dim)
					outputChatBox("#4169E1[SERVER NAME]:#ffffff Você foi para a posição de um cofre - ID: #4169E1"..safeID.."", playerSource,255,255,255, true)
				end
			end
		else
			outputChatBox("#4169E1[Use]:#ffffff /"..cmd.." [Cofre ID]", playerSource,255,255,255, true)
		end
	end
end)