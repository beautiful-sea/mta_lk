local wDropWeapon, sDropWeapon, eDropWeapon, bDropWeapon, bCancelDropWeapon = nil
local _ammo, _weapon, _x, _y, _z, dieinafire = nil

local function hideDropWeaponGUI()
	if wDropWeapon then
		destroyElement(wDropWeapon)
		wDropWeapon = nil
		if wItems then
			guiSetEnabled(wItems, true)
		end
	end
	_weapon = nil
	_ammo = nil
	_x = nil
	_y = nil
	_z = nil
	dieinafire = false
end

local function dropWeaponFromGUI(ammo)
	waitingForItemDrop = true
	local ammo = math.min( _ammo, ammo )
	triggerServerEvent("dropItem", getLocalPlayer(), _weapon, _x, _y, _z, ammo, _ammo - ammo)
	hideDropWeaponGUI()
end

function openWeaponDropGUI(weapon, ammo, x, y, z)
	if wDropWeapon then
		hideDropWeaponGUI()
	end
	
	_ammo = ammo
	_weapon = weapon
	_x = x
	_y = y
	_z = z
	if ammo == 1 then
		dropWeaponFromGUI(ammo)
	else
		local width, height = 400, 110
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		wDropWeapon = guiCreateWindow(x, y, width, height, getWeaponNameFromID(weapon) or "", false)
		guiWindowSetSizable(wDropWeapon, false)
		guiSetEnabled(wItems, false)
		
		guiCreateLabel(0.05, 0.25, 0.9, 0.3, "How much ammo of your " .. ( getWeaponNameFromID(weapon) or "?" ) .. " do you want to drop?", true, wDropWeapon) 
		
		sDropWeapon = guiCreateScrollBar( 0.05, 0.52, 0.7, 0.16, true, true, wDropWeapon )
		guiSetProperty(sDropWeapon, "StepSize", "0.01")
		addEventHandler("onClientGUIScroll", sDropWeapon, 
			function()
				if not dieinafire then
					dieinafire = true
					guiSetText( eDropWeapon, math.ceil( _ammo * guiScrollBarGetScrollPosition(source) / 100 ))
					dieinafire = false
				end
			end,
			false)
		
		eDropWeapon = guiCreateEdit( 0.77, 0.5, 0.25, 0.18, "0", true, wDropWeapon )
		addEventHandler("onClientGUIChanged", eDropWeapon,
			function()
				local value = tonumber( guiGetText(source) )
				if value and not dieinafire then
					dieinafire = true
					if value > _ammo then
						value = _ammo
						guiSetText( source, tostring( value ) )
					end
					guiScrollBarSetScrollPosition( sDropWeapon, math.ceil( value / _ammo * 100 ) )
					dieinafire = false
				end
			end, false)
			
		bDropWeapon = guiCreateButton( 0.26, 0.75, 0.22, 0.25, "Drop", true, wDropWeapon )
		addEventHandler("onClientGUIClick", bDropWeapon, 
			function(key, state)
				value = tonumber( guiGetText(eDropWeapon) )
				if value then
					dropWeaponFromGUI(value)
				else
					outputChatBox("That's not a number!", 255, 0, 0)
				end
			end, false)
		bCancelDropWeapon = guiCreateButton( 0.52, 0.75, 0.22, 0.25, "Cancel", true, wDropWeapon )
		addEventHandler("onClientGUIClick", bCancelDropWeapon, hideDropWeaponGUI, false)
	end
end

bindKey('i', 'down', hideDropWeaponGUI)