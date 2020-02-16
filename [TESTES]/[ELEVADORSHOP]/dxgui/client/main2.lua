local dxRootElement = createElement("dxRootElement")
local sx,sy = guiGetScreenSize()
setElementData(dxRootElement,"x",0,false)
setElementData(dxRootElement,"y",0,false)
setElementData(dxRootElement,"width",sx,false)
setElementData(dxRootElement,"height",sy,false)
local movedElementOffset = {0,0}

function dxGridListSetSelectedItem(item)
	for id, element in ipairs (getElementChildren(getElementParent(item))) do
		setElementData(element,"clicked",nil,false)
	end
	return setElementData(item,"clicked",true,false)
end

function dxGridListGetSelectedItem(grid)
	for id, element in ipairs (getElementChildren(grid)) do
		if getElementData(element,"clicked") then 
			return element
		end
	end
	return false
end

function dxGridListGetItemCount(grid)
	if not grid then return false end
	local count = 0
	for id, element in ipairs (getElementChildren(grid)) do
		if getElementType(element) ~= "dxScrollBar" then 
			count = count + 1
		end
	end
	return count
end

function dxGridListSetItemColorCoded(item,bool)
	if not item then return false end
	return setElementData(item,"colored",bool,false)
end

function dxSetVisible(item,bool)
	if (not item) and (not isElement(item)) then return false end
	return setElementData(item,"visible",bool,false)
end

function dxGetVisible(item)
	if not item then return false end
	return getElementData(item,"visible")
end

function dxGridListGetItemText(item)
	return getElementData(item,"text")
end

function dxGridListSetItemText(item,text)
	return setElementData(item,"text",text,false)
end

function dxGridListClear(grid)
	for id, element in ipairs (getElementChlidren(grid)) do
		destroyElement(element)
	end
	return true
end

function dxStaticImageLoadImage(image,path)
	if not image then return false end
	return setElementData(image,"filepath",path,false)
end

function dxScrollBarSetScrollPosition(scroll,position)
	return setElementData(scroll,"scroll",position/100,false)
end

function dxCheckBoxGetSelected(cb)
	if not cb then return false end
	return (getElementData(cb,"check"))
end

function dxCheckBoxSetSelected(cb,state)
	if not cb then return false end
	return setElementData(cb,"check",state,false)
end

function dxEditSetMasked(edit,bool)
	if not edit then return false end
	return setElementData(edit,"masked",bool,false)
end

function dxEditSetReadOnly(edit,bool)
	if not edit then return false end
	return setElementData(edit,"readonly",bool,false)
end

function dxScrollBarGetScrollPosition(scroll)
	return (tonumber(getElementData(scroll,"scroll")*100))
end

function dxCreateWindow (x,y,width,height,titleBarText)
	
	if x and y and width and height and titleBarText then

		local element = createElement("dxWindow")
		setElementParent(element,dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"movable",true,false)
		setElementData(element,"text",titleBarText,false)
		setElementData(element,"font","default",false)
		setElementData(element,"title",tocolor(0,0,0,255),false)
		setElementData(element,"titleBackgroundColor",tocolor(0,0,0,150),false)
		setElementData(element,"backgroundColor",tocolor(255,255,255,255),false)
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing(dxCreateWindow)")
	end
end

function dxWindowSetTitleBackgroundColor(element,red,green,blue,alpha)
	setElementData(element,"titleBackgroundColor",tocolor(red,green,blue,alpha),false)
end

function dxWindowSetBackgroundColor(element,red,green,blue,alpha)
	setElementData(element,"backgroundColor",tocolor(red,green,blue,alpha),false)
end

function dxCreateGridList (x,y,width,height,relative,parent)
	if x and y and height and width then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxGridList")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x)
		setElementData(element,"y",y)
		setElementData(element,"width",width)
		setElementData(element,"height",height)
		setElementData(element,"filepath",filepath)
		setElementData(element,"parent",parent)
		setElementData(element,"scale",0.5)
		setElementData(element,"state","normal")	
		setElementData(element,"visible",true)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateGridList)")	
	end
end

function dxCreateProgressBar (x,y,width,height,relative,parent)
	if x and y and height and width then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxProgressBar")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x)
		setElementData(element,"y",y)
		setElementData(element,"width",width)
		setElementData(element,"height",height)
		setElementData(element,"progress",50)
		setElementData(element,"parent",parent)
		setElementData(element,"state","normal")	
		setElementData(element,"visible",true)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateGridList)")	
	end
end

