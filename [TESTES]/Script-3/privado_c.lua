markerPrivado1 = createMarker(1217.955078125,2.158203125,1000.921,"checkpoint",1, 0, 0,  0, 50)
local janela_privado = guiCreateWindow(663, 174, 596, 408, "", false)
guiWindowSetSizable(janela_privado, false)
guiSetVisible(janela_privado,false)

local gridlist = guiCreateGridList(18, 112, 557, 237, false, janela_privado)

local label_sala_privada = guiCreateLabel(87, 26, 426, 64, "Sala privada", false, janela_privado)
local font0_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 44)
guiSetFont(label_sala_privada, font0_A_Love_of_Thunder)
guiLabelSetHorizontalAlign(label_sala_privada, "center", false)
local label_a = guiCreateLabel(2, 38, 54, 52, "  a", false, janela_privado)
local font1_BeautyMarks = guiCreateFont(":GUI/fonts/BeautyMarks.ttf", 13)
guiSetFont(label_a, font1_BeautyMarks)
local label_v = guiCreateLabel(518, 40, 68, 50, "v", false, janela_privado)
local font2_BeautyMarks = guiCreateFont(":GUI/fonts/BeautyMarks.ttf", 14)
guiSetFont(label_v, font2_BeautyMarks)
guiLabelSetHorizontalAlign(label_v, "center", false)

local label_qtd_pessoas = guiCreateLabel(35, 126, 374, 39, "Quantidade de Pessoas:", false, janela_privado)
local font3_PetitFormalScript = guiCreateFont(":GUI/fonts/PetitFormalScript.ttf", 20)
guiSetFont(label_qtd_pessoas, font3_PetitFormalScript)

local campo_qtd_pessoas = guiCreateEdit(407, 16, 95, 33, "", false, gridlist)
local label_tempo_max = guiCreateLabel(18, 72, 351, 49, "Minutos na Sala:", false, gridlist)
local font4_PetitFormalScript = guiCreateFont(":GUI/fonts/PetitFormalScript.ttf", 27)
guiSetFont(label_tempo_max, font4_PetitFormalScript)
local campo_tempo_max = guiCreateEdit(407, 88, 95, 33, "", false, gridlist)
local campo_total = guiCreateLabel(425, 183, 122, 44, "0.00", false, gridlist)
local font5_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 24)
guiSetFont(campo_total, font5_A_Love_of_Thunder)
guiLabelSetColor(campo_total, 42, 246, 8)
guiLabelSetVerticalAlign(campo_total, "bottom")
local label_rs = guiCreateLabel(336, 167, 89, 67, "R$", false, gridlist)
local font6_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 34)
guiSetFont(label_rs, font6_A_Love_of_Thunder)
guiLabelSetHorizontalAlign(label_rs, "center", false)
guiLabelSetVerticalAlign(label_rs, "bottom")
local label_valor_total = guiCreateLabel(15, 157, 297, 70, "VALOR TOTAL:", false, gridlist)
local font7_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 29)
guiSetFont(label_valor_total, font7_A_Love_of_Thunder)
guiLabelSetColor(label_valor_total, 227, 150, 39)
guiLabelSetHorizontalAlign(label_valor_total, "center", false)
guiLabelSetVerticalAlign(label_valor_total, "bottom")

local btn_pagar = guiCreateButton(460, 354, 115, 44, "PAGAR", false, janela_privado)
local font8_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 15)
guiSetFont(btn_pagar, font8_A_Love_of_Thunder)
local btn_sair = guiCreateButton(18, 355, 111, 43, "SAIR", false, janela_privado)
guiSetFont(btn_sair, font8_A_Love_of_Thunder)    

