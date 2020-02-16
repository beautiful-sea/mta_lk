mysql = exports.mysql
-- ////////////////////////////////////
-- //			MYSQL				 //
-- ////////////////////////////////////
sqlUsername = exports.mysql:getMySQLUsername()
sqlPassword = exports.mysql:getMySQLPassword()
sqlDB = exports.mysql:getMySQLDBName()
sqlHost = exports.mysql:getMySQLHost()
sqlPort = exports.mysql:getMySQLPort()

handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)

function checkMySQL()
	if not (mysql_ping(handler)) then
		handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)
	end
end
setTimer(checkMySQL, 300000, 0)

function closeMySQL()
	if (handler) then
		mysql_close(handler)
		handler = nil
	end
end

function verificarSenha(senha)
	data =  mysql:query_fetch_assoc("SELECT senha_cofre, dinheiro_caixa FROM favelas WHERE nome='Rocinha'")
	senha_liberada = false
	if senha == tostring(data['senha_cofre']) then
		senha_liberada = true
	end

	triggerClientEvent ( "retornoSenha", resourceRoot,senha_liberada,data)
end

addEvent( "verificarSenha", true )
addEventHandler( "verificarSenha", resourceRoot, verificarSenha )


function sacar(valor)
	data =  mysql:query_fetch_assoc("SELECT senha_cofre, dinheiro_caixa FROM favelas WHERE nome='Rocinha'")
	mysql:query_free("UPDATE characters SET `money` = "..(getPlayerMoney(client)+valor).." WHERE charactername = '" .. mysql:escape_string(getPlayerName(client)) .. "'")
	mysql:query_free("UPDATE favelas SET `dinheiro_caixa` = "..(data['dinheiro_caixa']-valor).." WHERE nome = 'Rocinha'")
	setPlayerMoney(client,getPlayerMoney(client)+valor)
	outputChatBox("Você sacou R$ "..valor, client,150,200,150)
	inserirExtrato(1, client,valor)
end

addEvent( "sacar", true )
addEventHandler( "sacar", resourceRoot, sacar )

function depositar(valor)
	if(valor <= getPlayerMoney(client)) then
		mysql:query_free("UPDATE characters SET `money` = "..(getPlayerMoney(client)-valor).." WHERE charactername = '" .. mysql:escape_string(getPlayerName(client)) .. "'")
		mysql:query_free("UPDATE favelas SET `dinheiro_caixa` = "..(data['dinheiro_caixa']+valor).." WHERE nome = 'Rocinha'")
		setPlayerMoney(client,getPlayerMoney(client)-valor)
		outputChatBox("Você depositou R$ "..valor, client,255,255,150)
		inserirExtrato(2, client,valor)
		return true
	end
	outputChatBox("Você não tem dinheiro pra isso"..valor, client,255,255,100)
	return false	
end

function trancarCofre()
	mysql:query_free("UPDATE favelas SET `porta_cofre_aberta` = 0 WHERE nome = 'Rocinha'")
end

function inserirExtrato(operacao, operador,valor)
	mysql:query_free("INSERT INTO extrato_cofre_favela (favela,operacao,operador,data) VALUES ( 'Rocinha',"..operacao..",'"..getPlayerName(operador).."',"..tostring(valor)..")")
end

function getExtrato()
	result =  mysql_query( handler,"SELECT * FROM extrato_cofre_favela WHERE favela='Rocinha' ORDER BY id DESC")

	local count = 0
	repeat
		row = mysql_fetch_assoc(result)
		if row then
			count = count + 1
			triggerClientEvent ( "retornoExtrato", resourceRoot,row)
			

		end
	until not row


	
end

addEvent( "getExtrato", true )
addEventHandler( "getExtrato", resourceRoot, getExtrato )

addEvent( "trancarCofre", true )
addEventHandler( "trancarCofre", resourceRoot, trancarCofre )

addEvent( "depositar", true )
addEventHandler( "depositar", resourceRoot, depositar )