rot = 0.0
vehicle = false
effect = false

function realisticDamage(attacker, weapon, bodypart)
	if getElementData(source, "reconx") and getElementData(source, "reconx") ~= true then
		cancelEvent( )
	else
		-- Only AK47, M4 and Sniper can penetrate armor
		local armor = getPedArmor(source)
		
		if (weapon>0) and (attacker) then
			local armorType = getElementData(attacker, "armortype")
			local bulletType = getElementData(attacker, "bullettype")
			
			if (armor>0) and (armorType==1) and (bulletType~=1) and (weapon>0) then
				if ((weapon~=30) and (weapon~=31) and (weapon~=34)) and (bodypart~=9) then
					cancelEvent()
				end
			end
		end
		
		-- Damage effect
		local gasmask = getElementData(source, "gasmask")
		if not (effect) and ((not gasmask or gasmask==0) and (weapon==17)) then
			fadeCamera(false, 1.0, 255, 0, 0)
			effect = true
			setTimer(endEffect, 250, 1)
		end
	end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(), realisticDamage)

function endEffect()
	fadeCamera(true, 1.0)
	effect = false
end

function playerDeath()
if getElementData(getLocalPlayer(),"inevent") or  getElementData(getLocalPlayer(), "adminjailed") or getElementData(getLocalPlayer(), "pd.jailtimer")   then
	return
end
	--setTimer(setCameraMatrix,5000,1,1206.26171875, -1321.556640625, 25.04949951171,1172.953125, -1323.4091796875, 15.39839)
end
addEventHandler("onClientPlayerWasted", getLocalPlayer(), playerDeath)

function lowerTimer()
	deathTimer = deathTimer - 1
	
	if (deathTimer>1) then
		guiSetText(deathLabel, tostring(deathTimer) .. " Seconds")
	else
		if (isElement(deathLabel)) then
			guiSetText(deathLabel, tostring(deathTimer) .. " Second")
		end
	end
end

deathTimer = 10
deathLabel = nil

function playerRespawn()
	setGameSpeed(1)
	if (isElement(deathLabel)) then
		destroyElement(deathLabel)
	end
	setCameraTarget(getLocalPlayer())
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), playerRespawn)

-- weapon fix for #131
function checkWeapons()

		if getElementData(getLocalPlayer(),"inevent") then
			return
		end
	local weapons = { }
	local removedWeapons, removedWeapons2
	local count = 1
	
	local gunlicense = tonumber(getElementData(getLocalPlayer(), "license.gun"))
	local team = getPlayerTeam(getLocalPlayer())
	local factiontype = getElementData(team, "type")
	
	for i = 0, 12 do
		local weapon = getPedWeapon(getLocalPlayer(), i)
		local ammo = getPedTotalAmmo(getLocalPlayer(), i)
		
		if (weapon) and (ammo~=0) then
			-- takes away weapons if you do not have a gun license and aren't in a PD/fbi
			-- takes away mp5/sniper/m4/ak if you aren't in PD/fbi
			-- always takes away rocket launchers, flamethrowers and miniguns, knifes and katanas
			if (((weapon >= 16 and weapon <= 40 and gunlicense == 0) or weapon == 29 or weapon == 30 or weapon == 32 or weapon ==31 or weapon == 34) and factiontype ~= 2) or (weapon >= 35 and weapon <= 38) then
				if (removedWeapons==nil) then
					removedWeapons = getWeaponNameFromID(weapon)
				else
					removedWeapons = removedWeapons .. ", " .. getWeaponNameFromID(weapon)
				end
				weapons[count] = { }
				weapons[count][1] = weapon
				weapons[count][2] = ammo
				weapons[count][3] = 1
			elseif weapon == 4 or weapon == 8 then
				if removedWeapons2 == nil then
					removedWeapons2 = getWeaponNameFromID(weapon)
				else
					removedWeapons2 = removedWeapons2 .. " and " .. getWeaponNameFromID(weapon)
				end
			else
				weapons[count] = { }
				weapons[count][1] = weapon
				weapons[count][2] = ammo
				weapons[count][3] = 0
			end
			count = count + 1
		end
	end
	
	triggerServerEvent("onDeathRemovePlayerWeapons", getLocalPlayer(), weapons, removedWeapons, removedWeapons2)
end
addEventHandler("onClientPlayerWasted", getLocalPlayer(), checkWeapons)
