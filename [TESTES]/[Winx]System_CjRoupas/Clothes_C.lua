﻿-- Tables
local theCategories = { [0]="Camisetas", [1]="Cabelo", [2]="Calças/bermudas", [3]="Tênis", [4]="Tattoos: Left Upper Arm", [5]="Tattoos: Left Lower Arm", [6]="Tattoos: Right Upper Arm", [7]="Tattoos: Right Lower Arm", [8]="Tattoos: Back", [9]="Tattoos: Left Chest", [10]="Tattoos: Right Chest", [11]="Tattoos: Stomach", [12]="Tattoos: Lower Back", [13]="Cordões", [14]="Relógios", [15]="Bandanas", [16]="Boné", [17]="Extras" }

local theMarkers = {
    {1890.830078125,-1318.1259765625,29.4921875, 0, 0}, -- Shopping
	--[[
    {1097.14661, -1433.43970, 15, 0, 0}, -- Dev one
    {2123.725, -1198.089, 23.207, 0, 0}, -- Glen Park
    {1467.643, -1119.731, 23.152, 0, 0}, -- Downtown]]--
}
local x, y, z, int, dim = nil, nil, nil, nil, nil
local pricesModel = {}
local previousModel = nil
local roupaBlip=createBlip(1873.5390625,-1320.7646484375,29.4921875 ,45)
-- GUI Window
CJClothesWindow = guiCreateWindow(509,153,444,480,"Roupas do CJ",false)
CJClothesLabel1 = guiCreateLabel(12,22,203,16,"Categorias:",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel1,"center",false)
guiSetFont(CJClothesLabel1,"default-bold-small")
CJClothesCatoGrid = guiCreateGridList(9,41,214,320,false,CJClothesWindow)
guiGridListSetSelectionMode(CJClothesCatoGrid,0)
CJClothesItemGrid = guiCreateGridList(225,40,210,321,false,CJClothesWindow)
guiGridListSetSelectionMode(CJClothesItemGrid,0)
CJClothesLabel2 = guiCreateLabel(230,22,203,16,"Items:",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel2,"center",false)
guiSetFont(CJClothesLabel2,"default-bold-small")
CJClothesLabel3 = guiCreateLabel(9,400,422,46,"Clique duas vezes em um item para alterar as roupas do CJ.\nSe você gostar da roupa cliquem em salvar, caso contrário clicando em guardar para voltar.\nEsta pele será salvo e definir quando usar a pele CJ.",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel3,"center",false)
CJClothesLabel4 = guiCreateLabel(15,452,414,20,"Total preço: $0",false,CJClothesWindow)
guiLabelSetColor(CJClothesLabel4,48,128,20)
guiLabelSetHorizontalAlign(CJClothesLabel4,"center",false)
guiSetFont(CJClothesLabel4,"default-bold-small")
CJClothesBuyButton = guiCreateButton(225,364,210,30,"Fechar e comprar a roupa",false,CJClothesWindow)
CJClothesCancelButton = guiCreateButton(11,364,211,30,"Fechar e não salvar a roupa",false,CJClothesWindow)

atendente1 = createPed(150,1873.5390625,-1322.7646484375,29.4921875)
atendente2 = createPed(148,1872.2392578125,-1322.830078125,29.4921875)
atendente3 = createPed(151,1875.09765625,-1322.830078125,29.4921875)
local column1 = guiGridListAddColumn( CJClothesCatoGrid, "  Categorias:", 0.8 )
local column2 = guiGridListAddColumn( CJClothesItemGrid, "  Nome:", 0.6 )
local column3 = guiGridListAddColumn( CJClothesItemGrid, "  Preço:", 0.3 )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(CJClothesWindow,false)
local x,y = (screenW-windowW)/1,(screenH-windowH)/1
guiSetPosition(CJClothesWindow,x,y,false)

guiWindowSetMovable (CJClothesWindow, true)
guiWindowSetSizable (CJClothesWindow, false)
guiSetVisible (CJClothesWindow, false)

for i=0,17 do
    local categorie = theCategories[i]
    local row = guiGridListAddRow ( CJClothesCatoGrid )
    guiGridListSetItemText ( CJClothesCatoGrid, row, 1, categorie, false, true )
    guiGridListSetItemData ( CJClothesCatoGrid, row, 1, i )
end

function createClothesJSONString ( returnType )
    local clothesTable = {}
    local smtn = false
    for i=0,17 do
        local texture, model = getPedClothes ( localPlayer, i )
        if ( texture ) then
            local theType, theIndex = getTypeIndexFromClothes ( texture, model )
            clothesTable[theType] = theIndex
            smtn = true
        end
    end
    if ( smtn ) then
        if ( returnType == "JSON" ) then
            return "" .. toJSON( clothesTable ):gsub( " ", "" ) .. ""
        else
            return clothesTable
        end
    else
        return "NULL"
    end
end 

