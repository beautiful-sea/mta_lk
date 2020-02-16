
GUIEditor_Window = {}
GUIEditor_Label = {}

GUIEditor_Window[1] = guiCreateWindow(538,176,246,169,"Position",false)
guiSetVisible ( GUIEditor_Window[1], false )
guiSetAlpha(GUIEditor_Window[1],1)
guiWindowSetSizable(GUIEditor_Window[1],false)
xp = guiCreateEdit(39,68,183,18,"",false,GUIEditor_Window[1])
GUIEditor_Label[1] = guiCreateLabel(24,68,9,16,"X",false,GUIEditor_Window[1])
GUIEditor_Label[2] = guiCreateLabel(24,97,9,16,"Y",false,GUIEditor_Window[1])
yp = guiCreateEdit(38,96,183,18,"",false,GUIEditor_Window[1])
GUIEditor_Label[3] = guiCreateLabel(24,122,9,16,"Z",false,GUIEditor_Window[1])
zp = guiCreateEdit(37,123,183,18,"",false,GUIEditor_Window[1])
get =  guiCreateButton(64,33,111,28,"Get My Position",false,GUIEditor_Window[1])
GUIEditor_Label[4] = guiCreateLabel(151,145,22,18,"By :",false,GUIEditor_Window[1])
GUIEditor_Label[5] = guiCreateLabel(172,145,58,16,"|S.s|SoRa",false,GUIEditor_Window[1])
guiLabelSetColor(GUIEditor_Label[5],255,0,0)
function onGuiClick (button, state, absoluteX, absoluteY)
	if (source == get) then
	local x,y,z = getElementPosition (getLocalPlayer())
   guiSetText (xp, x )
   guiSetText (yp, y )
   guiSetText (zp, z )
   outputChatBox ( "Your Position : "..x..","..y..","..z.."", getLocalPlayer(), 255, 0, 0, true )
end
end
addEventHandler ("onClientGUIClick", getRootElement(), onGuiClick)
function pos()
if guiGetVisible ( GUIEditor_Window[1] ) then

                guiSetVisible ( GUIEditor_Window[1], false )
				showCursor(false)
        else

                guiSetVisible ( GUIEditor_Window[1], true )
				showCursor(true)
        end
end
addCommandHandler ( "pos", pos )
