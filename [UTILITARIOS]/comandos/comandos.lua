function criar(thePlayer,nomeDoComando,param)
	outputChatBox(nomeDoComando,thePlayer)
	--criar_objeto_aqui ID_OBJETO [DIMENSAO]
	local x,y,z = getElementPosition(thePlayer)
	
	local dimensao = 0


	if(nomeDoComando == 'criar_objeto') then
		local objeto = createObject(tonumber(param),x,y-2,z-1)
		setElementVelocity(objeto, 0, 0, 0)
		setElementDimension (objeto, 0)
		outputChatBox("Objeto criado: "..param.."\nDimensão: "..dimensao.."\nx: "..x.."y: "..y.."z: "..z, thePlayer)
	end
	if(nomeDoComando == 'criar_marker') then
		if(param) then
			createMarker ( x, y, z, "checkpoint", param, 255, 0, 0, 255 )
			outputChatBox("Marker criado em: "..dimensao.."\nx: "..x.."y: "..y.."z: "..z, thePlayer)
		end 
	end
end

addCommandHandler("devmode",
	function()
		setDevelopmentMode(true)
	end
	)

function puxar_jogador(thePlayer, nomeDoComando, usuario)
	local x,y,z = getElementPosition(thePlayer)

	if(getPlayerFromName(usuario)) then
		spawnPlayer ( getPlayerFromName(usuario), x, y, z)
		outputChatBox("Jogador puxado", thePlayer)
	else
		outputChatBox("Jogador não existe", thePlayer)
	end
end

function minha_posicao(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	r, o, p =  getElementRotation ( thePlayer) 
	outputChatBox(x..","..y..","..z..","..r..","..o..","..p)
end

function carro(thePlayer, nomeDoComando, idCarro)
	local x,y,z = getElementPosition(thePlayer)
	local carro = createVehicle ( idCarro, 0, 0, 0 ) 
	spawnVehicle ( carro, x,y,z )
	outputChatBox("Carro criado", thePlayer)
end
addCommandHandler("criar_objeto", criar)
addCommandHandler("criar_marker", criar)
addCommandHandler("puxar", puxar_jogador)
addCommandHandler("posic", minha_posicao)
addCommandHandler("carro", carro)


function set_dimensao_player(thePlayer,nomeDoComando,dimensao)
	setElementDimension (thePlayer, dimensao)
	outputChatBox("Nova Dimensão: "..dimensao, thePlayer)
end

function set_gravidade(thePlayer, nomeDoComando, gravidade,player)

	if(not player) then
		player = thePlayer
	else
		player = getPlayerFromName(player)
	end
	setPedGravity ( player,tonumber(gravidade))
	outputChatBox("Nova Gravidade: "..gravidade, thePlayer)

end

function desbugar(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	carro = getPedOccupiedVehicle ( thePlayer )
	if(carro) then
		setElementPosition( carro, x-10,y,z-5000 )
	else
		setElementPosition( thePlayer, x-10,y,z-5000 )
	end
	setPedGravity (thePlayer, 0.008)
	--setTimer(setPedGravity (thePlayer, 0.00001),3000,1)
	outputChatBox(getPlayerName(thePlayer).." Desbugado")
end

function getGravidade( thePlayer )
	local gravidade = getPedGravity (thePlayer )
	outputChatBox ( "A gravidade atual é " .. gravidade, thePlayer )
end

function loja_roupa(thePlayer)
	setElementPosition( thePlayer, 1873.5390625,-1320.7646484375,29.4921875 )
end

function rocinha(thePlayer)
	setElementPosition( thePlayer, 2295.654296875,-1065.5703125,49.404296875 )
end
function concessionaria(thePlayer)
	setElementPosition( thePlayer, 1756.37109375,-1701.7626953125,13.533596038818 )
end

function fornecedor_de_drogas(thePlayer)
	setElementPosition( thePlayer, -1087.9306640625,-1633.5947265625,76.3671875 )
end

function casa_patrao1(thePlayer)
	setElementPosition( thePlayer, 2414.908203125,-763.6162109375,118.55079650879 )
end

function setArma(thePlayer, nomeDoComando, arma)
	giveWeapon(thePlayer,arma)
	outputChatBox ( "Arma criada ", thePlayer )
end

function teleporte(thePlayer, nomeDoComando, x,y,z)
	carro = getPedOccupiedVehicle ( thePlayer )
	if(carro) then
		setElementPosition( carro, tonumber(x),tonumber(y),tonumber(z) )
	end
	setElementPosition( thePlayer, tonumber(x),tonumber(y),tonumber(z) )
	outputChatBox(getPlayerName(thePlayer).." Teleportado para: "..tonumber(x)..","..tonumber(y)..","..tonumber(z))
end

function deletarObjetosProximos(thePlayer)
	local pe = {getElementPosition(thePlayer)}
	local dis = 6
	local dis2 = 0
	local obj = -1

	local type = "object"
	for key, value in ipairs(getElementsByType(type)) do
		local p2 = {getElementPosition(value)}
		dis2 = getDistanceBetweenPoints3D (pe[1], pe[2], pe[3], p2[1], p2[2], p2[3])
		if tonumber(dis2) < tonumber(dis)  then
			dis = dis2
			obj = value
			destroyElement(obj)

		end
	end
end
addCommandHandler ( "get_gravidade", getGravidade )
addCommandHandler("d", set_dimensao_player)
addCommandHandler("gravidade", set_gravidade)
addCommandHandler("desbug", desbugar)
addCommandHandler("loja_roupa", loja_roupa)
addCommandHandler("rocinha", rocinha)
addCommandHandler("arma", setArma)
addCommandHandler("tp", teleporte)
addCommandHandler("conc", concessionaria)
addCommandHandler("forn", fornecedor_de_drogas)
addCommandHandler("patrao1", casa_patrao1)
addCommandHandler("del", deletarObjetosProximos)