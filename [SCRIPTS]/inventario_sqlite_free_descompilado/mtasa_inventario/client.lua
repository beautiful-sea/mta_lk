-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

sX, sY = guiGetScreenSize()
pW, pH = itemSize*column + margin*(column+1), itemSize * row + (1+row)*margin
moveX, moveY = (sX/2), (sY/2)
setElementData(localPlayer, "char.showedPlayerInventory", 0)
showInventory = false
local showLeft = false
local font = dxCreateFont("files/font.ttf", 16, false, "cleartype")
local lastClick = 0
local invMenu = 1
local selectedAmount = 1
local amountBox = nil
local inSlotBox = false
local m = {}
local moving = false

playerItems = {}
inventoryItems = {}
itemBugFixOnOff = false
clickedTimer = false

local actionItems = {}
local elementSource = nil
activeSide = "bag"
newMenu = nil
local vehBoot = false

local hoverSlot = -1
local hoverItem = nil
local inMove = false
local startTick = -1
local movedItem = nil
local movedSlot = -1

local inClone = false
local clonedItem = nil
local clonedSlot = -1

local actionSlots = 6
local action_array     = {}
for i=1, actionSlots do action_array[i] = {-1, -1, "bag"} end
local isCursorInAction = false
local current_action_slot = -1
local isMove = false
defX, defY = 0,0
actPos = {sX/2-(300/2), sY-50}

activeBikeLockSlot = -1
activeBikeLockKeySlot = -1
activeCuffSlot = -1
activeCuffKeySlot = -1
bodySearchState = false
bodySearchInventoryOpened = false

local panelSize = {350, 15}
local font_progress = dxCreateFont("files/font.ttf", 19, false, "cleartype")
local bodysearch_progress_tick = 0
local bodysearch_progress_max = panelSize[1]
local bodysearch_progress_text = ""

function getCursorFuck()
	cX, cY = getCursorPosition()
	cX, cY = cX*sX, cY*sY
	return cX, cY
end

addEventHandler("onClientClick",getRootElement(),function(button,state)
	if showInventory then
		if button == "left" and state == "down" then
			if isInBox(moveX-25, moveY-24, 427, 18) then
				isMove = true
				local curX, curY = getCursorFuck()
				local x,y = moveX,moveY
				defX, defY = curX - x, curY - y
			end
		elseif button == "left" and state == "up" then
			if isMove then
				isMove = false
			end
		end
	end
end)

bindKey("i", "down",
	function()
		--if not getElementData(localPlayer, "CharLoggedIn") then return end
		openInventory(localPlayer)
		if getElementData(localPlayer, "char.showedPlayerInventory") > 0 then
		    setElementData(localPlayer, "char.showedPlayerInventory", 0)
		end
	end
)

bindKey("m", "down", function()
	if not movedItem then
		showCursor(not isCursorShowing())
	end
end)

function removeHex (text)
    return type(text)=="string" and string.gsub(text, "#%x%x%x%x%x%x", "") or text
end

function create_tooltip(text)
	local cx, cy = getCursorPosition()
	cx, cy = cx * sX, cy * sY
	if text then
		local textWidth = dxGetTextWidth(removeHex(text), 1)
        dxDrawRectangle(cx - textWidth/2, cy - 25/2 -50, textWidth+10, 45, tocolor(0, 0, 0, 255/100*85), true)
        dxDrawText(text, cx - textWidth/2, cy - 25/2-100, textWidth + cx - textWidth/2+10, 45 + cy - 25/2 , tocolor(255, 255, 255, 255), 0.5, font, "center", "center", false, false, true, true)	
	end
end

local function tooltip( text, text2 )
	local x,y = getCursorPosition( )
	local x,y = x * sX, y * sY
	text = tostring( text )
	if text2 then
		text2 = tostring( text2 )
	end

	if text == text2 then
		text2 = nil
	end

	local width = dxGetTextWidth(text,1,"clear") + 20
	if text2 then
		width = math.max( width, dxGetTextWidth( text2, 1, "clear" ) + 20 )
		text = text .. "\n"..text2
	end
	local height = 10 * ( text2 and 5 or 3)
	x = math.max( 10, math.min( x, sX - width - 10 ) )
	y = math.max( 10, math.min( y, sY - height - 10 ) )
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0,160), true);
	dxDrawText( text, x, y, x + width, y + height, tooltip_text_color, 0.5, font, "center", "center", false, false, true,true)
end

local function tooltipWeapons( text, text2 )
	local x,y = getCursorPosition( )
	local x,y = x * sX, y * sY
	text = tostring( text )
	if text2 then
		text2 = tostring( text2 )
	end
	
	if text == text2 then
		text2 = nil
	end
	
	local width = dxGetTextWidth( text, 1, "clear" ) + 20
	if text2 then
		width = math.max( width, dxGetTextWidth( text2, 1, "clear" ) + 20 )
		text = text .. "\n" .. text2
	end
	local height = 12 * ( text2 and 5 or 3)
	x = math.max( 10, math.min( x, sX - width - 10 ) )
	y = math.max( 10, math.min( y, sY - height - 10 ) )
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0,160), true);
	dxDrawText( text, x, y, x + width, y + height, tooltip_text_color, 0.5, font, "center", "center", false, false, true,true)
end

local function tooltip_item( x,y,text, text2 )
	text = tostring( text )
	if text2 then
		text2 = tostring( text2 )
	end
		
	if text == text2 then
		text2 = nil
	end
	
	local width = dxGetTextWidth( text, 0.5, "clear" )
	if text2 then
		width = math.max( width, dxGetTextWidth( text2, 0.5, "clear" ))
		text = text .. "\n" .. text2
		y = y - 20
	end
	local height = 10 * ( text2 and 4 or 2 )
	x = x - (width/2) + (itemSize)
	dxDrawText( text, x+33, y+80, x - width, y + height, tocolor(200, 200, 200, 250), 0.5, font, "center", "center", false, false, false )
end


function openInventory(pElement)
	if (pElement) then
		showInventory = not showInventory
		triggerServerEvent("getElementItems", localPlayer, localPlayer, pElement, 2)
		activeSide = "bag"
		invMenu = 1
		if showInventory then
			if not isElement(amountBox) then
				amountBox = guiCreateEdit (moveX+350,moveY-23,50,18,"",false)
				guiSetAlpha(amountBox,0)
			end
		else
		    loadActionItems()
			if isElement(amountBox) then
				destroyElement(amountBox)
			end
			if bodySearchInventoryOpened then
			    bodySearchInventoryOpened = false
			end
			if getElementType(elementSource) == "vehicle" then
				triggerServerEvent("doorState", elementSource, elementSource, 0)
			end
		end

	end