--------------------------------------------
janela_saindo_privado = guiCreateWindow(697, 279, 413, 197, "Saindo da sala privada", false)
guiWindowSetSizable(janela_saindo_privado, false)
guiSetVisible(janela_saindo_privado,false)
btn_sim = guiCreateButton(275, 100, 116, 55, "SIM", false, janela_saindo_privado)
local font0_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 20)
guiSetFont(btn_sim, font0_A_Love_of_Thunder)
btn_nao = guiCreateButton(22, 97, 115, 58, "NAO", false, janela_saindo_privado)
guiSetFont(btn_nao, font0_A_Love_of_Thunder)
label_saindo_privado = guiCreateLabel(14, 24, 387, 66, "Deseja liberar a sala?", false, janela_saindo_privado)
local font1_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 24)
guiSetFont(label_saindo_privado, font1_A_Love_of_Thunder)
guiLabelSetHorizontalAlign(label_saindo_privado, "center", false)    
---------------------------------------------

janela_convite_privado = guiCreateWindow(627, 249, 464, 262, "Chamando pro rolê", false)
guiWindowSetSizable(janela_convite_privado, false)
guiSetVisible(janela_convite_privado,false)
label_convite_privado = guiCreateLabel(14, 28, 423, 114, "Lindomar_Silva convidou voce para uma sala privada que ele alugou na boate", false, janela_convite_privado)
local font0_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 16)
guiSetFont(label_convite_privado, font0_A_Love_of_Thunder)
guiLabelSetHorizontalAlign(label_convite_privado, "left", true)
label2_convite_privado = guiCreateLabel(15, 142, 422, 45, "deseja ir?", false, janela_convite_privado)
local font1_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 24)
guiSetFont(label2_convite_privado, font1_A_Love_of_Thunder)
guiLabelSetHorizontalAlign(label2_convite_privado, "center", false)
btn_convite_sim = guiCreateButton(307, 202, 130, 50, "sim", false, janela_convite_privado)
local font2_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 20)
guiSetFont(btn_convite_sim, font2_A_Love_of_Thunder)
btn_convite_nao = guiCreateButton(14, 202, 121, 50, "nao", false, janela_convite_privado)
guiSetFont(btn_convite_nao, font2_A_Love_of_Thunder)    
-----------------------------------------------------

janela_convidar_privado = guiCreateWindow(645, 246, 450, 236, "", false)
guiWindowSetSizable(janela_convidar_privado, false)
guiSetVisible(janela_convidar_privado,false)
label_convidar_privado = guiCreateLabel(12, 29, 424, 36, "Convide um jogador para boate", false, janela_convidar_privado)
local font0_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 18)
guiSetFont(label_convidar_privado, font0_A_Love_of_Thunder)
guiLabelSetColor(label_convidar_privado, 24, 106, 230)
label2_convidar_privado = guiCreateLabel(14, 100, 422, 40, "Digite o nome de alguem:", false, janela_convidar_privado)
local font1_A_Love_of_Thunder = guiCreateFont(":GUI/fonts/A_Love_of_Thunder.ttf", 14)
guiSetFont(label2_convidar_privado, font1_A_Love_of_Thunder)
campo_convidar_privado = guiCreateEdit(14, 130, 229, 32, "", false, janela_convidar_privado)
btn_convidar_privado = guiCreateButton(325, 185, 111, 41, "CONVIDAR", false, janela_convidar_privado)
btn_sair_convidar_privado = guiCreateButton(12, 186, 97, 40, "SAIR", false, janela_convidar_privado)    
label3_nome_player = guiCreateLabel(250, 132, 176, 30, "Buscando...", false, janela_convidar_privado)
guiSetFont(label3_nome_player, font1_A_Love_of_Thunder)
guiLabelSetColor(label3_nome_player, 249, 211, 4)   
markerConvidarJogador = createMarker(1221.81640625,4.5986328125,1000.921,"checkpoint",0.5, 0, 0,  0, 0)


---------------------------
local valor_por_minuto = 100
local valor_por_pessoa = 300
local valor_total = 0
local jogador_para_convidar = nil
---------------------------
function verificarQuemChegou()
	triggerServerEvent("verificarQuemChegou",root,getLocalPlayer())
end
function abrirPainelPrivado(thePlayer)
	iprint(thePlayer)
	if(thePlayer == getLocalPlayer()) then
		guiSetVisible(janela_privado,true)
		showCursor(true)
	end
end

