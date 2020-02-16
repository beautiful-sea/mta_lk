g_items = {
	-- name, description, category, model, rx, ry, rz, zoffset
	
-- categorias:
-- 1 = Comida e bebida
-- 2 = Chaves
-- 3 = Drogas
-- 4 = Outro
-- 5 = Livros
-- 6 = Roupas e acessórios
-- 7 = Eletrônica
	{"Hotdog", "Um hotdog quente, bonito e gostoso.", 1, 2215, 205, 205, 0, 0,01},
	{"Celular", "Um celular elegante também parece um novo.", 7, 330, 90, 90, 0, -0,05},
	{"Chave do veículo", "Uma chave do veículo com um pequeno crachá do fabricante. ((Abre o veículo ## v))", 2, 1581, 270, 270, 0, 0},
	{"Chave da casa", "Uma chave da casa verde", 2, 1581, 270, 270, 0, 0},
	{"Chave comercial", "Uma chave comercial azul", 2, 1581, 270, 270, 0, 0},
	{"Rádio", "Um rádio preto", 7, 330, 90, 90, 0, -0,05},
	{"Lista Telefônica", "Uma lista telefônica rasgada.", 5, 2824, 0, 0, 0, -0,01},
	{"Sanduíche", "Um sanduíche gostoso com queijo", 1, 2355, 205, 205, 0, 0,06},
	{"Softdrink", "Uma lata de Sprunk", 1, 2647, 0, 0, 0, 0,12},
	{"Dados", "Dados brancos com pontos brancos.", 4, 1271, 0, 0, 0, 0,285},
	{"Taco", "Um taco mexicano gorduroso", 1, 2215, 205, 205, 0, 0,06},
	{"Burger", "Um cheeseburger duplo com bacon.", 1, 2703, 265, 0, 0, 0,06},
	{"Rosquinha", "Rosquinha com cobertura de açúcar pegajoso quente", 1, 2222, 0, 0, 0, 0,07},
	{"Cookie", "Um biscoito de chocolate de luxo.", 1, 2222, 0, 0, 0, 0,07},
	{"Água", "Uma garrafa de água mineral.", 1, 1484, -15, 30, 0, 0,2},
	{"Roupas", "Um conjunto de roupas limpas. ((ID da pele ## v))", 6, 2386, 0, 0, 0, 0,1},
	{"Relógio", "Um relógio de ouro inteligente", 6, 1271, 0, 0, 0, 0,285},
	{"Guia da Cidade", "Um livreto de guia da cidade pequena", 5, 2824, 0, 0, 0, -0,01},
	{"MP3 Player", "Um MP3 Player branco e elegante. A marca é EyePod.", 7, 2886, 270, 0, 0, 0,1},
	{"Luta Padrão por Manequins", "Um livro sobre como fazer a luta padrão.", 5, 2824, 0, 0, 0, -0,01},
	{"Boxing for Dummies", "Um livro sobre como fazer boxe.", 5, 2824, 0, 0, 0, -0,01},
	{"Kung Fu for Dummies", "Um livro sobre como fazer kung fu.", 5, 2824, 0, 0, 0, -0,01},
	{"Knee Head Fighting for Dummies", "Um livro sobre como fazer luta de kick kick", 5, 2824, 0, 0, 0, -0,01},
	{"Grab Kick Fighting for Dummies", "Um livro sobre como fazer uma cotovelada.", 5, 2824, 0, 0, 0, -0,01},
	{"Elbow Fighting for Dummies", "Um livro sobre como fazer o cotovelo", 5, 2824, 0, 0, 0, -0,01},
	{"Máscara de Gás", "Uma máscara de gás preta, bloqueia os efeitos de gás e flashbangs.", 6, 2386, 0, 0, 0, 0,1},
	{"Flashbang", "Um pequeno recipiente de granada com FB escrito ao lado.", 4, 343, 0, 0, 0, 0,1},
	{"Glowstick", "A glowstick verde.", 4, 343, 0, 0, 0, 0,1},
	{"Ram da porta", "Um ram de porta de metal vermelho.", 4, 1587, 90, 0, 0, 0,05},
	{"Cannabis Sativa", "Cannabis Sativa, quando misturada, pode criar alguns medicamentos fortes.", 3, 1279, 0, 0, 0, 0},
	{"Alcaloide da cocaína", "Alcaloide da cocaína, quando misturado pode criar alguns medicamentos fortes.", 3, 1279, 0, 0, 0, 0},
	{"Ácido Lisérgico", "Ácido Lisérgico, quando misturado, pode criar alguns medicamentos fortes.", 3, 1279, 0, 0, 0, 0},
	{"PCP não processado", "PCP não processado, quando misturado, pode criar alguns medicamentos fortes.", 3, 1279, 0, 0, 0, 0},
	{"Cocaína", "1g de cocaína.", 3, 1575, 0, 0, 0, 0},
	{"Drug 2", "Um conjunto de maconha com cocaína.", 3, 1576, 0, 0, 0, 0},
	{"Droga 3", "50 mg de cocaína com ácido lisérgico.", 3, 1578, 0, 0, 0, -0,02},
	{"Droga 4", "50 mg de cocaína com fenciclidina.", 3, 1579, 0, 0, 0, 0},
	{"Marijuana", "Um conjunto de maconha.", 3, 3044, 0, 0, 0, 0,04},
	{"Droga 6", "Uma junta de maconha ligada ao ácido lisérgico.", 3, 1580, 0, 0, 0, 0},
	{"Angel Dust", "Uma junta de maconha com fenciclidina.", 3, 1575, 0, 0, 0, -0,02},
	{"LSD", "80 microgramas de LSD.", 3, 1576, 0, 0, 0, 0},
	{"Droga 9", "100 miligramas de líquido amarelo.", 3, 1577, 0, 0, 0, 0},
	{"PCP Hydrochloride", "10mg of phencyclidine powder.", 3, 1578, 0, 0, 0, 0},
	{"Conjunto de Química", "Um pequeno conjunto de química", 4, 1210, 90, 0, 0, 0,1},
	{"Algemas", "Um par de algemas de metal.", 4, 2386, 0, 0, 0, 0,1},
	{"Corda", "Uma corda longa.", 4, 1271, 0, 0, 0, 0,285},
	{"Algemas", "Um pequeno par de algemas.", 4, 2386, 0, 0, 0, 0,1},
	{"Mochila", "Uma mochila de tamanho razoável.", 4, 3026, 270, 0, 0, 0},
	{"Vara de pesca", "Uma vara de pescar em aço carbono de 7 pés.", 4, 338, 80, 0, 0, -0,02},
	{"Código da estrada de Los Santos", "O código da estrada de Los Santos", 5, 2824, 0, 0, 0, -0,01},
	{"Chemistry 101", "Uma Introdução à Química Útil.", 5, 2824, 0, 0, 0, -0,01},
	{"Manual do Policial", "Manual do Policial", 5, 2824, 0, 0, 0, -0,01},
	{"Breathalizer", "Um pequeno bafômetro preto.", 4, 1271, 0, 0, 0, 0,285},
	{"Ghettoblaster", "Um Ghettoblaster preto", 7, 2226, 0, 0, 0, 0},
	{"Cartão de visita", "Steven Pullman - L.V. Freight Depot, Tel: 12555", 4, 1581, 270, 270, 0, 0},
	{"Máscara de esqui", "Uma máscara de esqui", 6, 2386, 0, 0, 0, 0,1},
	{"Fuel Can", "A small canister metal fuel.", 4, 1517, 0, 0, 0, 0,15},
	{"Ziebrand Beer", "A melhor cerveja importada da Holanda.", 1, 1520, 0, 0, 0, 0,15},
	{"Mudkip", "Então, eu agrupo você como mudkips? O favorito de mabako.", 1, 1579, 0, 0, 0, 0},
	{"Seguro", "Um cofre para guardar seus itens.", 4, 2332, 0, 0, 0, 0},
	{"Strobes de luz de emergência", "Um estroboscópio de luz de emergência que você pode colocar no seu carro.", 7, 2886, 270, 0, 0, 0,1},
	{"Vodka Bastradov", "Para seus melhores amigos - Vodka Bastradov.", 1, 1512, 0, 0, 0, 0,25},
	{"Uísque escocês", "O melhor uísque escocês, agora produzido exclusivamente a partir de Haggis.", 1, 1512, 0, 0, 0, 0,25},
	{"LSPD Badge", "Um distintivo do Departamento de Polícia de Los Santos", 4, 1581, 270, 270, 0, 0},
	{"LSES Identification", "An Los Santos Emergency Service Identification.", 4, 1581, 270, 270, 0, 0},
	{"Venda", "Uma venda preta", 6, 2386, 0, 0, 0, 0,1},
	{"GPS", "Um GPS Satnav para um carro.", 6, 2886, 270, 0, 0, 0,1},
	{"Bilhete de loteria", "Um bilhete de loteria de Los Santos", 6, 1581, 270, 270, 0, 0},
	{"Dicionário", "Um dicionário", 5, 2824, 0, 0, 0, -0,01},
	{"Kit de primeiros socorros", "Salva uma vida. Pode ser usado #v vezes.", 4, 1240, 90, 0, 0, 0,05},
	{"Caderno", "Uma pequena coleção de papéis em branco, útil para escrever anotações. Existem #v páginas restantes. ((/ Writenote))", 4, 2824, 0, 0, 0, -0,01},
	{"Nota", "A nota diz: #v", 4, 2824, 0, 0, 0, -0,01},
	{"Elevador Remoto", "Um pequeno controle remoto para alterar o modo de um elevador.", 2, 364, 0, 0, 0, 0,05},
	{"Bomb", "O que poderia acontecer quando você usa isso?", 4, 363, 270, 0, 0, 0,05},
	{"Bomb Remote", "Possui um botão vermelho engraçado.", 4, 364, 0, 0, 0, 0,05},
	{"Riot Shield", "A heavy motim shield.", 4, 1631, -90, 0, 0, 0,1},
	{"Baralho de Cartas", "Um baralho de cartas para jogar alguns jogos.", 4,2824, 0, 0, 0, -0,01},
	{"San Andreas Pilot Certificate", "Uma permissão oficial para pilotar aviões e helicópteros.", 4, 1581, 270, 270, 0, 0},
	{"Fita pornô", "Uma fita pornô, #v", 4,2824, 0, 0, 0, -0,01},
	{"Item genérico", "#v", 4, 1271, 0, 0, 0, 0,285},
	{"Frigorífico", "Um frigorífico para guardar alimentos e bebidas.", 7, 2147, 0, 0, 0, 0},
	{"Identificação LST & R", "Esta identificação LST & R foi emitida para #v.", 4, 1581, 270, 270, 0, 0},
	{"Café", "Uma pequena xícara de café.", 1, 2647, 0, 0, 0, 0,12},
	{"Escort 9500ci Radar Detector", "Detecta a polícia a 800 metros.", 7, 330, 90, 90, 0, -0,05},
	{"Sirene de Emergência", "Uma sirene de emergência para colocar no seu carro.", 7, 330, 90, 90, 0, -0,05},
	{"Identificação da SAN", "Uma identificação da SAN emitida para # v.", 7, 330, 90, 90, 0, -0,05},
	{"LS Government Badge", "A Los Santos Government Badge", 4, 1581, 270, 270, 0, 0},
	{"Fone de ouvido", "Um fone de ouvido pequeno pode ser conectado a um rádio.", 7, 1581, 270, 270, 0, 0},
	{"Comida", "", 1, 2222, 0, 0, 0, 0,07},
	{"Capacete", "Ideal para andar de bicicleta.", 6, 2386, 0, 0, 0, 0,1},
	{"Gemada", "Yum Yum.", 1, 2647, 0, 0, 0, 0,1}, --91
	{"Turquia", "Yum Yum.", 1, 2222, 0, 0, 0, 0,1},
	{"Pudim de Natal", "Yum Yum.", 1, 2222, 0, 0, 0, 0,1},
	{"Presente de Natal", "Eu sei que você quer um.", 4, 1220, 0, 0, 0, 0,1},
	{"Bebida", "", 1, 1484, -15, 30, 0, 0,2},
	{"PDA", "Um PDA topo de gama para visualizar e-mails e navegar na Internet.", 6, 2886, 270, 0, 0, 0,1},
	{"Manual de procedimentos do LSES", "Manual de procedimentos do Serviço de Emergência de Los Santos", 5, 2824, 0, 0, 0, -0,01},
	{"Garage Remote", "Um pequeno controle remoto para abrir ou fechar uma Garage.", 2, 364, 0, 0, 0, 0,05},
	{"Bandeja mista de jantar", "Vamos jogar o jogo de adivinhação.", 1, 2355, 205, 205, 0, 0,06},
	{"Small Milk Carton", "Nódulos incluídos!", 1, 2856, 0, 0, 0, 0},
	{"Caixa pequena de suco", "Sedento?", 1, 2647, 0, 0, 0, 0,12},
	{"Repolho", "Para aqueles amantes de vegetarianos.", 1, 1271, 0, 0, 0, 0,1},
	{"Prateleira", "Uma prateleira grande para guardar itens", 4, 3761, -0,15, 0, 85, 1,95},
	{"TV Portátil", "Uma TV portátil para assistir a programas de TV.", 6, 2886, 270, 0, 0, 0,1},
	{"Cama de solteiro pequena", "Cama de solteiro.", 4, 1796, 0, 0, 0, 0}, --105
	{"Cama de casal", "Cama de casal", 4, 1799, 0, 0, 0, 0},
	{"Sofá único", "sofá único", 4, 1769, 0, 0, 0, 0},
	{"Sofá", "Um sofá", 4, 1768, 0, 0, 0, 0},
	{"Cadeira de madeira", "Uma pequena cadeira de madeira.", 4, 2120, 0, 0, 0, 0,8},
	{"Cadeira de escritório 1", "Uma cadeira de escritório.", 4, 1715, 0, 0, 0, 0,2},
	{"Cadeira de Escritório 2", "Uma pequena cadeira de madeira.", 4,1714, 0, 0, 0, 0,2}, --111
	{"Bar stool", "A barstool.", 4, 2350, 0, 0, 0, 0,3},
	{"Pizza Table", "A pizza table.", 4, 2764, 0, 0, 0, 0,3},
	{"Mesa de Bilhar", "Uma mesa de bilhar.", 4, 2964, 0, 0, 0, 0},
	{"Tabela de Cartas", "Uma Tabela de Cartas.", 4, 2188, 0, 0, 0, 1}, --115
	{"Rampa", "Uma rampa de madeira", 4, 1245, 0, 0, 0, 1},
	{"Rampa 2", "Uma rampa de cor amarela.", 4,13593, 0, 0, 0, 1},

	{"Shop Desk", "Um pequeno balcão de loja.", 4,2370, 0, 0, 0, 0, 0},
	{"Trava elétrica", "Uma trava elétrica para proteger o veículo de macacos.", 7,1581, 270, 270, 0, 0},
	{"Caixa de maconha", "Caixa disponibilizada pelo fornecedor de drogas com embalagens de 1Kg cada.", 4,1355, 0, 0, 0, 0.07}
	--Cadeiras = {1663, 1671, 1720, 1721, 1810, 1811, 2079, 2120, 2121, 2125, 2777, 2788, 1369}
	---- name, description, category, model, rx, ry, rz, zoffset
}

