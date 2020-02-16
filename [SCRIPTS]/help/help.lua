helpwindow = guiCreateWindow(176,164,445,332,"Spl4z Roleplay - Server Rules & Roleplay Intro",false)
guiSetVisible(helpwindow,false)
guiWindowSetSizable (helpwindow, false )
helpedit = guiCreateMemo(142,32,293,283,"**** Spl4z Roleplay Server Guide ****\n\n/helpcmds for Command List\n\n/animlist for animation list\n\n/n for newbie chat\n\nUse /report or press F2 for report system\n\n\nPlease choose an option",false,helpwindow)
guiSetInputEnabled (false )
guiMemoSetReadOnly(helpedit,true)
guiMemoSetCaretIndex (helpedit,2 )
rulesb = guiCreateButton(18,54,104,36,"Rules",false,helpwindow)
remb = guiCreateButton(18,109,104,36,"Things to Remember",false,helpwindow)
reportb = guiCreateButton(18,163,104,20,"Roleplay Guide",false,helpwindow)
readtime = 150
readb = guiCreateButton(18,210,104,30,"I have read all details("..readtime..")",false,helpwindow)

function OpenClose()
		forceread =  getElementData(getLocalPlayer(),"forceread")
		if guiGetVisible(helpwindow) == false then
			guiSetVisible(helpwindow,true)
			showCursor(true)	
			readtime = 150
			if getElementData(getLocalPlayer(),"rulesread") == 0 then
				guiSetEnabled (readb, false )
				if not readtimer then
					readtimer = setTimer (updateread,1000,150)
				end
			else
				guiSetText(readb,"You have already read all rules")
				guiSetEnabled (readb, true )
			end
			
		else
			if forceread == 0 or getElementData(getLocalPlayer(),"rulesread") == 1  then
				guiSetVisible(helpwindow,false)
				showCursor(false)
				killTimer(readtimer)
				readtimer = false
			else
				outputChatBox("You must wait and read all rules.You were forced by an admin")
			end
		end
end
bindKey("F9","down",OpenClose)
addEvent("forceread",true)
addEventHandler("forceread",getRootElement(),OpenClose)

function setText(button,state	)
	if (source==rulesb) then
			guiSetText(helpedit,"**** Spl4z Roleplay Server Rules ****\n1.No Deathmatching.You should not kill anyone without reason.\n\n2.No insults.We have zero tolerance rule against insults.\n\n3.Do not abuse/spam any chat./n(newbiechat) for question & answers only.\n\n4.No RK.Revenge Killing is chasing the person who killed you after you die and kill him for revenge\n\n5.Do not use any hacks, cheats or modifications that give you an advantage over other players\n\n6.Do not heal(eat something) during fights or shooting.\n\n7.Do not ad(vertise) or talk about other servers.\n\n8.Only administrators are allowed to be around OOC and are allowed to interrupt RP situations OOCly.Always keep everything IC.\n\n9.No abusive language towards other players in any OOC-chat\n\n10.Stat transfer from one character to another is not allowed.You must donate to server for that.\n\n11.Car KillingCar Killing is known as parking your car on someone so that their health reduces and they die. Car Killing is not allowed.")
	end
	if (source==remb) then
			guiSetText(helpedit,"**** Spl4z Roleplay Things To Remember **\n1.We do not punish for having low level roleplay,metagaming,powergaming or deathmatching for small reason but you are requested to keep roleplay as realistic as you can\n\n2.Players DO NOT need a /me for shooting.Automatic /me's are enough\n\n3.Players do not need to roleplay gun shot,vehicle crash injuries.Its upto player if he wants to roleplay injury or not.We do not force it.\n\n3.When reporting a player do not report past DM/Non RP.Those reports should be reported on forum with proof.You can only report for things which is happening ingame right now or it will be marked as false.You can always report for help.")
	end
	if (source==reportb) then
			guiSetText(helpedit,"**** Spl4z Roleplay Guide  ****\n\nOOC - Out Of Character (/o or press U) \nIC - In Character (/say or press T)\nRP - Roleplay\nDM - Deathmatch\nPK - Player Killing\nCK - Character Killing\nRK - Revenge Killing\n\nIC Chat: Roleplay chat.Do not use abbreviations such as OMG,LOL,u,ur,m8 etc. as you don't say m8, you say 'mate' in real life.\n\nOOC Chat:All out of game chat goes in ooc chat. /b and /o.\n\nUses of /me\nme command is used for your character's actions.You can call it a drawback of gtasa game.You can't show laugh on your character's face so you use /me laughs.You don't need to use it for actions which are not visible.For example. /me thinks is not a valid /me.You also don't need to use it for aiming gun,shooting.\n\nUses of /do\ndo command is used for briefing your environment.Examples: /do This box is red in colour. /do Medwin is wearing a blue cap.\n\nMetagaming\nMixing out of character information in In character situation.The most common examples are reading nametags above player's head and saying it In character or sending private message to your friend to help you from robbery.\n\nPowergaming\nYou powergame when you force your action on other player without giving him chance to react.Example:/me kicks Adam.You should use /me attemps to kick Adam or more advanced /me /.me raises his right leg up and swings it towards [name] [body part] with full force (or full strenght)")
	end
	if (source==readb) then
		triggerServerEvent("readall",getLocalPlayer(),getLocalPlayer())
	end
end
addEventHandler("onClientGUIClick",getRootElement(),setText)


function updateread()
	if readtime > 1 then
		readtime = readtime -1
		guiSetText(readb,"I have read all details("..readtime..")")
	else
		guiSetEnabled (readb,true) 
		guiSetText(readb,"I have read all details")
	end
end
