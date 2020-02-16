---------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_c.lua
-- Version: 1.0
----------------------------------------->>

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

local DXStats = {}
local DXStatsSorted = {}

local sX,sY = guiGetScreenSize()
local fontA = "default-bold"
local fontB = "default-bold"

local Z_OFFSET = 35     -- Space between stats
local PROG_WIDTH = 125  -- Progress Bar Width
local PROG_HEIGHT = 25  -- Progress Bar Height
local PROG_BORDER = 4   -- Progress Bar Border Thickness
local ALPHA = 255       -- Shadow Alpha

addEventHandler("onClientResourceStart", resourceRoot, function()
    local font = dxCreateFont("fonts/cambria.ttf", 10)
    if (font) then fontA = font end
    local font = dxCreateFont("fonts/verdana.ttf", 16)
    if (font) then fontB = font end
end)

-- Draw Stats
-------------->>

function drawStat(id, columnA, columnB, r, g, b, timer)
    if (type(id) ~= "string") then return end
    if (not columnA or columnA == "") then
        DXStats[id] = nil
        for i,v in ipairs(DXStatsSorted) do
            if (v == id) then
                table.remove(DXStatsSorted, i)
                break
            end
        end
        return true
    end 
    if (type(columnA) ~= "string" or not tostring(columnB) or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
    if (timer and type(timer) ~= "number") then return false end
    
    local iNotes = #DXStatsSorted
    
    if (not DXStats[id]) then
        table.insert(DXStatsSorted, id)
    end
    
    DXStats[id] = {columnA, columnB, r, g, b}
    if (timer) then
        local tick = getTickCount()+timer
        DXStats[id][6] = tick
    end
    
    if (iNotes == 0) then
        addEventHandler("onClientRender", root, renderDXStat)
    end
    return true
end
addEvent("GTIhud.drawStat", true)
addEventHandler("GTIhud.drawStat", root, drawStat)

function guiGetSizeScreen() 
    return guiGetScreenSize()
end
addEvent("guiGetSizeScreen",true)
addEventHandler("guiGetSizeScreen",guiGetSizeScreen)

local DXMessages = {}

local sX,sY = guiGetScreenSize()
local aX,aY,aW,aH = sX*(0.25), (sY*0.95)-20, sX*0.75, sY*0.95
if (sX <= 1280) then
    aX,aY,aW,aH = (sX/2)-(1280/4), (sY*0.95)-20, (sX/2)+(1280/4), sY*0.95
end

local font = "default-bold"

local DISPLAY_TIME = 7500

-- Display Message
------------------->>

function dm(text, r, g, b)
    if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
    if (r > 255 or g > 255 or b > 255) then return false end
    
    if (#DXMessages == math.floor((sY*0.2)/20)) then
        table.remove(DXMessages, 1)
    end
    
    local tick = getTickCount()+DISPLAY_TIME
    dxTable = {text, r, g, b, tick}
    table.insert(DXMessages, dxTable)
    
    if (#DXMessages == 1) then
        addEventHandler("onClientRender", root, renderDXMessage)
    end
    playSoundFrontEnd(11)
    outputConsole(text)
    return true
end
addEvent("GTIhud.dm", true)
addEventHandler("GTIhud.dm", root, dm)

-- Render DX Message
--------------------->>

function renderDXMessage()
    if (isPlayerMapVisible()) then return end
    if (#DXMessages == 0) then
        removeEventHandler("onClientRender", root, renderDXMessage)
    end
    
    local toRemove = 0
    for i,v in ipairs(DXMessages) do
        if (v[5] > getTickCount()) then
            dxDrawRectangle(aX, aY-( (i-1) *20), aW-aX, aH-aY, tocolor(0, 0, 0, 200))
            dxDrawText(v[1], aX, aY-( (i-1) *20), aW, aH-( (i-1) *20), tocolor(v[2], v[3], v[4], 255), 1, font, "center", "center", false, false, false, true)
        else
            toRemove = toRemove + 1
        end
    end
    if (toRemove > 0) then
        for i=1,toRemove do
            table.remove(DXMessages, 1)
        end
    end
    local i = #DXMessages-1
    dxDrawLine(aX-1, aY-1-(i*20), aX-1, aH-1, tocolor(0, 0, 0, 255), 2) -- Left
    dxDrawLine(aX-1, aY-(i*20), aW-1, aY-(i*20), tocolor(0, 0, 0, 255), 2) -- Top
    dxDrawLine(aW, aY-1-(i*20), aW, aH, tocolor(0, 0, 0, 255), 2) -- Right
    dxDrawLine(aX-1, aH-1, aW-1, aH-1, tocolor(0, 0, 0, 255), 2) -- Bottom
end








addEvent("onClientInteriorExit",true)

colShapeDerFix = createColCuboid ( 251.714, -81.700, 0.578, 12, 19, 10 )

local theRobbery = false
local robCashRegister = false
local robberyStarted = false
local hasBag = false
local cancelRobb = false
local intLeave = false

local peds = {

    --{createPed ( 179, 1370.286, -1292.434, 13.549, -90), 0, 0},
    --{createPed ( 179, 1370.297, -1286.706, 18.002, -90), 0, 0},
    {createPed ( 167, 2391.643, -1907.589, 13.557, 3.086), 0, 0},
    {createPed ( 179, 1316.687, -896.606, 39.578, 360 ), 0, 0 },
    {createPed ( 179, 1348.748046875, -1760.7326660156, 13.549824714661, 181.38510131836 ), 0, 0 },
    {createPed ( 167, 2411.5866699219, -1505.5615234375, 24.002511978149, 270.54040527344 ), 0, 0 },
    {createPed ( 179, 2112.098, -1201.445, 23.986, 179.201), 0, 0},
    {createPed ( 31, 438.303, -1505.487, 18.459, 278.116), 0, 0},
    {createPed ( 167, 937.137, -1358.876, 13.351, 92.546), 0, 0},
    {createPed ( 179, 1684.28, -2296.543, -1.219, 9.62 ), 0, 0 },
    {createPed ( 140, 662.785, -1863.757, 5.461, 174.936 ), 0, 0 },


    --{createPed ( 179, 2324.559, 57.402, 20.866, 90), 0, 0},


--[[
{createPed ( 179, 237.804, -167.235, -3.744, 180), 0, 0},
{createPed ( 179, 2170.868, 931.855, 10.096, 90), 0, 0},
{createPed ( 179, -2093.384, -2470.107, 30.625, 50), 0, 0},

{createPed ( 179, -318.559, 829.981, 14.245, 90), 0, 0},
{createPed ( 179, 2550.509, 2071.741, 10.107, 0), 0, 0},



--{createPed ( 59, -2235.597, 128.584, 1035.414, 0), 0, 6 },
--{createPed ( 59, 497.644, -77.471, 998.765, 0 ), 1, 11 },
--{createPed ( 59, -23.286, -57.334, 1003.547, 0 ), 1, 6 },
--{createPed ( 59, -28.066, -91.640, 1003.547, 0 ), 1, 18 },
--{createPed ( 59, -28.066, -91.640, 1003.547, 0 ), 0, 18 },
--{createPed ( 59, -23.409, -57.324, 1003.547, 0 ), 4, 6 },
--{createPed ( 59, -27.963, -91.640, 1003.547, 0 ), 2, 18 },
--{createPed ( 59, -23.409, -57.324, 1003.547, 0 ), 3, 6 },


{createPed ( 59, -1560.088, -2731.392, 48.748, 325 ), 0, 0 },
--{createPed ( 59, 1834.721, -1837.593, 13.595, 265 ), 0, 0 },

{createPed ( 59, 250.219, -54.828, 1.578, 180 ), 0, 0 },
{createPed ( 59, 2356.241, 68.039, 22.3, 90 ), 0, 0 },
{createPed ( 59, 2446.081, 2076.602, 10.826, 180 ), 0, 0 },
]]--
}

local cashRegister = {
--[[
{createObject ( 1514, -2235.574, 129.407, 1035.700, 0, 0, 180 ), 0, 6, 180 },
{createObject ( 1514, 497.646, -76.722, 999.005, 0, 0, 180 ), 1, 11, 180},
{createObject ( 1514, -23.386, -56.597, 1003.706, 0, 0, 180 ), 1, 6, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 1, 18, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 0, 18, 0 },
{createObject ( 1514, -23.395, -56.484, 1003.706, 0, 0, 180 ), 4, 6, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 2, 18, 0 },
{createObject ( 1514, -23.395, -56.484, 1003.706, 0, 0, 180 ), 3, 6, 0 },
]]--
{createObject ( 1514, 2439.421, 2075.942, 11.061, 0, 0, 0 ), 0, 0, 0 },
{createObject ( 1514, -1559.773, -2730.774, 48.895, 0, 0, 140 ), 0, 0, 0 },
{createObject ( 1514, 439.413, -1505.282, 18.663, 0, 0, 90 ), 0, 0, 0 },
{createObject ( 1514, 1316.697, -895.876, 39.624, 0, 0, 180 ), 0, 0, 0 },
{createObject ( 1514, 251.762, -55.555, 1.679, 0, 0, 0 ), 0, 0, 0 },
}

local markers = {
    {2408.949, -1890.547, 13.383},
    {-1561.990, -2733.559, 47.743},
    --{1832.750, -1842.396, 12.578},
    {1313.498, -898.805, 38.578},
    {244.183, -49.155, 0.578},
    {254.637, -64.013, 0.578},
    {2325.879, 74.452, 23.508},
    {2437.921, 2065.402, 9.820},
    {2112.73, -1212.727, 23.965},
    {459.081, -1501.632, 31.036},
    {924.013, -1353.352, 13.377},
    {1677.623, -2289.673, 24.759},
    {661.897, -1867.243, 14.761},
}

function respawnCashRegisters ( )
    for k,v in ipairs ( cashRegister ) do
      setTimer (respawnObject, 7500, 1, ( v[1] ) )
  end
end
addEventHandler ("onClientObjectBreak", root, respawnCashRegisters )

function secsToMin(seconds)
    local hours = 0
    local minutes = 0
    local secs = 0
    local theseconds = seconds
    if theseconds >= 60*60 then
        hours = math.floor(theseconds / (60*60))
        theseconds = theseconds - ((60*60)*hours)
    end
    if theseconds >= 60 then
        minutes = math.floor(theseconds / (60))
        theseconds = theseconds - ((60)*minutes)
    end
    if theseconds >= 1 then
        secs = theseconds
    end 
    if minutes < 10 then
        minutes = "0"..minutes
    end
    if secs < 10 then
        secs = "0"..secs
    end
    return minutes,secs
end

-- Marker and ped functions
function createMarkers ( )

    for k,v in ipairs(peds) do 
        local x, y, z = getElementPosition(v[1])
        --  createBlip ( x, y, z, 53, 1, 0, 0, 0, 0, 0, 1000 )
        local ass = createBlip(x, y, z, 58)
        setElementData(ass ,"blipName", "Assaltos")
    end

--[[
    for i, v in ipairs ( markers ) do
        local x = v[1]
        local y = v[2]
        local z = v[3]
        safeMarker = createMarker ( x, y, z, "cylinder", 3, 0, 0, 0, 0 )
        addEventHandler ("onClientMarkerHit", safeMarker, robberyCancelOnMarkerHit )
        addEventHandler ("onClientMarkerLeave", safeMarker, robberyCancelOnMarkerHit )
    end  
    ]]-- 
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )


function breakCashRegister ( player )
    if ( player == localPlayer and robCashRegister == false and robberyStarted == true ) then
        triggerServerEvent ("GTIstoreRob_payOutForCashRegister", localPlayer )
        robCashRegister = true
        timer = setTimer ( timeForCashRegister, 360000, 1 )
    else
        cancelEvent()
    end
end

function cancelTheKill ( player )
    cancelEvent ()
end

for k,v in ipairs(peds) do 
    addEventHandler ( "onClientPedDamage", v[1], cancelTheKill )
    setElementFrozen ( v[1], true )
    setElementInterior ( v[1], v[3] )
    setElementDimension ( v[1], v[2] )
end

for k,v in ipairs(cashRegister) do 
    addEventHandler ("onClientObjectBreak", v[1], breakCashRegister )
    setElementInterior ( v[1], v[3] )
    setElementDimension ( v[1], v[2] )
    setElementDoubleSided ( v[1], true )
end

function isItAPedToRob( ped )
    for k,v in ipairs(peds) do 
        if v[1] == ped then return true end
    end
end


setDevelopmentMode(true)
local teste1 = createColSphere(1316.5471191406,-896.48675537109,39.578125,3)
local teste2 = createColSphere(2391.643, -1907.589, 13.557,3)
local teste3 = createColSphere(1348.748046875, -1760.7326660156, 13.549824714661,3)
local teste4 = createColSphere(2411.5866699219, -1505.5615234375, 24.002511978149,3)
local teste5 = createColSphere(2112.115, -1201.606, 23.866,3)
local teste6 = createColSphere(438.303, -1505.487, 18.459,3)
local teste7 = createColSphere(937.137, -1358.876, 13.351,3)
local teste8 = createColSphere(1684.3642578125,-2296.6496582031,-1.2178611755371,3)
local teste9 = createColSphere(662.78527832031,-1863.7574462891,5.4609375,3)




--outputChatBox(getPedWeaponSlot ( localPlayer ))

function detectAim( target )
    --local job = exports.btc_employment:getPlayerJob(true)
    --if getPlayerTeam(localPlayer) == getTeamFromName("Policia") then return end
    
    if isElementWithinColShape(localPlayer, teste1) or isElementWithinColShape(localPlayer, teste2) or isElementWithinColShape(localPlayer, teste3) or isElementWithinColShape(localPlayer, teste4) or isElementWithinColShape(localPlayer, teste5) or isElementWithinColShape(localPlayer, teste6) or isElementWithinColShape(localPlayer, teste7) or isElementWithinColShape(localPlayer, teste8) or isElementWithinColShape(localPlayer, teste9) then

        local pedSlot = getPedWeaponSlot ( localPlayer )
        if (pedSlot == 0)	then return end
        
        local arma = getPedWeapon ( localPlayer )
        if (arma == 22)	then return end




        if ( target ) and ( getElementType( target ) == "ped" ) and (source == localPlayer) and getPedControlState("aim_weapon") and isItAPedToRob(target) then

            if ( robberyStarted == true ) then
                if not isDX then
                    dm("Porfavor eu não tenho mais dinheiro me deixe em paz!.", 200, 0, 0 )
                    isDX = true
                    setTimer(function() isDX = false end, 10000, 1)
                    return
                end
            end
            if (not robberyStarted) then



                local policiaTeam = getTeamFromName ( "Policia" )
                local groveCount = countPlayersInTeam ( policiaTeam )
                if true then


                    setPedAnimation( target, "SHOP", "SHP_Rob_GiveCash", 3000, false, false, false, false)
                    --triggerServerEvent ("GTIstoreRob_WantedLevel", localPlayer )
                    theRobbery = true
                    dm("(fique dentro do local por 3 minutos!)", 200, 255, 0)
                        dm("Mãos pra cima isso é um assalto", 200, 0, 0)

                        isDX = true
                        setTimer(function() isDX = false end, 10000, 1)
                        robberyStarted = true
                        setElementData(localPlayer, "isPlayerRobbing", true)
                        cancelRobb = true
                        intLeave = true
                        seconds = 10
                        countDown = setTimer ( cDown, 1000, 20000 )
                    else
                     outputChatBox("#dc143c[AVISO]:#ffffff Não tem policia na cidade ( minimo 8 policiais ), vaza daqui!", 255, 255, 255, true)
                 end
             end
         end

     end
 end
 addEventHandler ( "onClientPlayerTarget", localPlayer, detectAim )
 addEventHandler ( "onClientColShapeHit", root, detectAim )


 function timeForCashRegister ( )
    robCashRegister = false
end

function cDown ( )
    seconds = seconds - 1
    local mins,secds = secsToMin(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer( countDown )
        createMoneyBag()
        setElementData(localPlayer, "isPlayerRobbing", false)
        drawStat("storeRobTimer", "", "", 200, 0, 0)
    else
        drawStat("storeRobTimer", "Tempo restante: ", mins..":"..secds, 200, 0, 0)
    end
end

function createMoneyBag ( )
    triggerServerEvent ("GTIstoreRob_moneyBag", localPlayer )
    x, y, z = getElementPosition ( localPlayer )
    colshape = createColCuboid ( x-200, y-200, z-50, 400, 400, 100 )
    dm("Assalto com sucesso saia da zona verde que apareceu no radar para receber o dinheiro!", 200, 0, 0)
    leaveAreaRadar = createRadarArea ( x-200, y-200, 400, 450, 0, 200, 0, 150 )
    addEventHandler ("onClientColShapeLeave", colshape, payoutForSafe )
    hasBag = true
end

function payoutForSafe ( player )
	if ( player == localPlayer ) and not isTimer(payTimer) then
       payTimer = setTimer(function()
           if (getElementInterior(localPlayer) ~= 0) or (getElementDimension(localPlayer) ~= 0) then return end
           if ( robberyStarted == false ) then return end
           if ( hasBag == false ) then return end
           triggerServerEvent ("GTIstoreRob_payoutForSafe", localPlayer )
           c = setTimer ( isRobberyFalseAgain, 10, 1 )
           destroyElement ( colshape )
           destroyElement ( leaveAreaRadar )
       end, 500, 1 )
   end
end

-- Cancel the robbery functions

--[[function createMarkers ( )
    for i, a in ipairs ( cancelMarkers ) do
        local x = a[1]
        local y = a[2]
        local z = a[3]
        cancelMarker = createMarker ( x, y, z, "cylinder", 4, 0, 0, 0, 0 )
        addEventHandler ("onClientMarkerHit", cancelMarker, robberyCancelOnMarkerHit )
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )--]]

local recieved = {}

function cancelRobbery ( jobName )
    if ( source == localPlayer ) then
        if ( intLeave == false ) then return end
        if ( robberyStarted == false) then return end
        if ( theRobbery == false ) then return end
        triggerServerEvent ("GTIstoreRob_stopMission", localPlayer )
        unbindKey ( "N", "down", startCrack )
        drawStat("storeRobTimer", "", "", 200, 0, 0)
        drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
        if (not recieved[localPlayer]) then
            dm("Você falhou no assalto!", 200, 0, 0)
            recieved[localPlayer] = true
        end   
        robCashRegister = true
        theRobbery = false
        hasBag = false
        if isElement ( colshape ) then destroyElement ( colshape ) end
        if isElement ( leaveAreaRadar ) then destroyElement ( leaveAreaRadar ) end
        setElementData(localPlayer, "isPlayerRobbing", false)
        if isTimer ( countDown ) then killTimer ( countDown ) end
        if isTimer ( timer ) then killTimer ( timer ) end
        if isTimer ( c ) then killTimer ( c ) end
        c = setTimer ( isRobberyFalseAgain, 1000, 1 )
    end
end

addEventHandler ("onClientPlayerQuitJob", root, 
    function ( jobName )
        if not jobName then 
            return true
        else
            return cancelRobbery ( )
        end
    end
    )

addEventHandler ("onClientPlayerGetJob", root, 
    function ( jobName ) 
        if jobName == "Criminal" then
            return true
        else
            return cancelRobbery ( )
        end
    end

    )

addEventHandler ("onClientPlayerWasted", localPlayer,
    function ( )
        cancelRobbery(localPlayer)
    end

    )


addEvent ("GTIstoreRob_CancelOnArrest", true )
addEventHandler ("GTIstoreRob_CancelOnArrest", root,
    function ()
        cancelRobbery()
    end
    )



local zone = createColCuboid(2380.43872, -1914.23547, 12.54688, 19.298095703125, 14.136474609375, 3.7000011444092)
local zone2 = createColCuboid(2409.65259, -1511.18237, 23.00000, 8.986328125, 18.93798828125, 3.9999946594238)
local zone3 = createColCuboid(1342.31470, -1770.88306, 10.95000, 22.0830078125, 11.440673828125, 6.5000213623047)
local zone4 = createColCuboid(1304.45557, -897.47839, 38.07304, 26.8134765625, 20.557800292969, 7.1000274658203)
local zone5 = createColCuboid(2105.19775, -1210.71985, 22.68626, 20.486328125, 19.161987304688, 4.5999931335449)
local zone6 = createColCuboid(430.75732, -1511.03052, 17.36860, 32.690795898438, 15.77978515625, 8.1999839782715)
local zone7 = createColCuboid(927.80475, -1370.13892, 12.08152, 11.592041015625, 20.926635742188, 4.3000005722046)
local zone8 = createColCuboid(1660.10242, -2301.18018, -2.18887, 46.776245117188, 29.052490234375, 9.4000004768372)
local zone9 = createColCuboid(647.63837, -1874.81714, 4.46094, 31.708984375, 15.641845703125, 4.900001907348)

function robberyCancelOnMarkerHit ( player )
    if ( player == localPlayer ) then
        if ( intLeave == false ) then return end
        if ( hasBag == true ) then return end
        unbindKey ( "N", "down", startCrack )
        drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
        if ( cancelRobb == false ) then return end
        if ( robberyStarted == false) then return end
        drawStat("storeRobTimer", "", "", 200, 0, 0)
        if (not recieved[localPlayer]) then
            dm("Você falhou no assalto!", 200, 0, 0)
            recieved[localPlayer] = true
        end
        setElementData(localPlayer, "isPlayerRobbing", false)
        theRobbery = false
        cancelRobb = false
        hasBag = false
        robCashRegister = true
        triggerServerEvent ("GTIstoreRob_stopMission", localPlayer )
        if isElement ( colshape ) then destroyElement ( colshape ) end
        if isElement ( leaveAreaRadar ) then destroyElement ( leaveAreaRadar ) end
        if isTimer ( countDown ) then killTimer ( countDown ) end
        if isTimer ( timer ) then killTimer ( timer ) end
        if isTimer ( c ) then killTimer ( c ) end
        c = setTimer ( isRobberyFalseAgain, 180000, 1 )
    end
end

addEventHandler ("onClientColShapeLeave", zone, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone2, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone3, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone4, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone5, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone6, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone7, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone8, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", zone9, robberyCancelOnMarkerHit )

--addEventHandler ("onClientColShapeHit", colShapeDerFix, robberyCancelOnMarkerHit )
--addEventHandler ("onClientColShapeLeave", colShapeDerFix, robberyCancelOnMarkerHit )
--addEventHandler ("onClientInteriorExit", root, robberyCancelOnMarkerHit )

function isRobberyFalseAgain ( )
    robberyStarted = false
    robCashRegister = false
    theRobbery = false
    cancelRobb = false
    intLeave = false
    hasBag = false
    if isTimer ( timer ) then killTimer ( timer ) end
    if isTimer ( c ) then killTimer ( c ) end
end
