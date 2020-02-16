-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

row = 4
column = 9
margin = 5
itemSize = 36
maxweight = 25

actionSlots = 6

weaponModels = {
	[14] = {355, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[15] = {356, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[16] = {339, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[18] = {336, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[22] = {358, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[24] = {353, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[23] = {357, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
	[28] = {349, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, scale = 1},
}

weaponIndexByID = {
	[37] = 33,
	[32] = 24,
	[33] = 10,
	[31] = 32,
	[18] = 12,
	[35] = 3,
	[34] = 9,
	[40] = 4,
	[43] = 15,
	[44] = 25,
	[45] = 27,
	[46] = 26,
	[47] = 29,
	[48] = 30,
	[49] = 31,
	[50] = 2,
	[51] = 5,
	[52] = 14,
	[53] = 7,
	[54] = 8,
	[55] = 17,
	[56] = 18,
	[57] = 22,
	[58] = 24,
	[59] = 34,
	[60] = 42,
	[61] = 41,
	[65] = 1,
}

items = {
--- {Nome, Peso, Descrição, Arma: true=Sim false=não, Munição: true=Sim false=não, Empilhável: true=Sim false=não, Tipo: bag,key,cards
	{name = "Sanduíche", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --1
	{name = "Batata Frita", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --2
	{name = "X-Burger", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --3
	{name = "Rosquinha", weight = 0.02, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --4
	{name = "Ruffles", weight = 1.0, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --5
	{name = "Fandangos", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --6
	{name = "Pão", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --7
	{name = "Cookie", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --8
	{name = "Hotdog", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --9
	{name = "Coca-Cola", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --10
	{name = "Fanta Laranja", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --11
	{name = "Leite", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --12
	{name = "Cerveja Heineken", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --13
	{name = "Vodka Smirnoff", weight = 0.7, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --14
	{name = "Whisky Jack Daniels", weight = 1.0, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --15
	{name = "Gasolina", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --16
	{name = "Medkit", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --17
	{name = "Vara de Pesca", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --18
	{name = "Máscara", weight = 0.09, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --19
	{name = "Celular", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --20
	{name = "Rádio Comunicador", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --21
	{name = "Corda", weight = 1.0, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --22
	{name = "Maconha Embalada", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --23
	{name = "Micha", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --24
	{name = "Maço de Cigarro", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --25
	{name = "Cigarro", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --26
	{name = "Bic", weight = 0.05, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --27
	{name = "Rádio Portátil", weight = 1.5, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --28
	{name = "Chave do Veículo", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --29
	{name = "Chave de Casa", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --30
	{name = "Mini Uzi", weight = 1.5, description = "", isWeapon = true, ammo = 108, stackable = false, typ="bag", object = 6969}, --31
	{name = "Desert Eagle", weight = 1.8, description = "", isWeapon = true, ammo = 107, stackable = false, typ="bag", object = 6969}, --32
	{name = "Picareta", weight = 2.0, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --33
	{name = "Serra Eletrica", weight = 5.0, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --34
	{name = "Cassetete", weight = 0.5, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --35
	{name = "Flor", weight = 0.2, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --36
	{name = "Espingarda", weight = 5, description = "", isWeapon = true, ammo = 110, stackable = false, typ="bag", object = 6969}, --37
	{name = "Algema", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --38
	{name = "Colete", weight = 2, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --39
	{name = "Faca", weight = 0.2, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --40
	{name = "Agenda Telefonica", weight = 2, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --41
	{name = "Cabide", weight = 1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --42
	{name = "Bengala", weight = 0.4, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --43
	{name = "Shotgun", weight = 5, description = "", isWeapon = true, ammo = 114, stackable = false, typ="bag", object = 6969}, --44
	{name = "Shotgun Altomatica", weight = 5, description = "", isWeapon = true, ammo = 114, stackable = false, typ="bag", object = 6969}, --45
	{name = "Shotgun-off", weight = 5, description = "", isWeapon = true, ammo = 114, stackable = false, typ="bag", object = 6969}, --46
	{name = "MP5", weight = 2.5, description = "", isWeapon = true, ammo = 108, stackable = false, typ="bag", object = 6969}, --47
	{name = "AK47", weight = 4, description = "", isWeapon = true, ammo = 109, stackable = false, typ="bag", object = 6969}, --48
	{name = "M4", weight = 4, description = "", isWeapon = true, ammo = 109, stackable = false, typ="bag", object = 6969}, --49
	{name = "Facão", weight = 0.4, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --50
	{name = "Taco Baseball", weight = 1, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --51
	{name = "Machado", weight = 1.2, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --52
	{name = "Billiard", weight = 0.3, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --53
	{name = "Katana", weight = 0.5, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --54
	{name = "Gás Lacrimogêneo", weight = 0.2, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --55
	{name = "Molotov", weight = 0.3, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --56
	{name = "Colt 45", weight = 1.7, description = "", isWeapon = true, ammo = 107, stackable = false, typ="bag", object = 6969}, --57
	{name = ".40", weight = 0.4, description = "", isWeapon = true, ammo = 107, stackable = false, typ="bag", object = 6969}, --58
	{name = "Sniper", weight = 5, description = "", isWeapon = true, ammo = 110, stackable = false, typ="bag", object = 6969}, --59
	{name = "Extintor de Incêndio", weight = 3, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --60
	{name = "Spray", weight = 0.4, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --61
	{name = "Alga", weight = 8, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --62
	{name = "Chave de Algema", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --63
	{name = "Escudo Policial", weight = 0.7, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --64
	{name = "Soco Ingles", weight = 0.6, description = "", isWeapon = true, ammo = false, stackable = false, typ="bag", object = 6969}, --65
	{name = "Kit Reparo", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --66
	{name = "Maconha", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --67
	{name = "Sacola de Dinheiro +5000", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --68
	{name = "Balde Cheio", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --69
	{name = "Card Diamante +200", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --70
	{name = "Distintivo", weight = 0.07, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --71
	{name = "Cofre", weight = 10, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --72
	{name = "Caixa de Leite", weight = 2, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --73
	{name = "Coquetel", weight = 0.6, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --74
	{name = "Trava de Bicicleta", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --75
	{name = "Cartão de Identidade", weight = 0.008, description = "", isWeapon = false, ammo = false, stackable = false, typ="cards", object = 6969}, --76
	{name = "Café", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --77
	
	{name = "Chave de Bicicleta", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --78
	{name = "Madeira Quebrada", weight = 2, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --79
	{name = "Combustivel", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --80
	{name = "Semente de Maconha", weight =  0.001, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --81
	{name = "Balde Vazio", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --82
	{name = "Lata Velha", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --83
	{name = "Kit Medico", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --84
	{name = "Cocaína", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --85
	{name = "Card Dinheiro +500", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --86
	{name = "Card Dinheiro +1000", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --87
	
	{name = "Crack", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --88
	{name = "Pé de Cabra", weight = 1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --89
	{name = "Injeção", weight = 0.09, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --90
	{name = "Bota Velha", weight = 0.09, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --91
	{name = "Acido", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --92
	{name = "Balde Enferrujado", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --93
	{name = "Poupa de Cogumelo", weight = 0.05, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --94
	{name = "Maconha", weight = 1, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --95
	{name = "Card Diamante +500", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --96
	{name = "Selo", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --97
	{name = "LSD", weight = 0.04, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --98
	{name = "Fogos de Artifício", weight = 0.07, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --99
	{name = "Metilfenidato", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --100
	{name = "Ritalina", weight = 0.003, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --101
	{name = "Rede Velha", weight = 0.002, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --102
	{name = "Anticongelante", weight = 0.07, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --103
	{name = "Cristal", weight = 0.02, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --104
	{name = "Metanfetamina", weight = 0.2, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --105
	{name = "Speed", weight = 0.1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --106
	
	{name = "Munição 9MM", weight = 0.02, description = "Pistolas", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --107
	{name = "Munição .380", weight = 0.02, description = "TEC-9,MP5, UZI", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --108
	{name = "Munição 762", weight = 0.02, description = "M4/AK47", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --109
	{name = "Munição .50", weight = 0.05, description = "Sniper", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --110
	{name = "Carteira de Habilitação", weight = 0.002, description = "", isWeapon = false, ammo = false, stackable = false, typ="cards", object = 6969}, --111
	{name = "Fogos de Artifício", weight = 0.2, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --112
	{name = "Porte de Armas", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="cards", object = 6969}, --113
	{name = "Munição 18MM", weight = 0.09, description = "Espingarda", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --114
	
	{name = "Gorro", weight = 0.02, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --115
	{name = "Chocolate", weight = 1, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --116
	{name = "Cupcake", weight = 0.008, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --117
	{name = "Caixa de Bombom", weight = 0.006, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --118
	{name = "Pepsi", weight = 1.5, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --119
	{name = "Açúcar", weight = 0.01, description = "", isWeapon = false, ammo = false, stackable = true, typ="bag", object = 6969}, --120
	
	{name = "Tilapia", weight = 3.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --121
	{name = "Baiacu", weight = 2.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --122
	{name = "Estrela do Mar", weight = 0.02, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --123
	{name = "Peixe Morto", weight = 2.17, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --124
	{name = "Tubarão Martelo", weight = 8.21, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --125
	{name = "Polvo", weight = 2.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --126
	{name = "Tubarão Branco", weight = 45, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --127
	{name = "Caranguejo", weight = 23.82, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --128
	{name = "Chave do Cofre", weight = 0.001, description = "", isWeapon = false, ammo = false, stackable = false, typ="key", object = 6969}, --129
	
	{name = "Colt-45 Parte 1", weight = 0.5, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --130
	{name = "Colt-45 Parte 2", weight = 0.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --131
	{name = "Colt-45 Parte 3", weight = 0.9, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --132
	
	{name = "Uzi Parte 1", weight = 1.3, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --133
	{name = "Uzi Parte 2", weight = 0.8, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --134
	{name = "Uzi Parte 3", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --135
	
	{name = "AK-47 Parte 1", weight = 0.7, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --136
	{name = "AK-47 Parte 2", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --137
	{name = "AK-47 Parte 3", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --138
	
	{name = "Talão de Cheque", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --139
	{name = "Registro Criminal", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --140

	{name = "Jornal PH", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --141
	{name = "Jornal Velho", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --142
	{name = "Caixa de Presente", weight = 0.4, description = "", isWeapon = false, ammo = false, stackable = false, typ="bag", object = 6969}, --143
	{name = "Licença de Pesca", weight = 0.4, description = "oi", isWeapon = false, ammo = false, stackable = false, typ="cards", object = 6969}, --144
}

craft_recipes = {		
	{
		["item"] = {5, 1, 1},
		["itemCount"] = 1,
		[1] = {3,1},
	},	
}

function getItemName(id)
	if items[id] then
		return items[id].name
	end
end

function getItemWeight(id)
	if items[id] then
		return items[id].weight
	end
end

function getItemDescription(id)
	if items[id] then
		return items[id].description
	end
end

function getItemTable()
	return items
end

function getTypeOfElement(element)
	if not isElement(element) then return false end
	if getElementType(element) == "player" then
		return {"player", "charID", 30}
	elseif getElementType(element) == "vehicle" then
		return {"vehicle", "charID", 100}
	else
		return {"object", "charID", 70}
	end
end

function getPlayerDistanceFromElement(player, element)
	if not player or not element then return end
	local x, y, z = getElementPosition(player)
	local T_Pos = {getElementPosition(element)}
	return getDistanceBetweenPoints3D(x, y, z, unpack(T_Pos))
end


craftMarkers = {
	{2558.4677734375, -1296.404296875, 1044.125},
	{2556.1689453125, -1296.404296875, 1044.125},
	{2553.88476562, -1296.404296875, 1044.125},
	{2544.4248046875, -1296.404296875, 1044.125},
	{2542.071289062, -1296.404296875, 1044.125},
	{2558.4677734375, -1290.49609375, 1044.125},
	{2556.1689453125, -1290.49609375, 1044.125},
	{2553.88476562, -1290.49609375, 1044.125},
	{2544.4248046875, -1290.49609375, 1044.125},
	{2542.071289062, -1290.49609375, 1044.125},
}