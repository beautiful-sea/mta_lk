-- © Créditos: Mods MTA Oficial & Blowiddev 
-- © Site: www.modsmta.com.br 

local itemObjs = {}
local cigarettes = {}

function itemUse(player, data)
	local item_id 	 = tonumber(data["id"] or -1)
	local item_count = tonumber(data["count"] or -1)
	local item_value = tonumber(data["value"] or -1)
	local item_slot = tonumber(data["slot"] or -1)
	
	if item_id > -1 and item_count > -1 and item_value > -1 and item_slot > -1 then
	end
end
addEvent("useItem", true)
addEventHandler("useItem", root, itemUse)

function me(me)
	triggerEvent("chat.me", source, source, me)
end

function modifyItemCount(playerSource, data)
	if data and data["id"] and data["id"] > -1 then
		if data["count"] > 1 then
			local newCount = data["count"] - 1
			updateItemCount(playerSource, playerSource, 0, newCount, data["ID"])	
			getElementItems(playerSource, playerSource, 1)
			getElementItems(playerSource, playerSource, 2)			
		elseif data["count"] == 1 then
			deleteItem(playerSource, playerSource, data["ID"])
			getElementItems(playerSource, playerSource, 1)
			getElementItems(playerSource, playerSource, 2)
		end
	end
end

addEvent("elveszfegyot", true)
addEventHandler("elveszfegyot", getRootElement(),function(playerSource,itemWeap, itemValue)
	takeAllWeapons(playerSource)
	toggleControl(playerSource,"next_weapon",true)
	toggleControl(playerSource,"previous_weapon",true)
end)

addEvent("adjfgytolivel", true)
addEventHandler("adjfgytolivel", getRootElement(),function(playerSource,itemWeap, fegyoammo, itemValue, isAmmo)
	takeAllWeapons(playerSource)
	itemValue = tonumber(itemValue)
	setPedAnimation(playerSource, "COLT45", "sawnoff_reload", 500, false, false, false, false)
	giveWeapon(playerSource, itemWeap, fegyoammo, true)
	
	if isAmmo or getPedWeaponSlot(playerSource) == 1 or getPedWeaponSlot(playerSource) > 9 then
		toggleControl(playerSource, "fire", true)
	else
		toggleControl(playerSource, "fire", false)
	end

	local weapTimer = {}
	weapTimer[playerSource] = setTimer(function()
		toggleControl(playerSource,"next_weapon",false)
		toggleControl(playerSource,"previous_weapon",false)
		killTimer(weapTimer[playerSource])
	end,1000,1)
end)

function attachItemPlayer(playerSource,objID)
	itemObjs[playerSource] = createObject(objID,0,0,0)
	if objID == 2703 then
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,12,0,0.08,0.08,180,0)
	elseif objID == 2769 then
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,12,0,0.05,0.08,0,0)
	elseif objID == 2702 then
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,12,0,0.12,0.08,180,90,180)
	elseif objID == 1546 then
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,11,0,0.05,0.08,90,0,90)
	elseif objID == 2647 then
		setObjectScale(itemObjs[playerSource],0.6)
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,11,0,0.05,0.08,90,0,90)
	elseif objID == 1509 then
		setObjectScale(itemObjs[playerSource],0.8)
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,11,0,0.05,0.08,90,0,90)
	elseif objID == 1664 then
		exports.bone_attach:attachElementToBone(itemObjs[playerSource],playerSource,11,0,0.05,0.08,90,0,90)
	end
end
addEvent("attachItemPlayer",true)
addEventHandler("attachItemPlayer",root,attachItemPlayer)

function itemAnim(element, targetElement)
	setPedAnimation(element,"DEALER","DEALER_DEAL",3000,false,false,false,false)
	setPedAnimation(targetElement,"DEALER","DEALER_DEAL",3000,false,false,false,false)
end
addEvent("itemAnim", true)
addEventHandler("itemAnim", root, itemAnim)

function itemAnims(playerSource, typ)
	if typ == 1 then
		setPedAnimation(playerSource, "FOOD", "eat_pizza", 4000,false,false,false,false)
	elseif typ == 2 then
		setPedAnimation(playerSource, "VENDING", "vend_drink2_p", 4000,false,false,false,false)
	elseif typ == 3 then
		setPedAnimation(playerSource, "SMOKING", "M_smkstnd_loop", 4000,false,false,false,false)
	end
end
addEvent("itemAnims", true)
addEventHandler("itemAnims",root,itemAnims)

function detachItemPlayer(playerSource)
	exports.bone_attach:detachElementFromBone(itemObjs[playerSource])
	destroyElement(itemObjs[playerSource])
	itemObjs[playerSource] = false
end
addEvent("detachItemPlayer",true)
addEventHandler("detachItemPlayer",root,detachItemPlayer)

addEventHandler("onPlayerQuit",getRootElement(),function()
	if (itemObjs[source]) then
		exports.bone_attach:detachElementFromBone(itemObjs[source])
		destroyElement(itemObjs[source])
		itemObjs[source] = nil
	end
end)

function smokeEffect(player)
    if(not isSmoking(player))then
		cigarettes[player] = createObject(3027, 0, 0, 0)
		exports.bone_attach:attachElementToBone(cigarettes[player],player,12,0,0.04,0.15,0,0,90)
		setPedAnimation(player, "SMOKING", "M_smk_in", -1, false, true, true, false)
		outputChatBox("#4169E1[SERVER NAME]: #ffffffUse /fumar para tragar o cigarro",player,255,255,255,true)
		outputChatBox("#4169E1[SERVER NAME]: #ffffffUse /soltar para soltar o cigarro",player,255,255,255,true)
		setElementData(player, "smoking", true)
		smokeTimer = setTimer(function()
			smokeEffect(player)
		end,60000*5,1)
	else
		deleteCigarette(player)
		setPedAnimation(player, "SMOKING", "M_smk_tap", -1, false, true, true, false)
		if isTimer then
		    killTimer(smokeTimer)
	    end
		setTimer(function()
			setPedAnimation(player, false)
		end, 2000, 1)
	end
end
addEvent("onSmokeEffect", true)
addEventHandler("onSmokeEffect", root, smokeEffect)


addCommandHandler("soltar", function(player)
	if(isSmoking(player))then
		smokeEffect(player)
	end
end)

addCommandHandler("fumar", function(player)
	if(isSmoking(player))then
		setPedAnimation(player, "SMOKING", "M_smk_drag", -1, false, true, true, false)
	else
	--exports["vz_info"]:showBoxS(player,"Você não tem cigarro em sua mao","info")
	outputChatBox("Você não tem cigarro em sua mao", player, 255, 255, 255, true)
	end
end)

function isSmoking(player)
	return isElement(cigarettes[player])
end

function deleteCigarette(player)
	if(isSmoking(player))then
		destroyElement(cigarettes[player])
		setElementData(player, "smoking", false)	
	end
end

function Colete(thePlayer)
setPedArmor(thePlayer, 100)
end
addEvent("USAR:COLETE", true)
addEventHandler("USAR:COLETE",root, Colete)