function updatePlayerCJSkin ( CJClothesTable )
    if ( CJClothesTable ) then
        if (CJClothesTable == "NULL") then resetPlayerSkin(localPlayer) return end 
        for i=0,17 do
            local texture, model = getPedClothes ( localPlayer, i )
            if (texture) then
                removePedClothes(localPlayer, i)
                break
            else
                break    
            end
        end    
        for int, index in pairs( CJClothesTable ) do
            local texture, model = getClothesByTypeIndex ( int, index )
            if ( texture ) then
                addPedClothes ( source, texture, model, int )
            end
        end
    end
    triggerServerEvent( "onChangeClothesCJ", localPlayer, CJClothesTable, createClothesJSONString ( "JSON" ) )
end

function resetPlayerSkin(player)
    if (isElement(player)) then
    for clothesID = 0, 17 do
        if ( getPedClothes(player, clotheID)) then
            removePedClothes(player, clotheID)
        end
    end
        if (getPedClothes(player, 0)) then
            removePedClothes(player, 0)
        end 
        if (getPedClothes(player, 1)) then
            removePedClothes(player, 1)
        end
        if (getPedClothes(player, 2)) then
            removePedClothes(player, 2)
        end 
        if (getPedClothes(player, 3)) then
            removePedClothes(player, 3)
        end
        if (getPedClothes(player, 4)) then
            removePedClothes(player, 4)
        end
        if (getPedClothes(player, 5)) then
            removePedClothes(player, 5)
        end
        if (getPedClothes(player, 6)) then
            removePedClothes(player, 6)
        end
        if (getPedClothes(player, 7)) then
            removePedClothes(player, 7)
        end
        if (getPedClothes(player, 8)) then
            removePedClothes(player, 8)
        end
        if (getPedClothes(player, 9)) then
            removePedClothes(player, 9)
        end
        if (getPedClothes(player, 10)) then
            removePedClothes(player, 10)
        end
        if (getPedClothes(player, 11)) then
            removePedClothes(player, 11)
        end
        if (getPedClothes(player, 12)) then
            removePedClothes(player, 12)
        end
        if (getPedClothes(player, 13)) then
            removePedClothes(player, 13)
        end 
        if (getPedClothes(player, 14)) then
            removePedClothes(player, 14)
        end
        if (getPedClothes(player, 15)) then
            removePedClothes(player, 15)
        end
        if (getPedClothes(player, 16)) then
            removePedClothes(player, 16)
        end
        if (getPedClothes(player, 17)) then
            removePedClothes(player, 17)
        end
    end
end    
        
        
        

function onClientCJMarkerHit ( hitElement, matchingDimension )
    if ( matchingDimension ) then
        if (not isElement(hitElement)) then return end
        if (isPedInVehicle(hitElement)) then return end
        if ( hitElement == localPlayer ) then
            if ( 0 == 0 ) then
                local x1, y1, z1 = getElementPosition(source)
                local x2, y2, z2 = getElementPosition(hitElement)
                local maxZ = z1 + 2
                if (z2 > maxZ) then return end

                    fadeCamera( false, 1.0, 0, 0, 0 )
                    setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
                    
                    toggleAllControls ( false, true, false )
                    
                    local px, py, pz = getElementPosition( localPlayer )
                    x, y, z, int, dim = px, py, pz, getElementInterior( localPlayer ), getElementDimension( localPlayer )
                    
                    pricesModel = {}
                    previousModel = createClothesJSONString ( "table" )
                    
                    setTimer( function ()       
                    
                        --if ( getElementInterior( localPlayer ) ~= 1 ) then
                        --    setElementInterior( localPlayer, 1, 209.78, -33.73, 1001.92 )
                        --else
                            setElementPosition( localPlayer, 1466.3372802734,-1855.7869873047,26.367027282715 )

                        --end
                        
                        setElementFrozen( localPlayer, true )
                        

                        setElementDimension( localPlayer, math.random( 10,6543 ) )
                        setCameraMatrix( 1468.0489501953,-1852.9401855469,26.367027282715, 1466.3372802734,-1855.7869873047,26.367027282715, 0, 70 )
                        setTimer( function ()
						setElementRotation( localPlayer, 0, 0, 328.98315429688 )
						end, 1000, 2 )
                        setTimer( function ()
                            guiSetVisible ( CJClothesWindow, true )
                            showCursor( true )
                        end, 1000, 1 )
                    end, 1200, 1 )
            else
                exports.GTIhud:dm( "Você precisa da skin do CJ antes de poder definir a roupa", 225, 0, 0 )
            end
        end
    end
end

function recountTotalPrice ()
    local totalPrice = 0
    for i=0,17 do
        if ( pricesModel[i] == nil ) then
            -- Nothing
        else
            totalPrice = ( tonumber(totalPrice) + tonumber(pricesModel[i]) )
        end
    end 
    guiSetText( CJClothesLabel4, "Preço Total: R$"..totalPrice )
    return totalPrice
end