function dxCreateScrollBar (x,y,width,height,horizontal, relative,parent)
	if x and y and height and width then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxScrollBar")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x)
		setElementData(element,"y",y)
		setElementData(element,"scroll",0)
		setElementData(element,"horizontal",horizontal)
		setElementData(element,"width",width)
		setElementData(element,"height",height)
		setElementData(element,"filepath",filepath)
		setElementData(element,"parent",parent)
		setElementData(element,"state","normal")
		setElementData(element,"visible",true)
		
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxScrollBar)")	
	end
end

function dxGetText(element)
	if not element then return false end
	return getElementData(element,"text")
end

function dxSetText(element,text)
	if not element then return false end
	return setElementData(element,"text",text,false)
end

function dxCreateStaticImage (x,y,width,height,filepath,rotX,rotY,rotZ,color,relative,parent)
	if x and y and height and width and filepath then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxStaticImage")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"filepath",dxCreateTexture(filepath),false)
		setElementData(element,"parent",parent or false,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"rotX", rotX or 0,false)
		setElementData(element,"rotY", rotY or 0,false)
		setElementData(element,"rotZ", rotZ or 0,false)
		setElementData(element,"color", color or tocolor(255,255,255,255),false)
		setElementData(element,"rot", false,false)
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxStaticImage)")	
	end
end

function dxCreateLabel (x,y,width,height,text,relative,parent,colorcoded)
	
	if x and y and height and width and text then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxLabel")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"font","default",false)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"text",text,false)
		setElementData(element,"scale",false,false)
		setElementData(element,"angle","center",false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"colorcoded",colorcoded,false)
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateLabel)")	
	end
end

function dxCreateRectangle(x,y,width,height,color,relative,parent)
	
	if x and y and height and width then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxRectangle")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"color",color,false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"border",true,false)
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateRectangle)")	
	end
end

function dxCreateButton(x,y,width,height,text,color,relative,parent)
	
	if x and y and height and width and text then
		if not parent then
		parent = false
		end
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxButton")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"text",text,false)
		setElementData(element,"color",color,false)
		setElementData(element,"borderColor",tocolor(255,255,255,140),false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"font","sans",false)
		setElementData(element,"type","1",false)
		setElementData(element,"border",true,false)	
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateButton)")	
	end
end

function getColorAlpha(element)
	local color = getElementData(element,"color")
   return bitExtract(color,24,8) -- return bits 24-32
end


function replaceColorAlpha(element, alpha)
	local color = getElementData(element,"color")
  return setElementData(element,"color",tocolor(bitExtract(color,16,8), bitExtract(color,8,8), bitExtract(color,0,8), alpha),false)
end

function dxGetColor(element)
	local color = getElementData(element,"color")
	return bitExtract(color,16,8), bitExtract(color,8,8), bitExtract(color,0,8), bitExtract(color,24,8)
end

function dxSetColor(dxElement, color)
	if not dxElement  then
		outputDebugString("dxSetColor gets wrong parameters (dxElement)")
		return
	end
	return setElementData(dxElement,"color",color,false)
end

function dxSetImageRotation(dxElement, bool)
	if not dxElement  then 
		return
	end
	return setElementData(dxElement,"rot", bool,false)
end

function dxCreateEdit(x,y,width,height,text,relative,parent)
	if x and y and height and width and text then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxEdit")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"text",text,false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"scale",0.5,false)
		setElementData(element,"font","sans",false)
		setElementData(element,"visible",true,false)
		addEventHandler("onClientDxClick",element,moveCursor,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateEdit)")	
	end
end

function dxCreateMemo(x,y,width,height,text,relative,parent)
	if x and y and height and width and text then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxMemo")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"text",text,false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"scale",0.5,false)
		setElementData(element,"font","default",false)
		setElementData(element,"type",1,false)
		addEventHandler("onClientDxClick",element,moveCursor)
		setElementData(element,"visible",true,false)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCreateEdit)")	
	end
end

function dxCreateCheckBox(x,y, width, height, text,selected,relative,parent)
	
	if x and y and text then
		if relative then 
			if parent then
				x = x*getElementData(parent,"x")
				y = y*getElementData(parent,"y")
			else
				x = x
				y = y
			end
		end
		local element = createElement("dxCheckBox")
		setElementParent(element,parent or dxRootElement)
		setElementData(element,"x",x,false)
		setElementData(element,"y",y,false)
		setElementData(element,"width",width,false)
		setElementData(element,"height",height,false)
		setElementData(element,"text",text,false)
		setElementData(element,"check",selected,false)
		setElementData(element,"parent",parent,false)
		setElementData(element,"state","normal",false)
		setElementData(element,"font","default",false)
		setElementData(element,"type",1,false)
		setElementData(element,"visible",true)
		addEventHandler("onClientDxClick",element,function ()
			setElementData(source,"check",not getElementData(source,"check"),false)
		end)
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxCheckBox)")	
	end
end

