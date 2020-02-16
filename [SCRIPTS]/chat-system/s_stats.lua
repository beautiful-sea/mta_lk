function showStats(thePlayer, commandName, targetPlayerName)
	local showPlayer = thePlayer
	if exports.global:isPlayerAdmin(thePlayer) and targetPlayerName then
		targetPlayer = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
		if targetPlayer then
			if getElementData(targetPlayer, "loggedin") == 1 then
				thePlayer = targetPlayer
			else
				outputChatBox("O jogador não está logado.", showPlayer, 255, 0, 0)
				return
			end
		else
			return
		end
	end
	local carlicense = getElementData(thePlayer, "license.car")
	local gunlicense = getElementData(thePlayer, "license.gun")
	local job = getElementData(thePlayer, "job")

	if (carlicense==1) then
		carlicense = "Sim"
	elseif (carlicense==3) then
		carlicense = "Teste teórico aprovado"
	else
		carlicense = "Não"
	end
	
	if (gunlicense==1) then
		gunlicense = "Sim"
	else
		gunlicense = "Não"
	end

	if (job==1) then
		jobname = "Motorista de entrega"
	elseif (job==2) then
		jobname = "Taxista"
	elseif (job==3) then
		jobname = "Motorista de ônibus"
	elseif (job==4) then
		jobname = "Manutenção da cidade"
	elseif (job==5) then
		jobname = "Mecânico"
	elseif (job==6) then
		jobname = "Chaveiro"
	elseif (job==8) then
		jobname = "Fotógrafo"
	elseif (job==9) then
		jobname = "Pizzaboy"
	elseif (job==10) then
		jobname = "Traficante de armas"
	elseif (job==11) then
		jobname = "Escolta"
	else
		jobname = "Desempregado"
	end

	local dbid = tonumber(getElementData(thePlayer, "dbid"))
	
	-- CAR IDS
	local carids = ""
	local numcars = 0
	for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
		local owner = tonumber(getElementData(value, "owner"))

		if (owner) and (owner==dbid) then
			local id = getElementData(value, "dbid")
			carids = carids .. id .. ", "
			numcars = numcars + 1
		end
	end
	numcars = numcars .. "/" .. getElementData(thePlayer, "maxvehicles")
	
	-- Properties
	local properties = ""
	local numproperties = 0
	for key, value in ipairs(getElementsByType("pickup", getResourceRootElement(getResourceFromName("interior-system")))) do
		local owner = tonumber(getElementData(value, "owner"))
		if owner and owner == dbid and getElementData(value, "name") then
			local id = getElementData(value, "dbid")
			properties = properties .. id .. ", "
			numproperties = numproperties + 1
		end
	end
	
	if (properties=="") then properties = "None.  " end
	if (carids=="") then carids = "None.  " end
	
	local hoursplayed = getElementData(thePlayer, "hoursplayed")
	
	local languages = {}
	for i = 1, 3 do
		local lang = getElementData(thePlayer, "languages.lang" .. i)
		if lang and lang ~= 0 then
			local skill = getElementData(thePlayer, "languages.lang" .. i .. "skill")
			local langname = exports['language-system']:getLanguageName( lang )
			if langname then
				languages[i] = langname .. " (" .. skill .. "%)"
			else
				languages[i] = "-"
			end
		else
			languages[i] = "-"
		end
	end
	local accountID = getElementData(thePlayer, "gameaccountid")
	local result = mysql:query("SELECT * FROM accounts WHERE id='" .. accountID.."'")
	local row = exports.mysql:fetch_assoc(result)
	totalsnake = tonumber(row["totalsnake"])
	highsnake = tonumber(row["highsnake"])
	warns = tonumber(row["warns"])
	
	local result = mysql:query("SELECT * FROM characters WHERE id='" .. getElementData(thePlayer,"dbid").."'")
	local row = exports.mysql:fetch_assoc(result)
	deaths = tonumber(row["deaths"])
	photos = tonumber(row["photos"])
	tag = tonumber(row["tag"])
	weaponsell = tonumber(row["armsdealer"])
	fish = tonumber(row["fish"])
	
	outputChatBox("---------------------------------------------------------------- ", showPlayer, 102, 204, 153)
	outputChatBox("telefone: " .. getElementData(thePlayer, "cellnumber")..",  Licenciamento de veiculo: "..carlicense..",  Licença de Armas: "..gunlicense, showPlayer, 204, 204, 204)
	outputChatBox("Materiais: " .. getElementData(thePlayer, "mats")..",  Trabalho: " ..jobname..",  Horas: "..hoursplayed, showPlayer, 204 ,204, 204)
	outputChatBox("Fotos: "..photos..",  Armas vendidas: "..weaponsell..",  Peixe: "..fish,showPlayer,204,204,204)
	outputChatBox("Snake Pontos: [Total: " ..totalsnake.." Maior: "..highsnake.."],  Avisos: "..warns, showPlayer, 204, 204, 204)
	outputChatBox("Vip Tokens: " .. getElementData(thePlayer, "token")..",  TagID: "..tag..",  Mortes: "..deaths, showPlayer, 204, 204, 204)
	outputChatBox("Veículos (" .. numcars .. "): " .. string.sub(carids, 1, string.len(carids)-2), showPlayer, 204 ,204, 204)
	outputChatBox("Propriedades (" .. numproperties .. "): " .. string.sub(properties, 1, string.len(properties)-2),showPlayer,204,204,204)
	outputChatBox("---------------------------------------------------------------- ", showPlayer, 102, 204, 153)
end
addCommandHandler("stats", showStats, false, false)