col = engineLoadCOL("casacolisao.col")
engineReplaceCOL (col , 1855)
txd = engineLoadTXD("casa.txd")
engineImportTXD(txd , 1855) 
dff = engineLoadDFF("casa.dff" , 1855)
engineReplaceModel(dff , 1855)

------------------------------------PAINEL FORNECEDOR---------------------------
janela = guiCreateWindow(539, 187, 382, 243, "Fornecedor de Drogas", false)
guiWindowSetSizable(janela, false)
guiSetVisible(janela,false)
btn_comprar = guiCreateButton(270, 193, 92, 36, "COMPRAR", false, janela)
guiSetProperty(btn_comprar, "NormalTextColour", "7749FE4D")
guiCreateLabel(24, 38, 186, 20, "Digite a quantidade de maconha:", true, janela)
label_erva = guiCreateEdit(24, 59, 66, 36, "", false,janela)
guiCreateLabel(24, 38, 186, 20, "Digite a quantidade de maconha:", false,janela)
guiCreateLabel(21, 102, 176, 21, "Digite a quantidade de cocaína:", false, janela)
label_po = guiCreateEdit(21, 123, 68, 37, "", false, janela)
grid = guiCreateGridList(234, 34, 138, 140, false, janela)

guiCreateLabel(240, 40, 121, 23, "KG da Erva:", false, janela)
kg_erva = guiCreateLabel(280, 60, 113, 29, "R$ 500", false, janela)
guiSetFont(kg_erva, "clear-normal")
guiLabelSetColor(kg_erva, 252, 76, 76)
guiCreateLabel(240, 100, 120, 28, "KG do pó:", false, janela)
	kg_po = guiCreateLabel(280, 120, 56, 24, "R$ 800", false, janela)
	guiLabelSetColor(kg_po, 252, 76, 76)
	btn_sair = guiCreateButton(21, 199, 50, 30, "Sair", false, janela) 
	---------------------------------PAINEL DE RETIRADA--------------------------------------
	retirada = guiCreateWindow(528, 196, 343, 240, "Retirar Drogras", false)
	guiWindowSetSizable(retirada, false)
	guiSetVisible(retirada,false)
	retirada_btn = guiCreateButton(220, 184, 108, 46, "Retirar Drogas", false, retirada)
	retirada_sair = guiCreateButton(10, 199, 83, 31, "Sair", false, retirada)
	retirada_label_erva = guiCreateLabel(11, 30, 199, 37, "Erva disponível para retirada:", false, retirada)
	retirada_qtd_erva = guiCreateLabel(12, 56, 96, 45, "", false, retirada)
	guiSetFont(retirada_qtd_erva, "clear-normal")
	guiLabelSetColor(retirada_qtd_erva, 92, 246, 8)
	retirada_label_po = guiCreateLabel(12, 111, 203, 38, "Pó disponível para retirada:", false, retirada)
	retirada_qtd_po = guiCreateLabel(11, 138, 97, 51, "", false, retirada)
	guiSetFont(retirada_qtd_po, "clear-normal")
	guiLabelSetColor(retirada_qtd_po, 92, 246, 8)

	--AREA DO FORNECEDOR DE DROGAS
	markerAreaFornecedor = createMarker (-1100.8642578125,-1642.900390625,76.3671875, "cylinder", 70, 255, 255, 255 )
	setElementAlpha ( markerAreaFornecedor,50 )

	--NPC DAS DROGAS
	patrao = createPed ( 1,-1116.2451171875,-1649.57890625,76.421875,180)
	setPedAnimation(patrao, "ped", "SEAT_idle", -1, true, false, false, false)
	patraoMarker = createMarker (-1116.2451171875,-1650.87890625,76.421875, "cylinder", 2, 255, 255, 255 )
	setElementAlpha ( patraoMarker,0 )

	entradaPatraoMarker = createMarker (-1103.8427734375,-1651.0693359375,76.3671875, "cylinder",4, 255, 255, 255 )
	setElementAlpha ( entradaPatraoMarker,0 )

	markerSeguranca = createMarker(-1108.1552734375,-1654.283203125,76.421875,"cylinder",2,0,0,0)
	setElementAlpha ( markerSeguranca,0 )

	--SEGURANCA
	seguranca = createPed(24,-1111.288671875,-1655.108765625,76.421875,-90,true)--segurancaEsq 
	givePedWeapon(seguranca, 31, 5000, true)
	setPedAnimation(seguranca, "ped", "SEAT_idle", -1, true, false, false, false)

	--entregador
	entregador = createPed(29,-1118.0146484375,-1615.3759765625,76.3671875,180)--npcEntregadorDroga
	markerEntregador = createMarker(-1118.0146484375,-1616.6759765625,76.3671875,"cylinder",2,22,221,211)
	setElementAlpha ( markerEntregador,80 )

	--caminhao
	colCaminhao = createColSphere(-1096.5,-1620,76.3671875,2)
	caminhao_na_area = nil

	localPlayer = getLocalPlayer()
	statusCompra = 0
	maquina_funcionando = false
	carga_na_area = {}

	function abrirJanela()
		guiSetVisible(janela,true)
		showCursor(true)
	end

	function fecharJanela(thePlayer)
		setPedAnimation(patrao, "ped", "SEAT_idle", -1, true, false, false, false)
		guiSetVisible(janela,false)
		showCursor(false)
	end

	function sentar_seguranca()
		setPedAnimation(seguranca, "ped", "SEAT_idle", -1, true, false, false, false)

	end
	function levantar_seguranca()
		setPedAnimation(seguranca, "ped", "stepsit_out", -1, true, false, false, false)
	end


	local objeto = createObject(1855,-1105.3359375,-1653.9150390625,76.3671875-1,0,0,280)
	setElementDimension (objeto, 0)

	function comprar_drogas(thePlayer)
		setPedAnimation(patrao, "ped", "stepsit_out", -1, true, true, false, false)
		if(getLocalPlayer() == thePlayer) then
			abrirJanela()
		end
	end

	function finalizar_compra(thePlayer)
		qtd_erva = tonumber(guiGetText ( label_erva )) or 0
		qtd_po = tonumber(guiGetText ( label_po )) or 0
		triggerServerEvent("valida_compra", getLocalPlayer(), qtd_erva, qtd_po) 
	end

	function sem_dinheiro(thePlayer)
		outputChatBox("Você não tem dinheiro pra isso, RALA DAQUI!",thePlayer)
	end

	function mostrarPainelRetirada(thePlayer)
		if(getLocalPlayer() == thePlayer and maquina_funcionando == false) then
			triggerServerEvent("get_dados_painel_retirada", resourceRoot) 
			guiSetVisible(retirada,true)
			showCursor(true)
		else 
			outputChatBox("Aguarde a maquina desligar.",getLocalPlayer(),255,100,255)
		end
	end

	function atualizar_painel_retirada ( data )
		local po_pend = data['po_pend'] ~= nil and data['po_pend'].."Kg" or "Nada"
		local maconha_pend = data['maconha_pend'] ~= nil and data['maconha_pend'].."Kg" or "Nada"

		--a and t or f
		guiSetText(retirada_qtd_po,tostring(po_pend))


		guiSetText(retirada_qtd_erva,tostring(maconha_pend))


	end

	function desligarMaquina(thePlayer)
		maquina_funcionando = false
	end

	function ligarMaquina(thePlayer)
		esconderPainelRetirada()
		maquina_funcionando = true
	end

	addEvent( "atualizar_painel_retirada", true )
	addEventHandler( "atualizar_painel_retirada", localPlayer, atualizar_painel_retirada )

	addEvent( "desligarMaquina", true )
	addEventHandler( "desligarMaquina", localPlayer, desligarMaquina )

	addEvent( "ligarMaquina", true )
	addEventHandler( "ligarMaquina", localPlayer, ligarMaquina )

	function esconderPainelRetirada(thePlayer)
		guiSetVisible(retirada,false)
		showCursor(false)
	end

	function drograsRetiradas(thePlayer)

		esconderPainelRetirada()
		playSound3D  ( 'maquina.mp3',-1117.4,-1620,76.7 )   
	end

	function iniciarCompraDeDroga(hitPlayer)
		if(hitPlayer == getLocalPlayer()) then 
			outputChatBox("Você entrou em uma área de fornecimento de drogas, tenha cuidado.")
			if(statusCompra == 0) then
				addEventHandler("onClientMarkerHit",patraoMarker, comprar_drogas)

			end
		end
		--
		--if(thePlayer == localPlayer) then
			--	addEventHandler("onClientMarkerHit",markerEntregador, mostrarPainelRetirada)
			--end
		end

		addEvent("retirada", true)
		addEventHandler("retirada", getRootElement(), drograsRetiradas)

		addEvent("dinheiro_insuficiente", true)
		addEventHandler("dinheiro_insuficiente", getRootElement(), sem_dinheiro)

		addEvent("fechar_janela", true)
		addEventHandler("fechar_janela", getRootElement(), fecharJanela)

		addEvent("mostrarPainelRetirada", true)
		addEventHandler("mostrarPainelRetirada", getRootElement(), mostrarPainelRetirada)

		addEvent("esconderPainelRetirada", true)
		addEventHandler("esconderPainelRetirada", getRootElement(), esconderPainelRetirada)


		addEventHandler("onClientGUIClick", btn_comprar, finalizar_compra, false )
		addEventHandler("onClientGUIClick", btn_sair, fecharJanela, false )
		addEventHandler("onClientGUIClick", retirada_sair, esconderPainelRetirada, false )
		addEventHandler("onClientGUIClick", retirada_btn, 
			function()
				triggerServerEvent("concluir_retirada", getLocalPlayer())
			end)
		addEventHandler("onClientMarkerLeave",patraoMarker, fecharJanela)
		addEventHandler("onClientMarkerLeave",markerEntregador, esconderPainelRetirada)
		addEventHandler("onClientMarkerHit",markerEntregador, mostrarPainelRetirada)

		function verificaCaminhaoNaArea(elementos)
			local elementos = getElementsWithinColShape(colCaminhao)
			local na_area = false
			for _,elemento in ipairs(elementos) do
				if(getElementType(elemento) == "vehicle") then
					caminhao_na_area = elemento
					na_area = true
				end 
			end
			return na_area
		end
		addEventHandler("onClientMarkerHit",entradaPatraoMarker, sentar_seguranca)
		addEventHandler("onClientMarkerHit",markerSeguranca, levantar_seguranca)
		addEventHandler("onClientMarkerHit",markerAreaFornecedor, iniciarCompraDeDroga)
		addEventHandler("onClientColShapeHit",colCaminhao, 
			function(theElement, matchingDimension)

				elementos = getElementsWithinColShape(colCaminhao)
				na_area = verificaCaminhaoNaArea(elementos)
				for _,elemento in ipairs(elementos) do
					if(  getElementType(elemento) == "object" and getElementModel(elemento) == 1355 and na_area) then
						triggerServerEvent("inserirInventarioVeiculo", getRootElement(), caminhao_na_area,elemento)
						outputChatBox("asd")
						desligarMaquina()						
					elseif (getElementType(elemento) == "object" and getElementModel(elemento) == 1355 and na_area == false) then
						triggerServerEvent("destruirCaixa", getRootElement(), elemento)
						desligarMaquina()
					end
				end


			end)



		--setElementData(patrao, "sit_relaxed", true)

		--guiGetText ( element guiElement ) givePedWeapon(thePed, 31, 5000, true)
