mysql = exports.mysql

pdColShape = createColSphere( 263.751953125, 109.634765625, 1004.6171875, 3)
exports.pool:allocateElement(pdColShape)
setElementDimension(pdColShape, 1)
setElementInterior(pdColShape, 10)

pdColShape2 = createColSphere( 263.751953125, 109.634765625, 1004.6171875, 3)
exports.pool:allocateElement(pdColShape2)
setElementDimension(pdColShape2, 10583)
setElementInterior(pdColShape2, 10)

esColShape = createColSphere(285.86764526367, 148.56887817383, 1027.1853, 5)
exports.pool:allocateElement(esColShape)
setElementInterior(esColShape, 4)
setElementInterior(esColShape, 134)

fbiColShape = createColSphere(222.822265625, 123.501953125, 1010.2117919922, 5)
exports.pool:allocateElement(fbiColShape)
setElementDimension(fbiColShape, 795)
setElementInterior(fbiColShape, 10)

fdColShape = createColSphere(2229.9931640625, -1168.9091796875, 928.99603271484,10)
exports.pool:allocateElement(fdColShape)
setElementDimension(fdColShape, 10631)
setElementInterior(fdColShape, 3)

sacfColShape = createColSphere(1036.546875, 1222.09375, 1485.005859375, 5)
exports.pool:allocateElement(sacfColShape)
setElementDimension(sacfColShape, 777)
setElementInterior(sacfColShape, 3)

courtColShape = createColSphere(350.302734375, 163.7236328125, 1019.9912109375, 5)
exports.pool:allocateElement(courtColShape)
setElementDimension(courtColShape, 100)
setElementInterior(courtColShape, 3)

lstrColShape = createColSphere(256.9345703125, 115.6005859375, 1008.8130493164, 2.9)
exports.pool:allocateElement(lstrColShape)
setElementDimension(lstrColShape, 9001)
setElementInterior(lstrColShape, 10)

local authSwat = nil

function saveWeaponsOnDuty( thePlayer )
	triggerClientEvent(thePlayer, "saveGunsDuty", thePlayer)
	exports.global:takeAllWeapons(thePlayer)
end

function restoreWeapons( thePlayer )
	exports.global:takeAllWeapons(thePlayer)
	local weapons = getElementData(thePlayer, "dutyguns")
	if weapons then
		for k, v in pairs( weapons ) do
			exports.global:giveWeapon(thePlayer,k,v)
		end
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "dutyguns")
	end
end

--- DUTY TYPE
-- 0 = NONE
-- 1 = SWAT
-- 2 = Police
-- 3 = Cadet
-- 4 = ES
-- 5 = FIRE ES
-- 6 = FBI
-- 7 = Gov

-- 9 = SACF
-- 10 = SACF CERT (Wtf is CERT?)
-- 11 = Court
-- 12 = Detective (or should I bump all of the others down?)
-- 13 = ES SAR
-- 14 = LSTR

