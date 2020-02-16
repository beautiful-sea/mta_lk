mysql = exports.mysql

function trunklateText(thePlayer, text, factor)
	if getElementData(thePlayer,"alcohollevel") and getElementData(thePlayer,"alcohollevel") > 0 then
		local level = math.ceil( getElementData(thePlayer,"alcohollevel") * #text / ( factor or 5.5 ) )
		for i = 1, level do
			x = math.random( 1, #text )
			-- dont replace spaces
			if text.sub( x, x ) == ' ' then
				i = i - 1
			else
				local a, b = text:sub( 1, x - 1 ) or "", text:sub( x + 1 ) or ""
				local c = ""
				if math.random( 1, 6 ) == 1 then
					c = string.char(math.random(65,90))
				else
					c = string.char(math.random(97,122))
				end
				text = a .. c .. b
			end
		end
	end
	return text
end

function getElementDistance( a, b )
	if not isElement(a) or not isElement(b) or getElementDimension(a) ~= getElementDimension(b) then
		return math.huge
	else
		local x, y, z = getElementPosition( a )
		return getDistanceBetweenPoints3D( x, y, z, getElementPosition( b ) )
	end
end

local gpn = getPlayerName
function getPlayerName(p)
	local name = gpn(p) or getElementData(p, "ped:name")
	return string.gsub(name, "_", " ")
end

-- /ad
function advertMessage(thePlayer, commandName, showNumber, ...)
	local canIAD = getElementData(thePlayer, "sanAdvert") or 0
	--[[if (canIAD == 0) then
		outputChatBox("(( Command removed. Visit SAN to place an advertisement. ))", thePlayer)
	else]]
		local logged = tonumber(getElementData(thePlayer, "loggedin"))
		 
		if (logged==1) then
			if not (...) or not (showNumber) then
				outputChatBox("SINTAXE: /" .. commandName .. " [Show Phone Number 0/1] [Message]", thePlayer, 255, 194, 14)
			elseif getElementData(thePlayer, "adminjailed") then
				outputChatBox("You cannot advertise in jail.", thePlayer, 255, 0, 0)
			elseif getElementData(thePlayer, "alcohollevel") and getElementData(thePlayer, "alcohollevel") ~= 0 then
				outputChatBox("You are too drunk to advertise!", thePlayer, 255, 0, 0)
			else
				if (exports.global:hasItem(thePlayer, 2)) then
					if (getElementData(thePlayer, "ads") or 0) >= 2 then
						outputChatBox("You can only place 2 ads every 5 minutes.", thePlayer, 255, 0, 0)
						return
					end
					message = table.concat({...}, " ")
					if showNumber ~= "0" and showNumber ~= "1" then
						message = showNumber .. " " .. message
						showNumber = 0
					end
					if message:sub(-1) ~= "." then
						message = message .. "."
					end
					
					local cost = math.ceil(string.len(message)/6)
					if exports.global:takeMoney(thePlayer, cost) then
						local name = getPlayerName(thePlayer)
						local phoneNumber = getElementData(thePlayer, "cellnumber")
						
						exports.logs:logMessage("AD: " .. message .. ". ((" .. name .. "))", 2)
						for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
							if (getElementData(value, "loggedin")==1 and not getElementData(value, "disableAds")) then
								outputChatBox("   Advertisement: " .. message .. " #66ffff((" .. name .. "))", value, 10, 255, 200, true)
								
								if (tonumber(showNumber)==1) then
									outputChatBox("   Phone: #" .. phoneNumber .. ".", value, 10, 255, 200)
								end
							end
						end
						outputChatBox("Thank you for placing your advert. Total Cost: $" .. cost .. ".", thePlayer)
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "ads", ( getElementData(thePlayer, "ads") or 0 ) + 1, false)
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "sanAdvert", 0)
						setTimer(
							function(p)
								if isElement(p) then
									local c =  getElementData(p, "ads") or 0
									if c > 1 then
										exports['anticheat-system']:changeProtectedElementDataEx(p, "ads", c-1, false)
									else
										exports['anticheat-system']:changeProtectedElementDataEx(p, "ads")
									end
								end
							end, 300000, 1, thePlayer
						)
					else
						outputChatBox("You cannot afford to place such an advert, try making it smaller.", thePlayer)
					end
				else
					outputChatBox("You do not have a cellphone to call the advertisement agency.", thePlayer, 255, 0, 0)
				end
			end
		--end
	end
end
addCommandHandler("ad", advertMessage, false, false)

