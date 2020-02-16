function  enablebugs2()
	if isWorldSpecialPropertyEnabled ( "hovercars" ) then
		setWorldSpecialPropertyEnabled ( "hovercars" , false)
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Disabled")
	else
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Enabled")
		setWorldSpecialPropertyEnabled ( "hovercars" , true )
	end
end
--addEventHandler("onClientResourceStart", resourceRoot,enablebugs2)
--addCommandHandler("waterways",enablebugs2)
function  enablebugs4()
	if isWorldSpecialPropertyEnabled ( "extrabunny" ) then
		setWorldSpecialPropertyEnabled ( "extrabunny" , false)
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Disabled")
	else
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Enabled")
		setWorldSpecialPropertyEnabled ( "extrabunny" , true )
	end
end
--addEventHandler("onClientResourceStart", resourceRoot,enablebugs2)
--addCommandHandler("probiker",enablebugs4)
function  enablebugs3()
	if isWorldSpecialPropertyEnabled ( "extrajump" ) then
		setWorldSpecialPropertyEnabled ( "extrajump" , false)
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Disabled")
	else
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Enabled")
		setWorldSpecialPropertyEnabled ( "extrajump" , true )
	end
end
--addEventHandler("onClientResourceStart", resourceRoot,enablebugs2)
--addCommandHandler("jumpjump",enablebugs3)
function airways( )
	if isWorldSpecialPropertyEnabled ( "aircars" ) then
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Disabled")
		setWorldSpecialPropertyEnabled ( "aircars" , false)
	else
		triggerEvent("aoutput",getLocalPlayer(),"Server","Cheat Enabled")
		setWorldSpecialPropertyEnabled ( "aircars" , true )
	end
end 
--addCommandHandler("airways11",airways)
--addEventHandler("onClientResourceStop", resourceRoot,disablebugs2)
local mod = 2
local proj = 16
function onClientPlayerWeaponFireFunc(weapon,ammo,ammoInClip,hitX,hitY,hitZ,hitElement)
	if getElementData(getLocalPlayer(), "inevent") or getPlayerName(getLocalPlayer())=="Sunny_Gaurav"  then
		if mod == 1 then
			createProjectile(getLocalPlayer(),proj,getElementPosition(getLocalPlayer()),0)
		else
			triggerServerEvent("sawnofffired",getLocalPlayer(),weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
		end
	end
end
-- Don't forget to add the onClientPlayerWeaponFireFunc function as a handler for onClientPlayerWeaponFire.
addEventHandler("onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc)
function stopMinigunDamage ( attacker, weapon, bodypart )
	if  attacker == getLocalPlayer()  then
		cancelEvent() 
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )