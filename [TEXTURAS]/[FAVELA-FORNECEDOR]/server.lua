mysql = exports.mysql
function comprar(qtd_maconha,qtd_po)
	data =  mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. mysql:escape_string(getPlayerName ( source )) .."'")
	
	mysql:query_free("UPDATE characters SET `maconha_pend` = "..data["maconha_pend"]+qtd_maconha..", `po_pend` = "..data["po_pend"]+qtd_po.." WHERE charactername = '" .. mysql:escape_string(getPlayerName ( source )) .. "'") 
	data =  mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. mysql:escape_string(getPlayerName ( source )) .."'")
	outputChatBox("Retire "..data["maconha_pend"]..'Kg de maconha no depósito ao lado\nRetire '..data["po_pend"]..'Kg de pó no depósito ao lado.',source,255, 100, 14)
	setElementData(source,"qtd_maconha",data["qtd_maconha"]+qtd_maconha)
	setElementData(source,"qtd_po",data["qtd_po"]+qtd_po)
	triggerClientEvent(getRootElement(),"fechar_janela",getRootElement())
end

function valida_compra(qtd_maconha,qtd_po)
	data_maconha = mysql:query_fetch_assoc("SELECT value FROM settings where name = 'kg_maconha'")
	data_po = mysql:query_fetch_assoc("SELECT value FROM settings where name = 'kg_po'")

	valor_maconha = tonumber(data_maconha['value']) * tonumber(qtd_maconha)
	valor_po = tonumber(data_po['value']) * tonumber(qtd_po)
	dinheiro_atual = mysql:query_fetch_assoc("SELECT money FROM characters where charactername='" .. mysql:escape_string(getPlayerName ( source )) .."'")['money']
	total_compra = valor_po + valor_maconha

	outputChatBox("Valor total da compra: R$"..total_compra,source)
	outputChatBox("Seu dinheiro: R$"..dinheiro_atual,source)
	if(tonumber(total_compra) < tonumber(dinheiro_atual)) then
		mysql:query_free("UPDATE characters SET `money` = "..dinheiro_atual-total_compra.." WHERE charactername = '" .. mysql:escape_string(getPlayerName ( source )) .. "'") 
		comprar(qtd_maconha,qtd_po)
	else
		triggerClientEvent(source,"dinheiro_insuficiente",source)
	end
end


function retirar_drogas()
	local data =  mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. mysql:escape_string(getPlayerName ( source )) .."'")
	
	if(tonumber(data['maconha_pend']) == 0) then 
		outputChatBox("Você não tem nada para retirar",source,255,100,0)

	else

		local caixa_maconha = createObject ( 1355, -1117.4,-1620,76.7)

		outputChatBox("Droga retirada, se o veículo estiver na área de carga e for de sua propriedade, ele será abastecido com a droga.", source,255,255,100)
		--exports.global:giveItem( source, 120, data['maconha_pend'] )
		--setPedAnimation (source, "CARRY", "crry_prtial", 1,true,true,false)
		--exports.bone_attach:attachElementToBone(newColShape,caixa_maconha,4, 0.5, 0.1, -0.5, -125, 0, 0)
		attachElements (  newColShape,caixa_maconha)
		--mysql:query_free("UPDATE characters SET `qtd_maconha` = "..(data["maconha_pend"]+1)..", `qtd_po` = "..(data["po_pend"]+1).." WHERE charactername = '" .. mysql:escape_string(getPlayerName ( source )) .. "'")
		--mysql:query_free("UPDATE characters SET `maconha_pend` = "..data["po_pend"]+1..", `po_pend` = "..data["po_pend"]+1.." WHERE charactername = '" .. mysql:escape_string(getPlayerName ( source )) .. "'") 
		setElementData(caixa_maconha,"dono",source)
		triggerClientEvent(source,"retirada",source)

		moveObject  ( caixa_maconha, 15000, -1098.1,-1620,76.7)
		triggerClientEvent(source,"ligarMaquina",source)
	end

end

function inserir_inventario_veiculo( veiculo, caixa )
	outputChatBox("11")
	local dono_caixa = getElementData(veiculo, "owner")
	nome_dono = exports['cache']:getCharacterName(dono_caixa)
	nome_dono = nome_dono:gsub(" ", "_")
	if(exports.global:hasSpaceForItem( veiculo) and getElementType(caixa) == "object" and getElementType(veiculo) == "vehicle") then 
		exports.global:giveItem( veiculo, 120, 1 )
		local data =  mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. mysql:escape_string(nome_dono) .."'")
		mysql:query_free("UPDATE characters SET `qtd_maconha` = "..(data["maconha_pend"]+1)..", `qtd_po` = "..(data["po_pend"]+1).." WHERE charactername = '" .. mysql:escape_string(nome_dono) .. "'")
		outputChatBox("chegou")
		new_maconha_pend = (data["maconha_pend"] ==0) and 0 or data["maconha_pend"] - 1
		new_po_pend = (data["po_pend"] ==0) and 0 or data["po_pend"] - 1
		mysql:query_free("UPDATE characters SET `maconha_pend` = "..new_maconha_pend..", `po_pend` = "..new_po_pend.." WHERE charactername = '" .. mysql:escape_string(nome_dono) .. "'")		
	else
		outputChatBox("Inventario do veiculo não cabe mais drogas",dono_caixa,255,100,100)
		end
		destroyElement(caixa)
	end

	addEvent("inserirInventarioVeiculo", true)
	addEventHandler("inserirInventarioVeiculo", getRootElement(), inserir_inventario_veiculo)

	function destruirCaixa(caixa)
		destroyElement(caixa)
	end

	addEvent("destruirCaixa", true)
	addEventHandler("destruirCaixa", getRootElement(), destruirCaixa)

	function get_dados_painel_retirada()
		data =  mysql:query_fetch_assoc("SELECT * FROM characters WHERE charactername='" .. mysql:escape_string(getPlayerName ( client )) .."'")
		triggerClientEvent( getRootElement(),"atualizar_painel_retirada", getRootElement(),data)
	end

	addEvent("valida_compra", true)
	addEventHandler("valida_compra", getRootElement(), valida_compra)
	addEvent("concluir_retirada", true)
	addEventHandler("concluir_retirada", getRootElement(), retirar_drogas)
	addEvent("get_dados_painel_retirada", true)
	addEventHandler("get_dados_painel_retirada", getRootElement(), get_dados_painel_retirada)
	--droga
--createObject(1855,-1105.3359375,-1653.9150390625,76.3671875-1,0,0,280)