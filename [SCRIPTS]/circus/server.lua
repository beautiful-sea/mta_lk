mysql = exports.mysql
local root = getRootElement()
local weaponid 
local x,y,z = nil,nil,nil
local dimension, interior = nil,nil
local function getWeaponString( player )
	local weapons = { }
	local hasAnyWeapons = false
	for slot = 0, 12 do
		local weapon = getPedWeapon( player, slot )
		if weapon > 0 then
			local ammo = getPedTotalAmmo( player, slot )
			if ammo > 0 then
				weapons[weapon] = ammo
				hasAnyWeapons = true
			end
		end
	end
	if hasAnyWeapons then
		return toJSON( weapons ):gsub( " ", "" )
	else
		return "NULL"
	end
end
function joinevent(thePlayer,commandName)
	if getPedOccupiedVehicle(thePlayer) then
		triggerClientEvent(thePlayer,"doOutput",thePlayer,255,255,255,"You can't use this command inside vehicle.")
		return
	end
		
	if getElementData(thePlayer, "inevent") then
		triggerClientEvent(thePlayer,"doOutput",thePlayer,255,255,255,"You are already in a event. If you want to rejoin /quitevent")
		return
	end
	if not getElementData(root,"activeevent") then
				triggerClientEvent(thePlayer,"doOutput",thePlayer,255,255,255,"There are no active events")
		return
	end
	if getElementData(root, "lockevent") and not exports.global:isPlayerSuperAdmin(thePlayer)  then
		triggerClientEvent(thePlayer,"doOutput",thePlayer,255,255,255,"This event is currently locked")
		return
	end
	if  getElementData(root,"eventdata") then
		--outputChatBox("There are no active events",thePlayer,255,2,2)
		--return
	end
	
	local x1,y1,z1 = getElementPosition(thePlayer)
	local insertid = mysql:query_insert_free("INSERT INTO event SET charid='" .. mysql:escape_string(getElementData(thePlayer,"dbid")) .. "',x='" .. mysql:escape_string(x1) .. "', y='" .. mysql:escape_string(y1) .. "', z='" .. mysql:escape_string(z1) .. "', skin='" .. mysql:escape_string(getElementModel(thePlayer)) .. "', health='" .. mysql:escape_string(getElementHealth(thePlayer)) .. "', armor='" .. mysql:escape_string(getPedArmor(thePlayer)) .. "', interior='" .. mysql:escape_string(getElementInterior(thePlayer)) .. "', dimension='" .. mysql:escape_string(getElementDimension(thePlayer)) .. "', weapons='" .. mysql:escape_string(getWeaponString( thePlayer )).. "'")
	exports.global:takeAllWeapons(thePlayer)
	takeAllWeapons(thePlayer)
	exports.global:giveWeapon(thePlayer,getElementData(root,"gun"),500,true)
	setElementData(thePlayer,"inevent",true)
	outputChatBox("You joined an event.#FF0000 DO NOT SHOOT before countdown.",thePlayer,222,222,222,true)
	local eventstarter = getElementData(root,"eventstarter")
	if x then
		setElementPosition(thePlayer,x+math.random(0,200*0.01),y+math.random(0,200*0.01),z)
		setElementInterior(thePlayer,interior)
		setElementDimension(thePlayer,dimension)
		setElementHealth(thePlayer,100)
		setPedArmor(thePlayer,100)
	else
		quitevent(thePlayer)
		outputChatBox("Try later",thePlayer,255,2,2)
	end
end
addCommandHandler("joinevent",joinevent)

function lockevent(thePlayer,commandName)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	if not getElementData(root,"activeevent") then
		outputChatBox("There are no active events",thePlayer,255,2,2)
		return
	end
	setElementData(root,"lockevent",true)
	triggerClientEvent(root,"doOutput",root,255,255,255,"EVENT: Current event has been locked by an admin")
end
addCommandHandler("lockevent",lockevent)
function setmydimension(thePlayer,commandName,dimension)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	if dimension then
		outputChatBox("Your dimension set to "..dimension,thePlayer,255,2,2)
		setElementDimension(thePlayer,dimension)
	end
end
addCommandHandler("setmydimension",setmydimension)

function setmypos(thePlayer,commandName,xm,ym,zm,inte)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	if xm and ym and zm then
		outputChatBox("Your position changed.",thePlayer,255,2,2)
		setElementPosition(thePlayer,xm,ym,zm)
		setElementInterior(thePlayer,inte)
	end
end
addCommandHandler("setmypos",setmypos)

function lockevent(thePlayer,commandName)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	if not getElementData(root,"activeevent") then
		outputChatBox("There are no active events",thePlayer,255,2,2)
		return
	end
	setElementData(root,"lockevent",false)
	triggerClientEvent(root,"doOutput",root,255,255,255,"EVENT: Current event has been unlocked by an admin")
end
addCommandHandler("unlockevent",lockevent)
function lockevent(thePlayer,commandName)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	setElementData(root,"lockevent",true)
	outputChatBox("/startevent /lockevent /unlockevent /endevent /joinevent /quitevent",thePlayer,255,255,2)
