local g_screenX,g_screenY = guiGetScreenSize()
local BONE_ID = 8
local WORLD_OFFSET = 0.4
local ICON_PATH = "images/voice.png"
local ICON_WIDTH = 0.35*g_screenX
-- local ICON_HEIGHT = 0.213333333333*g_screenY
--
local iconHalfWidth = ICON_WIDTH/2
-- local iconHalfHeight = ICON_HEIGHT/2

local ICON_DIMENSIONS = 16
local ICON_LINE = 20
local ICON_TEXT_SHADOW = tocolor ( 0, 0, 0, 255 )
local R, G, B = 255, 255, 255

--Draw the voice image
addEventHandler ( "onClientRender", root,
	function()
		local index = 0
		if not bShowChatIcons then return end
		for player in pairs(voicePlayers) do
			local color = tocolor(getPlayerNametagColor ( player ))
			dxDrawVoiceLabel ( player, index, color )
			index = index + 1
			while true do
				--is he streamed in?
				if not isElementStreamedIn(player) then
					break
				end
				--is he on screen?
				if not isElementOnScreen(player) then
					break
				end
				local headX,headY,headZ = getPedBonePosition(player,BONE_ID)
				headZ = headZ + WORLD_OFFSET
				--is the head position on screen?
				local absX,absY = getScreenFromWorldPosition ( headX,headY,headZ )
				if not absX or not absY then
					break
				end
				local camX,camY,camZ = getCameraMatrix()
				--is there anything obstructing the icon?
				if not isLineOfSightClear ( camX, camY, camZ, headX, headY, headZ, true, false, false, true, false, true, false, player ) then
					break
				end
				dxDrawVoice ( absX, absY, color, getDistanceBetweenPoints3D(camX, camY, camZ, headX, headY, headZ) )
				break
			end
		end
	end
)

function dxDrawVoice ( posX, posY, color, distance )
	distance = 1/distance
	--dxDrawImage ( posX - iconHalfWidth*distance, posY - iconHalfWidth*distance, ICON_WIDTH*distance, ICON_WIDTH*distance, ICON_PATH, 0, 0, 0, color, false )
end


function dxDrawCircle3D( x, y, z, radius, segments, color, width )
    segments = segments or 16; -- circle is divided into segments -> higher number = smoother circle = more calculations
    width = width or 1;
    local segAngle = 360 / segments;
    local fX, fY, tX, tY; -- drawing line: from - to
    for i = 1, segments do
    fX = x + math.cos( math.rad( segAngle * i ) ) * radius;
    fY = y + math.sin( math.rad( segAngle * i ) ) * radius;
    tX = x + math.cos( math.rad( segAngle * (i+1) ) ) * radius;
    tY = y + math.sin( math.rad( segAngle * (i+1) ) ) * radius;
    dxDrawLine3D( fX, fY, z, tX, tY, z, color, width );
    end
end

function dxDrawVoiceLabel ( player, index, color )
	local sx, sy = guiGetScreenSize ()
	local scale = sy / 800
	local spacing = ( ICON_LINE * scale )
	local px, py = sx - 200, sy * 0.7 + spacing * index
	local icon = ICON_DIMENSIONS * scale
	local x, y, z = getElementPosition(getLocalPlayer())

	--dxDrawImage ( px, py, icon, icon, ICON_PATH, 0, 0, 0, color, false )

	px = px + spacing

	-- shadows
	--dxDrawText ( getPlayerName ( player ), px + 1, py + 1, px, py, ICON_TEXT_SHADOW, scale )
	-- text
	--dxDrawText ( getPlayerName ( player ), px, py, px, py, color, scale )
	R, G, B = 0, 0, 255
	x, y, z = getElementPosition(getLocalPlayer())
    --dxDrawCircle3D( -418.481, -1759.502, 6.219 -1, 0.5, 30, tocolor( 65, 180, 170 ),9)
    dxDrawCircle3D( x, y, z -0.7, 0.5, 30, tocolor( 0, 186, 235 ),9)
end

bindKey("z", "up",
function ()
	R, G, B = 255, 255, 255
end)