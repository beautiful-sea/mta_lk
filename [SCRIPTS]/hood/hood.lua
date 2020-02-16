local aaction = 35
local astep = 80
function DXdraw()
if ( getElementData(getLocalPlayer(), "loggedin") == 1 ) then

		sWidth, sHeight = guiGetScreenSize()
		tmoney=getPlayerMoney(getLocalPlayer())
		money= 'POCKET:' ..tmoney
		thealth=math.ceil(getElementHealth(getLocalPlayer()))
		health= 'HEALTH: ' ..thealth..''
		tarmor=math.ceil(getPedArmor(getLocalPlayer()))
		armor= 'ARMOR: ' ..tarmor.. ''
		tbank =getElementData(getLocalPlayer(), "bankmoney" )
		bank= 'BANK:' ..tbank.. ''
		thour=getElementData(getLocalPlayer(), "hoursplayed" ) or 0 
	tskin =  getElementModel( getLocalPlayer() ) 
		hour= '((Hours '..thour..' Skin ' ..tskin..'))'
		
astep = astep + aaction
	if (astep > 250) or (astep < 50) then
		aaction = aaction - aaction - aaction
	end
if thealth <= 40 then
dxDrawText(tostring (health),10,10,sWidth/1.0007,sHeight/2,tocolor(0,0,0,astep),0.55,"bankgothic","right","top",false,false,false)
dxDrawText(tostring (health),10,10,sWidth/1,sHeight/1,tocolor(204,0,0,astep),0.55,"bankgothic","right","top",false,false,false)
else
dxDrawText(tostring (health),10,10,sWidth/1.0007,sHeight/2,tocolor(0,0,0,255),0.55,"bankgothic","right","top",false,false,false)
dxDrawText(tostring (health),10,10,sWidth/1,sHeight/1,tocolor(255,255,255,255),0.55,"bankgothic","right","top",false,false,false)
end
if thealth < 18 then
dxDrawText ("You are low on health",100,500,sWidth/1.355,sHeight/2,tocolor(0,0,0,astep),1,"bankgothic","right","top",false,false,false)
dxDrawText ("You are low on health",100,500,sWidth/1.35,sHeight/1,tocolor(204,0,0,astep),1,"bankgothic","right","top",false,false,false)

end
dxDrawText(tostring (money),45,45,sWidth/1.0007,sHeight/2,tocolor(0,0,0,255),0.55,"bankgothic","right","top",false,false,false)
dxDrawText(tostring (money),45,45,sWidth/1,sHeight/1,tocolor(255,255,255,255),0.55,"bankgothic","right","top",false,false,false)
if tarmor >1 then
dxDrawText(tostring (armor),20,22,sWidth/1.0007,sHeight/2,tocolor(0,0,0,255),0.5,"bankgothic","right","top",false,false,false) 
dxDrawText(tostring (armor),20,22,sWidth/1,sHeight/1,tocolor(255,255,255,255),0.5,"bankgothic","right","top",false,false,false) 
end

dxDrawText(tostring (bank),60,60,sWidth/1.0007,sHeight/2,tocolor(0,0,0,255),0.5,"bankgothic","right","top",false,false,false) 
dxDrawText(tostring (bank),60,60,sWidth/1,sHeight/1,tocolor(255,255,255,255),0.5,"bankgothic","right","top",false,false,false) 
dxDrawText("Hours Played:"..tostring (thour),0,0,sWidth/1.0007,sHeight,tocolor(0,0,0,155),0.5,"bankgothic","right","top",false,false,false)
dxDrawText("Hours Played:"..tostring (thour),0,0,sWidth/1,sHeight,tocolor(255,153,0,255),0.5,"bankgothic","right","top",false,false,false)
end
end
addEventHandler("onClientRender", getRootElement(), DXdraw)
