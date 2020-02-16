----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_s.lua
-- Version: 1.0
----------------------------------------->>




local DXNotifications = {}
local DXNoteSorted = {}

local sX,sY = 500,200
local aX,aY = (sX*0.95), (sY*0.95)
local font = "clear"

addEventHandler("onClientResourceStart", resourceRoot, function()
    font = dxCreateFont("fonts/verdana.ttf", 12)
end)

local Z_OFFSET = -25    -- Distance between Notifications
local VEH_OFFSET = 205  -- Offset of Vehicle HUD
local ALPHA = 255       -- Shadow Alpha


-- Draw Notification
--------------------->>

function drawNote(id, text, r, g, b, timer)
    if (type(id) ~= "string") then return end
    if (not text or text == "") then
        DXNotifications[id] = nil
        for i,v in ipairs(DXNoteSorted) do
            if (v == id) then
                table.remove(DXNoteSorted, i)
                break
            end
        end
        return true
    end
    
    if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
    if (timer and type(timer) ~= "number") then return false end
    if (r > 255 or g > 255 or b > 255) then return false end
    
    local iNotes = #DXNoteSorted
    
    if (not DXNotifications[id]) then
        DXNotifications[id] = {text, r, g, b}
        if (timer) then
            local tick = getTickCount()+timer
            DXNotifications[id][5] = tick
        end
        table.insert(DXNoteSorted, id)
    else
        DXNotifications[id][1] = text
        DXNotifications[id][2] = r
        DXNotifications[id][3] = g
        DXNotifications[id][4] = b
        if (timer) then
            local tick = getTickCount()+timer
            DXNotifications[id][5] = tick
        end
    end
    
    if (iNotes == 0) then
        addEventHandler("onClientRender", root, renderDXNotification)
    end
    playSoundFrontEnd(11)
    return true
end




local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

local bags = {}

addEvent ("GTIstoreRob_moneyBag", true )
addEventHandler ("GTIstoreRob_moneyBag", root, 
    function ( )
        bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
        setElementDoubleSided ( bags[client], true )
        exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)
    end
)



addEvent ("GTIstoreRob_setPedAnim", true )
addEventHandler ("GTIstoreRob_setPedAnim", root, 
    function ( )
        exports.btc_anims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEvent ("GTIstoreRob_payoutForSafe", true )
addEventHandler ("GTIstoreRob_payoutForSafe", root,
    function ( )
        pay = math.random(30000, 50000) --math.random(3925*LOWER_BOUND, 3925*UPPER_BOUND)
		name = getPlayerName ( client )
        givePlayerMoney(client, pay)
        setElementData(client, "char:money", getElementData(client, "char:money") + pay)
        setElementData(client, "char:moneysujo", (getElementData(client,"char:moneysujo") or 0) + pay)
        
        outputChatBox(getElementData(client, "char:money"))
        outputChatBox(getElementData(client, "char:moneysujo"))
	triggerClientEvent(client, "onClientPlayerGiveMoney", client, pay)
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)



addEvent ("GTIstoreRob_payOutForCashRegister", true )
addEventHandler ("GTIstoreRob_payOutForCashRegister", root,
    function ( player )
        moneyfor = math.random ( 200, 400 )
        givePlayerMoney(client, moneyfor)
		setElementData(client, "char:money", getElementData(client, "char:money") + moneyfor)
	triggerClientEvent(client, "onClientPlayerGiveMoney", client, moneyfor)
    end
)

local isPlayerNotAllowedToRob = {}

addEvent ("GTIstoreRob_WantedLevel", true )
addEventHandler ("GTIstoreRob_WantedLevel", root,
    function ( )
       --exports.btc_policeWanted:chargePlayer ( client, 24 )
	   
	   			local x, y, z = getElementPosition ( client )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
			for _, players in ipairs(getElementsByType("player")) do
			drawNote("assalto" .. location .. "", "[Denuncia Anônima]: Estão roubando uma loja no bairro " .. location .. " " .. city, 255, 255, 255, 20000)
			end
			
			
	   	--local wantedLvl = getPlayerWantedLevel ( client )
		--setPlayerWantedLevel ( client, wantedLvl + 3 )
        local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = false
        end, 360000, 1, serial)
    end
)

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIstoreRob_CancelOnArrest", source )
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)
addEventHandler ("onPlayerJailed", root, onArrestCancelTheRob)

addEvent ("GTIstoreRob_stopMission", true )
addEventHandler ("GTIstoreRob_stopMission", root,
    function()
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

function onPlayerQuit ( )
    if ( bags[source] and isElement ( bags[source] ) ) then
        destroyElement (bags[source] )
        bags [source] = nil
    end
end
addEventHandler ("onPlayerQuit",root,onPlayerQuit )