end
addEvent("openInventory", true)
addEventHandler("openInventory", getRootElement(), openInventory)

addEventHandler("onClientElementDataChange", root, function(dataName, oldValue)
    --if getElementData(localPlayer, "CharLoggedIn") then
		if source == localPlayer then
			if dataName == "ID" then
				local newValue = tonumber(getElementData(source, dataName))
				if newValue > 0 then
					triggerServerEvent("getElementItems", localPlayer, localPlayer, localPlayer, 2)
					loadActionItems()
				end
			end
		end
	--end
end)
triggerServerEvent("getElementItems", localPlayer, localPlayer, localPlayer, 2)

function setElementItems(itemsTable, itemValue, pElement)
	elementSource = pElement
	if (itemValue == 2) then
		playerItems = itemsTable
	end
	if getElementType(pElement) == "player" then
		triggerServerEvent("Inventory->checkWeapons", localPlayer, localPlayer, itemsTable)
	end
	inventoryItems = itemsTable
end
addEvent("setElementItems", true)
addEventHandler("setElementItems", getRootElement(), setElementItems)

function getItemImg(itemID)
	if (tonumber(itemID)) then
		if (fileExists("files/img/items/" .. itemID .. ".png")) then
			return "files/img/items/" .. itemID .. ".png" 
		end
		return "files/img/items/1.png" 
	end
	return "files/img/items/1.png" 
end
	
local inItem = false
local actionX, actionY = sX/2 - 269/2,sY
local showBar = true
local weaponHot = 0

addEventHandler("onClientResourceStart",resourceRoot,function()
	setTimer(function()
		loadActionItems()
	end, 2000, 1)
	setElementData(localPlayer,"active:itemID",-1)
	setElementData(localPlayer,"active:itemSlot",-1)
end)

for i=1, actionSlots do
	bindKey(i, "down", function()
		if action_array[i] and action_array[i][1] > -1 and hasItemOnSlot(action_array[i][1]) then
			useItem(playerItems[action_array[i][3]][action_array[i][1]],action_array[i][1])
			if not hasItemOnSlot(action_array[i][1]) then
				action_array[i] = {-1,-1, -1}
			end
		end
	end)
end

local categoryTable = {
	{"bag","objetos","bag"},
	{"key","chaves","key"},
	{"cards","documentos","cards"},
}