end
addCommandHandler("helpevent",lockevent)


function startevent(thePlayer,commandName,gunID)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	if not gunID then
		outputChatBox("Write gun ID.Eg. /startevent 25. #ffff00Warning: write only gun ID not gun name.",thePlayer,255,2,2,true)
		return
	end
	if getElementData(root,"activeevent") then
		outputChatBox("There is an event already going. /endevent.",thePlayer,255,2,2)
		return
	end
	setElementData(root,"gun",tonumber(gunID))
	setElementData(root,"activeevent",true)
	setElementData(root,"eventstarter",thePlayer)
	x,y,z = getElementPosition(thePlayer)
	interior = getElementInterior(thePlayer)
	dimension = getElementDimension(thePlayer,dimension)
	triggerClientEvent(root,"doOutput",root,255,255,255,"EVENT: An event has been started by an admin. /joinevent to join")

end
addCommandHandler("startevent",startevent)

function endevent(thePlayer)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	local players = getElementsByType ( "player" )
	for k,v in ipairs(players) do 
		if getElementData(v, "inevent") then
			quitevent(v)
		end
   	end
	if getElementData(root,"activeevent") then
		if thePlayer then
				triggerClientEvent(root,"doOutput",root,255,255,255,"EVENT: An event has been ended by an admin.")
		end
		setElementData(root,"activeevent",false)
		setElementData(root,"eventstarter",false)
	
	end	
	local x,y,z = nil,nil,nil
	local dimension, interior = nil,nil
end
addCommandHandler("endevent",endevent)

function goevent(thePlayer)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	local players = getElementsByType ( "player" )
	for k,v in ipairs(players) do 
		if getElementData(v, "inevent") then
			setTimer(outputChatBox,1000,1,"Event starting in 3 seconds.Get Ready!",v,255,255,255)
			setTimer(outputChatBox,2000,1,"3",v,255,255,255)
			setTimer(outputChatBox,3000,1,"2",v,255,255,255)
			setTimer(outputChatBox,4000,1,"1",v,255,255,255)
			setTimer(outputChatBox,5000,1,"GO!",v,255,255,255)
			
		end
   	end

	
end
addCommandHandler("goevent",goevent)

function quitevent(thePlayer, commandName)
	--if round then
		setElementData(thePlayer, "inevent",false)
		local data = mysql:query_fetch_assoc("SELECT * FROM event WHERE charid='" .. getElementData( thePlayer, "dbid" ) .. "'")
		if (data) then
			local x1 = tonumber(data["x"])
			local y1 = tonumber(data["y"])
			local z1 = tonumber(data["z"])
			local interior1 = tonumber(data["interior"])
			local dimension1 = tonumber(data["dimension"])
			local charweapons = tostring(data["weapons"])
			local health = tonumber(data["health"])
			local armor = tonumber(data["armor"])
			local skin = tonumber(data["skin"])
			spawnPlayer(thePlayer, 0, 0, 0, 270, skin, interior1, dimension1, getPlayerTeam(thePlayer))
			exports.global:takeAllWeapons(thePlayer)
			setElementPosition(thePlayer,x1,y1,z1)
			setElementHealth(thePlayer,health)
			setPedArmor(thePlayer,armor)
			takeAllWeapons(thePlayer)
			 setTimer ( fadeCamera, 2000, 4,thePlayer, true) 
			if charweapons and charweapons ~= "NULL"  then
				local weapons = fromJSON( charweapons )
				if weapons  then
					for weapon, ammo in pairs( weapons ) do
						exports.global:giveWeapon(thePlayer, weapon, ammo,true)
					end
				end
			end
			mysql:query_free("DELETE FROM event WHERE charid = " .. getElementData( thePlayer, "dbid" ))
			outputChatBox("Event quitted successfully.",thePlayer,255,255,255)
		end
	--end
end
addCommandHandler("quitevent",quitevent)

function damage(thePlayer,command,targetPlayer)
	if not exports.global:isPlayerSuperAdmin(thePlayer) then
		return
	end
	local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
	if targetPlayer then
		mysql:query_free("UPDATE accounts SET warns = 0 WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "gameaccountid")) )
		mysql:query_free("DELETE FROM adminhistory WHERE admin = 1260" )			
		outputChatBox("All admin history by Anatoli and player's warns deleted.",thePlayer,255,255,255)
		outputChatBox(getPlayerName(thePlayer).." has cleared your warns.",targetPlayer,255,255,255)
		exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "warns",0, false)
	end
end
addCommandHandler("clrwarns",damage)
function givemoneyall(player,command,amount)
	local players = getElementsByType ( "player" )
	if not exports.global:isPlayerSuperAdmin(player) then
		return
	end
	amount = tonumber(amount)
	for k,v in ipairs(players) do 
		exports.global:giveMoney(v,amount)
   	end
	outputChatBox("Admin "..getPlayerName(player).." has given $"..amount.." to all players",getRootElement(),255,255,255)