-- ES
function lvesHeal(thePlayer, commandName, targetPartialNick, price)
	if not (targetPartialNick) or not (price) then -- if missing target player arg.
		outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Price of Heal]", thePlayer, 255, 194, 14)
	else
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialNick)
		if targetPlayer then -- is the player online?
			local logged = getElementData(thePlayer, "loggedin")
	
			if (logged==1) then
				local theTeam = getPlayerTeam(thePlayer)
				local factionType = getElementData(theTeam, "type")
				
				if not (factionType==4) then
					outputChatBox("You have no basic medic skills, contact the ES.", thePlayer, 255, 0, 0)
				else
					price = tonumber(price)
					if price > 600 then
						outputChatBox("This is too much to ask him for.", thePlayer, 255, 0, 0)
					else
						local x, y, z = getElementPosition(thePlayer)
						local tx, ty, tz = getElementPosition(targetPlayer)
						
						if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)>5) then -- Are they standing next to each other?
							outputChatBox("You are too far away to heal '".. targetPlayerName .."'.", thePlayer, 255, 0, 0)
						else
							local foundkit, slot, itemValue = exports.global:hasItem(thePlayer, 70)
							if (foundkit) then
								local money = exports.global:getMoney(targetPlayer)
								local bankmoney = getElementData(targetPlayer, "bankmoney")
								
								if money + bankmoney < price then
									outputChatBox("The player cannot afford the heal.", thePlayer, 255, 0, 0)
								else
									local takeFromCash = math.min( money, price )
									local takeFromBank = price - takeFromCash
									exports.global:takeMoney(targetPlayer, takeFromCash)
									if takeFromBank > 0 then
										exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "bankmoney", bankmoney - takeFromBank)
									end
									
									local tax = exports.global:getTaxAmount()
									
									exports.global:giveMoney( getTeamFromName("Los Santos Emergency Services"), math.ceil((1-tax)*price) )
									exports.global:giveMoney( getTeamFromName("Government of Los Santos"), math.ceil(tax*price) )
									
									setElementHealth(targetPlayer, 100)
									triggerEvent("onPlayerHeal", targetPlayer, true)
									outputChatBox("You healed '" ..targetPlayerName.. "'.", thePlayer, 0, 255, 0)
									outputChatBox("You have been healed by '" ..getPlayerName(thePlayer).. "' for $" .. price .. ".", targetPlayer, 0, 255, 0)
									exports.logs:logMessage("[ES/HEAL] " .. getPlayerName(thePlayer) .. " healed " .. targetPlayerName .. " for $"..price , 30)
									
									if itemValue > 1 then
										exports['item-system']:updateItemValue(thePlayer, slot, itemValue - 1)
									else
										exports.global:takeItem(thePlayer, 70, itemValue)
										if not exports.global:hasItem(thePlayer, 70) then
											outputChatBox("Warning, you're out of first aid kits. re /duty to get new ones.", thePlayer, 255, 0, 0)
										end
									end
								end
							else
								outputChatBox("You need a first aid kit to heal people.", thePlayer, 255, 0, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("heal", lvesHeal, false, false)

function lvesExamine(thePlayer, commandName, targetPartialNick)
	if not targetPartialNick then -- if missing target player arg.
		outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
	else
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialNick)
		if targetPlayer then -- is the player online?
			local logged = getElementData(thePlayer, "loggedin")
	
			if logged==1 then
				local theTeam = getPlayerTeam(thePlayer)
				local factionType = getElementData(theTeam, "type")
				
				if not (factionType==4) then
					outputChatBox("You have no basic medic skills, contact the ES.", thePlayer, 255, 0, 0)
				else
					local x, y, z = getElementPosition(thePlayer)
					local tx, ty, tz = getElementPosition(targetPlayer)
				
					if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)>5) then -- Are they standing next to each other?
						outputChatBox("You are too far away to examine '"..targetPlayerName.."'.", thePlayer, 255, 0, 0)
					else
						triggerEvent("onPlayerExamine", targetPlayer, thePlayer)
					end
				end
			end
		end
	end
end
addCommandHandler("examine", lvesExamine, false, false)

function lvesduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, esColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==4) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on Medic Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their uniform from their locker.")
						
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 41, 1500) -- Pepperspray
						exports.global:giveItem(thePlayer, 70, 7) -- first aid kit
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 4)
						
						saveSkin(thePlayer)
					end
				elseif (duty==4) then -- ES
					restoreWeapons(thePlayer)
					outputChatBox("You are now off Medic Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their uniform into their locker.")
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", lvesduty, false, false)

-- gov duty
function govduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if getElementDimension(thePlayer) == 125 then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local faction = getElementData(thePlayer, "faction")
			local factionrank = getElementData(thePlayer,"factionrank") 
			
			if (faction==3) then
				if (duty==0) then
					outputChatBox("You are now on duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their uniform from their locker.")
						
					
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
					end
					
					saveWeaponsOnDuty(thePlayer)
					setElementHealth(thePlayer, 100) -- restore health
					
					exports.global:giveItem(thePlayer, 46, 1) -- Rope
					setPedArmor(thePlayer, 50) -- 50% armor
					exports.global:giveWeapon(thePlayer, 22, 30) -- colt 45
					exports.global:giveWeapon(thePlayer, 41, 1000) -- pepper spray
					
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 7)
						
					saveSkin(thePlayer)
				elseif (duty==7) then -- gov
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their uniform into their locker.")
					exports.global:takeItem(thePlayer, 46)
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", govduty, false, false)