function renderInventory()
	hoverSlot = -1
	hoverItem = nil
	if showBar then
		--if not getElementData(localPlayer, "CharLoggedIn") then return end
		actBox = {255,itemSize}
		dxDrawImage(actPos[1]-25,actPos[2]-23, 300, 80, "files/img/actionbar.png", 0, 0, 0, tocolor(255,255,255,255))
		current_action_slot = -1
		
		if isInBox(actPos[1]-10,actPos[2]-10,actBox[1]+20,actBox[2]+20) then
			isCursorInAction = true
		else
			isCursorInAction = false
		end
		for i=1,actionSlots do 
			dxDrawRectangle(actPos[1]+(i*((itemSize+4)+2))-40,actPos[2], itemSize, itemSize, tocolor(0,0,0,100))
			if (not guiGetInputEnabled() and not isMTAWindowActive() and not isCursorShowing() and getKeyState(i)) or isInBox(actPos[1]+(i*((itemSize+6)+2))-45,actPos[2], itemSize, itemSize) then
				dxDrawRectangle(actPos[1]+(i*((itemSize+4)+2))-40,actPos[2], itemSize, itemSize, tocolor(65,105,225,200))
				current_action_slot = i
			end
		
			if action_array[i] and action_array[i][1] > -1 and not hasItemOnSlot(action_array[i][1]) and action_array[i][3] == activeSide then
				action_array[i] = {-1, -1, "bag"}
			end
			if action_array[i] and action_array[i][1] > -1 and hasItemOnSlot(action_array[i][1]) and action_array[i][3] == activeSide then
				if isInBox(actPos[1]+(i*((itemSize+6)+2))-45,actPos[2], itemSize, itemSize) then
						
					local actItem = playerItems[action_array[i][3]][action_array[i][1]]["id"]
					local actValue = playerItems[action_array[i][3]][action_array[i][1]]["value"]
					local actCount = playerItems[action_array[i][3]][action_array[i][1]]["count"]
					local actState = playerItems[action_array[i][3]][action_array[i][1]]["health"]
					local actName = items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].name
					if actItem == 40 or actItem == 41 or actItem == 42 or actItem == 57 then
						tooltip("#4169E1"..actName.."#ffffff","Identificação: #4169E1"..actValue.."")
					elseif (actItem >=2 and actItem <= 13) then
						tooltipWeapons("#4169E1"..actName.."#ffffff","Condição: #4169E1"..actState.."#ffffff%\nPeso: #4169E1"..items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].weight*actCount.." kg")
					elseif items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].isWeapon then
						tooltipWeapons("#4169E1"..actName.."#ffffff","Condição: #4169E1"..actState.."#ffffff%\nPeso: #4169E1"..items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].weight*actCount.." kg")
					elseif actItem == 29 or actItem == 30 or actItem == 129 then
						tooltip("#4169E1"..actName.." (ID: ".. actValue ..")#ffffff","Peso: #4169E1"..items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].weight*actCount.."")
					else
						tooltip("#4169E1"..actName.."#ffffff","Peso: #4169E1"..items[playerItems[action_array[i][3]][action_array[i][1]]["id"]].weight*actCount.." kg")
					end
				end
				dxDrawImage(actPos[1]+(i*((itemSize+4)+2))-40,actPos[2], itemSize, itemSize, "files/img/items/" .. action_array[i][2] .. ".png", 0, 0, 0, tocolor(255,255,255, 255)) --Item IMG
				tooltip_item(actPos[1]+(i*((itemSize+4)+2))-58,actPos[2]-23,playerItems[action_array[i][3]][action_array[i][1]]["count"])
			end
		end
		
	end
	if not showInventory then
		return
	end
	
	if isMove then
		local x, y = getCursorFuck()
		moveX,moveY = x - defX,y - defY
	end
	
	local itemWeight = getAllItemWeight()
	inItem = false
	if (isInBox(moveX-6, moveY-5, pW+12, pH+85)) then
		inItem = true
	end
	dxDrawImage(moveX-117, moveY-105, 600, 400, "files/img/panel/inventory.png", 0, 0, 0, tocolor(255,255,255,255))
	
	local catCount = 0
	if getElementType(elementSource) == "vehicle" or getElementType(elementSource) == "object" then
		categoryTable[4] = nil
	end
	for k,v in ipairs(categoryTable) do
		catCount = catCount+1
		if isInBox(moveX-70,moveY+40+(catCount*35),22,22) and not movedItem then
			dxDrawImage(moveX-112, moveY-105, 600, 400, "files/img/panel/"..v[1]..".png", 0, 0, 0, tocolor(65,105,225,250))
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				if invMenu ~= k then
					playSound("files/sounds/bincoselect.mp3")
				end
				invMenu = k
				activeSide = v[3]
			end
		else
			if invMenu == k then
				dxDrawImage(moveX-112, moveY-105, 600, 400, "files/img/panel/"..v[1]..".png", 0, 0, 0, tocolor(65,105,225,250))
			else
				dxDrawImage(moveX-112, moveY-105, 600, 400, "files/img/panel/"..v[1]..".png", 0, 0, 0, tocolor(200,200,200,250))
			end
		end
	end
	
	local drawRow = 0
	local drawColumn = 0
	
	if activeSide == "bag" or activeSide == "cards" or activeSide == "key" then
		
		dxDrawText("Quantidade:", moveX+280, moveY-22, 0, 0, tocolor(255, 255, 255, 180), 0.5, font, "left", "top", false, false, false, true)
		dxDrawText(guiGetText(amountBox),moveX+355,moveY-21,0,0,tocolor(255, 255, 255, 190), 0.5, font, "left", "top", false, false, false, true)
		if selectedAmount <= 0 then
			selectedAmount = 1
			guiSetText(amountBox,1)
		end
		dxDrawRectangle(moveX+350,moveY-22,50,15,tocolor(0,0,0,60))
		if isInBox(moveX+330,moveY-22,50,15) then
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				if isElement(amountBox) then
					if guiEditSetCaretIndex(amountBox, string.len(guiGetText(amountBox))) then
						guiBringToFront(amountBox)
						guiEditSetMaxLength(amountBox, 4)
					end
				end
			end
		end
		for i = 1, row * column do
			if isInBox(moveX + drawColumn * (itemSize + margin) + margin * 1, moveY + drawRow * (itemSize + margin) + margin * 1.6, itemSize, itemSize) then
				inSlotBox = true	
                dxDrawRectangle(moveX + drawColumn * (itemSize + margin) + margin * 1, moveY + drawRow * (itemSize + margin) + margin * 1.6, itemSize, itemSize, tocolor(65,105,225,200))				
				--
				hoverSlot = i
				if (inventoryItems[activeSide][i]) then
					hoverItem = (inventoryItems[activeSide][i])
						if inventoryItems[activeSide][i]["id"] == 40 or inventoryItems[activeSide][i]["id"] == 41 or inventoryItems[activeSide][i]["id"] == 42 or inventoryItems[activeSide][i]["id"] == 57 then
							tooltip("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Identificação: #4169E1"..inventoryItems[activeSide][i]["value"].."")
						elseif (inventoryItems[activeSide][i]["id"] >=2 and inventoryItems[activeSide][i]["id"] <= 13) then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Condição: #4169E1"..inventoryItems[activeSide][i]["health"].."#ffffff%\nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						elseif items[inventoryItems[activeSide][i]["id"]].isWeapon then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Condição: #4169E1"..inventoryItems[activeSide][i]["health"].."#ffffff%\nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						elseif inventoryItems[activeSide][i]["id"] == 25 then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Valor: #4169E1"..inventoryItems[activeSide][i]["value"].."#ffffff \nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						elseif inventoryItems[activeSide][i]["id"] == 29 or inventoryItems[activeSide][i]["id"] == 30 or inventoryItems[activeSide][i]["id"] == 129 or inventoryItems[activeSide][i]["id"] == 78 then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","ID: #4169E1"..inventoryItems[activeSide][i]["value"].."#ffffff \nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						elseif inventoryItems[activeSide][i]["id"] == 141 then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Condição: #4169E1"..inventoryItems[activeSide][i]["health"].."#ffffff%\nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						elseif inventoryItems[activeSide][i]["id"] == 144 then
							tooltipWeapons("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Condição: #4169E1"..inventoryItems[activeSide][i]["health"].."#ffffff%\nPeso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						else
							tooltip("#4169E1"..items[inventoryItems[activeSide][i]["id"]].name.."#ffffff","Peso: #4169E1"..items[inventoryItems[activeSide][i]["id"]].weight*inventoryItems[activeSide][i]["count"].." kg")
						end

				else
					hoverItem = nil
				end
			else
				dxDrawRectangle(moveX + drawColumn * (itemSize + margin) + margin * 1, moveY + drawRow * (itemSize + margin) + margin * 1.6, itemSize, itemSize, tocolor(0,0,0,100))
				if inventoryItems[activeSide][i] then
					if items[inventoryItems[activeSide][i]["id"]].typ == "bag" then
						if activeAmmoSlot == i or activeWeaponSlot == i or activeMask == i or activeShield == i or activeCuffSlot == i or activeCuffKeySlot == i then
							dxDrawRectangle(moveX + drawColumn * (itemSize + margin) + margin * 1, moveY + drawRow * (itemSize + margin) + margin * 1.6, itemSize, itemSize, tocolor(65,105,225,200))	
						end
					end
				end
				inSlotBox = false
			end
			local itemData = inventoryItems[activeSide][i]
			if (itemData) then
				local itemDbid = itemData["ID"]
				local itemID = itemData["id"]
				local itemCount = itemData["count"]
				local itemHeath = itemData["health"]
				if ((movedSlot == i)) then
					inMove = true
					local cX, cY = getCursorPosition()
					cX, cY = sX * cX, sY * cY
					dxDrawImage(cX - itemSize/2, cY - itemSize/2, 36, 36, getItemImg(tonumber(movedItem["id"])), 0, 0, 0, tocolor(255, 255, 255, 255), true)				
				else
					dxDrawImage(moveX + drawColumn * (itemSize + margin) + margin * 1, moveY + drawRow * (itemSize + margin) + margin * 1.6, 36, 36, getItemImg(tonumber(itemID)), 0, 0, 0, tocolor(255, 255, 255, 255))
					tooltip_item(moveX + drawColumn * (itemSize + margin) + margin * 1-18, moveY + drawRow * (itemSize + margin) + margin * 1.5-22,itemCount)
					
					if items[itemID] and items[itemID].statusbar then
						dxDrawRectangle(moveX + drawColumn * (itemSize + margin) + margin * 1 + 2, moveY + drawRow * (itemSize + margin) + margin * 1.5 + itemSize - 6, itemSize - 4, 4, tocolor(0, 0, 0, 255))
						dxDrawRectangle(moveX + drawColumn * (itemSize + margin) + margin * 1 + 2, moveY + drawRow * (itemSize + margin) + margin * 1.5 + itemSize - 6, itemHeath / 100 * (itemSize - 4), 4, tocolor(163, 93, 0, 255))
					end
				end
			end
			if (inClone) then
				local cX, cY = getCursorPosition()
				cX, cY = sX * cX, sY * cY
				dxDrawImage(cX - itemSize/2, cY - itemSize/2, 36, 36, getItemImg(tonumber(clonedItem["id"])), 0, 0, 0, tocolor(255, 255, 255, 255), true)									
			end
			drawColumn = drawColumn + 1
			if (drawColumn == column) then
				drawColumn = 0
				drawRow = drawRow + 1
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), renderInventory)

