function resourceStart(res)
	setTimer(saveGuns, 60000, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), resourceStart)

function saveGuns()
	local loggedin = getElementData(getLocalPlayer(), "loggedin")
	if (loggedin==1) then
		local weaponArr = { }
		for i=0, 12 do
			local weapon = getPedWeapon(getLocalPlayer(), i)
			if weapon then
				local ammo = math.min( getPedTotalAmmo(getLocalPlayer(), i), getElementData(getLocalPlayer(), "ACweapon" .. weapon) or 0 )
				if ammo > 0 then
					weaponArr[ #weaponArr + 1 ] = { weapon, ammo }
				end
			end
		end
		
		triggerServerEvent("syncWeapons", getLocalPlayer(), weaponArr)
	end
end

addEvent("saveGuns", true)
addEventHandler("saveGuns", getRootElement(), saveGuns)