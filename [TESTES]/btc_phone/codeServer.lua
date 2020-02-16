--[[
function EnviarMoney(item, targetplayer)
         if item < getElementData(source, "char:money") or item == getElementData(source, "char:money") then
		local targetPlayer2, targetPlayerName = exports.btc_core:findPlayer(source, targetplayer)
		
		setElementData(source, "char:money", (getElementData(source, "char:money") or 0)-item)
		setElementData(targetPlayer2, "char:money", (getElementData(targetPlayer2, "char:money") or 0) + item)
		outputChatBox("#dc143c[BGOMTA - Banco]: #ffffff "..getPlayerName(source).." Fez uma transferência R$ "..item.." para você!", targetPlayer2, 25, 152, 139, true)
		else
		outputChatBox("#dc143c[BGOMTA - Banco]: #ffffffVocê não tem dinheiro", source, 25, 152, 139, true)
    end
end
addEvent("EnviarMoney", true)
addEventHandler("EnviarMoney", root, EnviarMoney)]]--

function giveMoneyToPlayer(id,money)
if isTimer(timer) then return end

local player2 = exports.btc_core:findPlayer(source, id)
if player2 then
if (source ~= player2) then
local x, y, z = getElementPosition(source)
local tx, ty, tz = getElementPosition(player2)
local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)	
if distance <= 3  then
	timer = setTimer(function() end, 5000, 1) 
if getElementData(source, "char:money") >= money then 
setElementData(source, "char:money", getElementData(source, "char:money")-money)
setElementData(player2, "char:money", getElementData(player2, "char:money")+money)
outputChatBox ( "#FFFFFF*Você enviou R$: "..money.." para " .. getPlayerName(player2), source , 200, 0, 0, true)
outputChatBox ( "#FFFFFF*" .. getPlayerName(source) .." enviou R$: "..money.." para você ", player2, 200, 0, 0, true)
exports.btc_hud:dm("Você enviou R$: "..money.." para " .. getPlayerName(player2),source, 200, 100, 0)
exports.btc_hud:dm("*" .. getPlayerName(source) .." enviou R$: "..money.." para você",player2, 200, 100, 0)


exports.logs:logMessage("[TRANSFERENCIA CELULAR]: "..getPlayerName(source).." ID: "..getElementData(source, "acc:id").." enviou via celular R$: "..money.." para "..getPlayerName(player2).." ID: "..getElementData(player2, "acc:id").." ", 1)	



else
	outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFVocê está sem dinheiro', source,255,255,255,true) 
end
else
exports.btc_hud:dm("*Este jogador esta muito longe de você",source, 200, 100, 0)
end
else
exports.btc_hud:dm("*Você pode enviar dinheiro pra você mesmo!",source, 200, 100, 0)
outputChatBox ( "#FFFFFF*Você pode enviar dinheiro pra você mesmo!", source , 200, 0, 0, true)
end
else
exports.btc_hud:dm("*Este jogador não esta online!",source, 200, 100, 0)
outputChatBox ( "#FFFFFF*Este jogador não esta online!", source , 200, 0, 0, true)
end
end
addEvent("MoneyTransfer",true)
addEventHandler("MoneyTransfer",root,giveMoneyToPlayer)

function vfPhone (thePlayer, vplayer)
     if (vplayer) then
		  if exports['btc_items']:hasItemS(vplayer, 16) then
	      	 outputChatBox("#7cc576#FFFFFFPossui celular no bolso: #7cc576Sim", thePlayer, 255, 255, 255, true)
     	 else
 	     	 outputChatBox("#FFFFFFPossui celular no bolso: #7cc576Não", thePlayer, 255, 255, 255, true)
		 end
	 end
end
addEvent("vPhone",true)
addEventHandler("vPhone",root,vfPhone)

function giveMoneyToPlayer2(thePlayer,commandName, id,  money)
	if not (id) then
		outputChatBox("#7cc576Erro:#ffffff /" .. commandName .. " [nome / ID] Quantidade", thePlayer, 255, 255, 255, true)
	else

	local player2 = exports.btc_core:findPlayer(thePlayer, id)
	if player2 then
	if (thePlayer ~= player2) then
	local x, y, z = getElementPosition(thePlayer)
	local tx, ty, tz = getElementPosition(player2)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)	
	if distance <= 3  then
		if tonumber(id) <= getElementData(thePlayer, "char:money") or tonumber(id) == getElementData(thePlayer, "char:money") then
	setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money")-money)
	setElementData(player2, "char:money", getElementData(player2, "char:money")+money)
	outputChatBox ( "#FFFFFF*Você enviou R$: "..money.." para " .. getPlayerName(player2), thePlayer , 200, 0, 0, true)
	outputChatBox ( "#FFFFFF*" .. getPlayerName(thePlayer) .." enviou R$: "..money.." para você ", player2, 200, 0, 0, true)
	exports.btc_hud:dm("Você enviou R$: "..money.." para " .. getPlayerName(player2),thePlayer, 200, 100, 0)
	exports.btc_hud:dm("*" .. getPlayerName(thePlayer) .." enviou R$: "..money.." para você",player2, 200, 100, 0)
	else
		outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFVocê está sem dinheiro', thePlayer,255,255,255,true) 
	end
	else
	exports.btc_hud:dm("*Este jogador esta muito longe de você",thePlayer, 200, 100, 0)
	end
	else
	exports.btc_hud:dm("*Você pode enviar dinheiro pra você mesmo!",thePlayer, 200, 100, 0)
	outputChatBox ( "#FFFFFF*Você pode enviar dinheiro pra você mesmo!", thePlayer , 200, 0, 0, true)
	end
	else
	exports.btc_hud:dm("*Este jogador não esta online!",thePlayer, 200, 100, 0)
	outputChatBox ( "#FFFFFF*Este jogador não esta online!", thePlayer , 200, 0, 0, true)
	end
	end
