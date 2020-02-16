-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local s = {guiGetScreenSize()}
local box = {36,36}
local panel = {s[1]/2 -box[1]/2,s[2]/1.25 - box[2]/1.25}
local barItem = 0
local barNum = 0
local barShow = false
local barSize = 98
local barHealth = 0
local newAmount = 0
local hasznalhat = false

function me(me)
	triggerServerEvent("chat.me", localPlayer, localPlayer, me)
end

function itemBar(num,itemID,health)
	barShow = true
	barItem = itemID
	barNum = num
	barHealth = health
	newAmount = (barHealth/10) /2
	triggerServerEvent("attachItemPlayer",localPlayer,localPlayer,items[itemID].object)
end

addEventHandler("onClientRender",getRootElement(),function()
	if barShow == true then
		dxDrawRectangle(panel[1],panel[2],36+6,36+6,tocolor(0,0,0,140))
		dxDrawImage(panel[1] + 3,panel[2] + 3,36,36,getItemImg(barItem))
		
		dxCreateBorder(panel[1]-32,panel[2]+60,100,6,tocolor(0,0,0,180))
		dxDrawRectangle(panel[1]-32,panel[2]+60,100,6,tocolor(0,0,0,90))
		dxDrawRectangle(panel[1]-30,panel[2]+62,barSize,5,tocolor(208,101,29,250))
	end
end)

function hungBarClick(button, state)
	cancelEvent()
	if barShow == true then
		if button == "right" and state == "down" then
			if isInSlot(panel[1],panel[2],36,36) then
				if isTimer(hungTimer) then return end
				hungTimer = setTimer(function() end, 4000, 1)
				if getElementData(localPlayer, "char.hunger") == 100 then 
					exports.vz_info:showBox("Você não precisa comer/beber", "error")
					return false
				elseif getElementData(localPlayer, "char.hunger") + newAmount > 100 then
					setElementData(localPlayer, "char.hunger", 100)
					return true
				end 
				
				barSize = barSize-14
				if barNum == 1 then
					setElementData(localPlayer,"char.hunger",getElementData(localPlayer,"char.hunger")+newAmount)
					triggerServerEvent("itemAnims",localPlayer,localPlayer,1)
				elseif barNum == 2 then
					setElementData(localPlayer,"char.hunger",getElementData(localPlayer,"char.hunger")+(newAmount/2))
					triggerServerEvent("itemAnims",localPlayer,localPlayer,2)
				end
				if barSize <= 1 then
					triggerServerEvent("detachItemPlayer",localPlayer,localPlayer)
					barShow = false
					barSize = 98
				end
			end
		elseif button == "left" and state == "down" then
			if isInSlot(panel[1],panel[2],36,36) then
				barShow = false
				barSize = 98
				triggerServerEvent("detachItemPlayer",localPlayer,localPlayer)
			end
		end
	end
end
addEventHandler("onClientClick", root, hungBarClick)

