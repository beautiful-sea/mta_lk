local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)

local jobPed = {}
local roboto2 = "bankgothic"--dxCreateFont("files/Roboto.ttf",14)
local roboto = dxCreateFont("files/Roboto.ttf",14)



local Cplayer = getLocalPlayer(  );
setElementData( Cplayer, 'chatStatus', 'Online' )
setElementData( Cplayer, 'donotDisturb', nil )
local chat_Windows = {  };


local startTick = getTickCount()
local progress = ""
local elements = ""

local maxElem = 7
local nextPage = 0
local nextPageanimacoes = 0
local nextPageobjetos = 0
local inicio = false
local semcelular = false
local servicos = false
local dinheiro = false
local player = false
local semcelulardinheiro = false
local animacoes = false
local objetos = false

local celular_Table = {
	{"Player", ""},
	{"Serviços", ""}, 
	{"Enviar dinheiro", ""}, 
	{"Objetos", ""}, 
	{"WhatsApp", ""},
	{"Animações", ""}, 
	{"Revistar Jogador", ""}, 
}


local celularPlayer_Table = {
	{"Dinheiro", ""}, 
	{"Banco", ""},
	{"Dinheiro Sujo", ""},
	{"Voltar", ""},
}

local celularSEM_Table = {
	{"Dinheiro", ""}, 
	{"Banco", ""},
	{"Enviar dinheiro", ""}, 
}

local celularServicos_Table = {
	{"Chamar Staff", ""},
	{"Policia", ""}, 
	{"PRF", ""}, 
	{"Taxi", ""}, 
	{"BGO - Resgate", ""}, 
	{"Mecânico", ""}, 
	{"DRVV - Detran", ""}, 
	{"Voltar", ""},
}



local celulardinheiro_Table = {
	{"Enviar", ""},
	{"Voltar", ""},
}

local semcelulardinheiro_Table = {
	{"Enviar", ""},
	{"Voltar", ""},
}


local celularobjetos_Table = {
	{"Voltar", ""},

	{"Caixa de som na mão",""},
	{"Caixa na mão",""},
	{"Flor na mão",""},

	{"Guarda chuva na mão",""},

}


local celularanimacoes_Table = {
	{"Parar", ""},
	--{"Voltar", ""},
	{"Render-se",""},
	{"Qual Foi?",""},
	{"Apontar", ""},
	{"Chorar", ""},
	{"Dedo do meio", ""},
	{"Braços cruzados", ""},
	{"Aguardando", ""},
	{"Mirar", ""},
	{"Fumar", ""},
	{"Fumando encostado", ""},
	{"Iniciar corrida", ""},
	{"Medo", ""},
	{"Pensando", ""},	
}