function outputPressedCharacter(character)
	for id,element in ipairs(getElementsByType("dxEdit")) do
		if isCursorShowing() and not isMTAWindowActive() then
			if getElementData(element,"input") and not getElementData(element,"readonly") then
				if getElementData(element,"maxlength") then		
					if (string.len(getElementData(element,"text"))) < getElementData(element,"maxlength") then
						setElementData(element,"text",getElementData(element,"text")..character,false)
					end
				else
					setElementData(element,"text",getElementData(element,"text")..character,false)
				end
			end
		end
	end
end
addEventHandler("onClientCharacter", getRootElement(), outputPressedCharacter)

function playerPressedKey(button, press)
    if (press) then
		if (button == "backspace") then
			if isCursorShowing() and not isMTAWindowActive() then
				for id,element in ipairs(getElementsByType("dxEdit")) do
					if getElementData(element,"input") and not getElementData(element,"readonly") then
						setElementData(element,"text",string.sub(getElementData(element,"text"),1,string.len(getElementData(element,"text"))-1),false)
					end
				end
			end
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

function moveCursor()
	for id, element in ipairs (getElementsByType("dxEdit")) do
		setElementData(element,"input",nil,false)
	end
	setElementData(source,"input",true,false)
end

function dxWindowSetMovable(window,bool)
	if not window then return false end
	return setElementData(window,"movable",bool,false)
end

function dxSetElementType(element,type)
	if not element then return false end
	return setElementData(element,"type",type,false)
end

