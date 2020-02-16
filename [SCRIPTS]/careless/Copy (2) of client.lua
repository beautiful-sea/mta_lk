localplayer = getLocalPlayer()
leftarrow = {}
rightarrow = {}
label = {}
edit = {}
function viewgui()
	if getElementModel(localplayer) == 0 then
	cjwindow = guiCreateWindow(0.655,0.0083,0.335,0.96,"Customize CJ from ShoDown Gaming",true)

	local y = 30
	local count = 0
	
	while count~= 18 do
		text = getClothesTypeName (count)
		local clothest,clothesm = getPedClothes ( localplayer, count )
		index = -1 
		if not clothest then
			index= -1
		else
			intfix, index = getTypeIndexFromClothes ( clothest, clothesm )
		end

		label[count] = guiCreateLabel(9,y,116,26,text,false,cjwindow)
		leftarrow[count] = guiCreateButton(150,y,30,23,"<",false,cjwindow)
		edit[count] = guiCreateEdit(185,y,39,23,tostring(index),false,cjwindow)
		rightarrow[count] = guiCreateButton(230,y,30,23,">",false,cjwindow)
		setElementData(leftarrow[count],"count",count)
		setElementData(rightarrow[count],"count",count)
		addEventHandler ( "onClientGUIClick", leftarrow[count], leftclick, false )
		addEventHandler ( "onClientGUIClick", rightarrow[count], rightclick, false )

		count= count+1
		y = y +27.3
	end

	reset = guiCreateButton(90,538,60,21,"Reset CJ",false,cjwindow)
	save = guiCreateButton(21,538,60,21,"Save",false,cjwindow)
	close = guiCreateButton(160,538,60,21,"Cancel",false,cjwindow)
	addEventHandler ( "onClientGUIClick", save, savehandler, false )
	addEventHandler ( "onClientGUIClick", close, closehandler, false )
	addEventHandler ( "onClientGUIClick", reset, resethandler, false )
	showCursor( true )
	else
		outputChatBox("You need CJ skin to customize",244,0,0,true)
	end
end
addCommandHandler("cj",viewgui)
function rightclick(button)
	local count = getElementData(source,"count")
	guiSetText ( edit[count], guiGetText(edit[count])+1 )
	if guiGetText(edit[count]) == -1 then
		triggerServerEvent("addclothes",localplayer,count)
	else
		local clothest,clothesm = getClothesByTypeIndex(count ,guiGetText(edit[count]))
		triggerServerEvent("addclothes",localplayer,clothest,clothesm,count)
	end
end
function leftclick(button)
	local count = getElementData(source,"count")
	if guiGetText(edit[count])~= "-1" then
		guiSetText ( edit[count], guiGetText(edit[count])-1 )
	end
	if guiGetText(edit[count]) == -1 then
		triggerServerEvent("addclothes",localplayer,count)
	else
		local clothest,clothesm = getClothesByTypeIndex(count ,guiGetText(edit[count]))
		triggerServerEvent("addclothes",localplayer,clothest,clothesm,count)
	end
end
function savehandler()
	showCursor( false )
	guiSetVisible(cjwindow,false)
	triggerServerEvent("saveclothes",localplayer,1)
end
function closehandler()
	showCursor( false )
	guiSetVisible(cjwindow,false)
	triggerServerEvent("saveclothes",localplayer,2)
end
function resethandler()
	triggerServerEvent("saveclothes",localplayer,3)
	outputChatBox("Loaded default settings for CJ",22,222,222,true)
end