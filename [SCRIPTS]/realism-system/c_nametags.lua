local localPlayer = getLocalPlayer()
local show = true

function startRes()
	for key, value in ipairs(getElementsByType("player")) do
		setPlayerNametagShowing(value, false)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), startRes)

local playerhp = { }
local lasthp = { }

local playerarmor = { }
local lastarmor = { }

function playerQuit()
	if (getElementType(source)=="player") then
		playerhp[source] = nil
		lasthp[source] = nil
		playerarmor[source] = nil
		lastarmor[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", getRootElement(), playerQuit)
addEventHandler("onClientPlayerQuit", getRootElement(), playerQuit)


function setNametagOnJoin()
	setPlayerNametagShowing(source, false)
end
addEventHandler("onClientPlayerJoin", getRootElement(), setNametagOnJoin)

function streamIn()
	if (getElementType(source)=="player") then
		playerhp[source] = getElementHealth(source)
		lasthp[source] = playerhp[source]
		
		playerarmor[source] = getPedArmor(source)
		lastarmor[source] = playerarmor[source]
	end
end
addEventHandler("onClientElementStreamIn", getRootElement(), streamIn)

function isPlayerMoving(player)
	return (not isPedInVehicle(player) and (getPedControlState(player, "forwards") or getPedControlState(player, "backwards") or getPedControlState(player, "left") or getPedControlState(player, "right") or getPedControlState(player, "accelerate") or getPedControlState(player, "brake_reverse") or getPedControlState(player, "enter_exit") or getPedControlState(player, "enter_passenger")))
end

local lastrot = nil

function aimsSniper()
	return getPedControlState(localPlayer, "aim_weapon") and getPedWeapon(localPlayer) == 34
end

function aimsAt(player)
	return getPedTarget(localPlayer) == player and aimsSniper()
end

function renderNametags()
	if (show) then
		local players = { }
		local distances = { }
		local lx, ly, lz = getCameraMatrix()
	
		for key, player in ipairs(getElementsByType("player")) do
			if (isElement(player)) and isElementStreamedIn(player) then
				local logged = getElementData(player, "loggedin")
				
				if (logged == 1) then
					local lx, ly, lz = getElementPosition(localPlayer)
					local rx, ry, rz = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
					local limitdistance = 20
					local reconx = getElementData(localPlayer, "reconx")
					
					-- smoothing
					playerhp[player] = getElementHealth(player)
					
					if (lasthp[player] == nil) then
						lasthp[player] = playerhp[player]
					end
					
					playerarmor[player] = getPedArmor(player)
					
					if (lastarmor[player] == nil) then
						lastarmor[player] = playerarmor[player]
					end
					
					if (player~=localPlayer) and (isElementOnScreen(player)) and (aimsAt(player) or distance<limitdistance or reconx) then
						if not getElementData(player, "reconx") and not getElementData(player, "freecam:state") then
							--local lx, ly, lz = getPedBonePosition(localPlayer, 7)
							local lx, ly, lz = getCameraMatrix()
							local vehicle = getPedOccupiedVehicle(player)
							local collision, cx, cy, cz, element = processLineOfSight(lx, ly, lz, rx, ry, rz+1, true, true, true, true, false, false, true)

							if not (collision) or aimsSniper() or (reconx) then
								local x, y, z = getElementPosition(player)
								
								if not (isPedDucked(player)) then
									z = z + 1
								else
									z = z + 0.5
								end
								
								local sx, sy = getScreenFromWorldPosition(x, y, z+0.45, 100, false)
								local oldsy = nil
								-- HP
								if (sx) and (sy) then
									
									local health = math.ceil(lasthp[player])
									if ( math.ceil(playerhp[player]) < health ) then
										health = health - 1
										lasthp[player] = health
									elseif ( math.ceil(playerhp[player]) > health ) then
										health = health + 1
										lasthp[player] = health
									end
									
									if (health>0) then
										distance = distance / 5
										
										if (reconx or aimsAt(player)) then distance = 1
										elseif (distance<1) then distance = 1
										elseif (distance>2) then distance = 2 end
										
										local offset = 45 / distance
										
										-- DRAW BG
										dxDrawRectangle(sx-offset-5, sy, 95 / distance, 20 / distance, tocolor(255,255,255,255), false)
										oldsy = sy 
										
										-- DRAW HEALTH
										local width = 85
										local hpsize = (width / 100) * health
										local barsize = (width / 100) * (100-health)
										
										local color
										if (health>70) then
											color = tocolor(0, 255, 0,255)
										elseif (health>35 and health<=70) then
											color = tocolor(255, 255, 0, 255)
										else
											color = tocolor(255, 0, 0, 255)
										end
										
										if (distance<1.2) then
											dxDrawRectangle(sx-offset, sy+5, hpsize/distance, 10 / distance, color, false)
											dxDrawRectangle((sx-offset)+(hpsize/distance), sy+5, barsize/distance, 10 / distance, tocolor(62, 62, 62, 100), false)
										else
											dxDrawRectangle(sx-offset, sy+5, hpsize/distance-5, 10 / distance-3, color, false)
											dxDrawRectangle((sx-offset)+(hpsize/distance-5), sy+5, barsize/distance-2, 10 / distance-3, tocolor(62, 62, 62, 100), false)
										end
									end
								end
								
								-- ARMOR
								--sx, sy2 = getScreenFromWorldPosition(x, y, z+0.25, 100, false)
								
								if (sx) and (sy) then
									if (distance<=2) then
										sy = math.ceil( sy + ( 2 - distance ) * 20 )
									end
									sy = sy + 10
									
									
									if (sx) and (sy) then
										local armor = math.ceil(lastarmor[player])

										if ( math.ceil(playerarmor[player]) < armor ) then
											armor = armor - 1
											lastarmor[player] = armor
										elseif ( math.ceil(playerhp[player]) > armor ) then
											armor = armor + 1
											lastarmor[player] = armor
										end
										
										if (armor>5) then
											local offset = 45 / distance
											
											-- DRAW BG
											dxDrawRectangle(sx-offset-5, sy, 95 / distance, 20 / distance, tocolor(255,255,255,255), false)
											
											-- DRAW HEALTH
											local width = 85
											local armorsize = (width / 100) * armor
											local barsize = (width / 100) * (100-armor)
											
											
											if (distance<1.2) then
												dxDrawRectangle(sx-offset, sy+5, armorsize/distance, 10 / distance, tocolor(120,120,120, 255), false)
												dxDrawRectangle((sx-offset)+(armorsize/distance), sy+5, barsize/distance, 10 / distance, tocolor(60, 60, 60,255), false)
											else
												dxDrawRectangle(sx-offset, sy+5, armorsize/distance-5, 10 / distance-3, tocolor(120,120,120, 255), false)
												dxDrawRectangle((sx-offset)+(armorsize/distance-5), sy+5, barsize/distance-2, 10 / distance-3, tocolor(60, 60, 60, 255), false)
											end
										end
									end
									
									-- NAME
									--sx, sy = getScreenFromWorldPosition(x, y, z+0.6, 100, false)
									--sy = sy - (60 - distance*10)
									
									if (distance<=2) then
										sy = math.ceil( sy - ( 2 - distance ) * 40 )
									end
									sy = sy - 20
										
									if (sx) and (sy) then
										if (distance < 1) then distance = 1 end
										if (distance > 2) then distance = 2 end
										local offset = 75 / distance
										local scale = 0.6 / distance
										local font = "bankgothic"
										local r, g, b = getPlayerNametagColor(player)
										dxDrawText(getPlayerNametagText(player), sx-offset+2, sy+2, (sx-offset)+130 / distance, sy+20 / distance, tocolor(0, 0, 0, 220), scale, font)
										dxDrawText(getPlayerNametagText(player), sx-offset, sy, (sx-offset)+130 / distance, sy+20 / distance, tocolor(r, g, b, 220), scale, font)
										
										-- DRAW ids
										local offset = 65 / distance
										local id = getElementData(player, "playerid")
										
										if (oldsy) and (id) then
											if (id<100 and id>9) then -- 2 digits
												dxDrawRectangle(sx-offset-15, oldsy, 30 / distance, 20 / distance, tocolor(0, 0, 0, 100), false)
												dxDrawText(tostring(id), sx-offset-22.5, oldsy, (sx-offset)+26 / distance, sy+20 / distance, tocolor(255, 255, 255, 220), scale, font)
											elseif (id<=9) then -- 1 digit
												dxDrawRectangle(sx-offset-5, oldsy, 20 / distance, 20 / distance, tocolor(0, 0, 0, 100), false)
												dxDrawText(tostring(id), sx-offset-12.5, oldsy, (sx-offset)+26 / distance, sy+20 / distance, tocolor(255, 255, 255, 220), scale, font)
											elseif (id>=100) then -- 3 digits
												dxDrawRectangle(sx-offset-25, oldsy, 40 / distance, 20 / distance, tocolor(0, 0, 0, 100), false)
												dxDrawText(tostring(id), sx-offset-32.5, oldsy, (sx-offset)+26 / distance, sy+20 / distance, tocolor(255, 255, 255, 220), scale, font)
											end
										end
									
									
									end
								end
							end
						end
					end
				end
			end
		end
		
	end
end
addEventHandler("onClientRender", getRootElement(), renderNametags)

function hideNametags()
	show = false
end
addEvent("hidenametags", true)
addEventHandler("hidenametags", getRootElement(), hideNametags)

function showNametags()
	show = true
end
addEvent("shownametags", true)
addEventHandler("shownametags", getRootElement(), showNametags)