for i=1,#theMarkers do
    local x, y, z, int, dim = theMarkers[i][1], theMarkers[i][2], theMarkers[i][3], theMarkers[i][4], theMarkers[i][5]
    local CJMarker = createMarker( x, y, z-1, "cylinder", 1, 125, 125, 125, 150)
	--local blip = createBlip(  x, y, z, 45 )
    setElementInterior( CJMarker, int )
    setElementDimension( CJMarker, dim )
    addEventHandler( "onClientMarkerHit", CJMarker, onClientCJMarkerHit )
end

addEventHandler( "onClientGUIClick", CJClothesCancelButton,
function ()             
    fadeCamera( false, 1.0, 0, 0, 0 )
    setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
    
    toggleAllControls ( true, true, true )
    
    guiSetVisible ( CJClothesWindow, false )
    showCursor( false )
    
    updatePlayerCJSkin ( previousModel )
    setElementFrozen( localPlayer, false )
    
    setTimer( function ()
        --if ( getElementInterior( localPlayer ) ~= int ) then
        --    setElementInterior( localPlayer, int, x, y, z )
        --else
            setElementPosition( localPlayer, 1873.595703125,-1320.7666015625,29.4921875,0,0,180 )
            setElementRotation( localPlayer, 0, 0, 179.98315429688 )
            
            
        --end         
            
        setElementDimension( localPlayer, 0 )
        setCameraTarget ( localPlayer )
    end, 1200, 1 )
end
, false )

addEventHandler( "onClientGUIClick", CJClothesBuyButton,
function () 

    if (getPlayerMoney(localPlayer) >= tonumber( recountTotalPrice () ) ) then
        fadeCamera( false, 1.0, 0, 0, 0 )
        setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
        
        toggleAllControls ( true, true, true )
        
        guiSetVisible ( CJClothesWindow, false )
        showCursor( false )
        
        updatePlayerCJSkin ( createClothesJSONString ( "table" ) )
        triggerServerEvent( "onPlayerBougtSkin", localPlayer, recountTotalPrice () )
		exports.GTIhud:dm( "Você comprou as roupas do CJ com sucesso!", 225, 0, 0 )
        
        setElementFrozen( localPlayer, false )
        
        setTimer( function ()
           -- if ( getElementInterior( localPlayer ) ~= int ) then
            --    setElementInterior( localPlayer, int, x, y, z )
            --else
            setElementPosition( localPlayer, 1873.5390625,-1320.7646484375,29.4921875 )
            setElementRotation( localPlayer, 0, 0, 179.98315429688 )
            --end         
                
            setElementDimension( localPlayer, 0 )
            setCameraTarget ( localPlayer )
        end, 1200, 1 )
    else
        exports.GTIhud:dm( "Você não tem dinheiro suficiente para todos estes itens!", 225, 0, 0 )
    end
end
, false )

addEventHandler( "onClientGUIClick", CJClothesCatoGrid,
function ()
    guiGridListClear( CJClothesItemGrid )
    local theRow, theColumn = guiGridListGetSelectedItem ( CJClothesCatoGrid )
    if ( theRow == nil ) or ( theRow == -1 ) then
        return
    else
        local selectedCato = guiGridListGetItemData ( CJClothesCatoGrid, theRow, theColumn )
        if ( selectedCato ) then
            local theTable = getClothesTableByType ( selectedCato )
            for i=0,#theTable do
                local texture, model = getClothesByTypeIndex ( selectedCato, i )
                local row = guiGridListAddRow ( CJClothesItemGrid )
                guiGridListSetItemText ( CJClothesItemGrid, row, 1, texture.." - "..model, false, true )
                guiGridListSetItemText ( CJClothesItemGrid, row, 2, "$"..theTable[i], false, true )
                guiGridListSetItemData ( CJClothesItemGrid, row, 1, texture..","..model )
            end
        end
    end
end
, false )

addEventHandler( "onClientGUIDoubleClick", CJClothesItemGrid,
function ()
    local theRow, theColumn = guiGridListGetSelectedItem ( CJClothesItemGrid )
    if ( theRow == nil ) or ( theRow == -1 ) then
        return false
    else
        local selectedItem = guiGridListGetItemData ( CJClothesItemGrid, theRow, theColumn )
        local thePrice = guiGridListGetItemText ( CJClothesItemGrid, theRow, 2 )
        if ( selectedItem ) then
            local CJClothesTable = stringExplode( selectedItem, "," )
            local texture, model = CJClothesTable[1], CJClothesTable[2]
            local theType, index = getTypeIndexFromClothes ( texture, model )
            local gtexture, gmodel = getPedClothes ( localPlayer, theType )
            if ( gtexture == texture ) and ( gmodel == model ) then
                removePedClothes ( localPlayer, theType, texture, model )
            else
                pricesModel[theType] = tonumber( string.sub(thePrice, 2) )
                recountTotalPrice ()
                addPedClothes ( localPlayer, texture, model, theType )
            end
        end
    end
end
, false )

function stringExplode(self, separator)
    Check("stringExplode", "string", self, "ensemble", "string", separator, "separator")
 
    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end
 
    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end

function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end
