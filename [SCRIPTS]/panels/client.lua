vehiclewindow = guiCreateWindow(0.2288,0.3,0.465,0.395,"Vehicle Panel",true)
guiSetVisible(vehiclewindow,false)
respawnb = guiCreateButton(20,116,98,41,"Set Respawn",false,vehiclewindow)
winb = guiCreateButton(139,118,98,41,"Window",false,vehiclewindow)
handb = guiCreateButton(20,172,98,41,"Handbrake",false,vehiclewindow)
--seatb = guiCreateButton(141,172,98,41,"Seatbelt",false,vehiclewindow)
closeb = guiCreateButton(263,173,88,41,"Close",false,vehiclewindow)
sellb = guiCreateButton(262,117,88,41,"Sell vehicle",false,vehiclewindow)
vehicle = getPedOccupiedVehicle(getLocalPlayer())
if vehicle then
id = getElementData(vehicle,"dbid")
posl = guiCreateLabel(24,20,188,75,"Other:\n'K' to lock/unlock vehicle\nPress 'J' for engine & L for lights\nRight click on vehicle more options.\nVehicle ID: "..id.."",false,vehiclewindow)
end
guiLabelSetColor(posl,255,255,255)
guiLabelSetVerticalAlign(posl,"top")
guiLabelSetHorizontalAlign(posl,"left",false)

priceedit = guiCreateLabel(250,56,113,24,"Buyer's Name",false,vehiclewindow)
nameedit = guiCreateEdit(249,79,113,24,"Name",false,vehiclewindow)


function park()
	triggerServerEvent("vehpos",getLocalPlayer(),getLocalPlayer())
end
addEventHandler ( "onClientGUIClick",respawnb,park, false )
function  sell()
	
	target = guiGetText(nameedit)
	triggerServerEvent("sell",getLocalPlayer(),getLocalPlayer(),sell,target)
end
addEventHandler ( "onClientGUIClick",sellb,sell, false )
function  window()
	triggerServerEvent("togwindow",getLocalPlayer(),getLocalPlayer())
end
addEventHandler ( "onClientGUIClick",winb,window, false )
function  hand()
	triggerServerEvent("handbrake",getLocalPlayer(),getLocalPlayer())
end
addEventHandler ( "onClientGUIClick",handb,hand, false )



function veh()	
	if guiGetVisible(vehiclewindow)== false then 
	
		guiSetVisible(vehiclewindow,true)
		showCursor( true )
	else
		showCursor( false )
		guiSetVisible(vehiclewindow,false)
	end
end
addCommandHandler("pan",veh)
addEventHandler ( "onClientGUIClick",closeb,veh, false )
local x,y = guiGetScreenSize()
openp = guiCreateButton(0.84, 0.925, 0.1100,0.0517, "Vehicle Panel", true)
guiSetVisible(openp,false)

addEventHandler ( "onClientGUIClick",openp,veh, false )

function showb()
	if guiGetVisible(openp)== false then 
	
	guiSetVisible(openp,true)
	end
end
addEvent("showp",true)
addEventHandler("showp",getRootElement(),showb)

function hideb()
if guiGetVisible(openp)== true then 
	guiSetVisible(openp,false)
end
end
addEvent("hidep",true)
addEventHandler("hidep",getRootElement(),hideb)
