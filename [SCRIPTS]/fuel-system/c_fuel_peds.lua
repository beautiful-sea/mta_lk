local wPedRightClick, bTalkToPed, bClosePedMenu, closing, selectedElement = nil
local wGui = nil
local sent = false

function pedDamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage", getResourceRootElement(), pedDamage)

function clickPed(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="ped") and (button=="right") and (state=="down") and (sent==false) and (element~=getLocalPlayer()) then
		local gatekeeper = getElementData(element, "ped:fuelped")
		if (gatekeeper) then
			local x, y, z = getElementPosition(getLocalPlayer())
			
			if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=5) then
				if (wPedRightClick) then
					hidePedMenu()
				end
				
				showCursor(true)
				
				selectedElement = element
				closing = false
				
				wPedRightClick = guiCreateWindow(absX, absY, 150, 75, getElementData(element, "ped:name"), false)
				
				bTalkToPed = guiCreateButton(0.05, 0.3, 0.87, 0.25, "Talk", true, wPedRightClick)
				addEventHandler("onClientGUIClick", bTalkToPed,  function (button, state)
					if(button == "left" and state == "up") then
						triggerServerEvent("fuel:startConvo", selectedElement)
						hidePedMenu()
					end
				end, false)
				
				bClosePedMenu = guiCreateButton(0.05, 0.6, 0.87, 0.25, "Close Menu", true, wPedRightClick)
				addEventHandler("onClientGUIClick", bClosePedMenu, hidePedMenu, false)
				sent=true
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickPed, true)

function hidePedMenu()
	if (isElement(bTalkToPed)) then
		destroyElement(bTalkToPed)
	end
	bTalkToPed = nil
	
	if (isElement(bClosePedMenu)) then
		destroyElement(bClosePedMenu)
	end
	bClosePedMenu = nil

	if (isElement(wPedRightClick)) then
		destroyElement(wPedRightClick)
	end
	wPedRightClick = nil
	
	sent=false
	selectedElement = nil
	showCursor(false)
end

function onQuestionShow(questionArray) 
	selectedElement = source
	local Width = 300
	local Height = 450
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	local verticalPos = 0.05
	if not (wGui) then
		wGui = guiCreateWindow(X, Y, Width, Height, "Answer the question:", false )
		
		for answerID, answerStr in ipairs(questionArray) do
			if (answerStr) then
				local option = guiCreateButton( 0.05, verticalPos, 0.9, 0.2, answerStr, true, wGui )
				setElementData(option, "option", answerID, false)
				setElementData(option, "optionstr", answerStr, false)
				addEventHandler( "onClientGUIClick", option, answerConvo, false )
			end
			verticalPos = verticalPos + 0.2
		end
		showCursor(true)
	end
end
addEvent( "fuel:convo", true )
addEventHandler( "fuel:convo", getRootElement(), onQuestionShow )

function answerConvo( mouseButton )
	if (mouseButton == "left") then
		theButton = source
		local option = getElementData(theButton, "option")
		if (option) then
			local optionstr = getElementData(theButton, "optionstr")
			triggerServerEvent("fuel:convo", selectedElement, option, optionstr)
			cleanGUI()
		end
	end
end

function cleanGUI()
	destroyElement(wGui)
	wGui = nil
	showCursor(false)
end