function fecharPainelPrivado(thePlayer)
	guiSetVisible(janela_privado,false)
	showCursor(false)
end



function calcularTotal()
	if(guiGetText(campo_qtd_pessoas) ~= "" and guiGetText(campo_tempo_max) ~= "")then
		qtd_pessoas = tonumber(guiGetText(campo_qtd_pessoas))
		tempo_max 	= tonumber(guiGetText(campo_tempo_max))
		valor_total = (valor_por_minuto * tempo_max) + (valor_por_pessoa * qtd_pessoas)
		guiSetText(campo_total,tostring(valor_total))
	end
end

function solicitarLiberarSala()
	guiSetVisible(janela_saindo_privado,true)
	showCursor(true)
end

function receberConvite(quemConvidou)
	guiSetText(label_convite_privado,getPlayerName(quemConvidou).." convidou voce para uma sala privada que ele alugou na boate")
	guiSetVisible(janela_convite_privado,true)
	showCursor(true)
end

function procurarJogadorParaConvidar()
	busca = guiGetText(campo_convidar_privado)
	jogador = getPlayerFromPartialName(tostring(busca))
	if(jogador)then 
		guiSetText(label3_nome_player,getPlayerName(jogador))
		jogador_para_convidar = jogador
	end
end

addEventHandler( "onClientMarkerHit", markerPrivado1, verificarQuemChegou )
addEventHandler( "onClientMarkerHit", markerConvidarJogador, function(thePlayer)
	if(thePlayer == getLocalPlayer()) then
		guiSetVisible(janela_convidar_privado,true)
		showCursor(true)
	end
end )
addEventHandler( "onClientGUIClick", btn_sair_convidar_privado, function()
	guiSetVisible(janela_convidar_privado,false)
	showCursor(false)
end )
addEventHandler( "onClientGUIClick", btn_convidar_privado, function()
	if(jogador_para_convidar)then
		triggerServerEvent("convidarBoate",root,jogador_para_convidar)
		guiSetVisible(janela_convidar_privado,false)
		showCursor(false)
		outputChatBox("Jogador convidado.",150,250,150)
	end
	
end )

addEventHandler( "onClientGUIClick", btn_sair, fecharPainelPrivado )
addEventHandler( "onClientGUIClick", btn_sim, function()
	triggerServerEvent("liberarSala",root)
	guiSetVisible(janela_saindo_privado,false)
	showCursor(false)
	outputChatBox("Sala liberada.",150,250,150)
end )
addEventHandler( "onClientGUIClick", btn_convite_sim, function()
	triggerServerEvent("conviteAceito",root,getLocalPlayer())
	guiSetVisible(janela_convite_privado,false)
	showCursor(false)
	outputChatBox("Você aceitou o convite.",150,250,150)
end )
addEventHandler( "onClientGUIClick", btn_nao, function()
	guiSetVisible(janela_saindo_privado,false)
	showCursor(false)
end )
addEventHandler( "onClientGUIClick", btn_convite_nao, function()
	guiSetVisible(janela_convite_privado,false)
	showCursor(false)
end )
addEventHandler( "onClientGUIChanged", campo_tempo_max, calcularTotal )
addEventHandler( "onClientGUIChanged", campo_qtd_pessoas, calcularTotal )
addEventHandler( "onClientGUIChanged", campo_convidar_privado, procurarJogadorParaConvidar )
addEventHandler( "onClientGUIClick", btn_pagar, function()
	calcularTotal()
	triggerServerEvent("pagar",root,qtd_pessoas,tempo_max)
end )
addEvent("solicitarLiberarSala",true)
addEventHandler("solicitarLiberarSala",root,solicitarLiberarSala)
addEvent("receberConvite",true)
addEventHandler("receberConvite",root,receberConvite)
addEvent("abrirPainelPrivado",true)
addEventHandler("abrirPainelPrivado",root,abrirPainelPrivado)



function getPlayerFromPartialName(name)
	local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
	if name then
		for _, player in ipairs(getElementsByType("player")) do
			local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
			if name_:find(name, 1, true) then
				return player
			end
		end
	end
end