-- Main chat: Local IC, Me Actions & Faction IC Radio
function localIC(source, message, language)
	if exports['freecam-tv']:isPlayerFreecamEnabled(source) then return end
	
	local x, y, z = getElementPosition(source)
	local playerName = getPlayerName(source)
	
	message = string.gsub(message, "#%x%x%x%x%x%x", "") -- Remove colour codes
	local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
	message = trunklateText( source, message )
	
	local playerVehicle = getPedOccupiedVehicle(source)
	if playerVehicle then
		if (exports['vehicle-system']:isVehicleWindowUp(playerVehicle)) then
			exports.logs:logMessage("[EP: No Carro] " .. playerName .. ": " .. message, 1)
			outputChatBox( "#EEEEEE [EP] " .. playerName .. " ((No carro)) diz: " .. message, source, 133, 44, getElementData(source, "chatbubbles") == 2 and 89 or 88, true)		
		else
			exports.logs:logMessage("[IC: Local Chat] " .. playerName .. ": " .. message, 1)
			outputChatBox( "#EEEEEE [EP] " .. playerName .. " diz: " .. message, source, 133, 44, getElementData(source, "chatbubbles") == 2 and 89 or 88, true)
		end
	else
		exports.logs:logMessage("[IC: Local Chat] " .. playerName .. ": " .. message, 1)
		outputChatBox( "#EEEEEE [EP] " .. playerName .. " diz: " .. message, source, 133, 44, getElementData(source, "chatbubbles") == 2 and 89 or 88, true)
	end

	local dimension = getElementDimension(source)
	local interior = getElementInterior(source)
	local shownto = 1
	
	-- Chat Commands tooltip
	if(getResourceFromName("tooltips-system"))then
		triggerClientEvent(source,"tooltips:showHelp", source,17)
	end
	
	for key, nearbyPlayer in ipairs(getElementsByType( "player" )) do
		local dist = getElementDistance( source, nearbyPlayer )
		
		if dist < 20 then
			local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
			local nearbyPlayerInterior = getElementInterior(nearbyPlayer)

			if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
				local logged = tonumber(getElementData(nearbyPlayer, "loggedin"))
				if not (isPedDead(nearbyPlayer)) and (logged==1) and (nearbyPlayer~=source) then
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, nearbyPlayer, message, language)
					message2 = trunklateText( nearbyPlayer, message2 )
					
					local pveh = getPedOccupiedVehicle(source)
					local nbpveh = getPedOccupiedVehicle(nearbyPlayer)
					if pveh then
						if (exports['vehicle-system']:isVehicleWindowUp(pveh)) then
							for i = 0, getVehicleMaxPassengers(pveh) do
								local lp = getVehicleOccupant(pveh, i)
								
								if (lp) and (lp~=source) then
									outputChatBox("#EEEEEE [EP] " .. playerName .. " ((In Car)) diz: " .. message2, lp, 133, 44, getElementData(lp, "chatbubbles") > 0 and 89 or 88, true)
								end
							end
							if (getElementData(nearbyPlayer, "adminduty") == 1) and (getPedOccupiedVehicle(nearbyPlayer) ~= pveh) then
								outputChatBox("#EEEEEE [EP] " .. playerName .. " ((In Car)) diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							end
							return
						end
					end
					if nbpveh then
						if (exports['vehicle-system']:isVehicleWindowUp(nbpveh)) then
							if dist < 3 then
								outputChatBox( "#EEEEEE [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 6 then
								outputChatBox( "#DDDDDD [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 9 then
								outputChatBox( "#CCCCCC [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 12 then
								outputChatBox( "#BBBBBB [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							else
								outputChatBox( "#AAAAAA [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							end
						else
							if dist < 4 then
								outputChatBox( "#EEEEEE [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 8 then
								outputChatBox( "#DDDDDD [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 12 then
								outputChatBox( "#CCCCCC [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							elseif dist < 16 then
								outputChatBox( "#BBBBBB [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							else
								outputChatBox( "#AAAAAA [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
							end
						end
					elseif not nbpveh then
						if dist < 4 then
							outputChatBox( "#EEEEEE [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
						elseif dist < 8 then
							outputChatBox( "#DDDDDD [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
						elseif dist < 12 then
							outputChatBox( "#CCCCCC [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
						elseif dist < 16 then
							outputChatBox( "#BBBBBB [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
						else
							outputChatBox( "#AAAAAA [EP] " .. playerName .. " diz: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
						end
					end
					
					shownto = shownto + 1
				end
			end
		end
	end
	
	exports['freecam-tv']:add(shownto, playerName .. " diz: " .. message, source)
end

for i = 1, 3 do
	addCommandHandler( tostring( i ), 
		function( thePlayer, commandName, ... )
			local lang = tonumber( getElementData( thePlayer, "languages.lang" .. i ) )
			if lang ~= 0 then
				localIC( thePlayer, table.concat({...}, " "), lang )
			end
		end
	)
end

function meEmote(source, cmd, ...)
	local logged = getElementData(source, "loggedin")
	if not(isPedDead(source) and (logged == 1)) then
		local message = table.concat({...}, " ")
		if not (...) then
			outputChatBox("SINTAXE: /me [Action]", source, 255, 194, 14)
		else
			exports.global:sendLocalMeAction(source, message)
			exports.logs:logMessage("[IC OOC: ME ACTION] *" .. getPlayerName(source) .. " " .. message, 7)
		end
	end
end
addCommandHandler("ME", meEmote, false, true)
addCommandHandler("Me", meEmote, false, true)


function chatMain()
	
	if not getElementData(source, "loggedin") then		
             outputChatBox("Você precisa estar logado para conversar!",source,255,255,0)
	end
		
end
addEventHandler("onPlayerChat", getRootElement(), chatMain)


function govAnnouncement(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)
	
	if (theTeam) then
		local teamID = tonumber(getElementData(theTeam, "id"))
	
		if (teamID==1 or teamID==2 --[[or teamID==3]] or teamID==35) then
			local message = table.concat({...}, " ")
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))
			
			if (factionRank<8) then
				outputChatBox("Você não tem permissão para usar este comando.", thePlayer, 255, 0, 0)
			elseif #message == 0 then
				outputChatBox("SINTAXE: " .. commandName .. " [mensagem]", thePlayer, 255, 194, 14)
			else
				local ranks = getElementData(theTeam,"ranks")
				local factionRankTitle = ranks[factionRank]
				
				exports.logs:logMessage("[EP: Mensagem do governo] " .. factionRankTitle .. " " .. getPlayerName(thePlayer) .. ": " .. message, 6)
				
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					local logged = getElementData(value, "loggedin")
					
					if (logged==1) then
						outputChatBox(">> Anúncio do Governo de " .. factionRankTitle .. " " .. getPlayerName(thePlayer), value, 0, 183, 239)
						outputChatBox(message, value, 0, 183, 239)
					end
				end
			end
		end
	end
end
addCommandHandler("gov", govAnnouncement)

function playerToggleDonatorChat(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local enabled = getElementData(thePlayer, "donatorchat")
		
		if (enabled==1) then
			outputChatBox("Você ocultou o bate-papo com doadores.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "donatorchat", 0, false)
		else
			outputChatBox("Você ativou o bate-papo com doadores.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "donatorchat", 1, false)
		end
		mysql:query_free("UPDATE accounts SET donatorchat=" .. mysql:escape_string(getElementData(thePlayer, "donatorchat")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")))
	end
end
addCommandHandler("toggledonatorchat", playerToggleDonatorChat, false, false)
addCommandHandler("toggledon", playerToggleDonatorChat, false, false)
addCommandHandler("toggledchat", playerToggleDonatorChat, false, false)

function donatorchat(thePlayer, commandName, ...)
	if ( exports.global:isPlayerBronzeDonator(thePlayer) or exports.global:isPlayerAdmin(thePlayer) ) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [mensagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local title = ""
			local hidden = getElementData(thePlayer, "hiddenadmin") or 0

			if ( exports.global:isPlayerAdmin(thePlayer) ) then
				if (hidden == 1) or (exports.global:getPlayerAdminTitle(thePlayer) == "Player") then
					if not (exports.global:isPlayerBronzeDonator(thePlayer)) then
						title = "Doador Bronze"
					else
						title = exports.global:getPlayerDonatorTitle(thePlayer)
					end
				else
					title = exports.global:getPlayerAdminTitle(thePlayer)
				end
			elseif ( exports.global:isPlayerBronzeDonator(thePlayer) ) then
				title = exports.global:getPlayerDonatorTitle(thePlayer)
			end
				
			for key, value in ipairs(getElementsByType("player")) do
				if ( exports.global:isPlayerBronzeDonator(value) or exports.global:isPlayerAdmin(value) ) then
					if ( getElementData(value, "donatorchat") == 1 ) then
						outputChatBox("[Doador] " .. title .. " " .. getPlayerName(thePlayer) .. ": " .. message, value, 160, 164, 104)
					end
				end
			end
		end
	end
end
addCommandHandler("donator", donatorchat, false, false)
addCommandHandler("don", donatorchat, false, false)
addCommandHandler("dchat", donatorchat, false, false)

--[[function donatorchat(thePlayer, commandName, ...)
			helper = getElementData(theplayer,"helper") 
	if helper > 0 getElementData(theplayer,"helper") > 0 or exports.global:isPlayerAdmin(thePlayer) ) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local title = ""
			local hidden = getElementData(thePlayer, "hiddenadmin") or 0

			if ( exports.global:isPlayerAdmin(thePlayer) ) then
				if (hidden == 1) or (exports.global:getPlayerAdminTitle(thePlayer) == "Player") then
				
						title = "Helper"
				
					
				else
					title = exports.global:getPlayerAdminTitle(thePlayer)
				end
			
			end
				
			for key, value in ipairs(getElementsByType("player")) do
				if getElementData(value,"helper") > 0  or exports.global:isPlayerAdmin(value) ) then
					
						outputChatBox("[GM Chat] " .. title .. " " .. getPlayerName(thePlayer) .. ": " .. message, value, 255, 204, 255)
					
				end
			end
		end
	end
end
addCommandHandler("gm", donatorchat, false, false)]]


function departmentradio(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)
	
	if (theTeam) then
		local teamID = tonumber(getElementData(theTeam, "id"))

		if (teamID==1 or teamID==2 or teamID==3 or teamID == 30 or teamID == 71 or teamID == 36) then
			if (...) then
				local message = trunklateText( thePlayer, table.concat({...}, " ") )
				local PDFaction = getPlayersInTeam(getTeamFromName("Departamento de Polícia de Los Santos"))
				local ESFaction = getPlayersInTeam(getTeamFromName("Serviços de Emergência em Los Santos"))
				local TowFaction = getPlayersInTeam(getTeamFromName("Los Santos Towing and Recovery"))
				local GovFaction = getPlayersInTeam(getTeamFromName("Governo de Los Santos"))
				local SACFFaction = getPlayersInTeam(getTeamFromName("San Andreas Corretora"))
				local CorFaction = getPlayersInTeam(getTeamFromName("Primeira Corte de San Andreas"))
				local playerName = getPlayerName(thePlayer)
				
				exports.logs:logMessage("[EP: Rádio do Departamento] " .. playerName .. ": " .. message, 6)
				
				for key, value in ipairs(PDFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(ESFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(TowFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(GovFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(SACFFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(CorFaction) do
					outputChatBox("[DEPARTAMENTO RADIO] " .. playerName .. " diz: " .. message, value, 0, 102, 255)
				end
			else
				outputChatBox("SINTAXE: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("d", departmentradio, false, false)
addCommandHandler("department", departmentradio, false, false)

function blockChatMessage()
	cancelEvent()
end

addEventHandler("onPlayerChat", getRootElement(), blockChatMessage)
-- End of Main Chat

function globalOOC(thePlayer, commandName, ...)
        local logged = tonumber(getElementData(thePlayer, "loggedin"))
       
        if (logged==1) then
                if not (...) then
                        outputChatBox("SINTAXE: /" .. commandName .. " [mensagem]", thePlayer, 255, 194, 14)
                else
                        local oocEnabled = exports.global:getOOCState()
                        message = table.concat({...}, " ")
                        local muted = getElementData(thePlayer, "muted")
                        if (oocEnabled==0) and not (exports.global:isPlayerAdmin(thePlayer)) then
                                outputChatBox("O Chat FR está desativado no momento.", thePlayer, 255, 0, 0)
                        elseif (muted==1) then
                                outputChatBox("Atualmente, você está sem áudio no bate-papo do FR.", thePlayer, 255, 0, 0)
                        else
                                local players = exports.pool:getPoolElementsByType("player")
                                local playerName = getPlayerName(thePlayer)
                                local playerID = getElementData(thePlayer, "playerid")
                                       
                                exports.logs:logMessage("[FR: Global Chat] " .. playerName .. ": " .. message, 1)
                                for k, arrayPlayer in ipairs(players) do
                                        local logged = tonumber(getElementData(arrayPlayer, "loggedin"))
                                        local targetOOCEnabled = getElementData(arrayPlayer, "globalooc")
                                        local adminlevel = exports.global:getPlayerAdminLevel(thePlayer)
                                        title = exports.global:getPlayerAdminTitle(thePlayer)
                                        local helper = tonumber(getElementData(thePlayer,"helper"))
                                        if adminlevel >= 4 then
                                                 color = "#CC0000"
                                        else
                                                 color = "#00ff00"
                                        end
 
                                        if adminlevel == 0 or getElementData(thePlayer,"hiddenadmin") == 1 then
                                                title = false
                                        end
                                        if  exports.global:getPlayerDonatorLevel(thePlayer) > 0 and exports.global:getPlayerAdminLevel(thePlayer) == 0 then
                                                color = "#CC9933"
                                                title = "Doador"
                                        end
                                       
                                        if (logged==1) and (targetOOCEnabled==1) then
 
                                        if  title and color then
                                                outputChatBox("(( [GOOC] (" .. playerID .. ") ["..color.."" ..title.. "#ffe4c4] " .. playerName .. ": " .. message.." ))",arrayPlayer, 255,228,196,true)
                                        else
                        if helper > 0 then
                                            outputChatBox("(( [GOOC] (" .. playerID .. ") [#01BEFFGameMaster#ffe4c4] " .. playerName .. ": " .. message.." ))",arrayPlayer, 255,228,196,true)
                                        else
                                                outputChatBox("(( [GOOC] (" .. playerID .. ") " .. playerName .. ": " .. message.." ))", arrayPlayer, 255,228,196,true)
                                                    end
                                                end
                                            end
                                        end
                                end
                        end
                end
        end
addCommandHandler("o", globalOOC, false, false)
addCommandHandler("GlobalOOC", globalOOC)

function playerToggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local playerOOCEnabled = getElementData(thePlayer, "globalooc")
		
		if (playerOOCEnabled==1) then
			outputChatBox("You have now hidden Global OOC Chat.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "globalooc", 0, false)
		else
			outputChatBox("You have now enabled Global OOC Chat.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "globalooc", 1, false)
		end
		mysql:query_free("UPDATE accounts SET globalooc=" .. mysql:escape_string(getElementData(thePlayer, "globalooc")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")))
	end
end
addCommandHandler("toggleooc", playerToggleOOC, false, false)


local advertisementMessages = { "samp", "SA-MP", "vedic", "grimz","paradox","server", "sincityrp", "ls-rp", "sincity", "twd", "virtua", "vg", "valhalla", "www.", ".com", ".net", ".co.uk", ".org", "Bryan", "Danny", "everlast", "neverlast", "www.everlastgaming.com"}

function isFriendOf(thePlayer, targetPlayer)
	local friends = getElementData(targetPlayer, "friends")
	if friends then
		local targetID = tonumber( getElementData( thePlayer, "gameaccountid" ) )
		if friends[ targetID ] then
			return true
		end
	end
	return false
end

function pmPlayer(thePlayer, commandName, who, ...)
	if not (who) or not (...) then
		outputChatBox("SINTAXE: /" .. commandName .. " [Nick Parcial do Jogador] [mensagem]", thePlayer, 255, 194, 14)
	else
		message = table.concat({...}, " ")
		
		local loggedIn = getElementData(thePlayer, "loggedin")
		if (loggedIn==0) then
			return
		end
		
		local targetPlayer, targetPlayerName
		if (isElement(who)) then
			if (getElementType(who)=="player") then
				targetPlayer = who
				targetPlayerName = getPlayerName(who)
				message = string.gsub(message, string.gsub(targetPlayerName, " ", "_", 1) .. " ", "", 1)
			end
		else
			targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
		end
		
		if (targetPlayer) then
			local logged = getElementData(targetPlayer, "loggedin")
			local pmblocked = getElementData(targetPlayer, "pmblocked")

			if not (pmblocked) then
				pmblocked = 0
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "pmblocked", 0, false)
			end
			
			if (logged==1) and not getElementData(targetPlayer, "disablePMs") and (pmblocked==0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) or getElementData(thePlayer, "reportadmin") == targetPlayer or isFriendOf(thePlayer, targetPlayer)) then
				local playerName = getPlayerName(thePlayer):gsub("_", " ")
				
				if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
					-- Check for advertisements
					for k,v in ipairs(advertisementMessages) do
						local found = string.find(string.lower(message), "%s" .. tostring(v))
						local found2 = string.find(string.lower(message), tostring(v) .. "%s")
						if (found) or (found2) or (string.lower(message)==tostring(v)) then
							exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(playerName) .. " enviou um possível anúncio publicitário para " .. tostring(targetPlayerName) .. ".")
							exports.global:sendMessageToAdmins("AdmWrn: mensagem: " .. tostring(message))
							break
						end
					end
				end
				
				-- Send the message
				local playerid = getElementData(thePlayer, "playerid")
				local targetid = getElementData(targetPlayer, "playerid")
				outputChatBox("PM de [" .. playerid .. "] " .. playerName .. ": " .. message, targetPlayer, 255, 153, 0 )
				outputChatBox("PM Enviado para [" .. targetid .. "] " .. targetPlayerName .. ": " .. message, thePlayer, 255, 153, 0 )
				
				exports.logs:logMessage("[PM de " ..playerName .. " para " .. targetPlayerName .. "]" .. message, 8)
				outputDebugString("[PM From " ..playerName .. " para " .. targetPlayerName .. "]" .. message)
				
				if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
					-- big ears
					local received = {}
					received[thePlayer] = true
					received[targetPlayer] = true
					for key, value in pairs( getElementsByType( "player" ) ) do
						if isElement( value ) and not received[value] then
							local listening = getElementData( value, "bigears" )
							if listening == thePlayer or listening == targetPlayer then
								received[value] = true
								outputChatBox("(" .. playerid .. ") " .. playerName .. " -> (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, value, 255, 255, 0)
							end
						end
					end
				end
			elseif (logged==0) then
				outputChatBox("O jogador ainda não está logado.", thePlayer, 255, 255, 0)
			elseif (pmblocked==1) then
				outputChatBox("O jogador está ignorando sussurros!", thePlayer, 255, 255, 0)
			end
		end
	end
end
addCommandHandler("pm", pmPlayer, false, false)

function localOOC(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if (logged==1) and not (isPedDead(thePlayer)) then
		local muted = getElementData(thePlayer, "muted")
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Messagem]", thePlayer, 255, 194, 14)
		elseif (muted==1) then
			outputChatBox("Atualmente, você está silenciado no Chat FR.", thePlayer, 255, 0, 0)
		else
			exports.global:sendLocalText(thePlayer, "[LOOC] "..getPlayerName(thePlayer) .. ": (( " .. table.concat({...}, " ") .. " ))",127,255,212)
			exports.logs:logMessage("[OOC: Local Chat] " .. getPlayerName(thePlayer) .. ": " .. table.concat({...}, " "), 1)
		end
	end
end
addCommandHandler("b", localOOC, false, false)
addCommandHandler("LocalOOC", localOOC)

function districtIC(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
	
	if (logged==1) and not (isPedDead(thePlayer)) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Menssagem]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			local message = table.concat({...}, " ")
			local zonename = exports.global:getElementZoneName(thePlayer)
			
			for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
				local playerzone = exports.global:getElementZoneName(value)
				local playerdimension = getElementDimension(value)
				local playerinterior = getElementInterior(value)
				
				if (zonename==playerzone) and (dimension==playerdimension) and (interior==playerinterior) then
					local logged = getElementData(value, "loggedin")
					if (logged==1) then
						outputChatBox("Distrito EP: " .. message .. " ((".. playerName .."))", value, 255, 255, 255)
					end
				end
			end
		end
	end
end
addCommandHandler("district", districtIC, false, false)

function localDo(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Ação / Evento]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			exports.logs:logMessage("[EP: Local Do] * " .. message .. " *      ((" .. getPlayerName(thePlayer) .. "))", 19)
			exports.global:sendLocalDoAction(thePlayer, message)
		end
	end
end
addCommandHandler("do", localDo, false, false)


function localShout(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Menssage]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			
			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
			
			local message = trunklateText(thePlayer, table.concat({...}, " "))
			outputChatBox("[EP] " .. playerName .. " shouts: " .. message .. "!!", thePlayer, 255, 255, 255)
			exports.logs:logMessage("[IC: Local Shout] " .. playerName .. ": " .. message, 1)
			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
				if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
					local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
					local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
					
					if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) and (nearbyPlayer~=thePlayer) then
						local logged = getElementData(nearbyPlayer, "loggedin")
						
						if (logged==1) and not (isPedDead(nearbyPlayer)) then
							--local mode = tonumber(getElementData(nearbyPlayer, "chatbubbles"))
							local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
							message2 = trunklateText(nearbyPlayer, message2)
							--if mode > 0 then
							--	triggerClientEvent(nearbyPlayer, "onMessageIncome", thePlayer, message2, mode)
							--end
							outputChatBox("[EP] " .. playerName .. " shouts: " .. message2 .. "!!", nearbyPlayer, 255, 255, 255)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("s", localShout, false, false)

function megaphoneShout(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		local faction = getPlayerTeam(thePlayer)
		local factiontype = getElementData(faction, "type")
		
		if (factiontype==2) or (factiontype==3) or (factiontype==4) then
			if not (...) then
				outputChatBox("SINTAXE: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			else
				local playerName = getPlayerName(thePlayer)
				local message = trunklateText(thePlayer, table.concat({...}, " "))
				
				local languageslot = getElementData(thePlayer, "languages.current")
				local language = getElementData(thePlayer, "languages.lang" .. languageslot)
				local langname = "languages.lang1"
				
				for index, nearbyPlayer in ipairs(getElementsByType("player")) do
					if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
						local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
						local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
						
						if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
							local logged = getElementData(nearbyPlayer, "loggedin")
						
							if (logged==1) and not (isPedDead(nearbyPlayer)) then
								local message2 = message
								if nearbyPlayer ~= thePlayer then
									message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
								end
								outputChatBox(" [" .. langname .. "] ((" .. playerName .. ")) Megaphone <O: " .. trunklateText(nearbyPlayer, message2), nearbyPlayer, 255, 255, 0)
							end
						end
					end
				end
			end
		else
			outputChatBox("Acredite ou não, é difícil gritar através de um megafone que você não possui.", thePlayer, 255, 0 , 0)
		end
	end
end
addCommandHandler("m", megaphoneShout, false, false)

local togState = { }
function toggleFaction(thePlayer, commandName, State)
	local pF = getElementData(thePlayer, "faction")
	local fL = getElementData(thePlayer, "factionleader")
	local theTeam = getPlayerTeam(thePlayer)

	if fL == 1 then
		if togState[pF] == false or not togState[pF] then
			togState[pF] = true
			outputChatBox("Faction chat is now disabled.", thePlayer)
			for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
				if isElement( arrayPlayer ) then
					if getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
						outputChatBox("OOC Faction Chat Disabled", arrayPlayer, 255, 0, 0)
					end
				end
			end
		else
			togState[pF] = false
			outputChatBox("Faction chat is now enabled.", thePlayer)
			for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
				if isElement( arrayPlayer ) then
					if getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
						outputChatBox("OOC Faction Chat Enabled", arrayPlayer, 0, 255, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("togglef", toggleFaction)
addCommandHandler("togf", toggleFaction)

function factionOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local theTeamName = getTeamName(theTeam)
			local playerName = getPlayerName(thePlayer)
			local playerFaction = getElementData(thePlayer, "faction")
			
			if not(theTeam) or (theTeamName=="Citizen") then
				outputChatBox("Você não está em uma facção.", thePlayer)
			else
				local message = table.concat({...}, " ")
				
				if (togState[playerFaction]) == true then
					return
				end
				exports.logs:logMessage("[OOC: " .. theTeamName .. "] " .. playerName .. ": " .. message, 6)
			
				for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
					if isElement( arrayPlayer ) then
						if getElementData( arrayPlayer, "bigearsfaction" ) == theTeam then
							outputChatBox("((" .. theTeamName .. ")) " .. playerName .. ": " .. message, arrayPlayer, 3, 157, 157)
						elseif getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
							outputChatBox("((OOC Faction Chat)) " .. playerName .. ": " .. message, arrayPlayer, 3, 237, 237)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("f", factionOOC, false, false)

-- Admin chat
function adminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SINTAXE: /a [Messagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			exports.logs:logMessage("[Admin Chat] " .. username .. ": " .. message, 3)
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if(exports.global:isPlayerAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox(adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 51, 255, 102)
				end
			end
			
		end
	end
end

addCommandHandler("a", adminChat, false, false)


-- Admin announcement
function adminAnnouncement(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Messagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if (logged) then
					if exports.global:isPlayerAdmin(arrayPlayer) then
						outputChatBox( "Anúncio do administrador por " .. getPlayerName(thePlayer) .. ":", arrayPlayer, 255, 194, 14)
					end
					outputChatBox("   *** " .. message .. " ***", arrayPlayer, 255, 194, 14)
				end
			end
		end
	end
end
addCommandHandler("ann", adminAnnouncement, false, false)

function adminAnnouncement(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Menssagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if (logged) then
					if exports.global:isPlayerAdmin(arrayPlayer) then
						outputChatBox( "Anúncio do administrador por " .. getPlayerName(thePlayer) .. ":", arrayPlayer, 255, 194, 14)
					end
					triggerClientEvent(arrayPlayer,"aoutput",arrayPlayer,"Anúncio",message,2)
					--outputChatBox("   *** " .. message .. " ***", arrayPlayer, 255, 194, 14)
				end
			end
		end
	end
end
addCommandHandler("bnn", adminAnnouncement, false, false)

function leadAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerLeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Menssagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if (exports.global:isPlayerLeadAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox("*4+* " ..adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 204, 102, 255)
				end
			end
		end
	end
end

addCommandHandler("l", leadAdminChat, false, false)

function headAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Menssagem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if(exports.global:isPlayerHeadAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox("*5+* " ..adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 255, 204, 51)
				end
			end
		end
	end
end

addCommandHandler("h", headAdminChat, false, false)

-- Misc
local function sortTable( a, b )
	if b[2] < a[2] then
		return true
	end
	
	if b[2] == a[2] and b[4] > a[4] then
		return true
	end
	
	return false
end

function showAdmins(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) then
		local players = exports.global:getAdmins()
		local counter = 0
		
		admins = {}
		outputChatBox("#33CC99------------------------ #FFFFFFAdministradores#33CC99 ------------------------", thePlayer,255,255,255,true)

		for k, arrayPlayer in ipairs(players) do
			local hiddenAdmin = getElementData(arrayPlayer, "hiddenadmin")
			local logged = getElementData(arrayPlayer, "loggedin")
			
			if logged == 1 then
				if hiddenAdmin == 0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
					admins[ #admins + 1 ] = { arrayPlayer, getElementData( arrayPlayer, "adminlevel" ), getElementData( arrayPlayer, "adminduty" ), getPlayerName( arrayPlayer ) }
				end
			end
		end
		
		table.sort( admins, sortTable )
		
		for k, v in ipairs(admins) do
			arrayPlayer = v[1]
			local adminTitle = exports.global:getPlayerAdminTitle(arrayPlayer)
			
			if exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
				v[4] = v[4] .. " (" .. tostring(getElementData(arrayPlayer, "gameaccountusername")) .. ")"
			end
			
			if(v[3]==1)then
				outputChatBox("    " .. tostring(adminTitle) .. " " .. v[4].." - #66CC00On Duty", thePlayer, 255, 255, 255,true)
			else
				outputChatBox("    " .. tostring(adminTitle) .. " " .. v[4].." - #FF0033Off Duty", thePlayer,255,255,255,true)
			end
		end
		
		if #admins == 0 then
			outputChatBox("     No Admins Online.", thePlayer,204,204,204)
		end
		outputChatBox("#33CC99------------------------ #FFFFFFTutores#33CC99 ------------------------", thePlayer,255,255,255,true)
		local count = 0
		for k,v in ipairs( getElementsByType ( "player" )) do
			helper = tonumber(getElementData(v,"helper"))
			if helper == 1 then
					rank = "Estagiário"
			elseif helper ==2 then 
					rank = ""
			elseif helper ==3 then 
					rank = "Senior"	
			elseif helper ==4 then 
					rank = "Condutor"	
			elseif helper ==5 then 
					rank = "Cabeça"	
			end
			if helper > 0 then
					outputChatBox("   " ..rank.." Tutor "..getPlayerName(v),thePlayer,255,255,255)
					count = count + 1
			end
		end
		if count == 0 then
			
			outputChatBox("	  Não há tutores on-line",thePlayer,204,204,204)
		end
		
	end
end
addCommandHandler("admins", showAdmins, false, false)

function playerChangeChatbubbleMode(thePlayer, commandName, mode)
	local logged = getElementData(thePlayer, "loggedin")
	
	if logged == 1 then
		mode = tonumber(mode)
		if not mode or mode < 0 or mode > 2 then
			outputChatBox("SINTAXE: /" .. commandName .. " [Modo]", thePlayer, 255, 194, 14)
			outputChatBox("0 = ocultar tudo 1 = ocultar o próprio 2 = mostrar tudo", thePlayer, 255, 194, 14)
		else
			if (mode == 0) then
				outputChatBox("Todos os chatbubbles estão agora ocultos.", thePlayer, 255, 194, 14)
			elseif (mode == 1) then
				outputChatBox("Somente suas próprias conversas estão ocultas, outras são visíveis.", thePlayer, 255, 194, 14)
			elseif (mode == 2) then
				outputChatBox("Todos os chatbubbles agora estão visíveis.", thePlayer, 255, 194, 14)
			end
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "chatbubbles", mode, false)
			mysql:query_free("UPDATE accounts SET chatbubbles=" .. mysql:escape_string(mode) .. " WHERE id = " .. mysql:escape_string(getElementData( thePlayer, "gameaccountid" )) )
		end
	end
end
addCommandHandler("changecbmode", playerChangeChatbubbleMode, false, false)

function toggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer)) then
		local players = exports.pool:getPoolElementsByType("player")
		local oocEnabled = exports.global:getOOCState()
		if (commandName == "togooc") then
			if (oocEnabled==0) then
				exports.global:setOOCState(1)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					
					if	(logged==1) then
						--outputChatBox("OOC Chat Enabled by Admin.", arrayPlayer, 0, 255, 0)
						triggerClientEvent(arrayPlayer,"aoutput",arrayPlayer,"Atenção","Global FR Chat Ativado pelo Admin. Pressione 'U' para falar",2)
					end
				end
			elseif (oocEnabled==1) then
				if getPlayerCount()<=15 and not (exports.global:isPlayerLeadAdmin(thePlayer)) then
					outputChatBox("Deve haver mais de 15 jogadores para desativar este bate-papo.",thePlayer,255,2,2)
					return
				end
				exports.global:setOOCState(0)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					
					if	(logged==1) then
						--outputChatBox("OOC Chat Disabled by Admin.", arrayPlayer, 255, 0, 0)
						triggerClientEvent(arrayPlayer,"aoutput",arrayPlayer,"Atenção","Global FR Chat desativado pelo administrador.",3)
					end
				end
			end
		elseif (commandName == "stogooc") then
			if (oocEnabled==0) then
				exports.global:setOOCState(1)
				
				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					local admin = getElementData(arrayPlayer, "adminlevel")
					
					if	(logged==1) and (tonumber(admin)>0)then
						outputChatBox("FR Bate-papo ativado silenciosamente pelo administrador " .. getPlayerName(thePlayer) .. ".", arrayPlayer, 0, 255, 0)
					end
				end
			elseif (oocEnabled==1) then
				if getPlayerCount()<=15 and not (exports.global:isPlayerLeadAdmin(thePlayer)) then
					outputChatBox("Deve haver mais de 15 jogadores para desativar este bate-papo.",thePlayer,255,2,2)
					return
				end
				exports.global:setOOCState(0)
				
				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					local admin = getElementData(arrayPlayer, "adminlevel")
					
					if	(logged==1) and (tonumber(admin)>0)then
						outputChatBox("FR Bate-papo desativado silenciosamente pelo administrador " .. getPlayerName(thePlayer) .. ".", arrayPlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end

addCommandHandler("togooc", toggleOOC, false, false)
addCommandHandler("stogooc", toggleOOC, false, false)
		
function togglePM(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and ((exports.global:isPlayerAdmin(thePlayer)) or (exports.global:isPlayerBronzeDonator(thePlayer)))then
		local pmenabled = getElementData(thePlayer, "pmblocked")
		
		if (pmenabled==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "pmblocked", 0, false)
			outputChatBox("Agora os PMs estão ativados.", thePlayer, 0, 255, 0)
		else
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "pmblocked", 1, false)
			outputChatBox("PM agora estão desativados.", thePlayer, 255, 0, 0)
		end
		mysql:query_free("UPDATE accounts SET pmblocked=" .. mysql:escape_string(getElementData(thePlayer, "pmblocked")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")))
	end
end
addCommandHandler("togpm", togglePM)
addCommandHandler("togglepm", togglePM)

function toggleAds(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerGoldDonator(thePlayer))then
		local adblocked = getElementData(thePlayer, "disableAds")
		if (adblocked) then -- enable the ads again
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "disableAds", false, false)
			outputChatBox("Os anúncios estão agora ativados.", thePlayer, 0, 255, 0)
			mysql:query_free("UPDATE accounts SET adblocked=0 WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")) )
		else -- disable them D:
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "disableAds", true, false)
			outputChatBox("Os anúncios estão agora desativados.", thePlayer, 255, 0, 0)
			mysql:query_free("UPDATE accounts SET adblocked=1 WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")) )
		end
	end
end
addCommandHandler("togad", toggleAds)
addCommandHandler("togglead", toggleAds)

-- /pay
function payPlayer(thePlayer, commandName, targetPlayerNick, amount)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if not (targetPlayerNick) or not (amount) or not tonumber(amount) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Nick Parcial do Jogador] [Montante]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)
			
			if targetPlayer then
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				
				local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
				
				if (distance<=10) then
					amount = math.floor(math.abs(tonumber(amount)))
					
					local hoursplayed = getElementData(thePlayer, "hoursplayed")
					
					if (targetPlayer==thePlayer) then
						outputChatBox("Você não pode pagar dinheiro para si mesmo.", thePlayer, 255, 0, 0)
					elseif amount == 0 then
						outputChatBox("Você precisa inserir um valor maior que 0.", thePlayer, 255, 0, 0)
					elseif (hoursplayed<5) and (amount>50) and not exports.global:isPlayerAdmin(thePlayer) and not exports.global:isPlayerAdmin(targetPlayer) and not exports.global:isPlayerBronzeDonator(thePlayer) then
						outputChatBox("Você deve jogar pelo menos 5 horas antes de transferir mais de R$ 50", thePlayer, 255, 0, 0)
					elseif exports.global:takeMoney(thePlayer, amount) then
						if hoursplayed < 5 and not exports.global:isPlayerAdmin(targetPlayer) and not exports.global:isPlayerBronzeDonator(thePlayer) then
							local totalAmount = ( getElementData(thePlayer, "payAmount") or 0 ) + amount
							if totalAmount > 200 then
								outputChatBox( "Você pode apenas /pagar R$ 200 por cinco minutos. /reporte a um administrador para transferir uma quantia maior de dinheiro.", thePlayer, 255, 0, 0 )
								return
							end
							exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "payAmount", totalAmount, false)
							setTimer(
								function(thePlayer, amount)
									if isElement(thePlayer) then
										local totalAmount = ( getElementData(thePlayer, "payAmount") or 0 ) - amount
										exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "payAmount", totalAmount <= 0 and false or totalAmount, false)
									end
								end,
								300000, 1, thePlayer, amount
							)
						end
						
						exports.logs:logMessage("[Transferência de dinheiro de " .. getPlayerName(thePlayer) .. " Para: " .. targetPlayerName .. "] Valor: " .. amount .. "R$", 5)
						if (hoursplayed<5) then
							exports.global:sendMessageToAdmins("AdmWarn:Novo jogador '" .. getPlayerName(thePlayer) .. "' transferido " .. amount .. "$ para '" .. targetPlayerName .. "'.")
						end
						
						exports.global:giveMoney(targetPlayer, amount)
						
						local gender = getElementData(thePlayer, "gender")
						local genderm = "ela"
						if (gender == 1) then
							genderm = "ele"
						end
						
						exports.global:sendLocalMeAction(thePlayer, "tira algumas notas da " .. genderm .. " carteira e dá a " .. targetPlayerName .. ".")
						outputChatBox("Você deu R$" .. amount .. " para " .. targetPlayerName .. ".", thePlayer)
						outputChatBox(getPlayerName(thePlayer) .. " te deu R$" .. amount .. ".", targetPlayer)

						exports.global:applyAnimation(thePlayer, "DEALER", "shop_pay", 4000, false, true, true)
					else
						outputChatBox("Você não tem dinheiro suficiente.", thePlayer, 255, 0, 0)
					end
				else
					outputChatBox("Você está muito longe de " .. targetPlayerName .. ".", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("pay", payPlayer, false, false)

function removeAnimation(thePlayer)
	exports.global:removeAnimation(thePlayer)
end

-- /w(hisper)
function localWhisper(thePlayer, commandName, targetPlayerNick, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (targetPlayerNick) or not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Nick Parcial do Jogador / ID] [Menssagem]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)
			
			if targetPlayer then
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				
				if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)<3) then
					local name = getPlayerName(thePlayer)
					local message = table.concat({...}, " ")
					exports.logs:logMessage("[EP: Sussurro] " .. name .. " para " .. targetPlayerName .. ": " .. message, 1)
					message = trunklateText( thePlayer, message )
					
					local languageslot = getElementData(thePlayer, "languages.current")
					local language = getElementData(thePlayer, "languages.lang" .. languageslot)
					local languagename = "languages.lang1"
					
					message2 = trunklateText( targetPlayer, message2 )
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayer, message, language)
					
					exports.global:sendLocalMeAction(thePlayer, "Sussurro para " .. targetPlayerName .. ".")
					outputChatBox("[EP] " .. name .. " Sussurro: " .. message, thePlayer, 255, 255, 255)
					outputChatBox("[EP] " .. name .. " Sussurro: " .. message2, targetPlayer, 255, 255, 255)
					for i,p in ipairs(getElementsByType( "player" )) do
						if (getElementData(p, "adminduty") == 1) then
							if p ~= targetPlayer and p ~= thePlayer then
								local ax, ay, az = getElementPosition(p)
								if (getDistanceBetweenPoints3D(x, y, z, ax, ay, az)<4) then
									outputChatBox("[EP] " .. name .. " Sussurro para " .. getPlayerName(targetPlayer):gsub("_"," ") .. ": " .. message, p, 255, 255, 255)
								end
							end
						end
					end
				else
					outputChatBox("Você está muito longe de " .. targetPlayerName .. ".", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("w", localWhisper, false, false)

-- /c(lose)
function localClose(thePlayer, commandName, ...)
	if exports['freecam-tv']:isPlayerFreecamEnabled(thePlayer) then return end
	
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local name = getPlayerName(thePlayer)
			local message = table.concat({...}, " ")
			exports.logs:logMessage("[IC: Whisper] " .. name .. ": " .. message, 1)
			message = trunklateText( thePlayer, message )
			
			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
			
			for index, targetPlayers in ipairs( getElementsByType( "player" ) ) do
				if getElementDistance( thePlayer, targetPlayers ) < 5 then
					local message2 = message
					if targetPlayers ~= thePlayer then
						message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayers, message, language)
						message2 = trunklateText( targetPlayers, message2 )
					end
					local pveh = getPedOccupiedVehicle(targetPlayers)
					if pveh then
						if (exports['vehicle-system']:isVehicleWindowUp(pveh)) then			
							outputChatBox( " [EP] " .. name .. " Sussurro: " .. message2, targetPlayers, 255, 255, 255)
						end
					else
						outputChatBox( " [EP] " .. name .. " Sussurro: " .. message2, targetPlayers, 255, 255, 255)
					end
				end
			end
		end
	end
end
addCommandHandler("c", localClose, false, false)

------------------
-- News Faction --
------------------
-- /n(ews)
function newsMessage(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		
		if(factionType==6)then -- news faction
			
			if not(...)then
				outputChatBox("SINTAXE: /" .. commandName .. " [Mensagem]", thePlayer, 255, 194, 14)
			else
				local message = table.concat({...}, " ")
				local name = getPlayerName(thePlayer)
				
				local abuse = true
				if (getElementDimension(thePlayer) == 9902) then
					abuse = false
				end
				for index, nearbyVehicle in ipairs( exports.global:getNearbyElements(thePlayer, "vehicle", 25) ) do
					if (getElementModel(nearbyVehicle) == 582) then
					 abuse = false
					end
				end
				
				if not abuse then
					exports.logs:logMessage("[EP: Notícias] " .. name .. ": " .. message, 18)
				else
					exports.logs:logMessage("[A" .. getElementDimension(thePlayer) .. "][EP: Notícias ] " .. name .. ": " .. message, 18)
				end
				
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
						
					if (getElementData(value, "loggedin")==1) then
							
						if not(getElementData(value, "tognews")==1) then
							outputChatBox("[Notícias] ".. name .." diz: ".. message, value, 200, 100, 200)
						end
					end
				end
				
				exports.global:giveMoney(theTeam, 200)
			end
		end
	end
end
addCommandHandler("san", newsMessage, false, false)

-- /tognews
function togNews(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) and (exports.global:isPlayerGoldDonator(thePlayer)) then
		local newsTog = getElementData(thePlayer, "tognews")
		
		if (newsTog~=1) then
			outputChatBox("/news desativado.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "tognews", 1, false)
		else
			outputChatBox("/news ativado.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "tognews", 0, false)
		end
		mysql:query_free("UPDATE accounts SET newsblocked=" .. mysql:escape_string(getElementData(thePlayer, "tognews")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "gameaccountid")) )
	end
end
addCommandHandler("tognews", togNews, false, false)
addCommandHandler("togglenews", togNews, false, false)


-- /startinterview
function StartInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SINTAXE: /" .. commandName .. " [Nick Parcial do Jogador]", thePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialPlayer)
				if targetPlayer then
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if(getElementData(targetPlayer,"interview"))then
							outputChatBox("Este jogador já está sendo entrevistado.", thePlayer, 255, 0, 0)
						else
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "interview", true, false)
							local playerName = getPlayerName(thePlayer)
							outputChatBox(playerName .." ofereceu-lhe uma entrevista.", targetPlayer, 0, 255, 0)
							outputChatBox("((Use / i para conversar durante a entrevista.))", targetPlayer, 0, 255, 0)
							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .." Foi convidado" .. targetPlayerName .. " para uma entrevista.))", value, 0, 255, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("interview", StartInterview, false, false)

-- /endinterview
function endInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SINTAXE: /" .. commandName .. " [Nick Parcial do Jogador]", thePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialPlayer)
				if targetPlayer then
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if not(getElementData(targetPlayer,"interview"))then
							outputChatBox("Este jogador não está sendo entrevistado.", thePlayer, 255, 0, 0)
						else
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "interview")
							local playerName = getPlayerName(thePlayer)
							outputChatBox(playerName .." terminou sua entrevista.", targetPlayer, 255, 0, 0)
						
							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .." terminou " .. targetPlayerName .. " entrevista.))", value, 255, 0, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("endinterview", endInterview, false, false)

-- /i
function interviewChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		if(getElementData(thePlayer, "interview"))then
			if not(...)then
				outputChatBox("SINTAXE: /" .. commandName .. "[Message]", thePlayer, 255, 194, 14)
			else
				local message = table.concat({...}, " ")
				local name = getPlayerName(thePlayer)
				
				exports.logs:logMessage("[IC: Interview Guest] " .. name .. ": " .. message, 18)
				
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					if (getElementData(value, "loggedin")==1) then
						if not (getElementData(value, "tognews")==1) then
							outputChatBox("[NEWS] Interview Guest " .. name .." diz: ".. message, value, 200, 100, 200)
						end
					end
				end
				
				exports.global:giveMoney(getTeamFromName"San Andreas Network", 200)
			end
		end
	end
end
addCommandHandler("i", interviewChat, false, false)

-- news hotline /news
function newsHotline(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if not (...) then
			outputChatBox("SINTAXE: /" .. commandName .. " [Description of Situation]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			local dimension = getElementDimension(thePlayer)
			local interior = getElementInterior(thePlayer)
			
			local message = table.concat({...}, " ")
			message = string.gsub(message, "#%x%x%x%x%x%x", "") -- Remove colour codes
			
			-- Show chat to console, for admins + log
			exports.global:sendLocalMeAction(thePlayer,"dials a number on their cellphone.")
			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
				local dist = getElementDistance( thePlayer, targetPlayers )
				if dist < 20 then
					local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
					local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
					if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
						local logged = tonumber(getElementData(nearbyPlayer, "loggedin"))
						if not (isPedDead(nearbyPlayer)) and (logged==1) then
							if dist < 4 then
								outputChatBox( "#EEEEEE" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 8 then
								outputChatBox( "#DDDDDD" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 12 then
								outputChatBox( "#CCCCCC" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 16 then
								outputChatBox( "#BBBBBB" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							else
								outputChatBox( "#AAAAAA" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							end
						end
					end
				end
			end
		
			outputChatBox("Thank you for calling the San Andreas Network Desk. Your tip will be forwarded to our staff.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer,"hangs up their cellphone.")
			
			local playerNumber = getElementData(thePlayer, "cellnumber")
			local theTeam = getTeamFromName("San Andreas Network")
			local teamMembers = getPlayersInTeam(theTeam)
			
			for key, value in ipairs(teamMembers) do
				if(exports.global:hasItem(value,2))then
					if getElementData( value, "phoneoff" ) ~= 1 then
						for _,nearbyPlayer in ipairs(exports.global:getNearbyElements(value, "player")) do
							triggerClientEvent(nearbyPlayer, "startRinging", value, 2)
						end
						exports.global:sendLocalMeAction(value,"receives a text message.")
					end
					outputChatBox("SMS From: News Desk - '".. message.."' Ph:".. playerNumber .." (("..getPlayerName(thePlayer) .."))", value)
				end
			end
		end
	end
end
addCommandHandler("news", newsHotline, false, false)

function showRoadmap(thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		outputChatBox("Carregando Progresso ... Aguarde ...", thePlayer, 255, 194, 15)
		callRemote("", displayRoadmap, thePlayer)
	end
end
--addCommandHandler("roadmap", showRoadmap)
--addCommandHandler("progress", showRoadmap)

function displayRoadmap(thePlayer, version1, percent1, changes1, version2, percent2, changes2, version3, percent3, changes3, mtaversion, mtapercent, mtachanges)
	if (thePlayer~="ERROR") then
		outputChatBox("~~~~~~~~~~~~~~~~~~ Progresso ~~~~~~~~~~~~~~~~~~", thePlayer, 255, 194, 15)
		outputChatBox("" .. version1 .. ": " .. percent1 .. ". Mudança: " .. changes1 .. ".", thePlayer, 255, 194, 15)
		outputChatBox(" " .. version2 .. ": " .. percent2 .. ". Mudança: " .. changes2 .. ".", thePlayer, 255, 194, 15)
		outputChatBox(" " .. version3 .. ": " .. percent3 .. ". Mudança: " .. changes3 .. ".", thePlayer, 255, 194, 15)
		outputChatBox("MultiTheftAuto " .. mtaversion .. ": " .. mtapercent .. ". Mudança: " .. mtachanges .. ".", thePlayer, 255, 194, 15)
	end
end


function disableMsg(message, player)
	cancelEvent()

	-- send it using our own PM etiquette instead
	pmPlayer(source, "pm", player, message)
end
addEventHandler("onPlayerPrivateMessage", getRootElement(), disableMsg)