height = 0
theight = 0
text = ""
local r = 0
local g = 255 
local g = 255
local b = 0
function background()
		x , y = guiGetScreenSize()
		otext =  getElementData(getLocalPlayer(),"otext")
		dxDrawRectangle (x/2.3, 0,600,height, tocolor ( 0, 0, 0, 150 ) ) 
		for key, value in ipairs( otext ) do
		dxDrawText (value,x/2.3,key*25,900,height,tocolor( r,g,b,255),1,"default","left","top",false,true)
		end
		
end
addEventHandler( "onClientRender",getRootElement(),background)

function cooldown()
		height = height - 38
		triggerServerEvent("removetext",getLocalPlayer(),getLocalPlayer())
end

function writeText(red,grn,blue,...)
	local text = table.concat({...}, " ")
	r =  tonumber(red)
	g = tonumber(grn)
	b = tonumber(blue)	
	height = height + 38
	setTimer (cooldown,15000,1)
	triggerServerEvent("addtext",getLocalPlayer(),getLocalPlayer(),text)
end

addCommandHandler("writetext",writeText)
addEvent("doOutput",true)
addEventHandler("doOutput",getRootElement(),writeText)




