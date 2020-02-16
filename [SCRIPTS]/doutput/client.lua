text = "Error report at shodowngaming.com"
local r = 0
local g = 255 
local b = 0
--[[ Hhaiwj &*&awoijwaoijwojwojwOJAOJWOAW>AW>A>W]]--   
otext = { }
addEventHandler( "onClientRender",getRootElement(),function()
		color = getElementData(getLocalPlayer(),"color")
		x , y = guiGetScreenSize()
		if otext then
			for key,value in ipairs(otext) do
			rec = dxDrawRectangle (x/2.6,key*19,500,19, tocolor ( 0, 0, 0,170) ) 
			text = 	dxDrawText (value,x/2.6,key*19,900,25,tocolor(255,255,255,255),1,"default","left","top",false,true)
			end
		end
end)
--[[ Hhaiwj &*&@#^ ^*$^@*$^*@^ ^$*^@*^$JAIWJ IOAJWOI AJWO JAOJW  ?>php ?<php IWAIWAI JWIAJ ajwi jwi ajow aokw oakwo anwiab wuaw uauw ahuwh
aiwhaiwhaiwh iwai &98782426496296264131971+_+__@_#|+++_______!@#_@+@#___++@)#_``````````-9292049028497276622*****
*************/////////***9999999877854ajkajwiajw9a728737266??>>>W>AW>A>W]]--

function cooldown()
	tablerow = getElementData(getLocalPlayer(),"tablerow")
    if tablerow == 5566 then
		table.remove(otext,1)
	end	
end


function writeText(r,g,b,...)
	tablerow = getElementData(getLocalPlayer(),"tablerow")
    if tablerow == 5566 then
		
		local text = table.concat({...}, " ")
		setTimer (cooldown,25000,1)
		table.insert(otext,text)
    end

end
function test()
	t = math.random(1,99999999)
	writeText(255,255,255,"Testing This is just a random text to test doutput resource.This is just a random"..t)
end
addCommandHandler("testtext",test)


addEvent("doOutput",true)
addEventHandler("doOutput",getRootElement(),writeText)
--[[ Hhaiwj &*&@#^ ^*$^@*$^*@^ ^$*^@*^$JAIWJ IOAJWOI AJWO JAOJW  ?>php ?<php IWAIWAI JWIAJ ajwi jwi ajow aokw oakwo anwiab wuaw uauw ahuwh
aiwhaiwhaiwh iwai &98782426496296264131971+_+__@_#|+++_______!@#_@+@#___++@)#_``````````-9292049028497276622*****
*************/////////***9999999877854ajkajwiajw9a728737266??>>>W>AW>A>W]]--
