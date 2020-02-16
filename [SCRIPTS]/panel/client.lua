bindKey("F1","down","jetpackme")
GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Label = {}

GUIEditor_Window[1] = guiCreateWindow(0.3075,0.28,0.375,0.62,"User & Stats Panel",true)
GUIEditor_Button[6] = guiCreateButton(20,34,35,18,"Main",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(20,50,35,18,"Bank",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(96,50,35,18,"Deaths",false,GUIEditor_Window[1])
GUIEditor_Button[5] = guiCreateButton(58,50,35,18,"Hours",false,GUIEditor_Window[1])
GUIEditor_Button[7] = guiCreateButton(134,50,35,18,"Admin",false,GUIEditor_Window[1])
checkedBox = guiCreateCheckBox(20,305,400,30,"Serial lock( Lock your account for \nonly this computer)",getElementData(getLocalPlayer(),"seriallock"),false,GUIEditor_Window[1])
GUIEditor_Button[8] = guiCreateButton(58,34,35,18,"Cmds",false,GUIEditor_Window[1])
function clickHandler()
    executeCommandHandler("helpcmds")
	guiSetVisible(GUIEditor_Window[1], false)
end
addEventHandler("onClientGUIClick",GUIEditor_Button[8],clickHandler,false)
GUIEditor_Button[9] = guiCreateButton(172,50,35,18,"H.Snake",false,GUIEditor_Window[1])
GUIEditor_Button[12] = guiCreateButton(210,50,35,18,"Odometer",false,GUIEditor_Window[1])
--GUIEditor_Button[10] = guiCreateButton(210,50,35,18,"T.Snake",false,GUIEditor_Window[1])
--GUIEditor_Button[11] = guiCreateButton(20,330,35,18,"Suicide",false,GUIEditor_Window[1])
GUIEditor_Label[1] = guiCreateLabel(27,73,250,300,"",false,GUIEditor_Window[1])
guiLabelSetColor(GUIEditor_Label[1],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
guiSetVisible(GUIEditor_Window[1],false)
guiSetText ( GUIEditor_Label[1], "Select an option" )

function bank()
	triggerServerEvent ( "tops", getLocalPlayer(), 2 ) 
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[2], bank, false )
function hours()
	triggerServerEvent ( "tops", getLocalPlayer(), 5 ) 
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[5],hours, false )

function hours()
	triggerServerEvent ( "tops", getLocalPlayer(), 7 ) 
	
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[7],hours, false )

function hours()
	triggerServerEvent ( "tops", getLocalPlayer(), 9 ) 
	
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[9],hours, false )
function hours()
	triggerServerEvent ( "seriallock", getLocalPlayer(), guiCheckBoxGetSelected( checkedBox ) )
end
addEventHandler ( "onClientGUIClick",checkedBox,hours, false )
function hours()
	triggerServerEvent ( "tops", getLocalPlayer(), 10 ) 
	
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[10],hours, false )
function hours()
	triggerServerEvent ( "tops", getLocalPlayer(), 12 ) 
	
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[12],hours, false )
function suicide()
	setElementHealth (getLocalPlayer(),0)
	outputChatBox("You commited suicide",255,204,0,true)
	--triggerServerEvent("killp",getLocalPlayer(),getPlayerName(getLocalPlayer()))
	guiSetVisible(GUIEditor_Window[1],false)
	showCursor( false )
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[11],suicide, false )

function statsbutton()
	--guiSetVisible(GUIEditor_Button[6],false)
	--guiSetVisible(GUIEditor_Button[1],true)
	--guiSetVisible(GUIEditor_Button[2],false)
	--guiSetVisible(GUIEditor_Button[5],false)
	triggerServerEvent ( "stats", getLocalPlayer())
	
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[6], statsbutton, false )

function topHandler ( text ,x)
    guiSetText ( GUIEditor_Label[1], text )
    if x == 2  then
	guiSetVisible(GUIEditor_Window[1],false)
    end
end
addEvent( "topsclient", true )
addEventHandler( "topsclient", getRootElement(), topHandler )

function death()
	triggerServerEvent ( "tops", getLocalPlayer(), 3 ) 
end
addEventHandler ( "onClientGUIClick",GUIEditor_Button[3],death, false )

function panel()
	if guiGetVisible(GUIEditor_Window[1])== false then 
		guiSetVisible(GUIEditor_Window[1],true)
		showCursor( true )
		guiCheckBoxSetSelected ( checkedBox,getElementData(getLocalPlayer(),"seriallock") )
		statsbutton()
		triggerEvent("load",getLocalPlayer())
	else
		showCursor( false )
		guiSetVisible(GUIEditor_Window[1],false)
	end
end
addCommandHandler("statics",panel)
bindKey("F7","down","statics")

xm = 0
function HandleTheRenderi()
    xm = 0
end
addEvent("resetxm",true)
addEventHandler("resetxm",getRootElement(), HandleTheRenderi)

function testc()
	msg =  getElementData(getRootElement(),"movingmsg")
	
		if  msg then
			local screenWidth, screenHeight = guiGetScreenSize()
			
			xm = xm + 1
			dxDrawText(msg,800-xm, screenHeight-30,screenWidth,screenHeight, tocolor (255,0,0, 255 ), 0.6,"bankgothic" )
		end
end
function HandleTheRenderin()
    addEventHandler("onClientRender",getRootElement(),testc)
end
addEventHandler("onClientResourceStart",getRootElement(), HandleTheRenderin)