addEventHandler("onClientClick", getRootElement(),	
	function(pButton, pState, _, _, _, _, _, clickedElement)
		if (pButton == "left" and pState == "down" and showInventory) then
			if (tonumber(hoverSlot) > -1 and hoverItem and not inClone) then
				if isSlotUsedByAction(hoverSlot) and bodySearchInventoryOpened == false then outputChatBox("#FF0000[Error]: #ffffffEsse item já está sendo usado", 255,255,255,true) return end		
				if itemBugFixOnOff then return end
				if bodySearchInventoryOpened then return end
				if activeSide == "bag" and activeWeaponSlot == hoverSlot or activeAmmoSlot == hoverSlot or activeMask == hoverSlot or activeShield == hoverSlot then
				
				else
					startTick = getTickCount()
					movedItem = hoverItem
					movedSlot = tonumber(hoverSlot)
					
					if guiGetText(amountBox) == "" then
					
					else
						inClone = true
						clonedItem = hoverItem
						clonedSlot = tonumber(hoverSlot)
					end
				end
			end
			if(isCursorInAction and current_action_slot > -1)then
				action_array[current_action_slot] = {-1, -1, "bag"}
				saveAction()
				itemBugFixOn()
			end
		elseif (pButton == "left" and pState == "up" and showInventory) then
			if (not inItem and isCursorInAction and movedItem and movedSlot > -1) then
				action_array[current_action_slot] = {movedSlot, movedItem["id"], activeSide}
				saveAction()
				itemBugFixOn()
			end
			
			if hoverSlot == movedSlot then
				hideClone()
			end
			
			if not hoverItem then
				if hoverSlot == -1 then
					hideClone()
				end
			end
			
			if (movedSlot > -1 and movedItem and not hoverItem and hoverSlot > -1 and hoverSlot ~= movedSlot and inItem and inMove) then
			if movedItem["duty"] >= 1 then outputChatBox("#FF0000[Error]: #ffffffVocê não pode colocar esse objeto", 255,255,255,true) return end
			itemBugFixOn()
				if guiGetText(amountBox) == "" then
					setItemSlot(movedSlot, hoverSlot)
					delItemSlot(movedSlot)
				else
					if movedItem["count"] >= selectedAmount then
						if movedItem["count"] - selectedAmount == 0 then
							delItem(movedSlot)
						else
							setItemCount(movedSlot, movedItem["count"] - selectedAmount)
						end
						createNewItem(hoverSlot, clonedItem["ID"], clonedItem["id"], clonedItem["value"], selectedAmount, clonedItem["duty"])
					end
					hideClone()
				end
			elseif (movedSlot > -1 and movedItem and hoverItem and hoverSlot > -1 and hoverItem["id"] == movedItem["id"] and hoverSlot ~= movedSlot and inItem and inMove and items[movedItem["id"]].stackable) then
			itemBugFixOn()
				if isSlotUsedByAction(hoverSlot) then outputChatBox("#FF0000[Error]: #ffffffEsse item já está sendo usado", 255,255,255,true) hideMove() return end
				if guiGetText(amountBox) == "" then
					setItemCount(hoverSlot, hoverItem["count"] + movedItem["count"])
					delItem(movedSlot)
				else
					if hoverItem["id"] == clonedItem["id"] then
						if clonedItem["count"] >= selectedAmount then
							setItemCount(movedSlot, movedItem["count"] - selectedAmount)
							setItemCount(hoverSlot, hoverItem["count"] + selectedAmount)
							if clonedItem["count"] == 0 then
								delItem(clonedSlot)
							end
						end
						hideClone()
					end
				end
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(clickedElement) == "vehicle" and getElementData(clickedElement, "ID") > 0) and not isCursorInAction then
			    if (getElementModel(clickedElement) == 509 or getElementModel(clickedElement) == 481 or getElementModel(clickedElement) == 510) then return end
				if not (isVehicleLocked(clickedElement)) then
					if movedItem["duty"] >= 1 or movedItem["id"] == 66 or movedItem["id"] == 70 or movedItem["id"] == 80 or movedItem["id"] == 84 or movedItem["id"] == 86 or movedItem["id"] == 87 or movedItem["id"] == 96 then
						outputChatBox("#FF0000[Error]: #ffffffVocê não pode mover esse objeto",255,255,255,true)
					else
						if isPedInVehicle(localPlayer) then return end
						if getDistanceFromElement(elementSource, clickedElement) < 3 then
							itemBugFixOn()
							me("colocou um(a): "..items[movedItem["id"]].name .." no porta-malas")
							triggerServerEvent("tradeItem", localPlayer, localPlayer, clickedElement, elementSource, movedItem)
						end
					end
				else
					outputChatBox("#4169E1[Error]: #ffffffO veículo selecionado está fechado",255,255,255,true)
				end
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(clickedElement) == "player" and getElementData(clickedElement, "ID") > 0) and not isCursorInAction and clickedElement ~= localPlayer then		
				if movedItem["duty"] >= 1 then
					outputChatBox("#4169E1[Error]: #ffffffVocê não pode mover esse objeto",255,255,255,true)
			else
				if getDistanceFromElement(elementSource, clickedElement) < 5 then
					if movedItem["id"] == 76 then
					    triggerServerEvent("chat.me", localPlayer, localPlayer, "apresenta seu rg")
						triggerServerEvent("onServerShowDocument", localPlayer, localPlayer, clickedElement, 1)
					elseif movedItem["id"] == 111 then
						triggerServerEvent("chat.me", localPlayer, localPlayer, "apresenta sua cnh")
						triggerServerEvent("onServerShowDocument", localPlayer, localPlayer, clickedElement, 2)
					else
					    itemBugFixOn()
						me("enviou para: "..string.gsub(getPlayerName(clickedElement), "-", "").." um(a): "..items[movedItem["id"]].name .."")
						triggerServerEvent("itemAnim",localPlayer,localPlayer,clickedElement)
						triggerServerEvent("tradeItem", localPlayer, localPlayer, clickedElement, elementSource, movedItem)
						triggerServerEvent("getElementItems", localPlayer, clickedElement, clickedElement, 2)
						end
					end
				end
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(clickedElement) == "object") and getElementModel(clickedElement) == 1359 and clickedElement ~= localPlayer and not isCursorInAction then		
				if getDistanceFromElement(elementSource, clickedElement) < 5 then
					triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				end
		elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(clickedElement) == "ped") and getElementData(clickedElement, "weaponPed") and clickedElement ~= localPlayer and not isCursorInAction then
				if movedItem["id"] == 130 and getElementData(clickedElement, "givedItem1") == false then
				    setElementData(clickedElement, "givedItem1", true)
					triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 131 and getElementData(clickedElement, "givedItem2") == false then
				    setElementData(clickedElement, "givedItem2", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 132 and getElementData(clickedElement, "givedItem3") == false then
				    setElementData(clickedElement, "givedItem3", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 133 and getElementData(clickedElement, "givedItem4") == false then
				    setElementData(clickedElement, "givedItem4", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 134 and getElementData(clickedElement, "givedItem5") == false then
				    setElementData(clickedElement, "givedItem5", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 135 and getElementData(clickedElement, "givedItem6") == false then
				    setElementData(clickedElement, "givedItem6", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 136 and getElementData(clickedElement, "givedItem7") == false then
				   setElementData(clickedElement, "givedItem7", true)
				    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 137 and getElementData(clickedElement, "givedItem8") == false then
				    setElementData(clickedElement, "givedItem8", true)
                    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil
				elseif movedItem["id"] == 138 and getElementData(clickedElement, "givedItem9") == false then
				    setElementData(clickedElement, "givedItem9", true)
                    triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, movedItem["ID"])
					inventoryItems[activeSide][movedSlot] = nil		
		        end	
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(elementSource) == "object") and clickedElement == localPlayer and not isCursorInAction then		
				if getDistanceFromElement(elementSource, clickedElement) < 5 then
				    itemBugFixOn()
					triggerServerEvent("tradeItem", localPlayer, localPlayer, localPlayer, elementSource, movedItem)
				end
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(elementSource) == "vehicle") and clickedElement == localPlayer and not isCursorInAction then		
				if getDistanceFromElement(elementSource, clickedElement) < 5 then
				    itemBugFixOn()
					triggerServerEvent("tradeItem", localPlayer, localPlayer, localPlayer, elementSource, movedItem)
					me("retirou um(a): "..items[movedItem["id"]].name .." do porta-malas")
				end
			elseif (movedSlot > -1 and movedItem and not inAction and inMove and not inItem and clickedElement and getElementType(clickedElement) == "object") and getElementData(clickedElement, "szef") and clickedElement ~= localPlayer and not isCursorInAction then		
				if movedItem["duty"] >= 1 then
					outputChatBox("#FF0000[Error]: #ffffffEsse objeto não pode ser movido",255,255,255,true)
				else
					if getDistanceFromElement(elementSource, clickedElement) < 5 then
						if hasItem(129,getElementData(clickedElement, "ID")) then
						    itemBugFixOn()
							triggerServerEvent("tradeItem", localPlayer, localPlayer, clickedElement, elementSource, movedItem)
						else
							outputChatBox("#FF0000[Error]: #ffffffVocê não tem a chave para esse cofre",255,255,255,true)
						end
					end
				end
			end
			hideMove()
		elseif (pButton == "right" and pState == "down" and showInventory and not inMove and movedSlot < 0) then
			if hoverSlot >=1 then
				if hoverItem then
					if elementSource == localPlayer then
					    itemBugFixOn()
						useItem(hoverItem,hoverSlot)
					end
				end
			end
		elseif (pButton == "right" and pState == "down") then
			if (clickedElement and getElementType(clickedElement) == "vehicle" and tonumber(getElementData(clickedElement, "ID") or 0) > 0) then -- carro
			itemBugFixOn()
				if getDistanceFromElement(localPlayer, clickedElement) < 5 then
					if isPedInVehicle(localPlayer) then return end
					if (getElementModel(clickedElement) == 509 or getElementModel(clickedElement) == 481 or getElementModel(clickedElement) == 510) then return end
					if (isVehicleLocked(clickedElement)) then
						outputChatBox("#4169E1[SERVER NAME]: #ffffffO porta-mala do veículo selecionado está fechado",255,255,255,true)
					else
						if getElementData(clickedElement,"veh:use") then
							outputChatBox("#4169E1[SERVER NAME]: #ffffffO porta-mala do veículo selecionado está em uso",255,255,255,true)
						else
							invMenu = 1
							activeSide = "bag"
							openInventory(clickedElement)
							triggerServerEvent("doorState", clickedElement, clickedElement, 1)
						end
					end
				end
			end
			if (clickedElement and getElementType(clickedElement) == "object" and tonumber(getElementData(clickedElement, "ID") or 0) > 0) and getElementModel(clickedElement) == 2332 then -- cofre
				if getDistanceFromElement(localPlayer, clickedElement) < 5 then
					if hasItem(129,getElementData(clickedElement, "ID")) then
						invMenu = 1
						activeSide = "bag"
						openInventory(clickedElement)
					else
						outputChatBox("#4169E1[SERVER NAME]: #ffffffVocê não tem a chave para esse cofre",255,255,2555,true)
					end
				end
			end
			
		    if (clickedElement and (getElementModel(clickedElement) == 509 or getElementModel(clickedElement) == 481 or getElementModel(clickedElement) == 510) and activeBikeLockSlot > 0) then
				if getElementData(clickedElement, "veh.locked") == 0 then
				    if getElementData(clickedElement, "veh.owner") == getElementData(localPlayer, "ID") then
					itemBugFixOn()
					triggerServerEvent("onServerBikeLockStateChange", localPlayer, clickedElement, false)
					--exports.vz_vehicle:parkVehicle(clickedElement)
					delItem(activeBikeLockSlot)
					activeBikeLockSlot = -1
						if not hasItem(78,getElementData(clickedElement, "ID")) then
						giveItem(78, getElementData(clickedElement, "ID"), 1, 0)
						end
					else
					exports.vz_info:showBox("Essa não é a sua moto/bike", "error")
					end
				   else
					exports.vz_info:showBox("A moto/bike já está fechada", "error")
					activeBikeLockSlot = -1
				end
			else
            activeBikeLockSlot = -1			
			end
			if (clickedElement and (getElementModel(clickedElement) == 509 or getElementModel(clickedElement) == 481 or getElementModel(clickedElement) == 510) and activeBikeLockKeySlot > 0) then
				if getElementData(clickedElement, "veh.locked") == 1 then
				    if hasItem(78,getElementData(clickedElement, "ID")) then
					itemBugFixOn()
					triggerServerEvent("onServerBikeLockStateChange", localPlayer, clickedElement, false)
					giveItem(75, 1, 1, 0)
					activeBikeLockKeySlot = -1
					else
					exports.vz_info:showBox("Você não tem a chave para bloquear essa moto/bike", "error")
					end
				   else
					exports.vz_info:showBox("A moto/bike não está fechada", "error")
					activeBikeLockKeySlot = -1
				end
			else
            activeBikeLockKeySlot = -1			
			end
            if (clickedElement and getElementType(clickedElement) == "player") and localPlayer ~= clickedElement then
				if getElementData(clickedElement, "char.cuff") or getElementData(clickedElement, "handsUp") then
				    itemBugFixOn()
                    addEventHandler("onClientRender", getRootElement(), bodySearch)
					bodySearchTarget = clickedElement
					bodysearch_progress_text = "Em andamento"
					bodySearchState = true
				   else
					exports.vz_info:showBox("O jogador não está algemado ou levantando a mão", "error")
				end	
			end
		elseif (pButton == "left" and pState == "down") then
		    if (clickedElement and getElementType(clickedElement) == "player" and activeCuffSlot > 0) then
				if getElementData(clickedElement, "char.cuff") == false then
				    itemBugFixOn()
					triggerServerEvent("cuffPlayer", getLocalPlayer(), getLocalPlayer(), clickedElement)
					activeCuffSlot = -1
				   else
					exports.vz_info:showBox("O jogador já está algemado", "error")
				end
			else
            activeCuffSlot = -1			
			end
			if (clickedElement and getElementType(clickedElement) == "player" and activeCuffKeySlot > 0) then
			   if getElementData(clickedElement, "char.cuff") then
			    itemBugFixOn()
				triggerServerEvent("cuffPlayer", getLocalPlayer(), getLocalPlayer(), clickedElement)
				activeCuffKeySlot = -1
			   else
				exports.vz_info:showBox("O jogador não está algemado", "error")
			   end
			else
            activeCuffKeySlot = -1	
			end

		elseif (pState == "up") then
			if bodySearchState then
			removeEventHandler("onClientRender", getRootElement(), bodySearch)
			bodySearchState = false
		    bodysearch_progress_tick = 0
		    bodysearch_progress_text = ""
			end
		end
	end
)

function bodySearch()
	bodysearch_progress_tick = bodysearch_progress_tick + 1
	bodySearchProgress() 
	if bodysearch_progress_tick >= bodysearch_progress_max then 
	    removeEventHandler("onClientRender", getRootElement(), bodySearch)
		openInventory(bodySearchTarget)
		bodySearchInventoryOpened = true
		bodySearchState = false
		bodysearch_progress_tick = 0
		bodysearch_progress_text = ""
	end
end

function bodySearchProgress()
if bodySearchState then 
	dxDrawRectangle(sX/2 - panelSize[1]/2, sY - panelSize[2]-65, panelSize[1], panelSize[2]-13,tocolor(0, 0, 0,100),false)
	dxDrawRectangle(sX/2 - panelSize[1]/2, sY - panelSize[2]-65, bodysearch_progress_tick, panelSize[2]-13,tocolor(254, 119, 29,180), true)
	dxCreateBorder(sX/2 - panelSize[1]/2, sY - panelSize[2]-66, panelSize[1], panelSize[2]-13,tocolor(0,0,0,255),false)
	dxDrawText(bodysearch_progress_text, sX/2 - panelSize[1]/2 + panelSize[1]/2, sY - panelSize[2]-80 +panelSize[2]/2 , sX/2 - panelSize[1]/2 + panelSize[1]/2, sY - panelSize[2]-80 +panelSize[2]/2, tocolor(255, 255, 255, 204), 0.5, font_progress, "center", "center", false, false, false, true)
	end
end

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+1,1,color)
	dxDrawRectangle(x,y+1,1,h,color)
	dxDrawRectangle(x+1,y+h,w,1,color)
	dxDrawRectangle(x+w,y+1,1,h,color)
end

function removeDecimal(number)
    local num = number
    local num2 = tostring(num)
    local found = nil
    for i=1,100000 do
        if string.sub(num2,i,i) == "." then
            found = i
        end
    end
    if type(found) == "number" then
        num2 = string.sub(num2,1,found-1)
    end
    num = tonumber(num2)
    return num
end

addEventHandler("onClientGUIChanged", getRootElement(),function()
	if source == amountBox  then
		local currentAmount = guiGetText (source)
		if string.len(currentAmount) > 0 then
			local am = tonumber(currentAmount)
			if am then
				selectedAmount = removeDecimal(am)
			else
				guiSetText(source, currentAmount)
			end
		else
			--guiSetText(source, 0)
			--selectedAmount = 0
		end
	end
end)

addCommandHandler("revistar", function(c, target)
	if tonumber(getElementData(localPlayer, "char.adminlevel") or 0) >= 9 then
	local targetPlayer, targetPlayerName = exports.vz_main:findPlayerByPartialNick(localPlayer, target)
	outputChatBox("#4169E1[Use]#FFFFFF /revistar [ID]", 255, 255, 255, true)
	if (targetPlayer) then
		openInventory(targetPlayer)
		end
	end
end)

function createNewItem(newSlot, itemDBID, itemID, itemValue, itemCount, itemDuty)
	if (newSlot > -1 and itemDBID and itemID and itemValue and itemCount and itemDuty) then
		triggerServerEvent("createNewItem", localPlayer, localPlayer, elementSource, itemID, newSlot,itemCount)
	end