-- ES FD
function lvfdduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, fdColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==4) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on Firefighter Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their firefighter gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 42, 3000) -- Fire Extinguisher
						exports.global:giveWeapon(thePlayer, 9, 1) -- Chainsaw
						exports.global:giveItem(thePlayer, 26, 1) -- Gas Mask
						exports.global:giveItem(thePlayer, 70, 3) -- first aid kit
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 5)
						
						saveSkin(thePlayer)
					end
				elseif (duty==5) then -- FIRE ES
					restoreWeapons(thePlayer)
					outputChatBox("You are now off Firefighter Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their firefighter gear into their locker.")
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("firefighter", lvfdduty, false, false)

-- ES FD
function sarduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, fdColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==4) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on Search & Rescue Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their SAR gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 9, 1) -- Chainsaw
						exports.global:giveItem(thePlayer, 26, 1) -- Gas Mask
						exports.global:giveItem(thePlayer, 28, 1) -- Glow Stick
						exports.global:giveItem(thePlayer, 28, 1) -- Glow Stick
						exports.global:giveItem(thePlayer, 28, 1) -- Glow Stick
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 13)
						
						saveSkin(thePlayer)
					end
				elseif (duty==13) then -- SAR ES
					restoreWeapons(thePlayer)
					
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 26)
					
					outputChatBox("You are now off Search & Rescue Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their SAR gear into their locker.")
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("sarduty", sarduty, false, false)

function pdarmor(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, pdColShape)) or (isElementWithinColShape(thePlayer, pdColShape2) or getElementDimension(thePlayer) == 10590) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				outputChatBox("You now have a new armor vest.", thePlayer, 255, 194, 14)
				setPedArmor(thePlayer, 100)
			end
		end
	end
end
addCommandHandler("armor", pdarmor)

function swatduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, pdColShape)) or (isElementWithinColShape(thePlayer, pdColShape2) or getElementDimension(thePlayer) == 10590) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				if (duty==0) then
					if isTimer( authSwat ) then
						outputChatBox("You are now on SWAT Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their swat gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						
						setPedArmor(thePlayer, 100)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 24, 250) -- Deagle / MP Handgun
						exports.global:giveWeapon(thePlayer, 27, 200) -- Shotgun
						exports.global:giveWeapon(thePlayer, 29, 800) -- MP5
						exports.global:giveWeapon(thePlayer, 31, 1200) -- M4
						exports.global:giveWeapon(thePlayer, 34, 200) -- Sniper
						exports.global:giveWeapon(thePlayer, 17, 10) -- Tear gas
						
						exports.global:giveItem(thePlayer, 26, 1)
						exports.global:giveItem(thePlayer, 27, 1)
						exports.global:giveItem(thePlayer, 28, 1)
						exports.global:giveItem(thePlayer, 29, 1)
						exports.global:giveItem(thePlayer, 45, 1)
						
						setElementModel(thePlayer, 285)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 1)
						
						saveSkin(thePlayer)
					else
						outputChatBox( "There is no SWAT Authorization from a Lt+.", thePlayer, 255, 0, 0)
					end
				elseif (duty==1) then -- SWAT
					restoreWeapons(thePlayer)
					outputChatBox("You are now off SWAT duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their SWAT gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 26)
					exports.global:takeItem(thePlayer, 27)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 29)
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==2) then
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==3) then -- CADET
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their cadet gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==12) then -- Detective
					restoreWeapons(thePlayer)
					outputChatBox ("You are now off duty", thePlayer )
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0 )
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45 )
					exports.global:takeItem(thePlayer, 71 )
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("swat", swatduty, false, false)

function policeduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, pdColShape)) or (isElementWithinColShape(thePlayer, pdColShape2) or getElementDimension(thePlayer) == 10590) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on Police Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						
						setPedArmor(thePlayer, 100)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 3, 1) -- Nightstick
						exports.global:giveWeapon(thePlayer, 24, 200) -- Deagle / MP Handgun
						exports.global:giveWeapon(thePlayer, 25, 200) -- Shotgun
						exports.global:giveWeapon(thePlayer, 29, 1000) -- MP5
						exports.global:giveWeapon(thePlayer, 41, 1500) -- Pepperspray
						exports.global:giveWeapon(thePlayer, 31, 150) -- M4
						
						exports.global:giveItem(thePlayer, 45, 1)
						
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 2)
						
						saveSkin(thePlayer)
					end
				elseif (duty==1) then -- SWAT
					restoreWeapons(thePlayer)
					outputChatBox("You are now off SWAT duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their SWAT gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 26)
					exports.global:takeItem(thePlayer, 27)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 29)
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==2) then
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==3) then -- CADET
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their cadet gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==12) then -- Detective
					restoreWeapons(thePlayer)
					outputChatBox ("You are now off duty", thePlayer )
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0 )
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45 )
					exports.global:takeItem(thePlayer, 71 )
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", policeduty, false, false)

function detectiveduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, pdColShape)) or (isElementWithinColShape(thePlayer, pdColShape2) or getElementDimension(thePlayer) == 10590) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				if (duty==0) then
					-- not checking for duty skin -- assuming detective use plain clothes.
					
					outputChatBox("You are now on Detective Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their detective gear from their locker.")
					
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
					end
					
					saveWeaponsOnDuty(thePlayer)
					
					--setPedArmor(thePlayer, 100)  -- Fox didn't mention armor on mantis.
					setElementHealth(thePlayer, 100)
					
					exports.global:giveWeapon(thePlayer, 22, 51) -- Pistol
					exports.global:giveWeapon(thePlayer, 43, 100 ) -- camera
					exports.global:giveItem(thePlayer, 45, 1) -- cuffs
					exports.global:giveItem(thePlayer, 71, 20 ) -- notepad + 20 pages. (should be more?)
					
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 12)
					
					saveSkin(thePlayer)
				elseif (duty==1) then -- SWAT
					restoreWeapons(thePlayer)
					outputChatBox("You are now off SWAT duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their SWAT gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 26)
					exports.global:takeItem(thePlayer, 27)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 29)
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==2) then -- POLICE
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
				
				elseif (duty==3) then -- CADET
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their cadet gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==12) then -- Detective
					restoreWeapons(thePlayer)
					outputChatBox ("You are now off duty", thePlayer )
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0 )
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45 )
					exports.global:takeItem(thePlayer, 71 )
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("dduty", detectiveduty, false, false)

function cadetduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, pdColShape)) or (isElementWithinColShape(thePlayer, pdColShape2) or getElementDimension(thePlayer) == 10590) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on Cadet Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their cadet gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						
						saveWeaponsOnDuty(thePlayer)
						
						setPedArmor(thePlayer, 100)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 3, 1) -- Nightstick
						exports.global:giveWeapon(thePlayer, 24, 200) -- Deagle / MP Handgun
						exports.global:giveWeapon(thePlayer, 41, 1000) -- Pepperspray
						
						exports.global:giveItem(thePlayer, 45, 1)
						
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 3)
						
						saveSkin(thePlayer)
					end
				elseif (duty==1) then -- SWAT
					restoreWeapons(thePlayer)
					outputChatBox("You are now off SWAT duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their SWAT gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 26)
					exports.global:takeItem(thePlayer, 27)
					exports.global:takeItem(thePlayer, 28)
					exports.global:takeItem(thePlayer, 29)
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==2) then -- POLICE
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==3) then -- CADET
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their cadet gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				elseif (duty==12) then -- Detective
					restoreWeapons(thePlayer)
					outputChatBox ("You are now off duty", thePlayer )
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0 )
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45 )
					exports.global:takeItem(thePlayer, 71 )
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("cadet", cadetduty, false, false)

function fbiduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if (isElementWithinColShape(thePlayer, fbiColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			local factionType = getElementData(theTeam, "type")
			
			if (factionType==2) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					
					if (dutyskin==-1) then
						outputChatBox("You have not picked a uniform yet, press F4 to pick a uniform.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You are now on FBI Duty.", thePlayer)
						exports.global:sendLocalMeAction(thePlayer, "takes their FBI gear from their locker.")
						
						if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
							mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
						end
						saveWeaponsOnDuty(thePlayer)
						
						setPedArmor(thePlayer, 100)
						setElementHealth(thePlayer, 100)
						
						exports.global:giveWeapon(thePlayer, 22, 200) -- Colt 45
						exports.global:giveItem(thePlayer, 45, 1) -- Cuffs
						
						setElementModel(thePlayer, dutyskin)
						
						exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 6)
						
						saveSkin(thePlayer)
					end
				elseif (duty==6) then -- FBI
					restoreWeapons(thePlayer)
					outputChatBox("You are now off FBI duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their FBI gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					exports.global:takeItem(thePlayer, 45)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				else
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
--addCommandHandler("fbi", fbiduty, false, false)

function saveSkin(thePlayer)
	mysql:query_free( "UPDATE characters SET skin = " .. getElementModel( thePlayer ) .. ", duty = " .. ( getElementData( thePlayer, "duty" ) or 0 ) .. " WHERE id = " .. getElementData( thePlayer, "dbid" ) )
end

addCommandHandler( "authswat",
	function( thePlayer )
		local theTeam = getPlayerTeam(thePlayer)
		
		if theTeam then
			local teamID = tonumber(getElementData(theTeam, "id"))
		
			if teamID == 1 then
				local factionRank = getElementData(thePlayer, "factionrank") or 0
				
				if factionRank >= 8 then
					if isTimer( authSwat ) then
						killTimer( authSwat )
						authSwat = nil
						
						for k, v in pairs( getPlayersInTeam( theTeam ) ) do
							outputChatBox( "SWAT Authorization has been revoked by " .. getPlayerName( thePlayer ):gsub( "_", " " ) .. ".", v, 255, 0, 0 )
						end
					else
						authSwat = setTimer( 
							function( theTeam )
								for k, v in pairs( getPlayersInTeam( theTeam ) ) do
									outputChatBox( "SWAT Authorization has been revoked after 10 minutes.", v, 255, 0, 0 )
								end
								authSwat = nil
							end, 600000, 1, theTeam
						)
						for k, v in pairs( getPlayersInTeam( theTeam ) ) do
							outputChatBox( "SWAT Authorization has been granted by " .. getPlayerName( thePlayer ):gsub( "_", " " ) .. " ((/swat in the locker for 10 mins)).", v, 255, 0, 0 )
						end
					end
				end
			end
		end
	end
)

-- SAN /duty

function duty(thePlayer)
	if getElementDimension(thePlayer) == 136 and getTeamName(getPlayerTeam(thePlayer)) == "San Andreas Network" then
		exports.global:takeItem(thePlayer, 71)
		exports.global:giveItem(thePlayer, 71, 20)
		exports.global:takeWeapon(thePlayer, 43)
		exports.global:giveWeapon(thePlayer, 43, 200, true)
	end
end
addCommandHandler("duty", duty)


-- SACF /duty
function sacfduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, sacfColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			
			if getTeamName( theTeam ) == "San Andreas Correctional Facility" then
				if (duty==0) then
					outputChatBox("You are now on Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their gear from their locker.")
					
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
					end
					
					saveWeaponsOnDuty(thePlayer)
					
					setPedArmor(thePlayer, 100)
					setElementHealth(thePlayer, 100)
					
					exports.global:giveWeapon(thePlayer, 3, 1) -- Nightstick
					exports.global:giveWeapon(thePlayer, 41, 1500) -- Pepperspray
					
					setElementModel(thePlayer, 71)
					
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 9)
					
					saveSkin(thePlayer)
				elseif (duty==9) then
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", sacfduty, false, false)

--SACF /cert
function sacfduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, sacfColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			
			if getTeamName( theTeam ) == "San Andreas Correctional Facility" then
				if (duty==0) then
					outputChatBox("You are now on Cert Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their gear from their locker.")
					
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
					end
					
					saveWeaponsOnDuty(thePlayer)
					
					setPedArmor(thePlayer, 100)
					setElementHealth(thePlayer, 100)
					
					exports.global:giveWeapon(thePlayer, 3, 1) -- Nightstick
					exports.global:giveWeapon(thePlayer, 41, 1500) -- Pepperspray
					exports.global:giveWeapon(thePlayer, 25, 150) -- Shotgun

					exports.global:giveItem(thePlayer, 45, 1) -- Handcuffs

					setElementModel(thePlayer, 285)
					
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 10)
					
					saveSkin(thePlayer)
				elseif (duty==10) then
					restoreWeapons(thePlayer)
					exports.global:takeItem(thePlayer, 45, 1) -- Handcuffs
					outputChatBox("You are now off Cert duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their gear into their locker.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("cert", sacfduty, false, false)

-- Court US Marshalls /duty command
function courtduty(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, courtColShape)) then
		
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local theTeam = getPlayerTeam(thePlayer)
			
			if getTeamName( theTeam ) == "First Court of San Andreas" then
				if (duty==0) then
					outputChatBox("You are now on Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their equipment from a box.")
					
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid" ) )
					end
					
					saveWeaponsOnDuty(thePlayer)
					
					setPedArmor(thePlayer, 100)
					setElementHealth(thePlayer, 100)
					
					exports.global:giveWeapon(thePlayer, 22, 60) -- Colt
					
					setElementModel(thePlayer, 286)
					
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 11)
					
					saveSkin(thePlayer)
				elseif (duty==11) then
					restoreWeapons(thePlayer)
					outputChatBox("You are now off duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their equipment back into their box.")
					setPedArmor(thePlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", courtduty, false, false)

-- LST&R duty
function lstrduty(thePlayer, command)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if (isElementWithinColShape(thePlayer, lstrColShape)) then
				
			local duty = tonumber(getElementData(thePlayer, "duty"))
			local faction = getElementData(thePlayer, "faction")
			
			if (faction==30) then
				if (duty==0) then
					local dutyskin = getElementData(thePlayer, "dutyskin")
					local gender = getElementData(thePlayer, "gender")

					outputChatBox("You are now on Los Santos Towing & Recovery Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "takes their LST&R gear from their locker.")

						
					if exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "casualskin", getPedSkin(thePlayer), false) then
						mysql:query_free( "UPDATE characters SET casualskin = " .. getPedSkin(thePlayer) .. " WHERE id = " .. getElementData(thePlayer, "dbid") )
					end
						
					saveWeaponsOnDuty(thePlayer)
					setElementHealth(thePlayer, 100)
						
					exports.global:giveWeapon(thePlayer, 41, 50) -- Pepperspray
					exports.global:giveItem(thePlayer, 71, 5) -- Notebook
					exports.global:giveItem(thePlayer, 71, 5) -- Notebook
					exports.global:giveItem(thePlayer, 71, 5) -- Notebook
					
					if (gender==0) then
						setElementModel(thePlayer, 217)
					else
						setElementModel(thePlayer, 211)
					end
						
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 14)
						
					saveSkin(thePlayer)
				elseif (duty==14) then -- LSTR
					restoreWeapons(thePlayer)
					
					exports.global:takeItem(thePlayer, 71)
					exports.global:takeItem(thePlayer, 71)
					exports.global:takeItem(thePlayer, 71)
					
					outputChatBox("You are now off Los Santos Towing & Recovery Duty.", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "puts their LST&R gear into their locker.")
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "duty", 0)
					
					local casualskin = getElementData(thePlayer, "casualskin")
					setElementModel(thePlayer, casualskin)
					saveSkin(thePlayer)
				end
			end
		end
	end
end
addCommandHandler("duty", lstrduty, false, false)