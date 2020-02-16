local cooldown = false

local localPlayer = getLocalPlayer()

function checkSpeedHacks()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	
	if (vehicle) and not (cooldown) then
		local speedx, speedy, speedz = getElementVelocity(vehicle)
		local actualspeed = math.ceil(((speedx^2 + speedy^2 + speedz^2)^(0.5)*100))
		if (actualspeed>153) then -- you can fall at 152 mph
			cooldown = true
			setTimer(resetCD, 5000, 1)
			triggerServerEvent("alertAdminsOfSpeedHacks", localPlayer, actualspeed)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), checkSpeedHacks)

function resetCD()
	cooldown = false
end

local timer = false
local kills = 0
function checkDM(killer)
	if (killer==localPlayer) then
		kills = kills + 1
		
		if (kills>=3) then
			triggerServerEvent("alertAdminsOfDM", localPlayer, kills)
		end
		
		if not (timer) then
			timer = true
			setTimer(resetDMCD, 120000, 1)
		end
	end
end
addEventHandler("onClientPlayerWasted", getRootElement(), checkDM)

function resetDMCD()
	kills = 0
	timer = false
end

-- [WEAPON HACKS]
local strikes = 0

function resetWeaponTimer()
	if weapontimer then
		killTimer(weapontimer)
	end
	weapontimer = setTimer(checkWeapons, 15000, 0)
end

function checkWeapons()
	for i = 1, 47 do
		if i ~= 40 and i ~= 47 and i ~= 19 and i ~= 20 and i ~= 21 then
			local onslot = i == 15 and 10 or getSlotFromWeapon(i)
			if (onslot) then
				if getPedWeapon(localPlayer, onslot) == i then
					local ammo = getElementData(localPlayer, "ACweapon" .. i) or 0
					if ammo < 0 then
						ammo = 0
						setElementData(localPlayer, "ACweapon" .. i, 0, false)
					end
					local totalAmmo = getPedTotalAmmo(localPlayer, onslot)
					if i <= 15 or i >= 44 then -- fix for melee with 60k+ ammo
						totalAmmo = 1
					end
					if totalAmmo > ammo then
						strikes = strikes + 1
						triggerServerEvent("notifyWeaponHacks", localPlayer, i, totalAmmo, ammo, strikes)
					elseif totalAmmo < ammo then
						-- update the new ammo count
						setElementData(localPlayer, "ACweapon" .. i, totalAmmo, false)
					end
				else -- weapon on that slot, but not the current one
					setElementData(localPlayer, "ACweapon" .. i, nil, false)
				end
			end
		end
	end
end
-- addCommandHandler("fwc", checkWeapons)

function giveSafeWeapon(weapon, ammo)
	resetWeaponTimer()
	setElementData(localPlayer, "ACweapon" .. weapon, (getElementData(localPlayer, "ACweapon" .. weapon) or 0) + ammo, false)
	setTimer(triggerEvent, 200, 1, "saveGuns", localPlayer)
end
addEvent("giveSafeWeapon", true)
addEventHandler("giveSafeWeapon", localPlayer, giveSafeWeapon)

function setSafeWeaponAmmo(weapon, ammo)
	resetWeaponTimer()
	setElementData(localPlayer, "ACweapon" .. weapon, ammo, false)
	setTimer(triggerEvent, 200, 1, "saveGuns", localPlayer)
end
addEvent("setSafeWeaponAmmo", true)
addEventHandler("setSafeWeaponAmmo", localPlayer, setSafeWeaponAmmo)

function takeAllWeaponsSafe()
	resetWeaponTimer()
	for weapon = 0, 47 do
		setElementData(localPlayer, "ACweapon" .. weapon, nil, false)
	end
	setTimer(triggerEvent, 200, 1, "saveGuns", localPlayer)
end
addEvent("takeAllWeaponsSafe", true)
addEventHandler("takeAllWeaponsSafe", localPlayer, takeAllWeaponsSafe)

function takeWeaponSafe(weapon)
	resetWeaponTimer()
	setElementData(localPlayer, "ACweapon" .. weapon, nil, false)
	setTimer(triggerEvent, 200, 1, "saveGuns", localPlayer)
end
addEvent("takeWeaponSafe", true)
addEventHandler("takeWeaponSafe", localPlayer, takeWeaponSafe)

addEventHandler("onClientResourceStart", getResourceRootElement(), resetWeaponTimer)

function updateWeaponOnFire(weapon, ammo)
	setElementData(localPlayer, "ACweapon" .. weapon, (getElementData(localPlayer, "ACweapon" .. weapon) or 0) - 1, false)
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, updateWeaponOnFire)