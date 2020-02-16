mysql = exports.mysql
portao = createObject(971,2431.9541015625,-787.23144,124.45536346436,90,-21)
setObjectScale ( portao,1.14)

function abrirPortao(senha)
	data =  mysql:query_fetch_assoc("SELECT senha_geral,porta_cofre_aberta FROM favelas WHERE nome='Rocinha'")
	liberado = false
	if senha == tostring(data['senha_geral']) then
		liberado = true
	end


	if(liberado) then
		if(tonumber(data['porta_cofre_aberta']) == 0) then 
			moveObject(portao,5000,2431.9541015625,-785.23144,124.4607897)
			outputChatBox("Portão liberado",client,255,40,0)
			mysql:query_free("UPDATE favelas SET `porta_cofre_aberta` = 1 WHERE nome='Rocinha'")
		else
			moveObject(portao,5000,2431.9541015625,-787.23144,124.45536346436)
			outputChatBox("Portão trancado",client,255,40,0)
			mysql:query_free("UPDATE favelas SET `porta_cofre_aberta` = 0 WHERE nome='Rocinha'")
		end
		
		return true
	end
	outputChatBox("Senha incorreta",client,255,40,0)
	return false
end


addEvent( "abrirPortao", true )
addEventHandler( "abrirPortao", resourceRoot, abrirPortao )