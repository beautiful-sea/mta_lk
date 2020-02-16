local menu = {}
local sx,sy = guiGetScreenSize()
px,py = 1024,768
x,y =  (sx/px), (sy/py)

local p = {
{0,y*60,x*180,y*30},
{0,y*90,x*180,y*30},
{0,y*120,x*180,y*30},
{0,y*150,x*180,y*30},
{0,y*180,x*180,y*30},
{0,y*210,x*180,y*30},
{0,y*240,x*180,y*30},
{0,y*270,x*180,y*30}
}

function createMenus()
	font = exports.fonts:createFont("sans-pro-regular",18)
	menu["main"] = {}
	menu["main"].logo = exports.dxgui:dxCreateStaticImage(x*27, y*180, x*180, y*40,":"..getResourceName(getThisResource()).."/gfx/background.png")
	exports.dxgui:dxSetVisible(menu["main"].logo,false)
	exports.dxgui:dxSetBorder(menu["main"].logo,false)
	menu["main"].title = exports.dxgui:dxCreateLabel(0,y*6,x*180,x*16,"ELEVADOR",false, menu["main"].logo)
	exports.dxgui:dxSetVisible(menu["main"].title,false)
	exports.dxgui:dxSetScale(menu["main"].title,x*0.8)
	exports.dxgui:dxSetFont(menu["main"].title,font)
	exports.dxgui:dxSetAngle(menu["main"].title,"left")
	menu["main"].label = exports.dxgui:dxCreateButton(0,y*40,x*180,x*16,"HOME",tocolor(0,0,0,210),false, menu["main"].logo)
	exports.dxgui:dxSetVisible(menu["main"].label,false)
	exports.dxgui:dxSetElementType(menu["main"].label,"4")
	exports.dxgui:dxSetScale(menu["main"].label,x*0.5)
	exports.dxgui:dxSetFont(menu["main"].label,font)
	exports.dxgui:dxSetRightText(menu["main"].label,"✖")
	addEventHandler("onClientDxClick",menu["main"].label,setPreviousMenu)
	for k, v in ipairs(menus) do
		menu[v[1]..v[2]] = exports.dxgui:dxCreateButton(p[v[3]][1],p[v[3]][2],p[v[3]][3],p[v[3]][4],v[1],tocolor(0,0,0,200),false, menu["main"].logo)
		exports.dxgui:dxSetElementType(menu[v[1]..v[2]],"5")
		exports.dxgui:dxSetScale(menu[v[1]..v[2]],x*0.5)
		exports.dxgui:dxSetVisible(menu[v[1]..v[2]],false)
		exports.dxgui:dxSetFont(menu[v[1]..v[2]],font)
		if v[4] ~= "list" then
			exports.dxgui:dxSetRightText(menu[v[1]..v[2]],"$"..v[4])
			addEventHandler("onClientDxClick",menu[v[1]..v[2]],function() onItemClick({v[1],v[2],v[4]}) end)
		else
			addEventHandler("onClientDxClick",menu[v[1]..v[2]],setNextMenu)
		end
	end
end

function onResourceStart()
createMenus()
end
addEventHandler("onClientResourceStart",resourceRoot,onResourceStart)

function onPlayerRequestCloseMenu()
	showCursor(false)
	for k, v in ipairs(menus) do
		if isElement(menu[v[1]..v[2]]) then
			exports.dxgui:dxSetVisible(menu[v[1]..v[2]],false)
		end
	end
	exports.dxgui:dxSetVisible(menu["main"].logo,false)
	exports.dxgui:dxSetVisible(menu["main"].label,false)
	exports.dxgui:dxSetVisible(menu["main"].title,false)
end

function setNextMenu()
	local current = exports.dxgui:dxGetText(menu["main"].label)
	local nextM = exports.dxgui:dxGetText(source)
	setMenuVisible(name,false)
	setMenuVisible(nextM,true)
	exports.dxgui:dxSetText(menu["main"].label,nextM)	
	exports.dxgui:dxSetRightText(menu["main"].label,"◄")
end

function setPreviousMenu()
	local name = exports.dxgui:dxGetText(menu["main"].label)
	if name == "HOME" then
		return onPlayerRequestCloseMenu()
	end
	setMenuVisible(name,false)
	for k, v in ipairs(menus) do
		if v[1] == name then
			setMenuVisible(v[2],true)
			exports.dxgui:dxSetText(menu["main"].label,v[2])
			if v[2] == "HOME" then
				exports.dxgui:dxSetRightText(menu["main"].label,"✖")
			end
		end
	end	
end

function showMenu()
	exports.dxgui:dxSetVisible(menu["main"].logo,true)
	exports.dxgui:dxSetVisible(menu["main"].label,true)
	exports.dxgui:dxSetVisible(menu["main"].title,true)
	setMenuVisible("HOME",true)	
	showCursor(true)
end

function setMenuVisible(m,bool)
	for k, v in ipairs(menus) do
		if isElement(menu[v[1]..v[2]]) then
			exports.dxgui:dxSetVisible(menu[v[1]..v[2]],false)
		end
		if v[2] == m and isElement(menu[v[1]..v[2]]) then
			exports.dxgui:dxSetVisible(menu[v[1]..v[2]],bool)
		end		
	end
end