end

function setItemCount(itemSlot, newCount)
	if (itemSlot > -1 and newCount > -1) then
		if activeSide == "craft" then
			newMenu = "bag"
		else
			newMenu = activeSide
		end
		triggerServerEvent("updateItemCount", localPlayer, localPlayer, elementSource, itemSlot, newCount, inventoryItems[newMenu][itemSlot]["ID"])

		inventoryItems[newMenu][itemSlot]["count"] = newCount
		if (elementSource == localPlayer) then
			playerItems[newMenu][itemSlot]["count"] = newCount
		end
	end
end

function setItemValue(itemSlot, newValue)
	if (itemSlot > -1 and newValue > -1) then
		if activeSide == "craft" then
			newMenu = "bag"
		else
			newMenu = activeSide
		end
        triggerServerEvent("updateItemValue", localPlayer, localPlayer, elementSource, itemSlot, newValue, inventoryItems[newMenu][itemSlot]["ID"])
		inventoryItems[newMenu][itemSlot]["value"] = newValue
		if (elementSource == localPlayer) then
			playerItems[newMenu][itemSlot]["value"] = newValue
		end
	end
end

function delItemSlot(itemSlot)
	if (itemSlot > -1) then
		inventoryItems[activeSide][itemSlot] = nil
		saveAction()
		if (elementSource == localPlayer) then
			playerItems[activeSide][itemSlot] = nil
		end		
	end
