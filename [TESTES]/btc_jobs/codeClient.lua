﻿
local sx,sy = guiGetScreenSize()

local jobPed = {}
local roboto = dxCreateFont("files/Roboto.ttf",14)



local job_PedPos = {
	{110, 1175.0196533203,-1681.6768798828,14.020483970642, "Empregos", 177.83163452148},
	-- {2, 2035.3885498047, -2448.5388183594, 13.611819267273, "PentiX egy köcsög buzi aki kitörölte a városháza mappot...."},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local jobs_Table = { -- Munak neve, Munak leírása, Kép neve, munka ID 
	{"Ifood", "ifood", 155, 0}, 
	{"Lixeiro", "Lixeiro", 308, 0},
	{"Sedex", "Sedex", 177, 2}, 
	{"Motorista", "Motorista", 37, 5}, 
	{"Maquinista", "Maquinista", 61, 8}, 
	{"Entregador de Gás", "Entregador de Gas", 177, 13},
--	{"Bombeiro", "Bombeiro", 260, 15},  
}
local maxElem = 6
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:job", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:job") then
			cancelEvent ()
		end
	end
)

function createPanel()
	local jX, jY, jZ = getElementPosition(getLocalPlayer())
	local bX, bY, bZ = getElementPosition(elements)
	if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createPanel) removeEventHandler("onClientKey",root,keyControl) show = false return end
	dxDrawRectangle(sx/2-200,sy/2-250,400,500,tocolor(0,0,0,240))
	dxDrawText("btc#7cc576MTA v1 #FFFFFF- Empregos",sx/2-195,sy/2-233,sx/2-195,sy/2-233,tocolor(255,255,255,255),1,roboto,"left","center",false,false,false,true)
	--outputChatBox(tostring(getElementData(localPlayer,"job")))  -----------------DEBUG
	local elem = 0
	for index, value in ipairs (jobs_Table) do 
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			local text = ""
			local r, g, b = 124, 197, 118
			if localPlayer:getData("job") ==  value[2] then 
				text = "Demitir"
				r, g, b = 220,20,60
			else
				text = "Trabalhar"
				r, g, b = 124, 197, 118

			end
			
			
		if isInSlot(sx/2+200-60,sy/2-280,60,20) then
			dxDrawRectangle(sx/2+200-60,sy/2-280,60,20,tocolor(205,92,92,255))
		else
			dxDrawRectangle(sx/2+200-60,sy/2-280,60,20,tocolor(205,92,82,100))
		end
		dxDrawText("Fechar",sx/2+149,sy/2-280,sx,sy,tocolor(0,0,0,255),0.7,roboto,"left")
		
		

			dxDrawText(value[1].." - ( #00ff00Level "..jobs_Table[index][4].." #ffffff)", sx/2-190, sy/2.7-100+elem*(60), sx/2, 0, tocolor(255, 255, 255, 255), 0.89, roboto, "left", "top", false, false, false, true)

			if isInSlot(sx/2+70, sy/2.8-95+elem*(60), 120, 40) then
				dxDrawRectangle(sx/2+70, sy/2.8-95+elem*(60), 120, 40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx/2+70, sy/2.8-95+elem*(60), 120, 40, tocolor(r, g, b, 150))
			end
			--dxDrawText(text, sx/2-195, sy/1.7-100+elem*(60), sx/2, 0, tocolor(255, 0, 0, 255), 0.89, roboto, roboto, "left", "top", false, false, false, true)


			dxDrawText(text, sx/2+260, sy/2.7-100+elem*(60), sx/2, 0, tocolor(255, 255, 255, 255), 0.89, roboto, "center", "top", false, false, false, true)
		end
	end
end

local altura = 0
addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:job") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
				startTick = getTickCount()
				progress = "OutBack"
				removeEventHandler("onClientRender", root, createPanel)
				addEventHandler("onClientRender", root, createPanel)
				removeEventHandler("onClientKey",root,keyControl)
				addEventHandler("onClientKey",root,keyControl)
				show = true
				elements = element
			end
		end
	elseif state == "down" and button == "left" and show then 
	if isInSlot(sx/2+200-60,sy/2-280,60,20) then
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	show = false
	elements = nil
	end
	
		elem = 0
		for index, value in ipairs (jobs_Table) do 
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1
				--if isInSlot(sx/2+70, sy/2.8-95+elem*(60), 120, 40) then 
				if dobozbaVan(sx/2+70, sy/2.8-95+elem*(60), 120, 40, x, y) then 
						--exports.btc_infobox:addNotification("teste !","success")
					local level = localPlayer:getData("Sys:Level") 
					if level >= jobs_Table[index][4] then
					if localPlayer:getData("job") == jobs_Table[index][2] then 
					--if jobs_Table[index][2] == localPlayer:getData("job") then 
						--destroyPlayerJob(jobs_Table[index][2])
						--localPlayer:setData("job", "Desempregado") --Reseteli a munkát
						triggerServerEvent("trabalho", localPlayer, "SemEmprego", 0)
						
						exports.btc_infobox:addNotification("Você saiu com sucesso do "..jobs_Table[index][1].."!","success")
					elseif jobs_Table[index][2] ~= localPlayer:getData("job") and localPlayer:getData("job") == "SemEmprego" or localPlayer:getData("job") == "farm" or localPlayer:getData("job") == "0" or localPlayer:getData("job") == "Desempregad" or localPlayer:getData("job") == "Desempregado" then 
						--localPlayer:setData("job", jobs_Table[index][2])
						--startPlayerJob(jobs_Table[index][2])
						--exports.btc_employment:setPlayerJob(localPlayer, jobs_Table[index][2], jobs_Table[index][2], jobs_Table[index][3],true)
						
						triggerServerEvent("trabalho", localPlayer, jobs_Table[index][2],jobs_Table[index][3])

						exports.btc_infobox:addNotification("Você pegou com sucesso o emprego de "..jobs_Table[index][1].." !","success")
					--else
					--	exports.btc_infobox:addNotification("Você já tem um emprego para demitir use /demitir!","error")
					--end
					end
					currentjob = jobs_Table[index][2]
					else
					exports.btc_infobox:addNotification("Você precisa ser level "..jobs_Table[index][4].." para trabalhar!","error")
					end

				end
			end
		end
		end
		--triggerServerEvent("updateJobToServer", localPlayer, currentjob)
end)

function keyControl(k, s)
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif k == "mouse_wheel_down" then
		nextPage = nextPage + 1
		if(nextPage > #jobs_Table-maxElem)then
			nextPage = #jobs_Table-maxElem
		end
	elseif k == "backspace" then
		removeEventHandler("onClientRender", root, createPanel)
		removeEventHandler("onClientKey",root,keyControl)
		show = false
	end
end	

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

--[[
function startPlayerJob(ID)
	if not localPlayer then return end
	--outputChatBox(ID)
	if (tonumber(ID) == 1) then 
		startTransportJob()	
	elseif (tonumber(ID) == 2) then 
		startJob()	
	elseif (tonumber(ID) == 3) then 
		createMarkerToJob()	
	elseif (tonumber(ID) == 6) then 
		createMarkerFunction()
	end
end

function destroyPlayerJob(ID)
	if not localPlayer then return end
	if (tonumber(ID) == 1) then 
		destroyTransportJob()	
	elseif (tonumber(ID) == 2) then 
		destroyJob()	
	end
end

function munkaSpawn()
	local Loggedin = getElementData(localPlayer, "loggedin")

	if (Loggedin) then
		jelenlegiMunka = tonumber(localPlayer:getData("job"))
		if (jelenlegiMunka == 1) then -- Járműszállító
			startTransportJob()
		else
			destroyTransportJob()
		end		
		if (jelenlegiMunka == 2) then -- Pizza
			startJob()
		else
			destroyJob()
		end		
	end
end

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "player" and dataName == "job" then
		if getElementData(source,dataName) == 1 then
			startTransportJob()
		else
			destroyTransportJob()
		end		
		if getElementData(source,dataName) == 2 then
			startJob()
		else
			destroyJob()
		end		
		if getElementData(source,dataName) == 3 then
			createMarkerToJob()
		else
			destroyStorageBox()
		end		
	end
end )


addEventHandler("onClientPlayerSpawn", localPlayer, 
	function()
		setTimer(munkaSpawn, 1000, 1)
	end
)

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( resource )
		if (resource ~= getThisResource()) then return end
        setTimer(munkaSpawn, 1000, 1)
    end
)]]--


addEvent ("hudids",true)
function fechar22()
	exports.btc_hud:drawStat("PizzaID", "", "", 255, 200, 0)
	exports.btc_hud:drawStat("BusDriver", "", "")
	exports.btc_hud:drawProgressBar("BusLoad", "")
	exports.btc_hud:drawStat("MailCarrier", "", "", 255, 200, 0)
	triggerServerEvent("GTImailcarrier.terminateJob", resourceRoot, ig_shift)
	exports.btc_hud:drawStat("TrainDriver", "", "")
	exports.btc_hud:drawProgressBar("TrainLoad", "")
	local x,y,z = getElementPosition(localPlayer)
	--exports.btc_util:markPlayer(x,y,z)
	exports.btc_util:unmark(player)
end

addEventHandler ("hudids", root,  fechar22)