function drawingGUI()
	for id, v in ipairs (getElementsByType("dxWindow")) do
		if getElementData(v,"visible") == true then
			if getElementData(v,"movable")  then
				if elementBeingMoved == v then
					if isCursorShowing() then
						local cx,cy = getCursorPosition()
						cx = cx*sx
						cy = cy*sy
						setElementData(v,"x",  cx - movedElementOffset[1],false)
						setElementData(v,"y",  cy - movedElementOffset[2],false)
					end
				end
			end
		dxDrawRectangle(getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"width"), getElementData(v,"height"), tocolor(0,0,0,150), false )
		dxDrawLine(getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"x")+getElementData(v,"width"), getElementData(v,"y"),  tocolor(0,0,0,240), 1, false)
		dxDrawLine(getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"x"), getElementData(v,"y")+getElementData(v,"height"),  tocolor(0,0,0,240), 1, false)
		dxDrawLine(getElementData(v,"x"), getElementData(v,"y")+getElementData(v,"height"), getElementData(v,"x")+getElementData(v,"width"), getElementData(v,"y")+getElementData(v,"height"),  tocolor(0,0,0,240), 1, false)
		dxDrawLine(getElementData(v,"x")+getElementData(v,"width"), getElementData(v,"y"), getElementData(v,"x")+getElementData(v,"width"), getElementData(v,"y")+getElementData(v,"height"),  tocolor(0,0,0,240), 1, false)
		dxDrawImageSection(getElementData(v,"x")+1, getElementData(v,"y")+1, getElementData(v,"width")-1, 30,0,0,800,(600/getElementData(v,"height"))*30,"gfx/window.png",0,0,0,getElementData(v,"titleBackgroundColor"))
		dxDrawText(getElementData(v,"text"),getElementData(v,"x"),getElementData(v,"y"),getElementData(v,"x")+getElementData(v,"width"),getElementData(v,"y")+30,tocolor(255,255,255,255),1.3 * (15/dxGetFontHeight(1,getElementData(v,"font"))),getElementData(v,"font"),"center","center", false, false, false, true)
		end
	end
		for k, v in ipairs(getElementsByType("dxRectangle")) do
		if getElementData(v,"visible") == true then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), getElementData(v,"color"), false )
			if getElementData(v,"border") then
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, tocolor(255,255,255,220), 1, false)-- - top
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), tocolor(255,255,255,220), 1, false)-- l <
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(255,255,255,220),1, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(255,255,255,220), 1, false) -- > I
			end
			end
		end
	for id, v in ipairs (getElementsByType("dxStaticImage")) do
		if getElementData(v,"visible") then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			if getElementData(v,"rot") == true then
				dxDrawImage(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), getElementData(v,"filepath"), getTickCount()/20 % 360, getElementData(v,"rotY"), getElementData(v,"rotZ"), getElementData(v,"color"))
			else
				dxDrawImage(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), getElementData(v,"filepath"), getElementData(v,"rotX"), getElementData(v,"rotY"), getElementData(v,"rotZ"), getElementData(v,"color"))
			end
		end
	end
		for id, v in ipairs (getElementsByType("dxCheckBox")) do
		if getElementData(v,"visible") then
		local x = 0
		local y = 0
		if getElementData(v,"parent") then
			x = getElementData(getElementParent(v),"x")
			y = getElementData(getElementParent(v),"y")
		end
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(255,255,255,200), false)
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, tocolor(0,0,0,255), 1, false)-- - top
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 1, false)-- l <
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 1, false)
		dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 1, false) -- > I
		if getElementData(v,"check") then
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,240), 1.2, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,240), 1.2, false)
		end
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+20, getElementData(v,"y")+y,0,getElementData(v,"y")+y+20,tocolor(255,255,255,200),getElementData(v,"scale") or 1*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"left","center", false, false, false, true)
	end
	end
	for id, v in ipairs (getElementsByType("dxButton")) do
		if getElementData(v,"visible") == true then
		local x = 0
		local y = 0
		if getElementData(v,"parent") then
			x = getElementData(getElementParent(v),"x")
			y = getElementData(getElementParent(v),"y")
		end
		if getElementData(v,"type") == "1" then
		r,g,b,a = dxGetColor(v)
		if getElementData(v,"state") == "normal" then
			r,g,b,a = dxGetColor(v)
		elseif getElementData(v,"state") == "hovered" then
			r,g,b,a = brighter(v)
		elseif getElementData(v,"state") == "clicked" then
			r,g,b,a = brighter(v)
		end
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(r,g,b,a), false )
		
		if getElementData(v,"border") then
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"borderColor"), 0.8, false)-- - top
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"borderColor"), 1, false)-- l <
		dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"borderColor"), 0.8, false)
		dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"borderColor"), 0.8, false) -- > I
		end
		
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(255,255,255,255),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"center","center")
		elseif getElementData(v,"type") == "2" then
		
		r,g,b,a = dxGetColor(v)
		br,bg,bb = 255,255,255
		if getElementData(v,"state") == "normal" then
			r,g,b,a = dxGetColor(v)
			br,bg,bb = 255,255,255
		elseif getElementData(v,"state") == "hovered" then
			r,g,b,a = 2555,255,255,255
			br,bg,bb = 10,10,10
		elseif getElementData(v,"state") == "clicked" then
			r,g,b,a = 2555,255,255,255
			br,bg,bb = 10,10,10
		end
		
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(r,g,b,a), false )
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+6, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(br,bg,bb,255),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"left","center")
		if getElementData(v,"rightText") then
			dxDrawText(getElementData(v,"rightText"),getElementData(v,"x")+x+6, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width")-6, getElementData(v,"y")+y+getElementData(v,"height"),tocolor(br,bg,bb,255),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"right","center")
		end
	elseif getElementData(v,"type") == "3" then
		
		r,g,b,a = dxGetColor(v)
		rr,rg,rb,ra = 0,0,0,50
		if getElementData(v,"state") == "normal" then
			r,g,b,a = dxGetColor(v)
			rr,rg,rb,ra = 0,0,0,0
		elseif getElementData(v,"state") == "hovered" then
			r,g,b,a = brighter(v)
			rr,rg,rb,ra = 0,0,0,50
		elseif getElementData(v,"state") == "clicked" then
			r,g,b,a = brighter(v)
			rr,rg,rb,ra = 0,0,0,50
		end
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(rr,rg,rb,ra), false )
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+3, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(r,g,b,a),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"left","center")
		if getElementData(v,"rightText") then
			dxDrawText(getElementData(v,"rightText"),getElementData(v,"x")+x+3, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width")-6, getElementData(v,"y")+y+getElementData(v,"height"),tocolor(r,g,b,a),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"right","center")
		end	
		elseif getElementData(v,"type") == "4" then
		
		r,g,b,a = 255,255,255,220
		rr,rg,rb,ra = 0,0,0,205
		if getElementData(v,"state") == "normal" then
			rr,rg,rb,ra = 0,0,0,205
		elseif getElementData(v,"state") == "hovered" then
			rr,rg,rb,ra = 0,0,0,210
		elseif getElementData(v,"state") == "clicked" then
			rr,rg,rb,ra = 0,0,0,210
		end
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(rr,rg,rb,ra), false )
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+3, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(r,g,b,a),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"left","center")
		if getElementData(v,"rightText") then
			dxDrawText(getElementData(v,"rightText"),getElementData(v,"x")+x+3, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width")-6, getElementData(v,"y")+y+getElementData(v,"height"),tocolor(r,g,b,a),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"right","center")
		end
		elseif getElementData(v,"type") == "5" then
		
		r,g,b,a = 0,0,0,200
		br,bg,bb = 255,255,255
		if getElementData(v,"state") == "normal" then
			r,g,b,a = 0,0,0,200
			br,bg,bb = 255,255,255
		elseif getElementData(v,"state") == "hovered" then
			r,g,b,a = 2555,255,255,200
			br,bg,bb = 10,10,10
		elseif getElementData(v,"state") == "clicked" then
			r,g,b,a = 2555,255,255,200
			br,bg,bb = 10,10,10
		end
		
		dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(r,g,b,a), false )
		dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+6, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(br,bg,bb,240),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"left","center")
		if getElementData(v,"rightText") then
			dxDrawText(getElementData(v,"rightText"),getElementData(v,"x")+x+6, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width")-6, getElementData(v,"y")+y+getElementData(v,"height"),tocolor(br,bg,bb,240),getElementData(v,"scale") or 1.5*(15/dxGetFontHeight(1,getElementData(v,"font")))/1.6,getElementData(v,"font"),"right","center")
		end
		end
	end
	end
	for id, v in ipairs (getElementsByType("dxEdit")) do
		if getElementData(v,"visible") then
			local x = 0
			local y = 0
			local text = getElementData(v,"text")
			if getElementData(v,"masked") then
				text = string.gsub(text,".","•")
			end
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(255,255,255,255), false )
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, tocolor(0,0,0,255), 0.8, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 1, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 0.8, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 0.8, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"), tocolor(0,0,0,255), 0.8, false)
		
			if dxGetTextWidth(text,getElementData(v,"scale"),getElementData(v,"font")) <= getElementData(v,"width") then
				dxDrawText(text,getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(0,0,0,220),getElementData(v,"scale") or getElementData(v,"height")/( dxGetFontHeight(1,getElementData(v,"font")) )/1.2,getElementData(v,"font"),"left","center",true)
			else
				dxDrawText(text,getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(0,0,0,220),getElementData(v,"scale") or getElementData(v,"height")/dxGetFontHeight(1,getElementData(v,"font"))/1.2,getElementData(v,"font"),"right","center",true)
			end
			if getElementData(v,"input") and not getElementData(v,"readonly") and dxGetTextWidth(text,getElementData(v,"scale"),getElementData(v,"font")) <= getElementData(v,"width") then
			dxDrawLine(dxGetTextWidth(text,getElementData(v,"scale"),getElementData(v,"font"))+getElementData(v,"x")+x+8, getElementData(v,"y")+y+4, dxGetTextWidth(text,getElementData(v,"scale"),getElementData(v,"font"))+getElementData(v,"x")+x+8, getElementData(v,"y")+y+getElementData(v,"height")-4, tocolor(0,0,0,math.abs(math.sin(getTickCount()/300))*200), 2.5, false)
			end
		end
	end	
	for id, v in ipairs (getElementsByType("dxMemo")) do
		if getElementData(v,"visible") == true then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
		if getElementData(v,"type") == 1 then
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(255,255,255,200), false )
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y,  tocolor(0,0,0,240), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0,0,0,240), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0, 0, 0, 240), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0, 0, 0, 240), 1.5, false)	
			dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(0,0,0,255),1.5*(15/dxGetFontHeight(1,getElementData(v,"font"))),getElementData(v,"font"),"left","top",true,true)
		elseif getElementData(v,"type") == 2 then
			dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(0,0,0,255),getElementData(v,"scale") or 1,getElementData(v,"font"),"left","top",true,true,false,true)
		
		end
		end
	end
	for id, v in ipairs (getElementsByType("dxLabel")) do
		if getElementData(v,"visible") == true then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			dxDrawText(getElementData(v,"text"),getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),tocolor(255,255,255,255),getElementData(v,"scale") or getElementData(v,"height")/dxGetFontHeight(1,getElementData(v,"font"))/1.3,getElementData(v,"font"),getElementData(v,"angle"),"top",false,getElementData(v,"wordBreak") or true, false, false)
		end
	end
	for id, v in ipairs (getElementsByType("dxScrollBar")) do
		if getElementData(v,"visible") then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			if not getElementData(v,"horizontal") then
				dxDrawRectangle(getElementData(v,"x")+x+5-1, getElementData(v,"y")+y,getElementData(v,"width"), getElementData(v,"height")+2,tocolor(50,50,50,130))
				dxDrawRectangle(getElementData(v,"x")+x+5, getElementData(v,"y")+y + ((getElementData(v,"height")/2)*getElementData(v,"scroll")),getElementData(v,"width"), getElementData(v,"height")/2,tocolor(155,155,155,200))
			else
				dxDrawRectangle(getElementData(v,"x")+x+5, getElementData(v,"y")+y,getElementData(v,"width"), getElementData(v,"height"),tocolor(50,50,50,130))
				dxDrawRectangle(getElementData(v,"x")+x+5+ ((getElementData(v,"width")/2)*getElementData(v,"scroll")), getElementData(v,"y")+y ,getElementData(v,"width")/2, getElementData(v,"height"),tocolor(155,155,155,200))
			end
		end
	end	
	for id, v in ipairs (getElementsByType("dxGridList")) do
		if getElementData(v,"visible") == true then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(0,0,0,240), false )
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y,  tocolor(255,255,255,200), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(255,255,255,200), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor( 255, 255, 255, 200 ), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor( 255, 255, 255, 200 ), 1.5, false)
			local no = #getElementChildren(	v )
			for id, item in ipairs (getElementChildren(	v )) do
				local delta = 0
				if getElementData(v,"scrollbar") then
					local delta = getElementData(getElementData(v,"scrollbar"),"scroll")*no*1.5*15
				end
				delta = delta/2
				if (((id)*1.5*15)-delta) <= (getElementData(v,"height")+22.5) and (((id)*1.5*15)-delta) >= 0 then
					setElementData(item,"shown",true,false)
					if getElementData(item,"state") == "hovered" then
						dxDrawRectangle(getElementData(v,"x")+x,3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),getElementData(v,"width")-3,getItemShowingHeight(item),tocolor(255,255,255,100))
					end
					if getElementData(item,"state") == "clicked" then
						dxDrawRectangle(getElementData(v,"x")+x,3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),getElementData(v,"width")-3,getItemShowingHeight(item),tocolor(0,0,0,100)) for id, el in ipairs(getElementChildren(getElementParent(item))) do setElementData(el,"clicked",nil) end setElementData(item,"clicked",true)
					end
					if getElementData(item,"clicked") then
						dxDrawRectangle(getElementData(v,"x")+x,3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),getElementData(v,"width")-3,getItemShowingHeight(item),tocolor(0,0,255,100)) 
					end
					if getElementData(item,"colored") then
						dxDrawText(getElementData(item,"text"),getElementData(v,"x")+x+3,3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),getElementData(v,"width")+getElementData(v,"x")+x-3,getElementData(v,"y")+y + math.min(getElementData(v,"height"),((id)*1.5*15)-delta)-3,tocolor(255,255,255,255),1.3,"default","left", getItemAlign(math.max(((id-1)*1.5*15)-delta,0)) ,true, false, false, true)
						else
						dxDrawText(getElementData(item,"text"),getElementData(v,"x")+x+3,3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),getElementData(v,"width")+getElementData(v,"x")+x-3,getElementData(v,"y")+y + math.min(getElementData(v,"height"),((id)*1.5*15)-delta)-3,tocolor(255,255,255,255),1.3,"default","left", getItemAlign(math.max(((id-1)*1.5*15)-delta,0)) ,true)
					end
					setElementData(item,"width",getElementData(v,"width"),false)
					setElementData(item,"height",15*1.5,false)
					setElementData(item,"x",getElementData(v,"x")+x,false)
					setElementData(item,"y",3+ getElementData(v,"y")+y + math.max(((id-1)*1.5*15)-delta,0),false)
				else
					setElementData(item,"shown",false,false)
				end
			end
		end
	end
	for id, v in ipairs (getElementsByType("dxProgressBar")) do
		if getElementData(v,"visible") == true then
			local x = 0
			local y = 0
			if getElementData(v,"parent") then
				x = getElementData(getElementParent(v),"x")
				y = getElementData(getElementParent(v),"y")
			end
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"width"), getElementData(v,"height"), tocolor(255,255,255,150), false )
			dxDrawRectangle(getElementData(v,"x")+x, getElementData(v,"y")+y, ((getElementData(v,"width"))*((getElementData(v,"progress")/100))),getElementData(v,"height"),tocolor(0,255,0,155))
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y,  tocolor(0,0,0,alpha), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y, getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0,0,0,alpha), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x, getElementData(v,"y")+y+getElementData(v,"height"), getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0, 0, 0, alpha), 1.5, false)
			dxDrawLine(getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y, getElementData(v,"x")+x+getElementData(v,"width"), getElementData(v,"y")+y+getElementData(v,"height"),  tocolor(0, 0, 0, alpha), 1.5, false)	
		end
	end	
