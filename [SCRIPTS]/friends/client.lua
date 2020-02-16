friendwindow =  guiCreateWindow(126,135,600,327,"ShoDown Friends",false)
guiSetVisible(friendwindow,false)
friendgrid =  guiCreateGridList(12,22,170,268,false,friendwindow)
lastgrid =  guiCreateGridList(180,22,200,268,false,friendwindow)
msgedit =  guiCreateMemo(390,20,200,220,"",false,friendwindow)
idcol = guiGridListAddColumn(lastgrid,"Last Seen",0.9)
guiGridListSetSelectionMode(friendgrid,2)
guiGridListSetSelectionMode(lastgrid,2)
idcol = guiGridListAddColumn(friendgrid,"No.",0.2)
namecol = guiGridListAddColumn(friendgrid,"Name",0.6)
closeb = guiCreateButton(54,293,72,24,"Close",false,friendwindow)
delb =  guiCreateButton(153,294,72,23,"Delete",false,friendwindow)
updateb =  guiCreateButton(400,270,90,35,"Update",false,friendwindow)
guiSetEnabled ( updateb ,false )
yeswindow = guiCreateWindow(306,240,177,113,"Confirm",false)
guiSetVisible(yeswindow ,false)
dellabel = guiCreateLabel(19,22,137,19,"Delete",false,yeswindow)
guiLabelSetVerticalAlign(dellabel,"top")
guiLabelSetHorizontalAlign(dellabel,"left",false)
yesb = guiCreateButton(24,62,48,27,"Yes",false,yeswindow)
nob = guiCreateButton(99,62,48,27,"No",false,yeswindow)
function setfriends(friend,seen)
		guiGridListClear (lastgrid)
		guiGridListClear (friendgrid)
		row =guiGridListAddRow(friendgrid)
		text = guiGridListSetItemText (friendgrid,row,2,getElementData(getLocalPlayer(),"gameaccountusername"),false, true)
		row2 =guiGridListAddRow(lastgrid)
		text = guiGridListSetItemText(lastgrid,row2,1,"",false, true)
		for i,v in ipairs (friend) do
			row =guiGridListAddRow(friendgrid)
			text = guiGridListSetItemText (friendgrid,row,2,v, false, true)
			text2 = guiGridListSetItemText (friendgrid,row,1,i, false, true)
		end
		for i,v in ipairs (seen) do
			if v == 0 then
				v = "Today"
			else
				v = v.." days ago"
			end
			row2 =guiGridListAddRow(lastgrid)
			text = guiGridListSetItemText(lastgrid,row2,1,v,false, true)
		end
end
addEvent("setfriends",true)
addEventHandler("setfriends",getRootElement(),setfriends)

function showfriendmenu()
		if guiGetVisible(friendwindow) == false then
			triggerServerEvent("getfrdetails",getLocalPlayer(),getLocalPlayer())
			guiSetVisible(friendwindow,true)
			showCursor(true)
			guiSetInputEnabled ( true )
		else
			guiSetVisible(friendwindow,false)
			showCursor(false)
			guiSetInputEnabled ( false )
		end
end

function closefriendmenu()
		if source == closeb then
			guiSetVisible(friendwindow,false)
			showCursor(false)
			guiSetInputEnabled ( false )
		end
end
addEventHandler("onClientGUIClick",closeb,closefriendmenu)
bindKey("o", "down", showfriendmenu)
function friendmsg()
	if source == friendgrid then
	text = guiGridListGetItemText(friendgrid, guiGridListGetSelectedItem (friendgrid ), 2)
	if getElementData(getLocalPlayer(),"gameaccountusername") == text then
		guiSetEnabled ( updateb ,true )
		guiMemoSetReadOnly(msgedit,false)
	else
		guiSetEnabled ( updateb ,false )
		guiMemoSetReadOnly(msgedit,true)
	end
	if getElementData(getLocalPlayer(),"gameaccountusername") ~= text then
		guiSetEnabled ( delb ,true )
	else
		guiSetEnabled ( delb ,false )
	end
	triggerServerEvent("getfrmsg",getLocalPlayer(),getLocalPlayer(),text)
	end
end
addEventHandler("onClientGUIClick",friendgrid,friendmsg)


function setfmsg(msg)
	if msg == nil then
		msg = "Message is not set by user."
	end
	guiSetText(msgedit,msg)
end
addEvent("setfmsg",true)
addEventHandler("setfmsg",getRootElement(),setfmsg)

function yesno()
	if source == delb then
		text = guiGridListGetItemText(friendgrid, guiGridListGetSelectedItem (friendgrid ), 2)
		if guiGridListGetSelectedItem (friendgrid) then
			if guiGetVisible(yeswindow) == false then
				guiSetVisible(friendwindow,false)
				guiSetVisible(yeswindow ,true)		
				guiSetText(dellabel,"Delete " ..text.."?")
			else
				guiSetVisible(yeswindow ,false)
				guiSetVisible(friendwindow,true)
			end
		end
	end
end
addEventHandler("onClientGUIClick",delb,yesno)
function hideconfirm()
		guiSetVisible(yeswindow,false)
		guiSetVisible(friendwindow,true)
end
addEventHandler("onClientGUIClick",nob,hideconfirm)
function getkey()
		if source == yesb then
		text = guiGridListGetItemText(friendgrid, guiGridListGetSelectedItem (friendgrid ), 2)
		key = guiGridListGetItemText(friendgrid, guiGridListGetSelectedItem (friendgrid ), 1)	
		triggerServerEvent("delfriend",getLocalPlayer(),text,key,getLocalPlayer())
		hideconfirm()
		end
end
addEventHandler("onClientGUIClick",yesb,getkey)

function updatemsg()
	if source == updateb then
		text = guiGetText(msgedit)
		triggerServerEvent("updatemsg",getLocalPlayer(),text,getLocalPlayer())
	end
end
addEventHandler("onClientGUIClick",updateb,updatemsg)

