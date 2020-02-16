markerCofre = createMarker ( 2429.7966308594,-759.23809814453,116.1553634 ,"cylinder", 2.0,  0, 0, 255,  255)
setElementAlpha(markerCofre,10)

janela_cofre = guiCreateWindow(693, 118, 465, 268, "COFRE", false)
guiWindowSetSizable(janela_cofre, false)
guiSetVisible(janela_cofre, false)
label_status = guiCreateLabel(14, 57, 68, 18, "TRANCADO", false, janela_cofre)
guiLabelSetColor(label_status, 215, 0, 0)
campo_senha_cofre = guiCreateEdit(14, 75, 68, 25, "", false, janela_cofre)
btn_senha = guiCreateButton(85, 75, 60, 25, "IR", false, janela_cofre)

label1 = guiCreateLabel(14, 38, 73, 19, "Status:", false, janela_cofre)
gridlist = guiCreateGridList(150, 57, 465, 96, false, janela_cofre)
extrato_nome = guiGridListAddColumn(gridlist, "Nome", 0.4) 
extrato_nome = guiGridListAddColumn(gridlist, "Operação", 0.2) 
extrato_nome = guiGridListAddColumn(gridlist, "Valor", 0.2) 



label_extrato = guiCreateLabel(223, 33, 55, 20, "EXTRATO", false, janela_cofre)
label_saldo = guiCreateLabel(11, 110, 76, 17, "Saldo:", false, janela_cofre)
saldo = guiCreateLabel(14, 125, 77, 19, "", false, janela_cofre)
btn_sacar = guiCreateButton(252, 226, 97, 32, "SACAR", false, janela_cofre)
btn_depositar = guiCreateButton(370, 226, 94, 32, "DEPOSITAR", false, janela_cofre)
btn_sair = guiCreateButton(14, 226, 94, 32, "SAIR", false, janela_cofre)
valor_operacao = guiCreateEdit(252, 193, 465, 27, "", false, janela_cofre)
label_rs = guiCreateLabel(230, 201, 33, 25, "R$", false, janela_cofre)

cofre_aberto = false
saldo_cofre = 0

addEventHandler("onClientGUIClick",btn_sair, function() 
	guiSetVisible(janela_cofre, false)
	showCursor( false)
end)

addEventHandler("onClientGUIClick",btn_senha, function() 
	triggerServerEvent ( "verificarSenha", resourceRoot,guiGetText(campo_senha_cofre))
end)

function fechar_janela()
	guiSetVisible(janela_cofre, false)
	showCursor( false)
	trancarCofre()
end

function abrir_janela(thePlayer)
	if(getLocalPlayer() == thePlayer) then
		trancarCofre()
		guiSetVisible(janela_cofre, true)
		showCursor( true)
	end
end
addEventHandler("onClientMarkerHit",markerCofre, abrir_janela)

function atualizaExtrato()
	guiGridListClear(gridlist)
	triggerServerEvent ( "getExtrato", resourceRoot)
end

function retornoExtrato(extrato)
	if(extrato['operacao'] == '1') then operacao = "sacou" else operacao = "depositou" end
	guiGridListAddRow ( gridlist, extrato['operador'],operacao,"R$ "..extrato['data'])
end
addEvent( "retornoExtrato", true )
addEventHandler( "retornoExtrato", resourceRoot, retornoExtrato )

function retornoSenha(senha_liberada,data)
	if(senha_liberada) then
		cofre_aberto = true
		saldo_cofre = data['dinheiro_caixa']
		guiSetText(saldo,"R$ "..data['dinheiro_caixa'])
		guiLabelSetColor(label_status, 150, 200, 150)
		guiSetText(label_status,"ABERTO")
	end
end

function trancarCofre()
	atualizaExtrato()
	triggerServerEvent ( "trancarCofre", resourceRoot)
	cofre_aberto = false
	guiSetText(label_status,"TRANCADO")
	guiLabelSetColor(label_status, 215, 0, 0)
	guiSetText(campo_senha_cofre,"")
	guiSetText(valor_operacao,"")
end
addEventHandler("onClientGUIClick",btn_sacar, function() 
	local cofre_saldo = saldo_cofre
	if(cofre_aberto) then
		if(tonumber(guiGetText(valor_operacao)) < tonumber(cofre_saldo)) then
			saldo_cofre = cofre_saldo-tonumber(guiGetText(valor_operacao))
			triggerServerEvent ( "sacar", resourceRoot,guiGetText(valor_operacao))
			guiSetText(saldo,"R$ "..saldo_cofre)
			trancarCofre()
		end
	end
end)

addEventHandler("onClientGUIClick",btn_depositar, function()
	local cofre_saldo = saldo_cofre
	if(cofre_aberto) then
		data = triggerServerEvent ( "depositar", resourceRoot,tonumber(guiGetText(valor_operacao)))
		if(data) then
			saldo_cofre = cofre_saldo+tonumber(guiGetText(valor_operacao))
			guiSetText(saldo,"R$ "..saldo_cofre)
			trancarCofre()
		end
	end
end)

addEvent( "retornoSenha", true )
addEventHandler( "retornoSenha", resourceRoot, retornoSenha )