end

function getItemAlign(value)
	if value == 0 then
		return "bottom"
	else 
		return "top"
	end
end

function getRed(element)
	return bitAnd(bitRShift(getElementData(element,"color"),16),0xff)
end

function getGreen(element)
	return bitAnd(bitRShift(getElementData(element,"color"),8),0xff)
end

function getBlue(element)
	return bitAnd(bitRShift(getElementData(element,"color"),0),0xff)
end


function getAlpha(element)
	return bitAnd(bitRShift(getElementData(element,"color"),24),0xff)
end


function brighter(element)
	local r = getRed(element)
	local g = getGreen(element)
	local b = getBlue(element)
	local alpha = getAlpha(element)

	local i = 1.0/(1.0-0.7)
	if ( r == 0 and g == 0 and b == 0) then
		return tocolor(i, i, i, alpha)
	end
	
	if ( r > 0 and r < i ) then r = i end
	if ( g > 0 and g < i ) then g = i end
	if ( b > 0 and b < i ) then b = i end

	return math.min(r/0.7, 255),
							 math.min(g/0.7, 255),
							 math.min(b/0.7, 255),
							 alpha
end


function getItemShowingHeight(item)
	local y = getElementData(item,"y")
	local gx,gy = dxGetPosition(getElementParent(item))
	local delta =  getElementData(getElementParent(item),"height") - (y-gy)
	return math.min(delta,22.5)