end

function getAllItemWeight()
	local bagWeight = 0
	local keyWeight = 0
	local cardsWeight = 0
	for i = 1, row * column do
		if (playerItems["bag"][i]) then
			bagWeight = bagWeight + (getItemWeight(playerItems["bag"][i]["id"]) * playerItems["bag"][i]["count"])
		end
	end
	for i = 1, row * column do
		if (playerItems["key"][i]) then
			keyWeight = keyWeight + (getItemWeight(playerItems["key"][i]["id"]) * playerItems["key"][i]["count"])
		end
	end
	for i = 1, row * column do
		if (playerItems["cards"][i]) then
			cardsWeight = cardsWeight + (getItemWeight(playerItems["cards"][i]["id"]) * playerItems["cards"][i]["count"])
		end	
	end
	return bagWeight + cardsWeight + keyWeight
end

function delItem(itemSlot)
	if (itemSlot > -1) then
		if activeSide == "craft" then
			newMenu = "bag"
		else
			newMenu = activeSide
		end
		
		triggerServerEvent("deleteItem", localPlayer, localPlayer, elementSource, inventoryItems[newMenu][itemSlot]["ID"])
		saveAction()
		inventoryItems[newMenu][itemSlot] = nil
		if (elementSource == localPlayer) then
			playerItems[newMenu][itemSlot] = nil
		end	
	end
end

function takeStatus(itemID, statusMinus)
	if (itemID > -1) then
		local haveItem, _, _, itemSlot, itemType = hasItem(itemID)
		if haveItem then
			if tonumber(inventoryItems["bag"][itemSlot]["health"]) - tonumber(statusMinus) <= 0 then
				triggerServerEvent("deleteItem", localPlayer, localPlayer, localPlayer, inventoryItems[itemType][itemSlot]["ID"])
				if itemID == 141 then
				    giveItem(142, 1, 1, 0)
				end
				inventoryItems[itemType][itemSlot] = nil
				if (elementSource == localPlayer) then
					playerItems[itemType][itemSlot] = nil
				end	
				return
			else
				triggerServerEvent("takeStatus", localPlayer, localPlayer, localPlayer, inventoryItems["bag"][itemSlot]["ID"], tonumber(inventoryItems["bag"][itemSlot]["health"]) - statusMinus)
				inventoryItems["bag"][itemSlot]["health"] = tonumber(inventoryItems["bag"][itemSlot]["health"]) - statusMinus
				return
			end	
		end
	end
end

function takeItem(itemID)
	if (itemID > -1) then
		local haveItem, _, _, itemSlot, itemType = hasItem(itemID)
		if haveItem then
			triggerServerEvent("deleteItem", localPlayer, localPlayer, localPlayer, inventoryItems[itemType][itemSlot]["ID"])
			inventoryItems[itemType][itemSlot] = nil
			if (elementSource == localPlayer) then
				playerItems[itemType][itemSlot] = nil
			end	
		end	
	end
end
addEvent("takeItemServer",true)
addEventHandler("takeItemServer",getRootElement(),takeItem)

function setItemSlot(oldSlot, newSlot)
	if (oldSlot > -1 and newSlot > -1) then
		inventoryItems[activeSide][newSlot] = inventoryItems[activeSide][oldSlot]
		if (elementSource == localPlayer) then
			playerItems[activeSide][newSlot] = inventoryItems[activeSide][oldSlot]
		end
		triggerServerEvent("updateItemSlot", localPlayer, localPlayer, elementSource, newSlot, inventoryItems[activeSide][oldSlot])
	end
end

function hideMove()
	startTick = -1
	movedItem = nil
	movedSlot = -1
	inMove = false
end

function hideClone()
	clonedItem = nil
	clonedSlot = -1
	inClone = false
end

function hasActionItem(actionItem)
	hasTheItem = false
	if (actionItem) then
		if (playerItems["bag"] and playerItems["key"] and playerItems["cards"]) then
			for i = 1, row * column do
				if (playerItems["bag"][i]) then
					if (actionItem["ID"] == playerItems["bag"][i]["ID"]) then
						hasTheItem = true
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["key"][i]) then
					if (actionItem["ID"] == playerItems["key"][i]["ID"]) then
						hasTheItem = true
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["cards"][i]) then
					if (actionItem["ID"] == playerItems["cards"][i]["ID"]) then
						hasTheItem = true
					end
				end	
			end
			if hasTheItem then
				return true
			else
				return false
			end
			return false
		end
		return false
	end
	return false
end

function giveItem(itemID, itemValue, itemCount, itemDuty)
	triggerServerEvent("giveItem", localPlayer, localPlayer, itemID, itemValue, itemCount, itemDuty)
end

function hasItem(itemID, itemValue)
	if (not itemValue) then
		if (playerItems["bag"] and playerItems["key"] and playerItems["cards"]) then
			for i = 1, row * column do
				if (playerItems["bag"][i]) then
					if (itemID == playerItems["bag"][i]["id"]) then
						return true, itemID, itemValue, i, "bag", countItemsInInventory(itemID),playerItems["bag"][i]["count"]
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["key"][i]) then
					if (itemID == playerItems["key"][i]["id"]) then
						return true, itemID, itemValue, i, "key"
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["cards"][i]) then
					if (itemID == playerItems["cards"][i]["id"]) then
						return true, itemID, itemValue, i, "cards"
					end
				end	
			end
			return false
		end
		return false
	else
		if (playerItems["bag"] and playerItems["key"] and playerItems["cards"]) then
			for i = 1, row * column do
				if (playerItems["bag"][i]) then
					if (itemID == playerItems["bag"][i]["id"] and tonumber(itemValue) == tonumber(playerItems["bag"][i]["value"])) then
						return true, itemID, tonumber(itemValue), i
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["key"][i]) then
					if (itemID == playerItems["key"][i]["id"] and tonumber(itemValue) == tonumber(playerItems["key"][i]["value"])) then
						return true, itemID, tonumber(itemValue), i
					end
				end
			end
			for i = 1, row * column do
				if (playerItems["cards"][i]) then
					if (itemID == playerItems["cards"][i]["id"] and tonumber(itemValue) == tonumber(playerItems["cards"][i]["value"])) then
						return true, itemID, tonumber(itemValue), i
					end
				end	
			end
			return false
		end
		return false
	end
	return false
end

function countItemsInInventory(itemID, count)
	if (playerItems["bag"]) then
		local count = 0
		for i = 1, row * column do
			if (playerItems["bag"][i]) then
				if (itemID == playerItems["bag"][i]["id"]) then
					count = count + 1
				end
			end
		end
		return count
	end
	return false
end

function hasItemOnSlot(slot)
	if (playerItems["bag"][slot] and tonumber(playerItems["bag"][slot]["id"] or -1) > -1) then
		return true
	end
	return false
end

function isSlotUsedByAction(slot)
	if getElementType(elementSource) ~= "player" then return false end
	for k, v in ipairs(action_array) do
		if v[1] == slot and v[3] == activeSide then
			return true
		end
	end
	return false
end

function loadActionItems()
	if not fileExists("action.json") then
		local createFile = fileCreate("action.json")
		if createFile then
			for k=1, actionSlots do
				fileWrite(createFile, toJSON({-1, -1, "bag"}) .. " | ")
			end
			fileClose(createFile) 		
		end
	else
		setTimer(function()
			local hFile = fileOpen("action.json", true)
			if hFile then 
				local buffer
				while not fileIsEOF(hFile) do
					buffer = fileRead(hFile, 500)
					local splitted_result = split(buffer, " | ")
					for k, v in ipairs(splitted_result) do
						local data = fromJSON(string.gsub(v, " ", ""))
						if data then
							action_array[k] = {tonumber(data[1]), tonumber(data[2]), tostring(data[3])}
						end
					end
				end
				fileClose(hFile)
			end
		end, 200, 1)
	end
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function saveAction()
	if fileExists("action.json") then
		fileDelete("action.json")
		local createFile = fileCreate("action.json")
		if createFile then
			for k, v in ipairs(action_array) do
				fileWrite(createFile, toJSON({v[1] , v[2], v[3]}) .. " | ")
			end
			fileClose(createFile) 		
		end
	end
end

function isInBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*sX, cursorY*sY
		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
			return true
		else
			return false
		end
	end	
end

function getDistanceFromElement(from, to)
	if not from or not to then return end
	local x, y, z = getElementPosition(from)
	local x1, y1, z1 = getElementPosition(to)
	return getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
end

addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(),function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	local activeItemID = getElementData(localPlayer,"active:itemID")
	local activeitemSlot = getElementData(localPlayer,"active:itemSlot")
	if(activeItemID>-1) and (activeitemSlot>-1) then
		local witem = tonumber(getElementData(localPlayer,"active:itemID"))
		local wslot = tonumber(getElementData(localPlayer,"active:itemSlot"))
		if (items[witem].isWeapon) then
			if(tonumber(playerItems["bag"][wslot]["count"] or -1)<=1)then
				activeWeaponSlot = -1
				activeAmmoSlot = - 1
				delItem(wslot)
				setElementData(localPlayer,"active:itemID",-1)
				setElementData(localPlayer,"active:itemSlot",-1)
			else
				setItemCount(wslot,playerItems["bag"][wslot]["count"]-1)
			end
		end
	end
end)

addEvent("activeWeapon",true)
addEventHandler("activeWeapon",getRootElement(),function(slot)
	activeWeaponSlot = slot
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	receiveOnStart()
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	saveConfigFile()
end)

local config = {}
function createConfigFile()
	local RootNode = xmlCreateFile("config.xml","action")
	local Newcode = xmlCreateChild(RootNode, "data")
	xmlNodeSetAttribute(Newcode, "pos1", sX/2-(300/2))
	xmlNodeSetAttribute(Newcode, "pos2", sY/2-(80/2)+375)
	xmlSaveFile(RootNode)
end

function saveConfigFile()
	local RootNode = xmlCreateFile("config.xml","action")
	local Newcode = xmlCreateChild(RootNode, "data")
	xmlNodeSetAttribute(Newcode, "pos1", math.round(actPos[1]))
	xmlNodeSetAttribute(Newcode, "pos2", math.round(actPos[2]))
	xmlSaveFile(RootNode)
end

function receiveOnStart()
	local file = xmlLoadFile ( "config.xml" )
	local data = xmlFindChild ( file, "data", 0 )
	if file then
		if data then
			local wtf = xmlNodeGetAttributes ( data )
			actPos = {tonumber(wtf.pos1), tonumber(wtf.pos2)}
		end
	else
		createConfigFile()
		receiveOnStart()
	end
end

function move()
	if getKeyState("mouse1") and isCursorShowing() then
		local mx, my = getCursorPosition()
		local mx, my = mx*sX, my*sY
		actPos[1] = mx-m[1]
		actPos[2] = my-m[2]
	else
		removeEventHandler("onClientRender", root, move)
		moving = false
	end
end

function moveAction(b, s)
	if getElementData(localPlayer, "showHUD") == 1 then
		if b == "left" and s == "down" then
			if inbox(actPos[1], actPos[2], 300, 80) then
				local mx, my = getCursorPosition()
				local mx, my = mx*sX, my*sY
			
				m = {mx-actPos[1], my-actPos[2]}
				moving = true
				addEventHandler("onClientRender", root, move)
			end
		elseif b == "right" and s == "down" then
		if inbox(actPos[1], actPos[2], 300, 80) then
			if not moving then
				actPos = {sX/2-(300/2), sY-50}
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, moveAction)

function resetAction()
if not moving then
	    actPos = {sX/2-(300/2), sY-50}
	end
end
addCommandHandler("resetaction", resetAction)

function inbox(sx, sy, bx, by)
	if not isCursorShowing() then return false end
	local mx, my = getCursorPosition()
	mx, my = mx*sX, my*sY
	bx = sx+bx
	by = sy+by
	return sx <= mx and bx >= mx and sy <= my and by >= my
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function itemBugFixOn()
toggleAllControls(false)
showCursor(false)
itemBugFixOnOff = true
triggerServerEvent("itemBugFixServer", localPlayer, localPlayer)
end

addEvent("itemBugFixClient",true)
addEventHandler("itemBugFixClient", getRootElement(), function(player)
    toggleAllControls(true)
	showCursor(true)
	itemBugFixOnOff = false
end)

addEventHandler("onClientPlayerNetworkStatus", getRootElement(),
    function(status)
        if tonumber(status) == 0 then
            toggleAllControls(false)
			showCursor(false)
			guiSetInputEnabled(true)
            triggerServerEvent("sendBugMessageToAdmins", localPlayer, localPlayer)
        else
            toggleAllControls(true)
			guiSetInputEnabled(false)
        end
    end 
)