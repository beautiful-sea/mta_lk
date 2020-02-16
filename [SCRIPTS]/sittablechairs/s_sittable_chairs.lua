function sitOnChair(x, y, z, rz, chair, offset)
	setPedRotation(source, rz-180)
	exports.global:applyAnimation( source, "FOOD", "FF_Sit_Look", -1, true, false, true)
	exports.global:sendLocalMeAction(source, "sits down on the chair.")
	for k,v in ipairs(getElementsByType("player")) do
		if (v~=source) then
			triggerClientEvent(v,"csit",source,x,y,z)
		end
	end
end
addEvent("sit", true)
addEventHandler("sit", getRootElement(), sitOnChair)

function removeAnim(player)
	exports.global:removeAnimation( player )
end

function standUp(chair)
	removeAnim( source )
	setTimer(removeAnim, 100, 1, source)
	exports.global:sendLocalMeAction(source, "stands up from the chair.")
	
	for k,v in ipairs(getElementsByType("player")) do
		if (v~=source) then
			triggerClientEvent(v,"cstand",source)
		end
	end
end
addEvent("stand", true)
addEventHandler("stand", getRootElement(), standUp)