function table.random(theTable)
    return theTable[math.random(#theTable)]
end

local randomGifts = {"84", "86", "80", "70", "15", "96", "66", "84", "80", "70", "86", "70", "96"}

function useItem(itemData,itemSlot)
	if (itemData) then
			if (itemData["id"] < 10 and itemData["id"] > 0) or itemData["id"] == 116 or itemData["id"] == 117 or itemData["id"] == 118 or itemData["id"] == 120 then -- kaják
				if not barShow then
					itemBar(1,itemData["id"],itemData["health"])
					if (itemData["count"] - 1 > 0) then
						setItemCount(itemSlot, itemData["count"] - 1)
					else
						delItem(itemSlot)
					end
				end
			elseif (itemData["id"] < 16 and itemData["id"] > 9) or itemData["id"] == 73 or itemData["id"] == 74 or itemData["id"] == 77 or itemData["id"] == 119 then -- piák
				if not barShow then
					itemBar(2,itemData["id"],itemData["health"])
					if (itemData["count"] - 1 > 0) then
						setItemCount(itemSlot, itemData["count"] - 1)
					else
						delItem(itemSlot)
					end
				end
			elseif itemData["id"] == 25 then
				if (itemData["value"] - 1 > 0) then
						setItemValue(itemSlot, itemData["value"] - 1)
						giveItem(26, 10, 10, 0)
					else
						delItem(itemSlot)
						giveItem(26, 10, 10, 0)
				end
			elseif itemData["id"] == 70 then
				setElementData(localPlayer, "char.diamante", getElementData(localPlayer, "char.diamante") + 200)
				exports.vz_info:showBox("Card Diamante -1","info")
				delItem(itemSlot)
			elseif itemData["id"] == 68 then
				setElementData(localPlayer, "char.money", getElementData(localPlayer, "char.money") + 5000)
				exports.vz_info:showBox("Sacola de Dinheiro -1","info")
				delItem(itemSlot)
			--elseif itemData["id"] == 81 then
		       -- if getElementInterior(localPlayer) == 0 or getElementDimension(localPlayer) == 0 then
			      --  outputChatBox("#4169E1[SERVER NAME] #ffffffEsse não é o lugar de plantação", 255,255,255, true)
		       -- else
			       -- exports["vz_plantacao"]:createPlantC(getLocalPlayer(),1)
			      --  delItem(itemSlot)
		        --end
			elseif itemData["id"] == 24 then
		        if getElementInterior(localPlayer) == 0 or getElementDimension(localPlayer) == 0 then
                outputChatBox("#4169E1[SERVER NAME] #ffffffVocê não pode fazer ligação direta na rua", 255,255,255, true)
				else
		        triggerEvent("LIGACAO:DIRETA:ANDAMENTO", root, localPlayer)
				end
			--elseif itemData["id"] == 18 then
				--exports['vz_pescador']:createStick(itemSlot)
				--if not getElementData(localPlayer, "char:fishing"..itemSlot) then
					--setElementData(localPlayer, "char:fishing"..itemSlot, true)
				--else
					--setElementData(localPlayer, "char:fishing"..itemSlot, false)
				--end
			elseif itemData["id"] == 71 then
				if getElementData(localPlayer, "Distintivo") == false then
				   setElementData(localPlayer, "Distintivo", true)
				   exports.vz_info:showBox("Você colocou seu destintivo","info")
				else
				   exports.vz_info:showBox("Você retirou seu destintivo","info")
				   setElementData(localPlayer, "Distintivo", false)
				end
			elseif itemData["id"] == 19 then
				if getElementData(localPlayer, "nameMask") == false then
				   setElementData(localPlayer, "nameMask", true)
				   exports.vz_info:showBox("Você colocou sua mascara","info")
				else
				   exports.vz_info:showBox("Você retirou sua mascara","info")
				   setElementData(localPlayer, "nameMask", false)
				end
			--elseif itemData["id"] == 20 then
				--local strin = getElementData(localPlayer, "char:phoneState")
				--if strin == true then
					--setElementData(localPlayer, "char:phoneState", false)
					
				--else
					--setElementData(localPlayer, "char:phoneState", true)
					--exports["mta_phone"]:showPhoneFunction(itemSlot)
				--end
			elseif itemData["id"] == 21 then
				outputChatBox("#4169E1[Use]:#ffffff /y [Texto].", 255,255,255,true)	
			elseif itemData["id"] == 26 then
				if hasItem(27) then
					triggerServerEvent("onSmokeEffect", localPlayer, localPlayer)
					delItem(itemSlot)
				end	
			elseif itemData["id"] == 76 then	
				triggerEvent("onClientShowDocument", root, localPlayer, 1)
			elseif itemData["id"] == 111 then	
				triggerEvent("onClientShowDocument", root, localPlayer, 2)	
			elseif itemData["id"] == 66 then
			    local veh = getPedOccupiedVehicle(localPlayer)
				if veh then
				    fixVehicle(veh)
		            setElementData(veh, "veh.engineCrash", 0)
					setVehicleDamageProof(veh, false)
					exports.vz_info:showBox("Você usou um Kit Reparo","info")
				    delItem(itemSlot)	
				else
					exports.vz_info:showBox("Para usar esse item você precisa estar dentro de um veiculo","error")
				end
			elseif itemData["id"] == 80 then
				local veh = getPedOccupiedVehicle(localPlayer)
				if veh then
				    setElementData(veh, "veh.fuelData", 20)
					exports.vz_info:showBox("Você usou um galão de combustivel","info")
				    delItem(itemSlot)	
				else
                    exports.vz_info:showBox("Para usar esse item você precisa estar dentro de um veiculo","error")
				end
			elseif itemData["id"] == 84 then
			    if isPedDead(localPlayer) then
					setCameraTarget(localPlayer, localPlayer)
					triggerServerEvent("respawnDead", localPlayer, localPlayer)
					setElementHealth(localPlayer, 100)
					exports.vz_info:showBox("Você usou um Kit Medico","info")
				    delItem(itemSlot)
				else
				    exports.vz_info:showBox("Você não está ferido o suficiente","error")
				end
			elseif itemData["id"] == 86 then
			    setElementData(localPlayer, "char.money", getElementData(localPlayer, "char.money") + 500)
				exports.vz_info:showBox("Dinheiro +500","info")
				delItem(itemSlot)	
			--elseif itemData["id"] == 39 then
                --triggerServerEvent("USAR:COLETE", localPlayer, localPlayer)
				--exports.vz_info:showBox("Você agora está de colete a prova de balas","info")
				--delItem(itemSlot)		
			elseif itemData["id"] == 96 then
				setElementData(localPlayer, "char.diamante", getElementData(localPlayer, "char.diamante") + 500)
				exports.vz_info:showBox("Diamante +500","info")
				delItem(itemSlot)
			elseif itemData["id"] == 96 then
				setElementData(localPlayer, "char.diamante", getElementData(localPlayer, "char.diamante") + 500)
				exports.vz_info:showBox("Diamante +500","info")
				delItem(itemSlot)
			elseif itemData["id"] == 115 then
				triggerServerEvent("mikiSapi", localPlayer, localPlayer)
			--elseif itemData["id"] == 38 then
				--activeCuffSlot = itemSlot
				--outputChatBox("#4169E1[SERVER NAME]: #ffffffClique no jogador que você deseja algemar", 255, 255, 255, true)
				--if showInventory then
				    --openInventory(localPlayer)
				--end
			--elseif itemData["id"] == 63 then
				--activeCuffKeySlot = itemSlot
				--outputChatBox("#4169E1[SERVER NAME]: #ffffffClique no jogador que você deseja liberar", 255, 255, 255, true)	
				--if showInventory then
				   -- openInventory(localPlayer)
				--end
			elseif itemData["id"] == 75 then
				activeBikeLockSlot = itemSlot
				outputChatBox("#4169E1[SERVER NAME]: #ffffffClique na bicicleta que deseja colocar", 255, 255, 255, true)
				if showInventory then
				    openInventory(localPlayer)
				end	
			elseif itemData["id"] == 78 then
				activeBikeLockKeySlot = itemSlot
				outputChatBox("#4169E1[SERVER NAME]: #ffffffClique na bicicleta que deseja trancar", 255, 255, 255, true)
				if showInventory then
				    openInventory(localPlayer)
				end
			---elseif itemData["id"] == 139 then
				--exports['ph_ticket']:createTicketPanel(true)
				--if showInventory then
				  --  openInventory(localPlayer)
				--end
			elseif itemData["id"] == 99 then
				 triggerServerEvent("tuzijatek", localPlayer, localPlayer)
			--elseif itemData["id"] == 140 then
				--exports['ph_ticket']:showTicketCard(itemData["value"])
			--elseif itemData["id"] == 141 then
				--exports['ng_newspaper']:showNewsPanel()
				--if showInventory then
				  --  openInventory(localPlayer)
				--end
			--elseif itemData["id"] == 142 then
               -- exports.vz_info:showBox("Esse jornal não é mais válido","error")
			elseif itemData["id"] == 143 then
			        delItem(itemSlot)
					local randomGift = table.random(randomGifts)
					giveItem(tonumber(randomGift), 1, 1, 0)
					outputChatBox("#4169E1[SERVER NAME]: #ffffffVocê abriu a caixa e ganhou um(a): #4169E1"..getItemName(tonumber(randomGift)).."", 255, 255, 255, true)
			elseif items[itemData["id"]].isWeapon then
				if activeWeaponSlot == itemSlot then
					activeWeaponSlot = -1
					activeAmmoSlot = - 1
					--me("elrakott egy fegyvert. ("..getItemName(itemData["id"])..")")
					triggerServerEvent("elveszfegyot", localPlayer, localPlayer,weaponIndexByID[itemData["id"]],itemValue)
					setElementData(localPlayer,"active:weaponSlot",-1)
					setElementData(localPlayer,"active:itemID",-1)
					setElementData(localPlayer,"active:itemSlot",-1)
					setElementData(localPlayer,"handTaser",false)
				elseif activeWeaponSlot == -1 then
					local weaponAmmoBoxID = tonumber(items[itemData["id"]].ammo)
					local statja,itemidje,valueja,slotja,typ,_,darab = hasItem(weaponAmmoBoxID)
					activeWeaponSlot = itemSlot
					if statja then
						activeAmmoSlot = slotja
						triggerServerEvent("adjfgytolivel", localPlayer, localPlayer,weaponIndexByID[itemData["id"]],darab,itemData["value"],true)
						setElementData(localPlayer,"active:weaponSlot",itemSlot)
						setElementData(localPlayer,"active:itemID",itemData["id"])
						setElementData(localPlayer,"active:itemSlot",activeAmmoSlot)
						setElementData(localPlayer,"handTaser",false)
					else							
						triggerServerEvent("adjfgytolivel", localPlayer, localPlayer,weaponIndexByID[itemData["id"]],1,itemData["value"],false)
						setElementData(localPlayer,"active:weaponSlot",itemSlot)
						setElementData(localPlayer,"active:itemID",itemData["id"])
						setElementData(localPlayer,"active:itemSlot",activeAmmoSlot)
						setElementData(localPlayer,"handTaser",false)
					end
				end
			else
				triggerServerEvent("useItem", localPlayer, localPlayer, itemData)
			end

	end
end

local foodItems = {
	[1] = 50,
	[2] = 20,
	[3] = 25,
	[4] = 40,
	[5] = 30,
	[6] = 20,
}

local drinkItems = {
	[7] = 50,
	[8] = 30,
	[9] = 30,
}

local alcoholDrink = {
	[10] = 10,
	[11] = 30,
	[12] = 10,
	[13] = 30,
}

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+2,2,color)
	dxDrawRectangle(x,y+2,2,h,color)
	dxDrawRectangle(x+2,y+h,w,2,color)
	dxDrawRectangle(x+w,y+2,2,h,color)
end

function inBox(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(inBox(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end