function getItemRotInfo(id)
	if not g_items[id] then
		return 0, 0, 0, 0
	else
		return  g_items[id][5], g_items[id][6], g_items[id][7], g_items[id][8]
	end
end

local function findVehicleName( value )
	for _, theVehicle in pairs( getElementsByType( "vehicle" ) ) do
		if getElementData( theVehicle, "dbid" ) == value then
			return " (" .. getVehicleName( theVehicle ) .. ")"
		end
	end
	return ""
end

function getItemName(id, value)
	if id == -100 then
		return "Colete"
	elseif id == -46 then -- MTA Client bug
		return "Pára-quedas"
	elseif id < 0 then
		return getWeaponNameFromID( -id )
	elseif not g_items[id] then
		return "?"
	elseif id == 3 and value then
		return g_items[id][1] .. findVehicleName(value)
	elseif ( id == 4 or id == 5 ) and value then
		local pickup = exports['interior-system']:findParent( nil, value )
		local name = pickup and getElementData( pickup, "name" )
		return g_items[id][1] .. ( name and ( " (" .. name .. ")" ) or "" )
	elseif ( id == 80 ) and value then
		return value
	elseif ( id == 96 ) and value and value ~= 1 then
		return value
	elseif ( id == 89 or id == 95 ) and value and value:find( ";" ) then
		return value:sub( 1, value:find( ";" ) - 1 )
	else
		return g_items[id][1]
	end
end

function getItemValue(id, value)
	if id == 80 then
		return ""
	elseif id == 96 then
		return 1
	elseif id == 89 or id == 95 then
		return value:sub( value:find( ";" ) + 1 )
	else
		return value
	end
end

function getItemDescription(id, value)
	local i = g_items[id]
	if i then
		local desc = i[2]
		if id == 96 and value ~= 1 then
			return desc:gsub("PDA","Laptop")
		else
			return desc:gsub("#v",value)
		end
	end
end

function getItemType(id)
	return ( g_items[id] or { nil, nil, 4 } )[3]
end

function getItemModel(id)
	return ( g_items[id] or { nil, nil, nil, 1271 } )[4]
end
