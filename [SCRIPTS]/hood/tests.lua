function cobjs(chk)
blockNames = getElementByID("chk")
    outputChatBox(blockNames)
    toggleAllControls( source, false )
    showCursor( source, false )
    x, y, z = getElementPosition( source )
    rx, ry, rz = getElementRotation( source )
        if chk == 0 then
                rbobj = createObject(1459, x, y, z-0.5, rx, ry, rz)
            elseif chk == 1 then
                rbobj = createObject(1424, x, y, z-0.5, rx, ry, rz)
            elseif chk == 2 then
                rbobj = createObject(1425, x, y, z-0.5, rx, ry, rz)
            elseif chk == 3 then
                rbobj = createObject(1423, x, y, z-0.2, rx, ry, rz)
            elseif chk == 4 then
                rbobj = createObject(981, x, y, z-0.5, rx, ry, rz)
            elseif chk == 5 then
                rbobj = createObject(978, x, y, z-0.5, rx, ry, rz)
        end
   
end
addEvent("objcrt", true)
addEventHandler("objcrt", root, cobjs)