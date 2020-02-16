menus = {
{"Predio Andares inferiores","HOME",1,"list"},
{"Predio Andares Superiores","HOME",2,"list"},
{"EM BREVE","HOME",3,"list"},
{"EM BREVE 2","HOME",4,"list"},
{"EM BREVE 3","HOME",5,"list"},

{"Terreo","Predio Andares inferiores",1,0},
{"Primeiro andar Banco Central","Predio Andares inferiores",2,0},
{"Segundo andar Auto Escola","Predio Andares inferiores",3,0},
{"Terceiro andar Loja de roupas","Predio Andares inferiores",4,0},
{"Quarto andar Academia","Predio Andares inferiores",5,0},

{"Quinto andar Conveniencia","Predio Andares Superiores",1,0},
{"Sexto andar Dormitorios","Predio Andares Superiores",2,0},
{"COBERTURA","Predio Andares Superiores",3,0},

{"Disponivel EM BREVE","EM BREVE",1,0},
{"Disponivel EM BREVE 2","EM BREVE",2,0},

{"Disponivel EM BREVE 3","EM BREVE 2",1,0},

{"DISPONIVEL EM BREVE 4","EM BREVE 3",1,0}
}

local teleport = {
	["Predio Andares inferiores"] = {
		["Terreo"] = {1881.631, -1319.881, 14.5},
		["Primeiro andar Banco Central"] = {1881.849, -1319.517, 19.492},
		["Segundo andar Auto Escola"] = {1881.819, -1319.658, 24.492},
		["Terceiro andar Loja de roupas"] = {1881.723, -1319.313, 29.492},
		["Quarto andar Academia"] = {1882.169, -1319.483, 34.492}
	},
	["Predio Andares Superiores"] = {
		["Quinto andar Conveniencia"] = {1881.76, -1319.83, 39.492},
		["Sexto andar Dormitorios"] = {1881.552, -1319.674, 44.492},
		["COBERTURA"] = {1881.729, -1315.792, 83.997}
	},
	["EM BREVE"] = {
		["Disponivel EM BREVE"] = {1903.559, -1315.471, 14.191},
		["Disponivel EM BREVE 2"] = {1903.559, -1315.471, 14.191},
	},
	["Bone County"] = {
		["Aeroporto abandonado"] = {1903.559, -1315.471, 14.191}
	},
	["Whetstone"] = {
		["Mount chiliad"] = {1903.559, -1315.471, 14.191}
	}
}

function onItemClick(data)
	if getPlayerMoney(localPlayer) >= data[3] and not isPedInVehicle(localPlayer) then
		triggerServerEvent("onPlayerBuyItemInTeleport",localPlayer,data[3])
		local p = teleport[data[2]][data[1]]
		onPlayerRequestCloseMenu()
		for k, v in pairs(Menu.instances) do
				v.point:setColor(255,0,0)
				setTimer(function()				
					v.point:setColor(0, 191, 243)
				end,10000,1)
			end
		fadeCamera(false,1,0,0,0)
		setTimer(function()
			setElementPosition(localPlayer,p[1],p[2],p[3])
		end,1000,1)
		setTimer(fadeCamera,2000,1,true,0.5)
	else
		outputChatBox("#ffffff[ #00C8FFTeleport #FFFFFF] #00C8FFDinheiro insuficiente.",255,0,0)
	end
end

Menu = {}
Menu.__index = Menu
Menu.instances = {}

function Menu.onResourceStart()
	for k, v in pairs(teleport) do
		for i, v2 in pairs(v) do
			local p = setmetatable({}, Pointer)
			outputDebugString(i)
			p.point = Pointer.create(v2[1],v2[2],v2[3]-1)
			p.point:setColor(0, 191, 243)

			function p.point:onHit()
				if self:getColor()[1] == 0 and not isPedInVehicle(localPlayer) then
					showMenu()
					playSound("sfx/ping.mp3",false)
				end
			end
			
			table.insert(Menu.instances, p)
		end
	end
end
addEventHandler("onClientResourceStart",resourceRoot,Menu.onResourceStart)