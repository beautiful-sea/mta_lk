local privado1_ativo = true
local vidroCortina = createObject(3858,1216.8837890625,3.267578125,1000.921875,0,0,40)
local cortina1 = createObject(18079,1217.046875,3.0830078125,1001.221875,0,0,359.14031982422)
setElementInterior(cortina1,2)
local cortina2 = createObject(18079,1215.046875,3.1230078125,1001.221875,0,0,359.14031982422)
setElementInterior(cortina2,2)
local colshape_sala1 = createColRectangle ( 1213.805078125,3.16562, 8.7,6.8 )
markerSairSala = createMarker(1217.9560546875,4.091796875,1000.92187,"checkpoint",0.5, 0, 0,  0, 0)
local convidados = {}
---------------------------------
local valor_total = 0
local pagante = nil
local qtd_pessoas = 0
local tempo_max = 0
local cortina_fechada = true
local vezes_verificado = 0
--------------------------------
function pagar(qtd_pessoas_client,tempo_max_client)
	if pagante ~= client and pagante ~= nil then
		outputChatBox("A sala está ocupada no momento.",client,255,150,44)
	else
		qtd_pessoas = qtd_pessoas_client
		tempo_max   = tempo_max_client
		abrirCortina()
		pagante = client
		cortina_fechada = false
		convidados = {}
		tempo_em_milisegundos = (tempo_max*60)*1000
		setTimer(verificarTempoNaSala,tempo_em_milisegundos,2)
	end
end

function abrirCortina()
	moveObject( cortina1, 4000, 1215.246875,3.1230078125,1001.221875)
	moveObject( vidroCortina, 1000, 1210.2837890625,3.267578125,1000.921875)
end

function removerPlayerSala(player)
	setElementPosition ( player, 1216.37109375,2.888671875,1000.921)
end

function verificarTempoNaSala()
	vezes_verificado = vezes_verificado + 1
	if(vezes_verificado == 2) then
		iprint("verificando.2")
		finalizarSala()
	end
end

function finalizarSala()
	pessoas_dentro = getElementsWithinColShape ( colshape_sala1, "player" )
	for i=1,#pessoas_dentro do
		outputChatBox("O tempo alugado da sala acabou.", pessoas_dentro[i],255,255,0)
		convidados = {}
		valor_total = 0
		pagante = nil
		qtd_pessoas = 0
		tempo_max = 0
		cortina_fechada = true
		vezes_verificado = 0
		removerPlayerSala(pessoas_dentro[i])

	end
end

function verificarSala1(thePlayer)
	pessoas_dentro = getElementsWithinColShape ( colshape_sala1, "player" )
	if(convidados~= nil and pagante~= nil) then
		iprint(pessoas_dentro)
		if(#pessoas_dentro > qtd_pessoas and thePlayer ~= pagante)then
			removerPlayerSala(thePlayer)
			outputChatBox("Limite de pessoas atingido.",thePlayer,250,250,100)
			return
		end
		for i=1,#pessoas_dentro do
			for j=1,#convidados do
				if(convidados[j] == pessoas_dentro[i]) then return end
			end
			if not convidados[pessoas_dentro[i]] then
				iprint("fora da lista de convidados")
				if(pessoas_dentro[i] ~= pagante) then
					iprint("pessoa n e pagante")

					if(pagante == nil) then
						iprint("n tem pagante")

						removerPlayerSala(pessoas_dentro[i])
						return
					end
					outputChatBox(getPlayerName(pessoas_dentro[i]).." tentou entrar na sala mas foi barrado pelo segurança",pagante,255,255,255)
					outputChatBox("Ops.. Parece que você não pode entrar!",player,255,255,255)
					removerPlayerSala(pessoas_dentro[i])
				elseif(cortina_fechada == false and pessoas_dentro[i] == pagante)then
					moveObject( cortina1, 4000, 1217.046875,3.0830078125,1001.221875)
				end
			end	
		end
	else
		outputChatBox("Sala privada desocupada, negocie com o segurança para aluga-la.",thePlayer,140,44,60)
		removerPlayerSala(thePlayer)
	end
end

function solicitarLiberarSala(thePlayer)
	if(thePlayer == pagante)then
		triggerClientEvent ( thePlayer, "solicitarLiberarSala", thePlayer )
	end
end


function getPagante()
	return pagante
end

function liberarSala()
	finalizarSala()
end

function convidarBoate(convidado)
	triggerClientEvent(convidado,"receberConvite",convidado,pagante)
end
--1218,4.220703125,1000.921
function conviteAceito(convidado)
	table.insert(convidados,convidado)
	setElementPosition(convidado,1218.8828125,6.8681640625,1000.92187)
end
function verificarQuemChegou(quemChegou)
	if(client == pagante) then
		iprint(1)
		abrirCortina()
	elseif(#convidados > 1) then
		iprint(2)

		for i=1,#convidados do
			if(convidados[i] == client) then abrirCortina() end
		end
	else
		triggerClientEvent(quemChegou,"abrirPainelPrivado",quemChegou,quemChegou)
	end
end

function fecharCortina()
	moveObject( cortina1, 4000,1217.046875,3.0830078125,1001.221)
	moveObject( vidroCortina, 4000, 1216.8837890625,3.267578125,1000.9218)
end
addEventHandler( "onClientMarkerHit", markerSairSala, abrirCortina() )
addEventHandler ( "onColShapeLeave", root, solicitarLiberarSala )
addEventHandler( "onColShapeHit", root, verificarSala1 )
addEvent("removerPlayerSala",true)
addEventHandler("removerPlayerSala",root,removerPlayerSala)
addEvent("liberarSala",true)
addEventHandler("liberarSala",root,liberarSala)
addEvent("pagar",true)
addEventHandler("pagar",root,pagar)
addEvent("conviteAceito",true)
addEventHandler("conviteAceito",root,conviteAceito,convidado)
addEvent("convidarBoate",true)
addEventHandler("convidarBoate",root,convidarBoate,convidado)
addEvent("verificarQuemChegou",true)
addEventHandler("verificarQuemChegou",root,verificarQuemChegou)