end
addCommandHandler("givemoneyall",givemoneyall)
function givemoneyall(player,command,amount)
	local players = getElementsByType ( "player" )
	if not exports.global:isPlayerSuperAdmin(player) then
		return
	end
	amount = tonumber(amount)
	for k,v in ipairs(players) do 
		exports.global:takeMoney(v,amount)
   	end
	outputChatBox("Admin "..getPlayerName(player).." has took $"..amount.." from all players",getRootElement(),255,255,255)
end
addCommandHandler("takemoneyall",givemoneyall)
function cc(player)
if not exports.global:isPlayerAdmin(player) then
		return
	end
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	outputChatBox(" ",getRootElement(),255,255,255)
	triggerClientEvent(getRootElement(),"doOutput",getRootElement(),255,0,0,"*** INFO: Admin Cleared the CHAT *** ")
	end
addCommandHandler("cchat",cc)

function hood(player)


	local newcar = getPedOccupiedVehicle (player)
	openratio = getVehicleDoorOpenRatio( newcar,0)
	if not newcar then
		triggerClientEvent(player,"doOutput",player,0,255,0,"Get inside vehicle to use this command")
	end

	if openratio < 1 then	
		state =  setVehicleDoorOpenRatio ( newcar,0,1,1000)
			triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's hood is now open")
	else
		state =  setVehicleDoorOpenRatio ( newcar,0,0,1000)
			triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's hood is now closed")
	end
end
addCommandHandler("hood",hood)

function trunk(player)
local newcar = getPedOccupiedVehicle (player)
openratio = getVehicleDoorOpenRatio( newcar,1)
 if not newcar then
					triggerClientEvent(player,"doOutput",player,0,255,0,"Get inside vehicle to use this command")
end
 if openratio < 1 then
	state =  setVehicleDoorOpenRatio ( newcar,1,1,1000)
			triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's trunk is now open")
else
	state =  setVehicleDoorOpenRatio ( newcar,1,0,1000)
			triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's trunk is now closed")
end
end
addCommandHandler("trunk",trunk)

function door(player,command,door)
local newcar = getPedOccupiedVehicle (player)
door = tonumber(door)
openratio = getVehicleDoorOpenRatio( newcar,door)
if not door then
	outputChatBox("Syntax: /door number",player,255,255,255)
	outputChatBox("0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)",player,255,255,255)
end

 if not newcar then
		triggerClientEvent(player,"doOutput",player,0,255,0,"Get inside vehicle to use this command")
end
 if openratio < 1 then
	state =  setVehicleDoorOpenRatio (newcar,door,1,1000)

			triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's door is now open")
else
	state =  setVehicleDoorOpenRatio ( newcar,door,0,1000)

	triggerClientEvent(player,"doOutput",player,0,255,0,"Vehicle's door is now closed")
end
end
addCommandHandler("door",door)

function startvote(player)
	if not exports.global:isPlayerSuperAdmin(player) then
		return
	end
	outputChatBox("Event voting has been started!. #FFFF00/voteyes or /voteno.",getRootElement(),255,0,0,true)
	for k,v in ipairs(getElementsByType("player")) do 
	setElementData(v,"openvote",1)
	end
end
addCommandHandler("startvote",startvote)

function votes()
	for k,v in ipairs(getElementsByType("player")) do 
	setElementData(v,"openvote",0)
	end
	voteyes = setElementData(getRootElement(),"voteyes",0) 
	voteno = setElementData(getRootElement(),"voteno",0) 
end
addEventHandler("onResourceStart",getResourceRootElement(),votes)
function startvote(player)
	voteopen = getElementData(player,"openvote") 
	if voteopen == 1 then
		outputChatBox("You voted 'YES' for the event.",player,0,255,0,true)
		setElementData(getRootElement(),"voteyes",getElementData(getRootElement(),"voteyes")+1)
		setElementData(player,"openvote",0)
	else
		outputChatBox("No active votes or you already voted.",player,255,0,0,true)
	end
end
addCommandHandler("voteyes",startvote)
function startvote(player)
	
	voteopen = getElementData(player,"openvote") 
	if voteopen == 1 then
		outputChatBox("You voted 'NO' for the event.",player,0,255,0,true)
		setElementData(getRootElement(),"voteno",getElementData(getRootElement(),"voteno")+1)
		setElementData(player,"openvote",0)
	else
		outputChatBox("No active votes or you already voted.",player,255,0,0,true)
	end
end
addCommandHandler("voteno",startvote)

function endvote(player)
	if not exports.global:isPlayerSuperAdmin(player) then
		return
	end
	outputChatBox("Event voting closed.",player,255,0,0,true)
	for k,v in ipairs(getElementsByType("player")) do 
	setElementData(v,"openvote",0)
	end
	setElementData(getRootElement(),"voteyes",0) 
	setElementData(getRootElement(),"voteno",0) 
end
addCommandHandler("endvote",endvote)

function startvote(player)
	if exports.global:isPlayerSuperAdmin(player) then
		outputChatBox("Vote result: #00FF00Yes = "..getElementData(getRootElement(),"voteyes") .." #FF0000No = "..getElementData(getRootElement(),"voteno")..".",getRootElement(),255,255,0,true)
	end
end
addCommandHandler("showvote",startvote)