end

function dxGridListAddRow(gridlist,text)
	if gridlist and text then
		local element = createElement("dxGridListItem")
		setElementParent(element,gridlist)
		setElementData(element,"text",text,false)
		if (#(getElementChildren(gridlist))*15*1.5) >= getElementData(gridlist,"height") and not getElementData(gridlist,"scrollbar")then
			setElementData(gridlist,"width",getElementData(gridlist,"width")-20,false)
			local x,y = dxGetPosition(gridlist)
			local x1,y1 = dxGetPosition(getElementParent(gridlist))
			x = x- x1
			y = y - y1
			local scrollbar = dxCreateScrollBar(x+getElementData(gridlist,"width")-5,y,20,getElementData(gridlist,"height"),false,false,getElementParent(gridlist))
			setElementData(gridlist,"scrollbar",scrollbar,false)
		end
		return element
	else
		outputDebugString("ERROR: expected arguments are missing (dxGridListAddRow)")	
		return false
	end
end

function dxGetPosition(element,relative)
	if not element then return false end
	local x = getElementData(element,"x")
	local y = getElementData(element,"y")
	local px = getElementData(getElementParent(element),"x")
	local py = getElementData(getElementParent(element),"y")
	if not relative then
		return x + px, y + py
	else
		return x/px, y/py
	end
end

function dxGetAllPositions(element,relative)
	if not element then return false end
	local x = getElementData(element,"x")
	local y = getElementData(element,"y")
	local width = getElementData(element,"width")
	local height = getElementData(element,"height")
	local px = getElementData(getElementParent(element),"x")
	local py = getElementData(getElementParent(element),"y")
	if not relative then
		return x + px, y + py, width, height
	else
		return x/px, y/py, width, height
	end
end

function dxSetPosition(element,fx,fy,relative)
	if not element then return false end
	local x = getElementData(element,"x")
	local y = getElementData(element,"y")
	local px = getElementData(getElementParent(element),"x")
	local py = getElementData(getElementParent(element),"y")
	if not relative then
		setElementData(element,"x",fx,false)
		setElementData(element,"y",fy,false)
	else
		setElementData(element,"x",fx*px,false)
		setElementData(element,"y",fy*py,false)
	end
end

function dxSetSize(element,fx,fy,relative)
	if not element then return false end
	local px = getElementData(getElementParent(element),"width")
	local py = getElementData(getElementParent(element),"height")
	if not relative then
		setElementData(element,"width",fx,false)
		setElementData(element,"height",fy,false)
		return
	else
		setElementData(element,"height",fx*px,false)
		setElementData(element,"width",fy*py,false)
		return
	end
end

function dxGetSize(element,relative)
	if not element then return false end
	local px = getElementData(getElementParent(element),"width")
	local py = getElementData(getElementParent(element),"height")
	if not relative then
		return getElementData(element,"width"),getElementData(element,"height")
	else
		return (getElementData(element,"height"))/py, (getElementData(element,"width"))/py
	end
end

function dxEditSetMaxLength (edit,length)
	if not edit then return end
	return setElementData(edit,"maxlength",length,false)
end

function dxProgressBarSetProgress(progressbar,progress)
	if not progressbar then return end
	return setElementData(progressbar,"progress",progress,false)
end

function dxProgressBarGetProgress(progressbar)
	if not progressbar then return end
	return getElementData(progressbar,"progress")
end

function dxSetFont(element,font)
	return setElementData(element,"font",font,false)
end

function dxSetScale(element,scale)
	return setElementData(element,"scale",scale,false)
end

function dxGetFont(element)
	return getElementData(element,"font")
end

function dxSetBorder(element,value)
	return setElementData(element,"border",value,false)
end

function dxSetBorderColor(element,value)
	return setElementData(element,"borderColor",value,false)
end

function dxSetAngle(element,angle)
	return setElementData(element,"angle",angle,false)
end

function dxSetRightText(element,text)
	return setElementData(element,"rightText",text,false)
end

function dxGetRightText(element)
	return getElementData(element,"rightText") or ""
end

addEventHandler("onClientRender",getRootElement(), 
function()
	if not isCursorShowing() then
		return
	end
	if not attachedScrollBar then return end
	local cx, cy = getCursorPosition()
	if not cx or not cy then return end
	cx = cx * sx
	cy = cy * sy
	local x = 0
	local y = 0
	if getElementData(attachedScrollBar,"parent") then
		x = getElementData(getElementParent(attachedScrollBar),"x")
		y = getElementData(getElementParent(attachedScrollBar),"y")
	end
	if getElementData(attachedScrollBar,"horizontal") then
		x = x + getElementData(attachedScrollBar,"x")
		cx = cx - x - (getElementData(attachedScrollBar,"attachOffset") or 0 )
		local scroll = cx / (getElementData(attachedScrollBar,"width")/2)
		scroll = math.max(0,scroll)
		scroll = math.min(1,scroll)
		setElementData(attachedScrollBar,"scroll",scroll,false)
	else
		y = y + getElementData(attachedScrollBar,"y")
		cy = cy - y - (getElementData(attachedScrollBar,"attachOffset") or 0 )
		local scroll = cy / (getElementData(attachedScrollBar,"height")/2)
		scroll = math.max(0,scroll)
		scroll = math.min(1,scroll)
		setElementData(attachedScrollBar,"scroll",scroll,false)
	end
end)

function GUIstates()
	if not isCursorShowing() then
		return
	end
	local x,y = getCursorPosition()
	x = x * sx
	y = y * sy
	for id,element_r in ipairs(getElementChildren(dxRootElement)) do
		for id, element in ipairs(getElementChildren(element_r)) do
			if getElementData(element,"visible") then
				if getElementType(element) == "dxGridList" then
					for id, element in ipairs(getElementChildren(element)) do
						if getElementType(element) == "dxGridListItem" and getElementData(element,"shown") then
							local g_height = getElementData(element,"height") or 0
							local g_width = getElementData(element,"width") or 0
							local px = getElementData(element,"x")
							local py = getElementData(element,"y")
							if x >= px and x <= (px+g_width) and y >= py and y <= (py + g_height) then
								if getKeyState("mouse1") then
									setElementData(element,"state","clicked",false)
								else
									setElementData(element,"state","hovered",false)
								end
							else
								setElementData(element,"state","normal",false)
							end
						end
					end
				else
					local g_height = getElementData(element,"height") or 0
					local g_width = getElementData(element,"width") or 0
					local px, py = dxGetPosition(element)
					if x >= px and x <= (px+g_width) and y >= py and y <= (py + g_height) then
						if getKeyState("mouse1") then
							setElementData(element,"state","clicked",false)
						else
							if getElementData(element,"state") == "normal" then
								triggerEvent("onClientDXMouseEnter",element)
								setElementData(element,"state","hovered",false)
							end
						end
					else
						if getElementData(element,"state") == "hovered" then
							triggerEvent("onClientDXMouseLeave",element)
						end
						setElementData(element,"state","normal",false)
					end
				end
			end
		end
	end
end

function movingGUI(button,state,x,y)
	if not isCursorShowing() then
		return
	end
	for id, element in ipairs (getElementsByType("dxEdit")) do
		setElementData(element,"input",nil,false)
	end
	if button == "left" and state == "down" then
		for id, element in ipairs(getElementChildren(dxRootElement)) do
			local width = getElementData(element,"width") or 0
			local height = getElementData(element,"height") or 0
			if x >= getElementData(element,"x") and x <= (getElementData(element,"x")+width) and y >= getElementData(element,"y") and y <= (getElementData(element,"y") + 30) then
				elementBeingMoved = element
				movedElementOffset = { x - getElementData(element,"x"), y - getElementData(element,"y")}
				triggerEvent("onClientDxMove",element)
				return
			end
		end
	else
		elementBeingMoved = nil
		for id,element_r in ipairs(getElementChildren(dxRootElement)) do
			for id, element in ipairs(getElementChildren(element_r)) do			
				if getElementData(element,"visible") then
					local g_height = getElementData(element,"height") or 0
					local g_width = getElementData(element,"width") or 0
					local px, py = dxGetPosition(element)
					if x >= px and x <= (px+g_width) and y >= py and y <= (py + g_height) then
						if state == "up" and button =="left" then
							triggerEvent("onClientDxClick",element)
							return
						end
					end
				end
			end
		end
	end
end

addEvent("onClientDxMove",true)
addEvent("onClientDxClick",true)
addEvent("onClientDXMouseEnter",true)
addEvent("onClientDXMouseLeave",true)
addEventHandler("onClientClick",getRootElement(),movingGUI)
addEventHandler("onClientRender",getRootElement(),drawingGUI)
addEventHandler("onClientRender",getRootElement(),GUIstates)