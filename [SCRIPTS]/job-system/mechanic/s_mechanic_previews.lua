function previewColors( veh, color1, color2, color3,color21, color22, color23)
	if veh then
		if not getElementData( veh, "oldcolors" ) then
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldcolors", { getVehicleColor( veh,true) }, false )
		end
		local col = getElementData( veh, "oldcolors" )
		color1 = color1 or col[1]
		color2 = color2 or col[2]
		color3 = color3 or col[3]
		color21 = color21 or col[21]
		color22 = color22 or col[22]
		color23 = color23 or col[23]
		if setVehicleColor( veh, color1, color2, color3,color21, color22, color23) then
			setTimer(endColorPreview, 45000, 1, veh)
		end
	end
end
addEvent("colorPreview", true)
addEventHandler("colorPreview", getRootElement(), previewColors)

function endColorPreview( veh )
	if veh then
		local colors = getElementData( veh, "oldcolors" )
		if colors then
			setVehicleColor( veh, unpack( colors ) )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldcolors" )
		end
	end
end
addEvent("colorEndPreview", true)
addEventHandler("colorEndPreview", getRootElement(), endColorPreview)

function previewPaintjob( veh, paintjob )
	if veh then
		if not getElementData( veh, "oldpaintjob" ) then
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldpaintjob", getVehiclePaintjob( veh ), false )
		end
		if setVehiclePaintjob( veh, paintjob ) then
			local col1, col2 = getVehicleColor( veh ,true)
			if col1 == 0 or col2 == 0 then
				if not getElementData( veh, "oldcolors" ) then
					exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldcolors", { getVehicleColor( veh,true ) }, false )
				end
				setVehicleColor( veh, 1, 1, 1, 1 )
			end
			setTimer(endPaintjobPreview, 45000, 1, veh)
		end
	end
end
addEvent("paintjobPreview", true)
addEventHandler("paintjobPreview", getRootElement(), previewPaintjob)

function endPaintjobPreview( veh )
	if veh then
		local paintjob = getElementData( veh, "oldpaintjob" )
		if paintjob then
			setVehiclePaintjob( veh, paintjob )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldpaintjob" )
		end
		local colors = getElementData( veh, "oldcolors" )
		if colors then
			setVehicleColor( veh, unpack( colors ) )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldcolors" )
		end
	end
end
addEvent("paintjobEndPreview", true)
addEventHandler("paintjobEndPreview", getRootElement(), endPaintjobPreview)

function previewlight( veh, red, green , blue )
	if veh then
		if not getElementData( veh, "oldlightred" ) then
			local red, green, blue = getVehicleHeadLightColor ( veh)
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightred", red, false )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightgreen", green, false )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightblue", blue, false )
		end

		if setVehicleHeadLightColor ( veh, red, green, blue ) then
			
			setTimer(endlightPreview, 45000, 1, veh)
		end
	end
end
addEvent("lightPreview", true)
addEventHandler("lightPreview", getRootElement(), previewlight)

function endlightPreview( veh )
	if veh then
		local red = getElementData( veh, "oldlightred" )
		local green = getElementData( veh, "oldlightgreen" )
		local blue = getElementData( veh, "oldlightblue" )
		if red and green and blue then
			local color = setVehicleHeadLightColor ( veh, red, green, blue )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightred" )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightgreen" )
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldlightblue" )
		end
	end
end
addEvent("lightEndPreview", true)
addEventHandler("lightEndPreview", getRootElement(), endlightPreview)

function previewUpgrade( veh, upgrade, slot )
	if veh then
		if not getElementData( veh, "oldupgrade" .. slot ) then
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldupgrade" .. slot, getVehicleUpgradeOnSlot( veh, slot ), false )
		end
		if addVehicleUpgrade( veh, upgrade ) then
			setTimer(endUpgradePreview, 45000, 1, veh, slot)
		end
	end
end
addEvent("upgradePreview", true)
addEventHandler("upgradePreview", getRootElement(), previewUpgrade)

function endUpgradePreview( veh, slot )
	if veh then
		local upgrade = getElementData( veh, "oldupgrade" .. slot )
		if upgrade then
			if upgrade == 0 then
				removeVehicleUpgrade( veh, getVehicleUpgradeOnSlot( veh, slot ) )
			else
				addVehicleUpgrade( veh, upgrade )
			end
			exports['anticheat-system']:changeProtectedElementDataEx( veh, "oldupgrade" .. slot )
		end
	end
end
addEvent("upgradeEndPreview", true)
addEventHandler("upgradeEndPreview", getRootElement(), endUpgradePreview)
