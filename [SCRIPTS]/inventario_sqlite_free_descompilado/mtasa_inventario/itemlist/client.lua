-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local opensans = dxCreateFont("files/font.ttf", 12)
local listShow = false
local listWheel = 0
local lastClick = 0

addEventHandler("onClientRender",getRootElement(),function()
	if listShow then
		local s = {guiGetScreenSize()}
		local listBox = {330,490}
		local listPos = {s[1]/2 -listBox[1]/2,s[2]/2 - listBox[2]/2}
		dxDrawRectangle(listPos[1],listPos[2],listBox[1],listBox[2],tocolor(0,0,0,140))
		dxDrawRectangle(listPos[1],listPos[2],listBox[1],30,tocolor(0,0,0,70))
		dxDrawText("ID",listPos[1]+58,listPos[2]+3,0,0,tocolor(255,255,255,255),1,opensans,"left","top",true,true,true,true)
		dxDrawText("Nome",listPos[1]+90,listPos[2]+3,0,0,tocolor(255,255,255,255),1,opensans,"left","top",true,true,true,true)
		local count = 0
		for k,v in ipairs(items) do
			if k > listWheel and count < 10 then
				count = count+1
				dxDrawImage(listPos[1]+10,listPos[2]-5+(count*45),36,36,getItemImg(tonumber(k)))
				if isInBox(listPos[1]+10,listPos[2]-5+(count*45),36,36) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						triggerServerEvent("giveItem",localPlayer,localPlayer,tonumber(k),1,1,0)
					end
				end
				dxDrawText(tonumber(k),listPos[1]+62,listPos[2]+4+(count*45),0,0,tocolor(255,255,255,255),1,opensans,"left","top",true,true,true,true)
				dxDrawText(v.name,listPos[1]+95,listPos[2]+4+(count*45),0,0,tocolor(255,255,255,255),1,opensans,"left","top",true,true,true,true)
			end
		end
	end
end)

addEvent("itemlist:command",true)
addEventHandler("itemlist:command",getRootElement(),function()
	listShow = not listShow
end)

bindKey("mouse_wheel_up", "down",function()
	if listShow then
		listWheel = listWheel - 1
		if listWheel < 1 then
			listWheel = 0
		end
	end
end)

bindKey("mouse_wheel_down", "down",function()
	if listShow == true then
		listWheel = listWheel + 1
		if listWheel > #items - 10 then
			listWheel = #items - 10
		end
	end
end)

bindKey("backspace","down",function()
	if listShow then
		listShow = false
	end
end)