end
--addCommandHandler("enviar", giveMoneyToPlayer2)





local animTimer = {}
local phone = {}


addEvent("BTCdroid.startAnimation", true)
addEventHandler("BTCdroid.startAnimation", root, function()
    --setPedWeaponSlot(client, 0)
	phone[client] = createObject(330, 0, 0, 0, 0, 0, 0)
	exports.bone_attach:attachElementToBone(phone[client], client, 12, 0, 0.01, 0.03, -15, 270, -15)
	setElementDimension(phone[client], getElementDimension(client))
	setElementInterior(phone[client], getElementInterior(client))
	setPedAnimation ( client, "ped","phone_in", 1000, false, false, false, true)
	animTimer[client] = setTimer(function(player)
		if ( isElement(player) ) then
			setPedAnimationProgress(player, "phone_in", 0.8)
		end
	end, 500, 0, client)
end)

addEvent("BTCdroid.stopAnimation", true)
addEventHandler("BTCdroid.stopAnimation", root, function()
	removePhone(client)
	setPedAnimation ( client, "ped", "phone_out", 50, false, false, false, false)
end)

addEventHandler("onPlayerQuit", root, function()
	removePhone(source)
end)

addEventHandler("onPlayerWasted", root, function()
	removePhone(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	removePhone(source)
end)

function removePhone(player)
	if (phone[player]) then
		destroyElement(phone[player])
		phone[player] = nil
	end
	if (animTimer[player]) then
		killTimer(animTimer[player])
		animTimer[player] = nil
	end	
	setPedAnimation(player)
end


function abrircelular()
	exports.btc_chat:sendLocalMeAction(source, "Abriu o celular.")
end
addEvent("abrircelular", true)
addEventHandler("abrircelular", root, abrircelular)


function animarcelular(teste)
executeCommandHandler (teste, source)

end
addEvent("animarcelular", true)
addEventHandler("animarcelular", root, animarcelular)

 function painel(thePlayer)
	if getElementData(thePlayer, "loggedin") == false then return end
	if exports.btc_items:hasItemS(thePlayer, 16) then 
		setElementData(thePlayer, "celular", true)
		triggerClientEvent(thePlayer, "Celular", getRootElement())
		
		

	else
	setElementData(thePlayer, "celular", false)
	triggerClientEvent(thePlayer, "Celular", getRootElement())
	--	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	--	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	--	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	--	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	--	outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você não tem celular é preciso comprar um nos comercios da cidade ( Icone Bolinha amarela no F11 ).", thePlayer, 255, 255, 255, true)
	end
end

--[[
 function painel(thePlayer)
	--if getElementData(thePlayer, "loggedin") == false then return end
		triggerClientEvent(thePlayer, "Celular", getRootElement())
		
		
end
]]--
function restart()
	for index, player in ipairs(getElementsByType("player")) do
		bindKey(player, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
		unbindKey(player, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)












local BLIP_VISIBLE_DISTANCE = 750

local blips2 = {}
local blips3 = {}
local blips4 = {}

local BLIP_VISIBLE_DISTANCE = 750
local blips = {}

player_blips = {} --creating a table 


local medicoCall = {}
local medicoCallCount = 0
addEvent( "SendMsgToTeammedic", true )
addEventHandler( "SendMsgToTeammedic", root,
function (menCopom)

	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end


	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)


		if getElementData(source, "call:medico") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end

		outputChatBox("#bebebeVocê chamou o medico, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou o médico, aguarde.", source, 255, 200, 0)

		medicoCallCount = medicoCallCount + 1
		medicoCall[medicoCallCount] = source
		setElementData(source, "call:medico", medicoCallCount)

		setTimer ( setElementData, 60000, 1, source, "call:medico", false)
		tirarchamadomedicoCall = setTimer(function()
			medicoCall[medicoCallCount] = nil
		end, 25000, 1 )




		local x, y, z = getElementPosition(source)
		setElementData(source, "call:medicoposx", x)
		setElementData(source, "call:medicoposy", y)
		setElementData(source, "call:medicoposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 4  then
			   outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
         outputChatBox("#FFA000[COPOM RESGATE] #FFFFFFUnidade disponivel? Chamada: #FFA000"..medicoCallCount, player, 255, 255, 255, true)
				 outputChatBox("#FFA000[COPOM RESGATE] #FFFFFFChamada feita por: "..getPlayerName(source), player, 255, 255, 255, true)
				 outputChatBox("#FFA000[COPOM RESGATE] #FFFFFFChamada emitida: #FFA000"..menCopom, player, 255, 255, 255, true)
			  end
		end
end )



local prfCall = {}
local prfCallCount = 0
addEvent( "SendMsgToTeamPRF", true )
addEventHandler( "SendMsgToTeamPRF", root,
function (menCopom)
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end

		if getElementData(source, "call:prf") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end

		outputChatBox("#bebebeVocê chamou a Polícia Rodoviaria Federal aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou a Polícia Rodoviaria Federal aguarde.", source, 255, 200, 0)

		prfCallCount = prfCallCount + 1
		prfCall[prfCallCount] = source
		setElementData(source, "call:prf", prfCallCount)

		setTimer ( setElementData, 60000, 1, source, "call:prf", false)
		tirarchamadoprfCall = setTimer(function()
			prfCall[prfCallCount] = nil
		end, 25000, 1 )




		local x, y, z = getElementPosition(source)
		setElementData(source, "call:prfposx", x)
		setElementData(source, "call:prfposy", y)
		setElementData(source, "call:prfposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 21  then
			   outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
                 outputChatBox("#1060FF[COPOM PRF] #FFFFFFUnidade disponivel? Chamada: #FFE600"..prfCallCount, player, 255, 255, 255, true)
				 outputChatBox("#1060FF[COPOM PRF] #FFFFFFChamada feita por: #FFE600"..getPlayerName(source), player, 255, 255, 255, true)
				 outputChatBox("#1060FF[COPOM PRF] #FFFFFFChamada emitida: #FFE600"..menCopom, player, 255, 255, 255, true)
			  end
		end
end )

function aceitarprf(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 21  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if prfCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("A PRF aceitou sua chamada e está a caminho", prfCall[acceptID], 255, 200, 0)
				if isTimer(tirarchamadoprfCall) then
						killTimer(tirarchamadoprfCall)
				end
				local x, y, z = getElementData(prfCall[acceptID], "call:prfposx"), getElementData(prfCall[acceptID], "call:prfposy"), getElementData(prfCall[acceptID], "call:prfposz")
				triggerClientEvent(thePlayer, "createdetranMarker", thePlayer, thePlayer, acceptID, prfCall[acceptID], x, y, z)
				prfCall[acceptID] = nil
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("prf", aceitarprf)

function aceitarmedico(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 4  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if medicoCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("O medico aceitou sua chamada e está a caminho", medicoCall[acceptID], 255, 200, 0)
				if isTimer(tirarchamadomedicoCall) then
				killTimer(tirarchamadomedicoCall)
				end
				local x, y, z = getElementData(medicoCall[acceptID], "call:medicoposx"), getElementData(medicoCall[acceptID], "call:medicoposy"), getElementData(medicoCall[acceptID], "call:medicoposz")
				triggerClientEvent(thePlayer, "createMedicoMarker", thePlayer, thePlayer, acceptID, medicoCall[acceptID], x, y, z)
				medicoCall[acceptID] = nil
			  else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("ac", aceitarmedico)



local msCall = {}
local msCount = 0
addEvent( "SendMsgToTeamPolicia", true )
addEventHandler( "SendMsgToTeamPolicia", root,
function (menCopom)

	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end

	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

		if getElementData(source, "call:policia") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end
		msCount = msCount + 1
		msCall[msCount] = source
		setElementData(source, "call:policia", msCount)

		outputChatBox("#bebebeVocê chamou a policia, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou a policia, aguarde.", source, 255, 200, 0)

		setTimer ( setElementData, 60000, 1, source, "call:policia", false)
		tirarchamadomsCount = setTimer(function()
		msCall[msCount] = nil
		end, 25000, 1 )


		local x, y, z = getElementPosition(source)
		setElementData(source, "call:policiaposx", x)
		setElementData(source, "call:policiaposy", y)
		setElementData(source, "call:policiaposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 17 or getElementData(player, "char:dutyfaction") == 6 or getElementData(player, "char:dutyfaction") == 24 or getElementData(player, "char:dutyfaction") == 19  or getElementData(player, "char:dutyfaction") == 2 or getElementData(player, "char:dutyfaction") == 5 or getElementData(player, "char:dutyfaction") == 19 or getElementData(player, "char:dutyfaction") == 16 or getElementData(player, "char:dutyfaction") == 11 or  getElementData(player, "char:dutyfaction") == 20 or getElementData(player, "char:dutyfaction") == 21 or getElementData(player, "char:dutyfaction") == 22  then
			     outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
				 outputChatBox(" ", player, 255, 255, 255, true)
                 outputChatBox("#FFA000[COPOM POLICIA] #FFFFFFUnidade disponivel? Chamada: #FFA000"..msCount, player, 255, 255, 255, true)
				 outputChatBox("#FFA000[COPOM POLICIA] #FFFFFFChamada feita por: "..getPlayerName(source), player, 255, 255, 255, true)
				 outputChatBox("#FFA000[COPOM POLICIA] #FFFFFFChamada emitida: #FFA000"..menCopom, player, 255, 255, 255, true)
			  end
		end
end )

function aceitarpolicia(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 24 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 22  then
			if (acceptID) then
			local acceptID = tonumber(acceptID)
			if msCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("A Policia aceitou sua chamada e está a caminho", msCall[acceptID], 255, 200, 0)

				if isTimer(tirarchamadomsCount) then
						killTimer(tirarchamadomsCount)
				end

				local x, y, z = getElementData(msCall[acceptID], "call:policiaposx"), getElementData(msCall[acceptID], "call:policiaposy"), getElementData(msCall[acceptID], "call:policiaposz")
				triggerClientEvent(thePlayer, "createPoliciaMarker", thePlayer, thePlayer, acceptID, msCall[acceptID], x, y, z)
				msCall[acceptID] = nil
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarpolicia)





local mecanicoCall = {}
local mecanicoCount = 0
addEvent( "SendMsgToTeamMecanico", true )
addEventHandler( "SendMsgToTeamMecanico", root,
function (  )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end


	if getElementData(source, "call:mecanico") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o mecanico, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou o mecanico, aguarde.", source, 255, 200, 0)





		mecanicoCount = mecanicoCount + 1
		mecanicoCall[mecanicoCount] = source
		setElementData(source, "call:mecanico", mecanicoCount)



		setTimer ( setElementData, 60000, 1, source, "call:mecanico", false)

		tirarchamadomecanicoCount = setTimer(function()
			mecanicoCall[mecanicoCount] = nil
		end, 25000, 1 )



		local x, y, z = getElementPosition(source)
		setElementData(source, "call:mecanicoposx", x)
		setElementData(source, "call:mecanicoposy", y)
		setElementData(source, "call:mecanicoposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 3  then
				outputChatBox("#bebebe"..getPlayerName(source).." chamou o mecanico utilize /ac " .. mecanicoCount .. " para aceitar o pedido", player, 255, 255, 255, true)
				displayServerMessage(player, ""..getPlayerName(source).." chamou  o mecanico utilize /ac " .. mecanicoCount .. " para aceitar o pedido", "warning")
			  end
		end
end )

function aceitarmecanico(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 3  then

		if getElementData(thePlayer, "emcall:mecanico") == true then
		exports.btc_hud:dm("você ja tem uma chamada em andamento!", thePlayer, 255, 200, 0)
		return 
		end



		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if mecanicoCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("O mecanico aceitou sua chamada e está a caminho", mecanicoCall[acceptID], 255, 200, 0)

					if isTimer(tirarchamadomecanicoCount) then
						killTimer(tirarchamadomecanicoCount)
					end

					setElementData(thePlayer, "emcall:mecanico", true)

				local x, y, z = getElementData(mecanicoCall[acceptID], "call:mecanicoposx"), getElementData(mecanicoCall[acceptID], "call:mecanicoposy"), getElementData(mecanicoCall[acceptID], "call:mecanicoposz")
				triggerClientEvent(thePlayer, "createMecanicoMarker", thePlayer, thePlayer, acceptID, mecanicoCall[acceptID], x, y, z)
				mecanicoCall[acceptID] = nil
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarmecanico)










local taxiCall = {}
local taxiCount = 0
addEvent( "SendMsgToTeamtaxi", true )
addEventHandler( "SendMsgToTeamtaxi", root,
function (  )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)


	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end


	if getElementData(source, "call:taxi") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o taxi, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou o taxi, aguarde.", source, 255, 200, 0)


		taxiCount = taxiCount + 1
		taxiCall[taxiCount] = source
		setElementData(source, "call:taxi", taxiCount)

		setTimer ( setElementData, 60000, 1, source, "call:taxi", false)
		tirarchamadotaxiCall = setTimer(function()
			taxiCall[taxiCount] = nil
		end, 25000, 1 )






		local x, y, z = getElementPosition(source)
		setElementData(source, "call:taxiposx", x)
		setElementData(source, "call:taxiposy", y)
		setElementData(source, "call:taxiposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 12  then
				outputChatBox("#bebebe"..getPlayerName(source).." chamou o taxi utilize /ac " .. taxiCount .. " para aceitar o pedido", player, 255, 255, 255, true)
				displayServerMessage(player, ""..getPlayerName(source).." chamou  o taxi utilize /ac " .. taxiCount .. " para aceitar o pedido", "warning")
			  end
		end
end )

function aceitartaxi(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 12  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if taxiCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("O taxi aceitou sua chamada e está a caminho", taxiCall[acceptID], 255, 200, 0)



				if isTimer(tirarchamadotaxiCall) then
						killTimer(tirarchamadotaxiCall)
				end



				local x, y, z = getElementData(taxiCall[acceptID], "call:taxiposx"), getElementData(taxiCall[acceptID], "call:taxiposy"), getElementData(taxiCall[acceptID], "call:taxiposz")
				triggerClientEvent(thePlayer, "createtaxiMarker", thePlayer, thePlayer, acceptID, taxiCall[acceptID], x, y, z)
				taxiCall[acceptID] = nil

			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitartaxi)




local detranCall = {}
local detranCount = 0
addEvent( "SendMsgToTeamDetran", true )
addEventHandler( "SendMsgToTeamDetran", root,
function (  )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)


	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end



	if getElementData(source, "call:detran") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o detran, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou o detran, aguarde.", source, 255, 200, 0)


		detranCount = detranCount + 1
		detranCall[detranCount] = source
		setElementData(source, "call:detran", detranCount)


		setTimer ( setElementData, 60000, 1, source, "call:detran", false)
		tirarchamadodetranCall = setTimer(function()
			detranCall[detranCount] = nil
		end, 25000, 1 )


		local x, y, z = getElementPosition(source)
		setElementData(source, "call:detranposx", x)
		setElementData(source, "call:detranposy", y)
		setElementData(source, "call:detranposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 1  then
				outputChatBox("#bebebe"..getPlayerName(source).." chamou o detran utilize /ac " .. detranCount .. " para aceitar o pedido", player, 255, 255, 255, true)
				displayServerMessage(player, ""..getPlayerName(source).." chamou  o detran utilize /ac " .. detranCount .. " para aceitar o pedido", "warning")
			  end
		end
end )

function aceitardetran(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 1  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if detranCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("O detran aceitou sua chamada e está a caminho", detranCall[acceptID], 255, 200, 0)

				if isTimer(tirarchamadodetranCall) then
						killTimer(tirarchamadodetranCall)
				end


				local x, y, z = getElementData(detranCall[acceptID], "call:detranposx"), getElementData(detranCall[acceptID], "call:detranposy"), getElementData(detranCall[acceptID], "call:detranposz")
				triggerClientEvent(thePlayer, "createdetranMarker", thePlayer, thePlayer, acceptID, detranCall[acceptID], x, y, z)
				detranCall[acceptID] = nil


				chamadodetranCount = setTimer(function()
					detranCount = detranCount - 1
				end, 30000, 1 )


			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitardetran)


local staffCall = {}
local staffCount = 0
addEvent( "SendMsgToTeamstaff", true )
addEventHandler( "SendMsgToTeamstaff", root,
function (  )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)



	local pX,pY,pZ = getElementPosition(source)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= source then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", source, 255, 255, 255, true)
				return
			end
		end
	end
end


	if getElementData(source, "call:staff") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", source, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o staff, aguarde.", source, 255, 255, 255, true)
		exports.btc_hud:dm(" "..getPlayerName(source).." Você chamou o staff, aguarde.", source, 255, 200, 0)


		staffCount = staffCount + 1
		staffCall[staffCount] = source
		setElementData(source, "call:staff", staffCount)


		setTimer ( setElementData, 60000, 1, source, "call:staff", false)
		tirarchamadostaffCall = setTimer(function()
			staffCall[staffCount] = nil
		end, 25000, 1 )


		local x, y, z = getElementPosition(source)
		setElementData(source, "call:staffposx", x)
		setElementData(source, "call:staffposy", y)
		setElementData(source, "call:staffposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:adminduty") == 1  then
				outputChatBox("#bebebe"..getPlayerName(source).." chamou o staff utilize /ac " .. staffCount .. " para aceitar o pedido", player, 255, 255, 255, true)
				displayServerMessage(player, ""..getPlayerName(source).." chamou  o staff utilize /ac " .. staffCount .. " para aceitar o pedido", "warning")
			  end
		end
end )

ChamadasS = {}



function aceitarstaff(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:adminduty") == 1  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if staffCall[acceptID] then
				exports.btc_hud:dm("Você aceitou o chamado " .. acceptID .. "", thePlayer, 255, 200, 0)
				exports.btc_hud:dm("O staff "..getPlayerName(thePlayer).." aceitou sua chamada", staffCall[acceptID], 255, 200, 0)

				--if isTimer(chamadostaffCall) then
				--	killTimer(chamadostaffCall)
				--end
				if isTimer(tirarchamadostaffCall) then
						killTimer(tirarchamadostaffCall)
				end

				for theKey,player in ipairs (getElementsByType("player")) do
					if getElementData(player, "char:adminduty") == 1  then
						outputChatBox(" ", player, 255, 255, 255, true)
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeStaff "..getPlayerName(thePlayer).." aceitou o chamado " .. staffCount .. "", player, 255, 255, 255, true)
						outputChatBox(" ", player, 255, 255, 255, true)
						--setChamada (thePlayer)
					  end
				end

				setChamada (thePlayer)

				local x, y, z = getElementData(staffCall[acceptID], "call:staffposx"), getElementData(staffCall[acceptID], "call:staffposy"), getElementData(staffCall[acceptID], "call:staffposz")
				setElementPosition(thePlayer, x, y, z)
				setElementData(thePlayer, "call:staff", nil)
				--triggerClientEvent(thePlayer, "createstaffMarker", thePlayer, thePlayer, acceptID, staffCall[acceptID], x, y, z)
				staffCall[acceptID] = nil




				--staffCount = staffCount - 1
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarstaff)



for theKey,player in ipairs (getElementsByType("player")) do
	setElementData(player, "call:staff", nil)
	setElementData(player, "call:policia", nil)
	setElementData(player, "call:mecanico", nil)
	setElementData(player, "call:medico", nil)
	setElementData(player, "call:prf", nil)
	setElementData(player, "call:taxi", nil)
	setElementData(player, "call:detran", nil)
end



setTimer(function()
	if staffCount > 0 then
	staffCount = staffCount - 1

	--for theKey,player in ipairs (getElementsByType("player")) do
	--	if getElementData(player, "char:adminduty") == 1  then
	--		outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de staff alteradas para  "..staffCount.."   ", player, 255, 255, 255, true)
	--	end
	--end


	end
	if detranCount > 0 then
		detranCount = detranCount - 1

		
	--for theKey,player in ipairs (getElementsByType("player")) do
	--	if getElementData(player, "char:adminduty") == 1  then
	--		outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de detran alteradas para  "..detranCount.."   ", player, 255, 255, 255, true)
	--	end
	--end


	end
	if taxiCount > 0 then
		taxiCount = taxiCount - 1

		--for theKey,player in ipairs (getElementsByType("player")) do
		--	if getElementData(player, "char:adminduty") == 1  then
		--		outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de taxi alteradas para  "..taxiCount.."   ", player, 255, 255, 255, true)
		--	end
		--end
	end
	if mecanicoCount > 0 then
		mecanicoCount = mecanicoCount - 1

	--	for theKey,player in ipairs (getElementsByType("player")) do
	--		if getElementData(player, "char:adminduty") == 1  then
	--			outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de mecanico alteradas para  "..mecanicoCount.."   ", player, 255, 255, 255, true)
	--		end
	--	end


	end
	if msCount > 0 then
		msCount = msCount - 1

	--	for theKey,player in ipairs (getElementsByType("player")) do
	----		if getElementData(player, "char:adminduty") == 1  then
	--			outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de Policia alteradas para  "..msCount.."   ", player, 255, 255, 255, true)
	--		end
	--	end


	end
	if prfCallCount > 0 then
		prfCallCount = prfCallCount - 1

	--	for theKey,player in ipairs (getElementsByType("player")) do
	--		if getElementData(player, "char:adminduty") == 1  then
	--			outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de prf alteradas para  "..prfCallCount.."   ", player, 255, 255, 255, true)
	--		end
	--	end


	end
	if medicoCallCount > 0 then
		medicoCallCount = medicoCallCount - 1

	---	for theKey,player in ipairs (getElementsByType("player")) do
	--		if getElementData(player, "char:adminduty") == 1  then
	--			outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeChamadas de Resgate alteradas para  "..medicoCallCount.."   ", player, 255, 255, 255, true)
	--		end
	--	end


	end


	

end, 120000, 0 )

function setChamada (thePlayer)
local serial = getElementData(thePlayer, "char:id") --getPlayerSerial(thePlayer)
     if serial then
	     if not ChamadasS[serial] then
		     ChamadasS[serial] = 0
		 end
		 if ChamadasS[serial] then
		     ChamadasS[serial] = ChamadasS[serial] + 1
		 end
	 end
end

--[[
function getChamadas (thePlayer, commandName, ids)
     local id = tonumber(ids)
     if getElementData(thePlayer, "acc:admin") > 7 then
        -- for theKey,player in ipairs (getElementsByType("player")) do
		     if (getElementData(player, "char:id") == id) then
			     local serial = getElementData(thePlayer, "char:id")  --getPlayerSerial(thePlayer)
				 if ChamadasS[serial] then
				     outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(player).." tem #dc143c"..ChamadasS[serial].." #bebebechamada acoumalada.", thePlayer, 255, 255, 255, true)
					 else
					 outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(player).." #bebebenão tem chamada atendidas.", thePlayer, 255, 255, 255, true)
				 --end
			 end
		 end
	 end
end
addCommandHandler("chamada", getChamadas)
]]--


addCommandHandler("chamada",
	function(playerSource, cmd, player)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
			if player then
				local targetPlayer,targetPlayerName = exports["btc_core"]:findPlayer(playerSource, player)
				if targetPlayer then

					local serial = getElementData(targetPlayer, "char:id")  --getPlayerSerial(thePlayer)
					if ChamadasS[serial] then
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(targetPlayer).." #bebebetem #dc143c"..ChamadasS[serial].." #bebebechamada acumuladas", playerSource, 255, 255, 255, true)
						else
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(targetPlayer).." #bebebenão tem chamada atendidas.", playerSource, 255, 255, 255, true)
					--end
					end

					
				else
					outputChatBox(error .. "Não existe tal jogador.", playerSource, 255, 255, 255, true)
				end
			else
				outputChatBox("#7cc576use:#ffffff /"..cmd.." [nome / ID] ", playerSource,166,196,103,true)			
			end
		end
	end
)




function displayServerMessage(source, message, type)
	triggerClientEvent(source, "servermessagesCelular", getRootElement(), message, type)
end




local objetosom = { }
local objetocaixa = { }
local objetoflor = { }
local objetoguardachuva = { }

addEvent( "objetomaosom", true )
addEventHandler( "objetomaosom", root,
function (thePlayer, object)

		if isElement(objetosom[thePlayer]) then


			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

	--destroyElement(objetosom[thePlayer])
	outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end


		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetosom[thePlayer] = createObject(2226,0,0,0) 
		setElementDimension(objetosom[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetosom[thePlayer], getElementInterior(thePlayer))
	exports.bone_attach:attachElementToBone(objetosom[thePlayer],thePlayer,12,0,0,0.4,0,180,0) 
	end
end
)


addEvent( "objetomaocaixa", true )
addEventHandler( "objetomaocaixa", root,
function (thePlayer, object)
		if isElement(objetocaixa[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end

			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

		--destroyElement(objetocaixa[thePlayer])
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else
		

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		local rot = getElementRotation(thePlayer)
		objetocaixa[thePlayer] = createObject(3014, 0, 0, 0)

		setElementDimension(objetocaixa[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetocaixa[thePlayer], getElementInterior(thePlayer))


		setObjectScale(objetocaixa[thePlayer], 0.9)		
		exports.bone_attach:attachElementToBone(objetocaixa[thePlayer],thePlayer,3,-0.1, 0.45, 0.19, 0, rot, 0) 
		exports.btc_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)
	end
end
)


addEvent( "objetomaoflor", true )
addEventHandler( "objetomaoflor", root,
function (thePlayer, object)
		if isElement(objetoflor[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end


		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetoflor[thePlayer] = createObject(325,0,0,0) 

		setElementDimension(objetoflor[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetoflor[thePlayer], getElementInterior(thePlayer))
		exports.bone_attach:attachElementToBone(objetoflor[thePlayer],thePlayer,12,-0.02,0,0,0,-90,0) 
	end
end
)


addEvent( "objetgchuva", true )
addEventHandler( "objetgchuva", root,
function (thePlayer, object)
		if isElement(objetoguardachuva[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end


		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetoguardachuva[thePlayer] = createObject(642,0,0,0) 
		setElementDimension(objetoguardachuva[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetoguardachuva[thePlayer], getElementInterior(thePlayer))
		setObjectScale(objetoguardachuva[thePlayer], 0.5)	

		exports.bone_attach:attachElementToBone(objetoguardachuva[thePlayer],thePlayer,12,-0.5,-0.21,-0.1,120,-60,0) 


		setPedAnimation ( thePlayer, "GANGS", "smkcig_prtl_f", -0, true, false, false )
		setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "smkcig_prtl_f", 1.9)
		setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "smkcig_prtl_f", 0)

		--exports.btc_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)

	end
end
)






addEventHandler("onPlayerQuit", root, function()
	if isElement(objetosom[source]) then
		destroyElement(objetosom[source])
	end

	if isElement(objetoflor[source]) then
		destroyElement(objetoflor[source])
	end


	if isElement(objetocaixa[source]) then
		destroyElement(objetocaixa[source])
	end


	if isElement(objetoguardachuva[source]) then
		destroyElement(objetoguardachuva[source])
	end
	
	if isElement(objetosom[source]) then
		destroyElement(objetosom[source])
	end

	if isElement(objetoflor[source]) then
		destroyElement(objetoflor[source])
	end

end)




function removerobj (thePlayer, commandName)
	if isElement(objetosom[thePlayer]) then
		destroyElement(objetosom[thePlayer])
	end

	if isElement(objetoflor[thePlayer]) then
		destroyElement(objetoflor[thePlayer])
	end


	if isElement(objetocaixa[thePlayer]) then
		destroyElement(objetocaixa[thePlayer])
	end


	if isElement(objetoguardachuva[thePlayer]) then
		destroyElement(objetoguardachuva[thePlayer])
	end
	
	if isElement(objetosom[thePlayer]) then
		destroyElement(objetosom[thePlayer])
	end

	if isElement(objetoflor[thePlayer]) then
		destroyElement(objetoflor[thePlayer])
	end


end
addCommandHandler("removerobj", removerobj)

function restart()
	for index, player in ipairs(getElementsByType("player")) do
		bindKey(player, "x", "down", removerobj)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "x", "down", removerobj)
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
		unbindKey(player, "x", "down", removerobj)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)























local chatSystemDB = dbConnect( 'sqlite', 'Chat System - Database.db' )
dbExec( chatSystemDB, 'CREATE TABLE IF NOT EXISTS `Chat_System` (sourceSerial, blockedSerial)' )

addEvent( 'onServerCheckShow', true );
addEventHandler( 'onServerCheckShow', root,
function( player, name )
	if ( player and player ~= source ) then
		triggerClientEvent( player, 'onClientShowWrite', source, source, name )
	end
end );

addEvent( 'onServerCheckHide', true );
addEventHandler( 'onServerCheckHide', root,
function( player )
	if ( player and player ~= source ) then
		triggerClientEvent( player, 'onClientHideWrite', source, source )
	end
end );

addEvent( 'onServerCheckIfBlocked', true );
addEventHandler( 'onServerCheckIfBlocked', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
	if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a message to this player .. it\'s blocked !', source, 255, 255, 255, true ) return end
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', serial, getPlayerSerial( source ) )
		local results = dbPoll( check, -1 )
	if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a message to this player .. he was blocked you !', source, 255, 255, 255, true ) return end
		triggerClientEvent( source, 'buildChattingWith', source )
end );

addEvent( 'onServerSendPoke', true );
addEventHandler( 'onServerSendPoke', root,
function( player, serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a poke to this player .. it\'s blocked or he was blocked you !', source, 255, 255, 255, true ) return end
		if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
			outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a poke to this player .. it\'s offline !', source, 255, 255, 255, true ) return end
		triggerClientEvent( player, 'onClientPokePlayer', source, getPlayerName( source ) )
end );

addEvent( 'onServerCheckBlockStatus', true );
addEventHandler( 'onServerCheckBlockStatus', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results == 0 or not results ) then triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' ) return end
		triggerClientEvent( source, 'onClientChangeButton', source, 'Unblock Player' )
end );

addEvent( 'onServerBlockPlayer', true );
addEventHandler( 'onServerBlockPlayer', root,
function( serial, player )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results ~= 0 ) then return end
		dbExec( chatSystemDB, 'INSERT INTO `Chat_System` VALUES(?,?)', getPlayerSerial( source ), serial )
	triggerClientEvent( source, 'onClientChangeButton', source, 'Desbloquear Player' )
	triggerClientEvent( player, 'onClientDestroyChats', source, source )
	triggerClientEvent( source, 'onClientDestroyChats', source, player )
end );

addEvent( 'onServerUnblockPlayer', true );
addEventHandler( 'onServerUnblockPlayer', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results == 0 or not results ) then triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' ) return end
		dbExec( chatSystemDB, 'DELETE FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
	triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' )
end );

addEventHandler( 'onPlayerJoin', getRootElement(  ),
function(  )
	triggerClientEvent( root, 'onClientAddPlayer', source, source )
end );

addEventHandler( 'onPlayerQuit', getRootElement(  ),
function(  )
	triggerClientEvent( root, 'onClientRemovePlayer', source, source )
end );

addEventHandler( 'onPlayerChangeNick', getRootElement(  ),
function( old, new )
	triggerClientEvent( root, 'onClientRemovePlayer_ChangedName', source, source, old )
end );

addEvent( 'onServerSetPlayerSerial', true );
addEventHandler( 'onServerSetPlayerSerial', root,
function(  )
	setElementData( source, 'chatSystem;playerSerial', getPlayerSerial( source ) )
end );

addEvent( 'onServerChangeStatus', true );
addEventHandler( 'onServerChangeStatus', root,
function( Status )
	triggerClientEvent( root, 'onClientUpdateStatus', source, source, Status )
end );

addEvent( 'onServerSendMessage', true );
addEventHandler( 'onServerSendMessage', root,
function( plr, message )
	triggerClientEvent( plr, 'onClientReceiveMessage', source, source, message )
end );

addEvent( 'onServerPutPlayers', true );
addEventHandler( 'onServerPutPlayers', root,
function(  )
	for _, player in ipairs( getElementsByType( 'player' ) ) do
			local plrName = getPlayerName( player )
		local plrStatus = getElementData( player, 'privateChatSystem;playerStatus' ) or 'Online'
	triggerClientEvent( root, 'onClientPutPlayers', player, plrName, plrStatus )
	end
end );