function keyControl(k, s)
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
		if(nextPageanimacoes>0)then
		nextPageanimacoes = nextPageanimacoes - 1
		end

		if(nextPageobjetos>0)then
			nextPageobjetos = nextPageobjetos - 1
		end
	elseif k == "mouse_wheel_down" then
		nextPage = nextPage + 1
		if(nextPage > #celular_Table-maxElem)then
			nextPage = #celular_Table-maxElem
		end
		
		nextPageobjetos = nextPageobjetos + 1
		if(nextPageobjetos > #celularobjetos_Table-maxElem)then
			nextPageobjetos = #celularobjetos_Table-maxElem
		end


		nextPageanimacoes = nextPageanimacoes + 1
		if(nextPageanimacoes > #celularanimacoes_Table-maxElem)then
			nextPageanimacoes = #celularanimacoes_Table-maxElem
		end
		--[[
	elseif k == "backspace" then
		removeEventHandler("onClientRender", root, createPanel)
		removeEventHandler("onClientKey",root,keyControl)
		show = false]]--
	end
end	




function createPanel()
	local elem = 0

	if getElementData(localPlayer, "celular") then

	if getElementData(localPlayer, "celular-inicio") then	

		--if getElementData(localPlayer, "char:adminduty") == 1 then
			--teste = 0
			--else
		--	teste = 75
		--	end
			--dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*200-teste,tocolor(31,32,41,255), 15)
			--dxDrawRectangle(sx*860,sy*320,sx*250,sy*190-teste,tocolor(31,32,41,255))

			dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*90,tocolor(31,32,41,255), 15)
			--dxDrawRectangle(sx*860,sy*320,sx*250,sy*80,tocolor(31,32,41,255))
			dxDrawText("Celular",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)

	for index, value in ipairs (celular_Table) do 
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			dinheiro = false
			semcelular = false
			inicio = true
			player = false
			animacoes = false
			objetos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255	

			
		if value[1] == "Revistar Jogador" then 
			if getElementData(localPlayer, "char:adminduty") == 1 or getElementData(localPlayer, "char:dutyfaction") == 18 or getElementData(localPlayer, "char:dutyfaction") == 25 or getElementData(localPlayer, "char:dutyfaction") == 23 or getElementData(localPlayer, "char:dutyfaction") == 24 or getElementData(localPlayer, "char:dutyfaction") == 16 or getElementData(localPlayer, "char:dutyfaction") == 8 or getElementData(localPlayer, "char:dutyfaction") == 10 or getElementData(localPlayer, "char:dutyfaction") == 13 or getElementData(localPlayer, "char:dutyfaction") == 14 or getElementData(localPlayer, "char:dutyfaction") == 15 then
				dxDrawRectangle(sx*860,sy*194+elem*(sy*52), sx*250,sy*55,tocolor(31,32,41,255))	
				if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then			
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
				else
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
				end	
				--elem = elem + 1
				dxDrawText(value[1], sx*1970, sy*445+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			else
				elem = elem - 1
			end
		else

			dxDrawRectangle(sx*860,sy*194+elem*(sy*52), sx*250,sy*55,tocolor(31,32,41,255))
			--dxDrawRectangle(sx*860,sy*190+elem*(sy*52), sx*250,sy*60,tocolor(31,32,41,255))
			if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then					
				dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
			end				
			dxDrawText("#000000"..value[1], sx*1970, sy*445+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
		end


		end	
	end
	end


	
	if getElementData(localPlayer, "celular-objetos") then
		--dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*285,tocolor(31,32,41,255), 15)
		--dxDrawRectangle(sx*860,sy*320,sx*250,sy*295,tocolor(31,32,41,255))
		--dxDrawText("Objetos",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)


		dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*90,tocolor(31,32,41,255), 15)
		--dxDrawRectangle(sx*860,sy*320,sx*250,sy*80,tocolor(31,32,41,255))
		dxDrawText("Objetos",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)


	local elem2 = 0
	for index, value in ipairs (celularobjetos_Table) do 
	if (index > nextPageobjetos and elem2 < maxElem) then
		elem2 = elem2 + 1
		semcelular = false
		inicio = false
		dinheiro = false
		servicos = false
		player = false
		animacoes = false
		objetos = true
		semcelulardinheiro = false
		local r, g, b = 255, 255, 255	
		--[[	
		if not isInSlot(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40) then
							
			dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
		else
			dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
		end
		dxDrawText("#000000"..value[1], sx*1970, sy*450+elem2*(sy*104), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
]]--

		dxDrawRectangle(sx*860,sy*194+elem2*(sy*52), sx*250,sy*55,tocolor(31,32,41,255))
		--dxDrawRectangle(sx*860,sy*190+elem*(sy*52), sx*250,sy*60,tocolor(31,32,41,255))
		if not isInSlot(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40) then					
			dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
		else
			dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
		end				
		dxDrawText("#000000"..value[1], sx*1970, sy*445+elem2*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)


	end	
end
end


		if getElementData(localPlayer, "celular-player") then
	dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*129,tocolor(31,32,41,255), 15)
	dxDrawRectangle(sx*860,sy*320,sx*250,sy*139,tocolor(31,32,41,255))
			dxDrawText("Player",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
		for index, value in ipairs (celularPlayer_Table) do 
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			semcelular = false
			player = true
			inicio = false
			dinheiro = false
			servicos = false
			animacoes = false
			objetos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255				


			if value[1] == "Dinheiro" then 
				if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then			
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
				else
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
				end	
			local money = (getElementData(localPlayer, "char:money") or 0)
			dxDrawText("#000000"..value[1]..": " .. money.."", sx*1970, sy*450+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			elseif value[1] == "Banco" then
				if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then			
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
				else
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
				end	
			local bankMoney = (getElementData(localPlayer, "char:bankmoney") or 0)
			dxDrawText("#000000"..value[1]..": " .. bankMoney .."", sx*1970, sy*450+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			elseif value[1] == "Dinheiro Sujo" then
				if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then			
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
				else
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
				end	
			local dinheiroSujo = (getElementData(localPlayer, "char:moneysujo") or 0)
			dxDrawText("#000000"..value[1]..": " .. dinheiroSujo .."", sx*1970, sy*450+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			--dxDrawText("#000000"..value[1]..": Em breve", sx*1970, sy*450+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			else
				if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then			
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
				else
					dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
				end	
			dxDrawText("#000000"..value[1],sx*1970, sy*450+elem*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			end	
		end	
	end
	end
	
	if getElementData(localPlayer, "celular-servicos") then
		dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*285,tocolor(31,32,41,255), 15)
		dxDrawRectangle(sx*860,sy*320,sx*250,sy*295,tocolor(31,32,41,255))
		dxDrawText("Serviços",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
			
			
		for index, value in ipairs (celularServicos_Table) do 
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			semcelular = false
			inicio = false
			player = false
			dinheiro = false
			servicos = true
			animacoes = false
			objetos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255		
			if not isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then
								
				dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx*863,sy*205+elem*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
			end
			dxDrawText("#000000"..value[1], sx*1970, sy*450+elem*(sy*104), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
		end	
	end
	end
	if getElementData(localPlayer, "celular-dinheiro") then
			semcelular = false
			inicio = false
			player = false
			dinheiro = true
			servicos = false
			animacoes = false
			objetos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255		
			dxDrawRoundedRectangle(sx*515,sy*300,sx*306,sy*310,tocolor(31,32,41,255), 15)
			dxDrawRectangle(sx*515,sy*320,sx*306,sy*305,tocolor(31,32,41,255))
			dxDrawText("Enviar Dinheiro",sx*1350, sy*630, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
			if not isInSlot(sx*547, sy*500, sx*242, sy*46) then
				dxDrawRectangle(sx*547, sy*500, sx*242, sy*46, tocolor(0, 112, 175, 255))
			else
				dxDrawRectangle(sx*547, sy*500, sx*242, sy*46, tocolor(0, 112, 175, 210))
			end		
			
			if not isInSlot(sx*547, sy*566, sx*242, sy*46) then
				dxDrawRectangle(sx*547, sy*566, sx*242, sy*46, tocolor(0, 112, 175, 255))
			else
				dxDrawRectangle(sx*547, sy*566, sx*242, sy*46, tocolor(0, 112, 175, 210))
			end
			createEditBox("1", 0.379, 0.443, 0.22, 0.06, true, "", false, 7, "default", false, 1, {0, 0, 0, 127 }, true, { r, g, b, 210 }, sy/2, true, 60, true, "Digite o valor", { 0, 0, 0, 127 }, true, sy/2, "default", true, true, {0, 0, 0}, false) 
			createEditBox("2", 0.379, 0.543, 0.22, 0.06, true, "", false, 7, "default", false, 1, {0, 0, 0, 127 }, true, { r, g, b, 210 }, sy/2, true, 60, true, "Conta bancaria do jogador", { 0, 0, 0, 127 }, true, sy/2, "default", true, true, {0, 0, 0}, false) 
			dxDrawText("Enviar",sx*1340, sy*1050, sx/2, 0,tocolor(255,255,255,255),sy/0.7,"default","center", "center",false,false,false,true)
			dxDrawText("Cancelar",sx*1340, sy*1175, sx/2, 0,tocolor(255,255,255,255),sy/0.7,"default","center", "center",false,false,false,true)
			if isInSlot(sx*517, sy*341, sx*302, sy*46) then
			dxDrawText("Digite o valor!",sx*1340, sy*530, sx/2, 0,tocolor(255,255,255,255),sy/0.5,"default","center", "center",false,false,false,true)
			end
			if isInSlot(sx*517, sy*416, sx*302, sy*46) then
			dxDrawText("Conta bancaria do jogador",sx*1340, sy*530, sx/2, 0,tocolor(255,255,255,255),sy/0.5,"default","center", "center",false,false,false,true)
			end	
			
		--end	
	--end
	end



	if getElementData(localPlayer, "celular-animacoes") then
			dxDrawRoundedRectangle(sx*860,sy*200,sx*250,sy*285,tocolor(31,32,41,255), 15)
			dxDrawRectangle(sx*860,sy*320,sx*250,sy*295,tocolor(31,32,41,255))
			dxDrawText("Animações",sx*1970, sy*450, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
		local elem2 = 0
		for index, value in ipairs (celularanimacoes_Table) do 
		if (index > nextPageanimacoes and elem2 < maxElem) then
			elem2 = elem2 + 1
			semcelular = false
			inicio = false
			dinheiro = false
			servicos = false
			player = false
			animacoes = true
			objetos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255		
			if not isInSlot(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40) then
								
				dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx*863,sy*205+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
			end
			dxDrawText("#000000"..value[1], sx*1970, sy*450+elem2*(sy*104), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)

		end	
	end
	end

	else
	
		local elem2 = 0
		if not getElementData(localPlayer, "semcelular-dinheiro") then
	dxDrawRoundedRectangle(sx*860,sy*400,sx*250,sy*170,tocolor(31,32,41,255), 15)
	dxDrawRectangle(sx*860,sy*420,sx*250,sy*185,tocolor(31,32,41,255))
	dxDrawText("Informações",sx*1970, sy*850, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
		for index, value2 in ipairs (celularSEM_Table) do 
			elem2 = elem2 + 1
			dinheiro = false
			semcelular = true
			inicio = false
			player = false
			servicos = false
			semcelulardinheiro = false
			local r, g, b = 255, 255, 255		
			if not isInSlot(sx*863,sy*405+elem2*(sy*52), sx*245,sy*40) then
				dxDrawRectangle(sx*863,sy*405+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx*863,sy*405+elem2*(sy*52), sx*245,sy*40, tocolor(r, g, b, 210))
			end
			if value2[1] == "Dinheiro" then 
			    local money = (getElementData(localPlayer, "char:money") or 0)
			dxDrawText("#000000"..value2[1]..": " .. money.."", sx*1970, sy*850+elem2*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			elseif value2[1] == "Banco" then 
			    local bankmoney = (getElementData(localPlayer, "char:bankmoney") or 0)
			dxDrawText("#000000"..value2[1]..": " .. bankmoney.."", sx*1970, sy*850+elem2*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)

			else
			dxDrawText("#000000"..value2[1], sx*1970, sy*850+elem2*(sy*105), sx/2, 0, tocolor(0, 0, 0, 255), sy/1.5, roboto, "center", "center", false, false, false, true)
			end	
	end
	else
			semcelular = false
			inicio = false
			player = false
			dinheiro = false
			servicos = false
			animacoes = false
			objetos = false
			semcelulardinheiro = true
			local r, g, b = 255, 255, 255		
			dxDrawRoundedRectangle(sx*515,sy*300,sx*306,sy*310,tocolor(31,32,41,255), 15)
			dxDrawRectangle(sx*515,sy*320,sx*306,sy*305,tocolor(31,32,41,255))
			dxDrawText("Enviar Dinheiro",sx*1350, sy*630, sx/2, 0,tocolor(255,255,255,255),sy/1.5,roboto2,"center", "center",false,false,false,true)
			if not isInSlot(sx*547, sy*500, sx*242, sy*46) then
				dxDrawRectangle(sx*547, sy*500, sx*242, sy*46, tocolor(0, 112, 175, 255))
			else
				dxDrawRectangle(sx*547, sy*500, sx*242, sy*46, tocolor(0, 112, 175, 210))
			end		
			
			if not isInSlot(sx*547, sy*566, sx*242, sy*46) then
				dxDrawRectangle(sx*547, sy*566, sx*242, sy*46, tocolor(0, 112, 175, 255))
			else
				dxDrawRectangle(sx*547, sy*566, sx*242, sy*46, tocolor(0, 112, 175, 210))
			end
			createEditBox("3", 0.379, 0.443, 0.22, 0.06, true, "", false, 7, "default", false, 1, {0, 0, 0, 127 }, true, { r, g, b, 210 }, sy/2, true, 60, true, "Digite o valor", { 0, 0, 0, 127 }, true, sy/2, "default", true, true, {0, 0, 0}, false) 
			createEditBox("4", 0.379, 0.543, 0.22, 0.06, true, "", false, 7, "default", false, 1, {0, 0, 0, 127 }, true, { r, g, b, 210 }, sy/2, true, 60, true, "Conta bancaria do jogador", { 0, 0, 0, 127 }, true, sy/2, "default", true, true, {0, 0, 0}, false) 
			dxDrawText("Enviar",sx*1340, sy*1050, sx/2, 0,tocolor(255,255,255,255),sy/0.7,"default","center", "center",false,false,false,true)
			dxDrawText("Cancelar",sx*1340, sy*1175, sx/2, 0,tocolor(255,255,255,255),sy/0.7,"default","center", "center",false,false,false,true)	
			if isInSlot(sx*517, sy*341, sx*302, sy*46) then
			dxDrawText("Digite o valor!",sx*1340, sy*530, sx/2, 0,tocolor(255,255,255,255),sy/0.5,"default","center", "center",false,false,false,true)
			end
			if isInSlot(sx*517, sy*416, sx*302, sy*46) then
			dxDrawText("Conta bancaria do jogador",sx*1340, sy*530, sx/2, 0,tocolor(255,255,255,255),sy/0.5,"default","center", "center",false,false,false,true)
			end			
		end
	end
end

local boxMenStats = false

local altura = 0
function teste(button, state, x, y, elementx, elementy, elementz, element)
	if state == "down" and button == "left" and inicio then 
		elem = 0
		for index, value in ipairs (celular_Table) do 
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1
				if isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then 
				if value[1] == "Player" then 
				setElementData(localPlayer, "celular-player", true)
				setElementData(localPlayer, "celular-inicio", false)
				end	
				if value[1] == "Serviços" then 
				setElementData(localPlayer, "celular-servicos", true)
				setElementData(localPlayer, "celular-inicio", false)
				end	
				if value[1] == "Enviar dinheiro" then 
				setElementData(localPlayer, "celular-dinheiro", true)
				setElementData(localPlayer, "celular-inicio", false)
				changeVisibility("1", true)
				changeVisibility("2", true)
				end
				if value[1] == "Animações" then 
				setElementData(localPlayer, "celular-animacoes", true)
				setElementData(localPlayer, "celular-inicio", false)
			end
			if value[1] == "Objetos" then 
				setElementData(localPlayer, "celular-objetos", true)
				setElementData(localPlayer, "celular-inicio", false)
			end
			if value[1] == "WhatsApp" then 
			guiSetVisible( GUIEditor.window[1], not guiGetVisible( GUIEditor.window[1] ) )
			--showCursor( guiGetVisible( GUIEditor.window[1] ) )
			guiSetInputEnabled( guiGetVisible( GUIEditor.window[1] ) )
		   	for cNumber, _ in pairs( chat_Windows ) do
			guiSetVisible( chat_Windows[cNumber].window, guiGetVisible( GUIEditor.window[1] ) )
			end
			end



			if value[1] == "Revistar Jogador" then 

				local posX1, posY1, posZ1 = getElementPosition(localPlayer)
				for _, player in ipairs(getElementsByType("player")) do
					local posX2, posY2, posZ2 = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
					if distance <= 1 then
						--if player then
						if player ~= localPlayer then
			    			 if getElementData(localPlayer, "char:adminduty") == 16 or getElementData(localPlayer, "char:dutyfaction") == 23 or getElementData(localPlayer, "char:dutyfaction") == 25 or getElementData(localPlayer, "char:dutyfaction") == 24 or getElementData(localPlayer, "char:adminduty") == 1 or getElementData(localPlayer, "char:dutyfaction") == 7 or getElementData(localPlayer, "char:dutyfaction") == 18 or getElementData(localPlayer, "char:dutyfaction") == 8 or getElementData(localPlayer, "char:dutyfaction") == 10 or getElementData(localPlayer, "char:dutyfaction") == 13 or getElementData(localPlayer, "char:dutyfaction") == 14 or getElementData(localPlayer, "char:dutyfaction") == 15 then
								if getElementData(localPlayer, "flood") then outputChatBox("#7cc576*ERROR #FFFFFFVocê revistou um jogador recentemente, Aguarde 5 minutos.", 255, 255, 255, true) return end
							 setElementData(localPlayer, "flood", true)
							 setTimer(setElementData, 60000 * 5, 1, localPlayer, "flood", false)
				        		outputChatBox(" ", 255, 255, 255, true)	
				     		    outputChatBox(" ", 255, 255, 255, true)	
     						    outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox(" ", 255, 255, 255, true)	
						        outputChatBox("#7cc576      ===== #FFFFFFREVISTANDO O JOGADOR #7cc576=====", 255, 255, 255, true)
						        outputChatBox("#7cc576" .. getPlayerName(player):gsub("_"," ") .. " #ffffffTem em seu bolso #7cc576R$" .. getElementData(player, "char:money") .. " #FFFFFFem dinheiro", 255, 255, 255, true)
								triggerServerEvent("vPhone", localPlayer, localPlayer, player)
						         return
						     end
  					     end
				     end
				 end
			end
		end
	end
end			
				
			elseif state == "down" and button == "left" and semcelular then 
			elem2 = 0
			for index2, value2 in ipairs (celularSEM_Table) do
			if (index2 > nextPage and elem2 < maxElem) then
				elem2 = elem2 + 1			
				if isInSlot(sx*863,sy*405+elem2*(sy*52), sx*245,sy*40) then 
				if value2[1] == "Enviar dinheiro" then 
				setElementData(localPlayer, "semcelular-dinheiro", true)
				setElementData(localPlayer, "celular-inicio", false)
				changeVisibility("3", true)
				changeVisibility("4", true)
			end
		end
	end
end	
				elseif state == "down" and button == "left" and semcelulardinheiro then 
				elem2 = 0	
				if isInSlot(sx*547, sy*566, sx*242, sy*46) then 			
				setElementData(localPlayer, "celular-animacoes", false)
				setElementData(localPlayer, "celular-dinheiro", false)
				setElementData(localPlayer, "semcelular-dinheiro", false)
				setElementData(localPlayer, "celular-servicos", false)
				setElementData(localPlayer, "celular-inicio", false)
				setElementData(localPlayer, "celular-objetos", false)
				changeVisibility("3", false)
				changeVisibility("4", false)
				elseif isInSlot(sx*547, sy*500, sx*242, sy*46) then 
				if getText("3") then
                --if tonumber(getText("3")) < getElementData(localPlayer, "char:money") or tonumber(getText("3")) == getElementData(localPlayer, "char:money") then
				local item = tonumber(getText("3"))
				local targerplayer = tonumber(getText("4")) 
                --triggerServerEvent("EnviarMoney", localPlayer, targerplayer, item)
				triggerServerEvent("MoneyTransfer",localPlayer, targerplayer, item);
				--else
				--outputChatBox("#dc143c[BGOMTA - Banco]: #ffffffVocê não tem dinheiro", 25, 152, 139, true)
                --end
			end
		end	
			elseif state == "down" and button == "left" and servicos then 
			elem = 0
			for index, value in ipairs (celularServicos_Table) do
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then 
				if value[1] == "Voltar" then 
				setElementData(localPlayer, "celular-animacoes", false)
				setElementData(localPlayer, "celular-dinheiro", false)
				setElementData(localPlayer, "celular-servicos", false)
				setElementData(localPlayer, "celular-objetos", false)
				setElementData(localPlayer, "celular-inicio", true)
				elseif value[1] == "Policia" then
				fac = "Policia"
				guiSetVisible(boxEmergencia, true)
                addEventHandler("onClientRender", root, boxMen)	
				boxMenStats = true	
				--guiSetInputEnabled(true)	
                OpenWin()		
				elseif value[1] == "PRF" then
				fac = "PRF"
				guiSetVisible(boxEmergencia, true)
                addEventHandler("onClientRender", root, boxMen)	
				boxMenStats = true	
				--guiSetInputEnabled(true)	
                OpenWin()						
				elseif value[1] == "Taxi" then 
				triggerServerEvent('SendMsgToTeamtaxi', localPlayer)
				elseif value[1] == "BGO - Resgate" then 
				fac = "BGO - Resgate"
				--guiSetInputEnabled(true)
				guiSetVisible(boxEmergencia, true)
				addEventHandler("onClientRender", root, boxMen)
				boxMenStats = true
				OpenWin()
				elseif value[1] == "Mecânico" then 
				triggerServerEvent('SendMsgToTeamMecanico', localPlayer)			
				elseif value[1] == "DRVV - Detran" then
				triggerServerEvent('SendMsgToTeamDetran', localPlayer)		
				elseif value[1] == "Chamar Staff" then 
				triggerServerEvent('SendMsgToTeamstaff', localPlayer)		
			end	
		end
	end
end

			elseif state == "down" and button == "left" and player then 
			elem = 0
			for index, value in ipairs (celularPlayer_Table) do
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then 
				if value[1] == "Voltar" then
				setElementData(localPlayer, "celular-player", false)				
				setElementData(localPlayer, "celular-animacoes", false)
				setElementData(localPlayer, "celular-objetos", false)
				setElementData(localPlayer, "celular-dinheiro", false)
				setElementData(localPlayer, "celular-servicos", false)
				setElementData(localPlayer, "celular-inicio", true)
			end	
		end
	end
end


				elseif state == "down" and button == "left" and objetos then 
				elem = 0
				for index, value in ipairs (celularobjetos_Table) do
				if (index > nextPageobjetos and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then 
					if value[1] == "Voltar" then 
						setElementData(localPlayer, "celular-animacoes", false)
						setElementData(localPlayer, "celular-dinheiro", false)
						setElementData(localPlayer, "celular-servicos", false)
						setElementData(localPlayer, "celular-objetos", false)
						setElementData(localPlayer, "celular-inicio", true)	

					elseif value[1] == "Caixa de som na mão" then 
				triggerServerEvent("objetomaosom", localPlayer, localPlayer, value[1])
				elseif value[1] == "Caixa na mão" then 
				triggerServerEvent("objetomaocaixa", localPlayer, localPlayer, value[1])
				elseif value[1] == "Flor na mão" then 
				triggerServerEvent("objetomaoflor", localPlayer, localPlayer, value[1])
				elseif value[1] == "Guarda chuva na mão" then 
				triggerServerEvent("objetgchuva", localPlayer, localPlayer, value[1])
				


			end
		end
	end
end	




				elseif state == "down" and button == "left" and animacoes then 
				elem = 0
				for index, value in ipairs (celularanimacoes_Table) do
				if (index > nextPageanimacoes and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*863,sy*205+elem*(sy*52), sx*245,sy*40) then 				
				if value[1] == "Apontar" then 
				triggerServerEvent("animarcelular", localPlayer, value[1])
				elseif value[1] == "Parar" then 
				triggerServerEvent("animarcelular", localPlayer, "stopanim")
				elseif value[1] == "Chorar" then 
				triggerServerEvent("animarcelular", localPlayer, "cry")
				elseif value[1] == "Aguardando" then 
				triggerServerEvent("animarcelular", localPlayer, "rap")				
				elseif value[1] == "Mirar" then 
				triggerServerEvent("animarcelular", localPlayer, "aim")	
				elseif value[1] == "Fumar" then 
				triggerServerEvent("animarcelular", localPlayer, "smoke")					
				elseif value[1] == "Fumando encostado" then 
				triggerServerEvent("animarcelular", localPlayer, "smokelean")		
				elseif value[1] == "Iniciar corrida" then 
				triggerServerEvent("animarcelular", localPlayer, "startrace")
				elseif value[1] == "Qual Foi?" then 
				triggerServerEvent("animarcelular", localPlayer, "what")
				elseif value[1] == "Medo" then 
				triggerServerEvent("animarcelular", localPlayer, "cover")
				elseif value[1] == "Pensando" then 
				triggerServerEvent("animarcelular", localPlayer, "think")				
				elseif value[1] == "Braços cruzados" then 
				triggerServerEvent("animarcelular", localPlayer, "wait")
				elseif value[1] == "Render-se" then 
				triggerServerEvent("animarcelular", localPlayer, "handsup")
				elseif value[1] == "Dedo do meio" then 
				triggerServerEvent("animarcelular", localPlayer, "fu")
				end
			end
		end
	end	
				elseif state == "down" and button == "left" and dinheiro then 
				elem = 0
				for index, value in ipairs (celulardinheiro_Table) do
				if (index > nextPage and elem < maxElem) then
				elem = elem + 1		
				if isInSlot(sx*547, sy*566, sx*242, sy*46) then 			
				setElementData(localPlayer, "celular-animacoes", false)
				setElementData(localPlayer, "celular-objetos", false)
				setElementData(localPlayer, "celular-dinheiro", false)
				setElementData(localPlayer, "celular-servicos", false)
				setElementData(localPlayer, "celular-inicio", true)
				changeVisibility("1", false)
				changeVisibility("2", false)
				elseif isInSlot(sx*547, sy*500, sx*242, sy*46) then 
				if getText("1") then
                --if tonumber(getText("1")) < getElementData(localPlayer, "char:money") or tonumber(getText("1")) == getElementData(localPlayer, "char:money") then
				local item = tonumber(getText("1"))
				local targerplayer = tonumber(getText("2")) 
                --triggerServerEvent("EnviarMoney", localPlayer, item, targerplayer)
				triggerServerEvent("MoneyTransfer",localPlayer, targerplayer, item);
				--else
				--outputChatBox("#dc143c[BGOMTA - Banco]: #ffffffVocê não tem dinheiro", 25, 152, 139, true)
						--end
					end
				end
			end
		end		
	end
end


function isInSlot( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end


addEventHandler("onClientKey", root, 
	function (button, press)
		if boxMenStats == true then
			if button == "F1" or button == "F2" or button == "u" or button == "y" or button == "t" or button == "F3" or button == "F4" or button == "F5" or button == "F6" or button == "F7" or button == "F9" or button == "F10" or button == "F11" or button == "F12" or button == "t" or button == "i" or button == "b" then
				cancelEvent()
			end
		end
	end
)

    boxEmergencia = guiCreateEdit(sx*509, sy*439, sx*375, sy*77, "", false)      
	guiSetInputEnabled(false)
function boxMen ()
        dxDrawRectangle(sx*504, sy*393, sx*385, sy*146, tocolor(19, 19, 19, 209), false)
        dxDrawRectangle(sx*504, sy*393, sx*385, sy*23, tocolor(6, 6, 6, 209), false)
        dxDrawText("COPOM ("..fac..")", sx*504, sy*393, sx*889, sy*416, tocolor(254, 254, 254, 143), sx*0.80, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("PRESSIONE 'ENTER' PARA EFETUAR A OCORRENCIA, 'X' PARA FECHAR", sx*504, sy*516, sx*889, sy*539, tocolor(254, 254, 254, 143), sx*0.80, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("ADICIONE UMA DESCRIÇÃO ABAIXO:", sx*504, sy*416, sx*889, sy*439, tocolor(254, 254, 254, 143), sx*0.80, "default-bold", "center", "center", false, false, false, false, false)
end


--boxMenStats = false

--boxEmergencia = guiCreateEdit(sx*306, sy*432, sx*550, sy*250, "", false)    
guiSetVisible(boxEmergencia, false) 
--[[
function boxMen ()
        dxDrawRectangle(sx*300, sy*352, sx*561, sy*303, tocolor(38, 38, 38, 170), false)
        dxDrawText("ADICIONE UMA DESCRIÇÂO ABAIXO PARA CHAMAR a", sx*299, sy*394, sx*1158, sy*417, tocolor(254, 254, 254, 119), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("PRESSIONE 'ENTER' PARA EFETUAR ESTA CHAMADA", sx*299, sy*672, sx*1158, sy*695, tocolor(254, 254, 254, 119), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end
--]]

bindKey("enter", "down",
function(button, state, x, y, elementx, elementy, elementz, element)
	--if state == "down" and boxMenStats then  
		if boxMenStats then
             getMen = guiGetText (boxEmergencia)
             if (getMen == "") then
			     outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione um descrição para chamada.", 255,255,255, true)
			     return
			 end 
		         if (fac == "Policia") then
				     triggerServerEvent('SendMsgToTeamPolicia', localPlayer, getMen)
                     fac = nil	
                     boxMenStats = false	
                     removeEventHandler("onClientRender", root, boxMen)		
					 guiSetVisible(boxEmergencia, false) 	
					 
					 --guiSetInputEnabled(false)
				    -- return
		        elseif (fac == "PRF") then
				     triggerServerEvent('SendMsgToTeamPRF', localPlayer, getMen)
                     removeEventHandler("onClientRender", root, boxMen)							 
					 fac = nil	
					 boxMenStats = false
					 guiSetVisible(boxEmergencia, false) 
		        elseif (fac == "BGO - Resgate") then
				     triggerServerEvent('SendMsgToTeammedic', localPlayer, getMen)
                     removeEventHandler("onClientRender", root, boxMen)							 
					 fac = nil	
					 boxMenStats = false
					 --guiSetInputEnabled(false)
					 guiSetVisible(boxEmergencia, false) 
				   --  return
				 end
			 end
end)

bindKey("x", "down", 
function(button, state, x, y, elementx, elementy, elementz, element)
		if boxMenStats then  
		--if boxMenStats then
             fac = nil	
             boxMenStats = false	
             removeEventHandler("onClientRender", root, boxMen)	
             guiSetVisible(boxEmergencia, false) 			 
	     return
	 end
end)

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

local open = false
function OpenWin()
	if open == false then
	open = true
	addEventHandler("onClientRender", root, createPanel)
	addEventHandler("onClientKey",root,keyControl)
	addEventHandler("onClientClick", root, teste) 
	inicio = true
	setElementData(localPlayer, "celular-inicio", true)

	triggerServerEvent("abrircelular", localPlayer)
	nextPage = 0
	nextPageanimacoes = 0
	changeVisibility("1", false)
	changeVisibility("2", false)
	changeVisibility("3", false)
	changeVisibility("4", false)		
	else
	--triggerServerEvent("BTCdroid.stopAnimation", resourceRoot) 
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	removeEventHandler("onClientClick", root, teste) 
	inicio = false
	open = false
	setElementData(localPlayer, "celular-player", false)
	setElementData(localPlayer, "celular-servicos", false)
	setElementData(localPlayer, "celular-inicio", false)
	setElementData(localPlayer, "semcelular-dinheiro", false)
	setElementData(localPlayer, "celular-dinheiro", false)
	setElementData(localPlayer, "celular-animacoes", false)
	setElementData(localPlayer, "celular-objetos", false)
	changeVisibility("1", false)
	changeVisibility("2", false)
	changeVisibility("3", false)
	changeVisibility("4", false)
	
	semcelular = false
	inicio = false
	player = false
	dinheiro = false
	servicos = false
	animacoes = false
	semcelulardinheiro = false
			
			
	end 
end
addEvent("Celular", true)
addEventHandler("Celular", root, OpenWin)

--[[

function OpenWin()
	if open == false then
	open = true
	addEventHandler("onClientRender", root, createPanel)
	addEventHandler("onClientKey",root,keyControl)
	inicio = true
	setElementData(localPlayer, "celular", false)
	setElementData(localPlayer, "celular-inicio", true)

	triggerServerEvent("BTCdroid.startAnimation", resourceRoot)
	nextPage = 0
	nextPageanimacoes = 0
	changeVisibility("1", false)
	changeVisibility("2", false)
	changeVisibility("3", false)
	changeVisibility("4", false)		
	else
	triggerServerEvent("BTCdroid.stopAnimation", resourceRoot) 
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	inicio = false
	open = false
	setElementData(localPlayer, "celular-player", false)
	setElementData(localPlayer, "celular-servicos", false)
	setElementData(localPlayer, "celular-inicio", false)
	setElementData(localPlayer, "semcelular-dinheiro", false)
	setElementData(localPlayer, "celular-dinheiro", false)
	setElementData(localPlayer, "celular-animacoes", false)
	changeVisibility("1", false)
	changeVisibility("2", false)
	changeVisibility("3", false)
	changeVisibility("4", false)
	end 
end
addEvent("SemCelular", true)
addEventHandler("SemCelular", root, OpenWin)

]]--
	

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end












local PoliciaMarkers = {}
local Policia = {}
function createPoliciaMarker(player, id, tplayer, x, y, z)
	if isElement(player) then
		
		PoliciaMarkers[id] = createMarker( x , y , z, "checkpoint", 12, 0, 0, 255, 255 )
		Policia[id] = createBlip( x , y , z, 30 )


			local hx,hy,hz = getElementPosition(localPlayer)
			exports.btc_radar:utvonalTervezes(hx,hy,hz, x , y , z)
			
			setElementData(PoliciaMarkers[id], "call:player", tplayer)
			setElementData(PoliciaMarkers[id], "call:id", id)
			setElementData(PoliciaMarkers[id], "call:accepted", player)
	end
end
addEvent("createPoliciaMarker", true)
addEventHandler("createPoliciaMarker", root, createPoliciaMarker)

function emergencyMarker( hitPlayer, matchingDimension )
	if PoliciaMarkers[getElementData(source, "call:id")] and getElementData(source, "call:accepted") == hitPlayer then
		
		local acceptID = getElementData(source, "call:id")
		local tplayer = getElementData(source, "call:player")
		
		if (acceptID) then
			exports.btc_hud:dm("Você chegou no chamado " .. acceptID .. " Faça seu serviço.", 255, 200, 0)
			setElementData(tplayer, "call:policia", nil)
			destroyElement(PoliciaMarkers[acceptID])
			destroyElement(Policia[acceptID])
		end	
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), emergencyMarker )




local MedicoMarkers = {}
local medicoblip = {}
function createMedicoMarker(player, id, tplayer, x, y, z)
	if isElement(player) then
		
		MedicoMarkers[id] = createMarker( x , y , z, "checkpoint", 12, 0, 0, 255, 255 )
		medicoblip[id] = createBlip( x , y , z, 21 )


			local hx,hy,hz = getElementPosition(localPlayer)
			exports.btc_radar:utvonalTervezes(hx,hy,hz, x , y , z)
			
			setElementData(MedicoMarkers[id], "call:player", tplayer)
			setElementData(MedicoMarkers[id], "call:id", id)
			setElementData(MedicoMarkers[id], "call:accepted", player)
	end
end
addEvent("createMedicoMarker", true)
addEventHandler("createMedicoMarker", root, createMedicoMarker)

function medicomarker( hitPlayer, matchingDimension )
	if MedicoMarkers[getElementData(source, "call:id")] and getElementData(source, "call:accepted") == hitPlayer then
		
		local acceptID = getElementData(source, "call:id")
		local tplayer = getElementData(source, "call:player")
		
		if (acceptID) then
			exports.btc_hud:dm("Você chegou no chamado " .. acceptID .. " Faça seu serviço.", 255, 200, 0)
			setElementData(tplayer, "call:medico", nil)
			destroyElement(MedicoMarkers[acceptID])
			destroyElement(medicoblip[acceptID])
		end	
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), medicomarker )




local mecanicoMarkers = {}
local mecanicoblip = {}
function createmecanicoMarker(player, id, tplayer, x, y, z)
	if isElement(player) then
		
		mecanicoMarkers[id] = createMarker( x , y , z, "checkpoint", 12, 0, 0, 255, 255 )
		mecanicoblip[id] = createBlip( x , y , z, 27 )


			local hx,hy,hz = getElementPosition(localPlayer)
			exports.btc_radar:utvonalTervezes(hx,hy,hz, x , y , z)
			
			setElementData(mecanicoMarkers[id], "call:player", tplayer)
			setElementData(mecanicoMarkers[id], "call:id", id)
			setElementData(mecanicoMarkers[id], "call:accepted", player)
	end
end
addEvent("createMecanicoMarker", true)
addEventHandler("createMecanicoMarker", root, createmecanicoMarker)

function mecanicomarker( hitPlayer, matchingDimension )
	if mecanicoMarkers[getElementData(source, "call:id")] and getElementData(source, "call:accepted") == hitPlayer then
		
		local acceptID = getElementData(source, "call:id")
		local tplayer = getElementData(source, "call:player")
		
		if (acceptID) then
			exports.btc_hud:dm("Você chegou no chamado " .. acceptID .. " Faça seu serviço.", 255, 200, 0)
			setElementData(hitPlayer, "call:mecanico", false)

			setElementData(hitPlayer, "emcall:mecanico", false)
			setElementData(tplayer, "emcall:mecanico", false)

			setElementData(tplayer, "call:mecanico", false)
			destroyElement(mecanicoMarkers[acceptID])
			destroyElement(mecanicoblip[acceptID])
		end	
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), mecanicomarker )







local taxiMarkers = {}
local taxiblip = {}
function createtaxiMarker(player, id, tplayer, x, y, z)
	if isElement(player) then
		
		taxiMarkers[id] = createMarker( x , y , z, "checkpoint", 12, 0, 0, 255, 255 )
		taxiblip[id] = createBlip( x , y , z, 11 )


			local hx,hy,hz = getElementPosition(localPlayer)
			exports.btc_radar:utvonalTervezes(hx,hy,hz, x , y , z)
			
			setElementData(taxiMarkers[id], "call:player", tplayer)
			setElementData(taxiMarkers[id], "call:id", id)
			setElementData(taxiMarkers[id], "call:accepted", player)
	end
end
addEvent("createtaxiMarker", true)
addEventHandler("createtaxiMarker", root, createtaxiMarker)

function taximarker( hitPlayer, matchingDimension )
	if taxiMarkers[getElementData(source, "call:id")] and getElementData(source, "call:accepted") == hitPlayer then
		
		local acceptID = getElementData(source, "call:id")
		local tplayer = getElementData(source, "call:player")
		
		if (acceptID) then
			exports.btc_hud:dm("Você chegou no chamado " .. acceptID .. " Faça seu serviço.", 255, 200, 0)
			setElementData(tplayer, "call:taxi", nil)
			destroyElement(taxiMarkers[acceptID])
			destroyElement(taxiblip[acceptID])
		end	
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), taximarker )




local detranMarkers = {}
local detranblip = {}
function createdetranMarker(player, id, tplayer, x, y, z)
	if isElement(player) then
		
		detranMarkers[id] = createMarker( x , y , z, "checkpoint", 12, 0, 0, 255, 255 )
		detranblip[id] = createBlip( x , y , z, 11 )


			local hx,hy,hz = getElementPosition(localPlayer)
			exports.btc_radar:utvonalTervezes(hx,hy,hz, x , y , z)
			
			setElementData(detranMarkers[id], "call:player", tplayer)
			setElementData(detranMarkers[id], "call:id", id)
			setElementData(detranMarkers[id], "call:accepted", player)
	end
end
addEvent("createdetranMarker", true)
addEventHandler("createdetranMarker", root, createdetranMarker)

function detranmarker( hitPlayer, matchingDimension )
	if detranMarkers[getElementData(source, "call:id")] and getElementData(source, "call:accepted") == hitPlayer then
		
		local acceptID = getElementData(source, "call:id")
		local tplayer = getElementData(source, "call:player")
		
		if (acceptID) then
			exports.btc_hud:dm("Você chegou no chamado " .. acceptID .. " Faça seu serviço.", 255, 200, 0)
			setElementData(tplayer, "call:detran", nil)
			destroyElement(detranMarkers[acceptID])
			destroyElement(detranblip[acceptID])
		end	
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), detranmarker )
















local Font_1 = "default-bold-small" --dxCreateFont("files/font.ttf", 8)
--local Font_2 = dxCreateFont("files/font.ttf", 5)
--local Font_3 = dxCreateFont("files/font.ttf", 7)
--local Font_4 = dxCreateFont("files/font.ttf", 8)
--local Font_5 = dxCreateFont("files/font.ttf", 7)


----------------------------------------------------------------------------------------------------------------------------------------------

-- //#Mensages

mensages = {}
messagetick = 0

function servermessagesCelular(message, type)
	local screenH, screenW = guiGetScreenSize()
	local x, y = (screenH/1366), (screenW/768)
	if not fontScale then fontScale = screenW/40 end
	table.insert(mensages, {message, type or "confirm", getTickCount(), dxGetTextWidth(message, fontScale*0.06, Font_1) + screenH*0.01, 0, 0, 0})
	messagetick = getTickCount()
end
addEvent("servermessagesCelular", true)
addEventHandler("servermessagesCelular", getRootElement(), servermessagesCelular)

function renderMensages()
	local screenH, screenW = guiGetScreenSize()
	local x, y = (screenH/1366), (screenW/768)
	local msgd = mensages
	if #msgd ~= 0 then
		local startY = screenW*0.5
		local i = 1
		repeat
			mData = msgd[i]
			local drawThis = true
			if i~= 1 then
				startY = startY + screenW*0.0425
			end
			if mData[5] == 0 and mData[6] == 0 then
				mData[5] = - mData[4] - screenH*0.015
				mData[6] = startY
				mData[7] = startY
			end
			local tick = getTickCount() - mData[3]
			local posX, posY, alpha
			if tick < 1000 then
				local progress = math.min(tick/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, 0, 0, 0, progress, "Linear")
			elseif tick >= 1000  and tick <= 7000 then
				mData[5] = 0
			elseif tick > 7000 then
				local progress = math.min((tick - 7000)/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, - mData[4] - mData[4] - screenH*0.015, 0, 0, progress, "Linear")
				if progress >= 1 then
					table.remove(msgd, i)
					drawThis = false
					messagetick = getTickCount()
				end
			end
			local globalTick = getTickCount() - messagetick
			if drawThis then
				mData[7] = startY
				mData[6] = interpolateBetween(mData[6], 0, 0, mData[7], 0, 0, math.min(globalTick/1000,1), "Linear")
				posX = mData[5]
				posY = mData[6]
				alpha = 255
				dxDrawRectangle(posX, posY, mData[4], screenW*0.04, tocolor(0, 0, 0, alpha*0.75), true)
				local r, g, b = 0, 255, 0
				if mData[2] == "warning" then
					r, g, b = 255, 0, 0
				end
				dxDrawRectangle(posX + mData[4], posY, screenH*0.010, screenW*0.04, tocolor(r, g, b, alpha*0.85), true)
				dxDrawText(mData[1], posX, posY, posX + mData[4], posY + screenW*0.04, tocolor(255, 255, 255, alpha), fontScale*0.05, Font_1, "center", "center", false, false, true, false, false)
			end
			i = i + 1
		until i > #msgd
		mensages = msgd
	end
end
addEventHandler("onClientRender", getRootElement(), renderMensages)






addEventHandler("onClientResourceStart", resourceRoot, function()
	local txd = engineLoadTXD("files/cellphone.txd")
	engineImportTXD(txd, 330)
	local dff = engineLoadDFF("files/cellphone.dff")
	engineReplaceModel(dff, 330)
end)


























local statusTable = {
	{ 'Todos' },
	{ 'Online' },
	{ 'Offline' },
};

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end


local badWordsTable = {
	{'اشخلك'},
	{'دينك'},
	{'ربك'},
	{'ورع'},
	{'ممحون'},
	{'سالب'},
	{'قحبة'},
	{'قحبه'},
	{'كلب'},
	{'متناك'},
	{'قواد'},
	{'جرار'},
	{'طيز'},
	{'كسختك'},
	{'زبي'},
	{'شرموط'},
	{'عرص'},
	{'كسمك'},
	{'امك'},
	{'ابوك'},
	{'اختك'},
	{'زق'},
	{'نيك'},
	{'منيوك'},
	{'_!_'},
};

GUIEditor = {
    checkbox = {},
    label = {},
    edit = {},
    button = {},
    window = {},
    gridlist = {},
    combobox = {}
};
GUIEditor.window[1] = guiCreateWindow(screenW - 414 - 10, (screenH - 391) / 2, 414, 391, "WhatsApp", false)

centerWindow(GUIEditor.window[1])
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetAlpha(GUIEditor.window[1], 1.00)
guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF139EFE")
guiSetVisible(GUIEditor.window[1], false)
GUIEditor.gridlist[1] = guiCreateGridList(10, 75, 254, 274, false, GUIEditor.window[1])
guiGridListSetSortingEnabled(GUIEditor.gridlist[1], false)
guiGridListAddColumn(GUIEditor.gridlist[1], "Player", 0.7)
guiGridListAddColumn(GUIEditor.gridlist[1], "Status", 0.2)
GUIEditor.button[1] = guiCreateButton(274, 144, 130, 22, "Abrir Chat", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1FC100")
GUIEditor.button[2] = guiCreateButton(274, 176, 129, 22, "Block Jogador", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFD00004")
GUIEditor.button[3] = guiCreateButton(275, 208, 128, 22, "Poke Jogador", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFDE6E00")
GUIEditor.button[4] = guiCreateButton(10, 359, 254, 22, "Ficar Offline", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF139EFE")
GUIEditor.button[5] = guiCreateButton(347, 359, 56, 22, "X", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFF0000")
GUIEditor.edit[1] = guiCreateEdit(10, 42, 254, 23, "", false, GUIEditor.window[1])
GUIEditor.label[1] = guiCreateLabel(10, 22, 254, 15, ".• ´Ferramenta de busca •.", false, GUIEditor.window[1])
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
GUIEditor.combobox[1] = guiCreateComboBox(273, 75, 131, 64, "Selecionar", false, GUIEditor.window[1])
GUIEditor.label[2] = guiCreateLabel(273, 50, 131, 15, ".• Mostrar players : •.", false, GUIEditor.window[1])
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
GUIEditor.checkbox[1] = guiCreateCheckBox(287, 240, 116, 16, "•Não Pertube", false, false, GUIEditor.window[1])
guiSetProperty(GUIEditor.checkbox[1], "NormalTextColour", "FFFE1217")
guiSetEnabled( GUIEditor.button[2], false )

for _, status in ipairs( statusTable ) do
	guiComboBoxAddItem( GUIEditor.combobox[1], status[1] )
end;

addEventHandler( 'onClientGUIChanged', root,
function(  )
	if ( source == GUIEditor.edit[1] ) then
		local plrString = guiGetText( GUIEditor.edit[1] )
			if ( plrString == '' or not plrString ) then
				local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
				if ( Sel == -1 ) then
					guiGridListClear( GUIEditor.gridlist[1] )
					for _, player in ipairs( getElementsByType( 'player' ) ) do
				addPlayer( player ) 
					end return end
			if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
			end
				else
				local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
				if ( Sel == -1 ) then
					guiGridListClear( GUIEditor.gridlist[1] )
					for _, player in ipairs( getElementsByType( 'player' ) ) do
					if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				addPlayer( player ) 
				end end return end
			if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
			addPlayer( player )
			end
		end
		end
	end
end
end );

function BuildChatting( player )
chat_Windows[player] = {  };
chat_Windows[player].window = guiCreateWindow((screenW - 629) / 2, (screenH - 314) / 2, 629, 314, getPlayerName( player ), false)
guiWindowSetSizable(chat_Windows[player].window, false)
guiSetAlpha(chat_Windows[player].window, 1.00)

chat_Windows[player].memo = guiCreateMemo(10, 21, 609, 242, "", false, chat_Windows[player].window)
guiMemoSetReadOnly(chat_Windows[player].memo, true)
chat_Windows[player].editBox = guiCreateEdit(10, 278, 401, 26, "", false, chat_Windows[player].window)
chat_Windows[player].SendButton = guiCreateButton(421, 280, 104, 24, "Enviar Mensagem", false, chat_Windows[player].window)
chat_Windows[player].Xclose = guiCreateButton(582, 278, 37, 26, "X", false, chat_Windows[player].window)
chat_Windows[player].Label = guiCreateLabel(10, 263, 609, 15, "* [N/A] is typing ...", false, chat_Windows[player].window)
guiSetFont(chat_Windows[player].Label, "default-small")
guiLabelSetVerticalAlign(chat_Windows[player].Label, "center")
guiSetVisible(chat_Windows[player].Label, false)
chat_Windows[player].Emoji = guiCreateButton(535, 278, 37, 26, "^ᴥ^", false, chat_Windows[player].window)
guiSetProperty(chat_Windows[player].Emoji, "NormalTextColour", "FF4080FF")
guiSetProperty(chat_Windows[player].Xclose, "NormalTextColour", "FFFE0000")
guiSetProperty(chat_Windows[player].SendButton, "NormalTextColour", "FF1FC100")

	if ( guiGetVisible( GUIEditor.window[1] ) == true ) then
		guiSetVisible( chat_Windows[player].window, true )
	else
		guiSetVisible( chat_Windows[player].window, false )
	end
end;

function clickTimer( element, timer )
	guiSetEnabled( element, false )
		setTimer( guiSetEnabled, timer * 1000, 1, element, true )
end;

function sendNewMessage( player )
	if ( isTimer( sendTimer ) ) then return end
	if ( chat_Windows[player] and isElement( chat_Windows[player].window ) ) then
		local message = guiGetText( chat_Windows[player].editBox )
			for _, badWord in ipairs( badWordsTable ) do
				if ( string.find( message, badWord[1] ) ) then
					guiSetProperty( chat_Windows[player].editBox, 'NormalTextColour', 'FFFF0000' )
						guiSetText( chat_Windows[player].editBox, 'السب والشتم سيعرضك للمخالفات !' )
							guiSetEnabled( chat_Windows[player].editBox, false )
								guiEditSetReadOnly( chat_Windows[player].editBox, true )
									setTimer( function(  )
										guiSetText( chat_Windows[player].editBox, '' )
											guiSetEnabled( chat_Windows[player].editBox, true )
										guiEditSetReadOnly( chat_Windows[player].editBox, false )
									guiSetProperty( chat_Windows[player].editBox, 'NormalTextColour', 'FF000000' )
								end, 3000, 1 )
							sendTimer = setTimer( function(  )
						killTimer( sendTimer )
					end, 2500, 1 )
						return
					end 
				end
			if ( string.len( message ) > 0 ) then
				local oldMessages = guiGetText( chat_Windows[player].memo )
					local newString = oldMessages..getPlayerName( Cplayer ):gsub( '#%x%x%x%x%x%x', '' )..' : '..message..'\n'
				guiSetText( chat_Windows[player].memo, newString )
			guiSetText( chat_Windows[player].editBox, '' )
				guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
			triggerServerEvent( 'onServerSendMessage', Cplayer, player, message )
		sendTimer = setTimer( function(  )
			killTimer( sendTimer )
			end, 2500, 1 )
		end
	end
end;

function destroyChattingWindow( player )
	if ( chat_Windows[player] and isElement( chat_Windows[player].window ) ) then
		destroyElement( chat_Windows[player].window )
		chat_Windows[player] = nil
	end
end;

function removePlayer( player )
	local name = getPlayerName( player )
		for i = 0, guiGridListGetRowCount( GUIEditor.gridlist[1] ) do
			if ( guiGridListGetItemText( GUIEditor.gridlist[1], i, 1 ) == name ) then
		guiGridListRemoveRow( GUIEditor.gridlist[1], i )
	end
end
end;

function privateChatClicks(  )
if ( getElementType( source ) ~= 'gui-button' ) then return end
	local parent = getElementParent( source )
		if ( parent == false or not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( player == false or not player ) then return end
	if ( source == chat_Windows[player].SendButton ) then
		sendNewMessage( player )
	elseif ( source == chat_Windows[player].Xclose ) then
		destroyChattingWindow( player )
	elseif ( source == chat_Windows[player].Emoji ) then
		if ( isTimer( emojiTimer ) ) then return end
		local oldMessages = guiGetText( chat_Windows[player].memo )
			local newString = oldMessages..getPlayerName( Cplayer ):gsub( '#%x%x%x%x%x%x', '' )..' : '..'^ᴥ^'..'\n'
				guiSetText( chat_Windows[player].memo, newString )
			guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
		triggerServerEvent( 'onServerSendMessage', Cplayer, player, '^ᴥ^' )
			guiSetEnabled( chat_Windows[player].Emoji, false )
				emojiTimer = setTimer( function(  )
					if ( chat_Windows[player] and isElement( chat_Windows[player].Emoji ) ) then
				guiSetEnabled( chat_Windows[player].Emoji, true )
					end
			killTimer( emojiTimer )
		end, 2500, 1 )
	end
end;
addEventHandler( 'onClientGUIClick', root, privateChatClicks );

addEventHandler( 'onClientGUIClick', root,
function(  )
	if ( source == GUIEditor.button[1] ) then
		clickTimer( GUIEditor.button[1], 3 )
			local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
				if ( Sel == -1 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Por Favor selecione o player com quem deseja iniciar chat !', 255, 255, 255, true ) return end
				local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
					if ( player == Cplayer ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Você Não pode iniciar chat com você Mesmo !', 255, 255, 255, true ) return end
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		triggerServerEvent( 'onServerCheckIfBlocked', Cplayer, serial )
	elseif ( source == GUIEditor.button[4] ) then
		clickTimer( GUIEditor.button[4], 5 )
		if ( guiGetText( GUIEditor.button[4] ) == 'Ficar Offline' ) then
			guiSetEnabled( GUIEditor.button[1], false )
				guiSetEnabled( GUIEditor.button[3], false )
				guiSetEnabled( GUIEditor.button[2], false )
				guiSetEnabled( GUIEditor.gridlist[1], false )
				guiSetEnabled( GUIEditor.combobox[1], false )
				guiSetEnabled( GUIEditor.edit[1], false )
				guiSetEnabled( GUIEditor.checkbox[1], false )
				guiSetText( GUIEditor.button[4], 'Ficar Online' )
			setElementData( Cplayer, 'chatStatus', 'Offline' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Offline' )
			for cNumber, _ in pairs( chat_Windows ) do
				if ( chat_Windows[cNumber] and isElement( chat_Windows[cNumber].window ) ) then
					destroyElement( chat_Windows[cNumber].window )
					chat_Windows[cNumber] = nil
				end
			end
				else
			guiSetEnabled( GUIEditor.button[1], true )
				guiSetEnabled( GUIEditor.button[3], true )
				guiSetEnabled( GUIEditor.gridlist[1], true )
				guiSetEnabled( GUIEditor.combobox[1], true )
				guiSetEnabled( GUIEditor.edit[1], true )
				guiSetEnabled( GUIEditor.checkbox[1], true )
				guiSetText( GUIEditor.button[4], 'Ficar Offline' )
			setElementData( Cplayer, 'chatStatus', 'Online' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		end
	elseif ( source == GUIEditor.button[5] ) then
		guiSetVisible( GUIEditor.window[1], false )
			showCursor( false )
		guiSetInputEnabled( false )
		for cNumber, _ in pairs( chat_Windows ) do
		guiSetVisible( chat_Windows[cNumber].window, false )
		end
	elseif ( source == GUIEditor.gridlist[1] ) then
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then
				guiSetEnabled( GUIEditor.button[2], false )
				guiSetText( GUIEditor.button[2], 'Block Player' )
			else
				guiSetEnabled( GUIEditor.button[2], true )
					local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
				local serial = getElementData( player, 'chatSystem;playerSerial' )
					if ( serial and string.len( serial ) == 32 ) then
				triggerServerEvent( 'onServerCheckBlockStatus', Cplayer, serial )
			end
		end
	elseif ( source == GUIEditor.button[2] ) then
		clickTimer( GUIEditor.button[2], 3 )
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		if ( guiGetText( GUIEditor.button[2] ) == 'Block Player' ) then
			triggerServerEvent( 'onServerBlockPlayer', Cplayer, serial, player )
		else
			triggerServerEvent( 'onServerUnblockPlayer', Cplayer, serial )
		end
	elseif ( source == GUIEditor.button[3] ) then
		clickTimer( GUIEditor.button[3], 10 )
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Por favor selecione o player que deseja dar poke', 255, 255, 255, true ) return end
				local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		triggerServerEvent( 'onServerSendPoke', Cplayer, player, serial )
	elseif ( source == GUIEditor.combobox[1] ) then
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				addPlayer( player )
			end
		end
	elseif ( source == GUIEditor.checkbox[1] ) then
		if ( guiCheckBoxGetSelected( GUIEditor.checkbox[1] ) == true ) then
			setElementData( Cplayer, 'donotDisturb', 'Enabled' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		else
			setElementData( Cplayer, 'donotDisturb', nil )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		end
	end
end );

local txtValue = 0

function showWriteMessage( player, name )
	if ( isTimer( writeTimer ) ) then return end
     		--guiSetText( chat_Windows[player].Label, '* ['..name..'] is typing')
			--guiSetVisible( chat_Windows[player].Label, true )
			--guiSetText( chat_Windows[player].Label, '* ['..name..'] está digitando...' )
									--[[
				writeTimer = setTimer( function(  )
					if ( txtValue >= 3 ) then
						guiSetText( chat_Windows[player].Label, '* ['..name..'] está digitando...' )
					txtValue = 0
				end
			guiSetText( chat_Windows[player].Label, guiGetText( chat_Windows[player].Label )..'.' )
		txtValue = txtValue + 1
	end, 500, 0 )
	]]--
end;
addEvent( 'onClientShowWrite', true ); addEventHandler( 'onClientShowWrite', root, showWriteMessage )


function hideWriteMessage( player )
	if ( isTimer( writeTimer ) ) then killTimer( writeTimer ) end
	--guiSetText( chat_Windows[player].Label, '* [N/A] is typing ...')
	--guiSetVisible( chat_Windows[player].Label, false )
end;
addEvent( 'onClientHideWrite', true ); addEventHandler( 'onClientHideWrite', root, hideWriteMessage )

--[[
addEventHandler( 'onClientGUIChanged', root,
function(  )
	local parent = getElementParent( source )
		if ( not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( not player ) then return end
			if ( source == chat_Windows[player].editBox ) then
				if ( guiGetText( chat_Windows[player].editBox ) ~= '' ) then
					triggerServerEvent( 'onServerCheckShow', Cplayer, player, getPlayerName( Cplayer ) )
				local messageStringText = guiGetText( chat_Windows[player].editBox )
					checkIfTextChanged( player, messageStringText )
				else
			triggerServerEvent( 'onServerCheckHide', Cplayer, player )
		end
	end
end );
]]--

function checkIfTextChanged( player, text )
	setTimer( function(  )
		if ( guiGetText( chat_Windows[player].editBox ) == text ) then
			triggerServerEvent( 'onServerCheckHide', Cplayer, player )
		end
	end, 1000, 1 )
end;

addEvent( 'onClientPokePlayer', true );
addEventHandler( 'onClientPokePlayer', root,
function( pokedBy )
	if ( getElementData( Cplayer, 'donotDisturb' ) ~= 'Enabled' ) then
		local sound = playSound( 'Wakeup.mp3' )
		setSoundVolume(sound, 0.5)
		outputChatBox( '#FFFF00• Chat Privado :#FFFFFF O Player : [ '..pokedBy..' ] - Chamou sua atenção !', 255, 255, 255, true )
	end
end );

addEvent( 'onClientChangeButton', true );
addEventHandler( 'onClientChangeButton', root,
function( Text )
	guiSetText( GUIEditor.button[2], Text )
end );

function buildChattingWith(  )
	local row, column = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( row == -1 or column == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], row, column ) )
			if ( getElementData( player, 'chatStatus' ) ~= 'Online' ) then
				outputChatBox( '#FF0000• ERROR :#FFFFFF Opa você não pode enviar mensagem para este player ele esta offline !', 255, 255, 255, true ) return end
				if ( not chat_Windows[player] ) then
			BuildChatting( player )
		guiBringToFront( chat_Windows[player].window )
	end
end;
addEvent( 'buildChattingWith', true ); addEventHandler( 'buildChattingWith', root, buildChattingWith )

function privateChatDoubleClicks(  )
	if ( source == GUIEditor.gridlist[1] ) then
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
			if ( player == Cplayer ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Você não pode iniciar chat com você mesmo !', 255, 255, 255, true ) return end
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		triggerServerEvent( 'onServerCheckIfBlocked', Cplayer, serial )
	end
end;
addEventHandler( 'onClientGUIDoubleClick', root, privateChatDoubleClicks );

addEvent( 'onClientReceiveMessage', true );
addEventHandler( 'onClientReceiveMessage', root,
function( player, message )
	if ( not chat_Windows[player] ) then
		BuildChatting( player ) 
	end
		local oldMessages = guiGetText( chat_Windows[player].memo )
			local newString = oldMessages..getPlayerName( player ):gsub( '#%x%x%x%x%x%x', '' )..' : '..message..'\n'
		guiSetText( chat_Windows[player].memo, newString )
	guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
		if ( guiGetVisible( GUIEditor.window[1] ) == false ) then
  			if ( getElementData( Cplayer, 'donotDisturb' ) ~= 'Enabled' ) then
				outputChatBox( '#FFFF00• Chat System :#FFFFFF O jogador : [ '..getPlayerName( player )..' ] - Enviou uma mensagem !', 255, 255, 255, true )
			local sound = playSound( 'Message.mp3' )
			setSoundVolume(sound, 0.5)
		end
	end
end );

function addPlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Online'
		local name = getPlayerName( player )
			local r, g, b = getPlayerNametagColor( player )
				local row = guiGridListAddRow( GUIEditor.gridlist[1] )
					guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
						guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
					guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
				if ( data == 'Online' ) then
				guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 0, 200, 0 )
			else
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 200, 0, 0 )
	end
end;

function addOnlinePlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Online'
		if ( data == 'Online' ) then
			local name = getPlayerName( player )
				local r, g, b = getPlayerNametagColor( player )
					local row = guiGridListAddRow( GUIEditor.gridlist[1] )
					guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
				guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
			guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 0, 200, 0 )
	end
end;

function addOfflinePlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Offline'
		if ( data == 'Offline' ) then
			local name = getPlayerName( player )
		local r, g, b = getPlayerNametagColor( player )
		local row = guiGridListAddRow( GUIEditor.gridlist[1] )
	guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
		guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
			guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 200, 0, 0 )
	end
end;

addEvent( 'onClientUpdateStatus', true );
addEventHandler( 'onClientUpdateStatus', root,
function( player, status )
	if ( status == 'Online' ) then
		removePlayer( player )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
	else
		destroyChattingWindow( player )
			removePlayer( player )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
	end
end );

addEvent( 'onClientDestroyChats', true );
addEventHandler( 'onClientDestroyChats', root,
function( player )
	destroyChattingWindow( player )
end );

function player_Join( player )
	if ( player ~= Cplayer ) then
	local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
end
end;
addEvent( 'onClientAddPlayer', true ); addEventHandler( 'onClientAddPlayer', root, player_Join )

function player_Quit( player )
	removePlayer( player )
	destroyChattingWindow( player )
end;
addEvent( 'onClientRemovePlayer', true ); addEventHandler( 'onClientRemovePlayer', root, player_Quit )

function player_ChangedName( player, name )
	for i = 0, guiGridListGetRowCount( GUIEditor.gridlist[1] ) do
		if ( guiGridListGetItemText( GUIEditor.gridlist[1], i, 1 ) == name ) then
			guiGridListRemoveRow( GUIEditor.gridlist[1], i )
		end
	end
		destroyChattingWindow( player )
	setTimer( function(  )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
end, 1500, 1 )
end;
addEvent( 'onClientRemovePlayer_ChangedName', true ); addEventHandler( 'onClientRemovePlayer_ChangedName', root, player_ChangedName )

function sendMessage( eleEdit )
	local parent = getElementParent( source )
		if ( parent == false or not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( player == false or not player ) then return end
	if ( eleEdit == chat_Windows[player].editBox ) then
		sendNewMessage( player )
	end
end;

addEventHandler( 'onClientGUIAccepted', root, sendMessage );

addEventHandler( 'onClientResourceStart', resourceRoot,
function(  )
	triggerServerEvent( 'onServerSetPlayerSerial', Cplayer )
		setTimer( function(  )
	for _, player in ipairs( getElementsByType( 'player' ) ) do
		addPlayer( player )
	end
end, 1000, 1 )
end );



   

addEventHandler("onClientGUIClick",root,
function ()
if( source == sms ) then
	guiSetVisible( GUIEditor.window[1], not guiGetVisible( GUIEditor.window[1] ) )
		--showCursor( guiGetVisible( GUIEditor.window[1] ) )
		guiSetInputEnabled( guiGetVisible( GUIEditor.window[1] ) )
   	for cNumber, _ in pairs( chat_Windows ) do
		guiSetVisible( chat_Windows[cNumber].window, guiGetVisible( GUIEditor.window[1] ) )
	end
	end
end );



