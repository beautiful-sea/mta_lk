
function stopNameChange(oldNick, newNick)
	if (source==getLocalPlayer()) then
		local legitNameChange = getElementData(getLocalPlayer(), "legitnamechange")

		if (oldNick~=newNick) and (legitNameChange==0) then
			triggerServerEvent("resetName", getLocalPlayer(), oldNick, newNick) 
			outputChatBox("Nick changing is not allowed.Press End to change character.", 255, 0, 0)
		end
	end
end
addEventHandler("onClientPlayerChangeNick", getRootElement(), stopNameChange)

function onPlayerSpawn()
	showCursor(false)
	
	local interior = getElementInterior(source)
	setCameraInterior(interior)
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), onPlayerSpawn)

function clearChatBox()
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
end

function hideInterfaceComponents()
	showPlayerHudComponent("weapon", false)
	showPlayerHudComponent("ammo", false)
	showPlayerHudComponent("vehicle_name", false)
	showPlayerHudComponent("money", false)
	showPlayerHudComponent("clock", false)
	showPlayerHudComponent("health", false)
	showPlayerHudComponent("armour", false)
	showPlayerHudComponent("breath", false)
	showPlayerHudComponent("area_name", false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), hideInterfaceComponents)

lLostSecurityKey, tLostSecurityKey, bForgot, chkRemember, chkAutoLogin, bLogin, lLogUsername, lLogUsernameNote,usee, passe, lLogPassword, tabPanelMain, tabLogin, tabRegister, tabForgot, lRegUsername, tRegUsername, lRegUsernameNote, lRegPassword, tRegPassword, lRegPassword2, tRegPassword2, bRegister, wDelConfirmation = nil
tosversion = 101

local xmbAlpha = 1.0
local motdX = guiGetScreenSize()
local motdSpeed = 1

local alphaAction = 3
local alphaStep = 50

function ground()
	local screenWidth, screenHeight = guiGetScreenSize()
		local x, y = guiGetScreenSize()
	dxDrawText("|-ShoDown Gaming Roleplay |- San Andreas |-",x/13.4,y/13.4,2000.0,2000.0,tocolor(255,255,255,255),0.7,"bankgothic","left","top",false,false,false)
	dxDrawRectangle(0.0,0.0,screenHeight+1000,screenWidth+1000,tocolor(51,51,102,175),false)	
end

function renderWelcomeMessage()
		alphaStep = alphaStep + alphaAction
	if (alphaStep > 200) or (alphaStep < 50) then
		alphaAction = alphaAction - alphaAction - alphaAction
	end
	local screenWidth, screenHeight = guiGetScreenSize()
		local x, y = guiGetScreenSize()
	dxDrawRectangle(0.0,0.0,screenHeight+1000,screenWidth+1000,tocolor(51,51,102,175),false)	
	dxDrawText("Welcome to ShoDown Gaming Roleplay Server", 36, screenHeight-61, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "pricedown")
	dxDrawText("Welcome to ShoDown Gaming Roleplay Server", 34, screenHeight-63, screenWidth, screenHeight, tocolor ( 255, 0, 0, 255 ), 1, "pricedown")
	
	--dxDrawImage(x/3,y/3,1279.0,108.0,"back.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
	if guiGetVisible ( chkRemember, true ) then
  dxDrawText("LOGIN",x/3,y/2.9,436.0,544.0,tocolor(204,0,0,255),1.0,"bankgothic","left","top",false,false,false)
dxDrawText("|-ShoDown Gaming Roleplay |- San Andreas |-",x/13.4,y/13.4,2000.0,2000.0,tocolor(255,255,255,255),0.7,"bankgothic","left","top",false,false,false)
    
	else
	dxDrawText("REGISTER",x/3,y/2.9,436.0,544.0,tocolor(204,0,0,255),1.0,"bankgothic","left","top",false,false,false)
	dxDrawText("Welcome! Here are some information you should know.\n Chat Buttons:\nPress 'U' to talk in global OOC chat(everyone can hear)\nPress 'B' for local OOC (nearby players)\nPress 'T' for in character chat(nearby players).\n\nWhat is roleplay?. \nRoleplay means acting as someone or something that takes place in real life\nand doing things realisticly at all times.\n\nForum Address:www.shodowngaming.com",x/13.4,y/13.4,2000.0,2000.0,tocolor(255,255,255,255),0.5,"bankgothic","left","top",false,false,false)
    end
	--dxDrawRectangle(0, screenHeight - 40, screenWidth, 20, tocolor(195, 195, 195, 150 * xmbAlpha), false)
	dxDrawImage ( x/1.7,y/4,133,88, 'shodown2.png',0,0,0, tocolor(255, 255, 255, alphaStep),false )
	dxDrawText("Welcome to ShoDown Gaming Roleplay Server./report anytime for admin help", motdX, screenHeight - 40, screenWidth, 20, tocolor(255, 255, 255, 200 * xmbAlpha), 0.5, "bankgothic", "left", "middle", false, false, false)
	motdX = motdX - motdSpeed
	
	if ( motd ) then
		if ( motdX < 0 - dxGetTextWidth(motd, 0.5, "bankgothic") ) then
			motdX = width
		end
	end
	

	local version = exports.global:getScriptVersion()
	
	dxDrawLine(0, screenHeight-30, screenWidth, screenHeight-30, tocolor(255,0, 0, 150), 2)
	
end
function loadScenarioOne()
	local id = getElementData(getLocalPlayer(), "playerid")
	
	if not (id) then
		id = 0
	end

	setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)
end
triggerServerEvent("getSalt", getLocalPlayer(), scripter)

function generateTimestamp(daysAhead)
	return tostring( 50000000 + getRealTime().year * 366 + getRealTime().yearday + daysAhead )
end

function storeSalt(theSalt, theIP)
	ip = theIP
	salt = theSalt
	
	createMainUI(getThisResource())
end
addEvent("sendSalt", true)
addEventHandler("sendSalt", getRootElement(), storeSalt)

function createMainUI(res, isChangeAccount)
	if (res==getThisResource()) then
		sent = false
		local tutFile = xmlLoadFile("vgrptut.xml")
		local regFile = xmlLoadFile("vgrpreg.xml")
		
		if (tutFile) or (regFile) then
			local xmlRoot = xmlCreateFile("vgrptut.xml", "passedtutorial")
			xmlSaveFile(xmlRoot)
		end
			-- Set the camera to a nice view
			local cameraRand = math.random(1, 1)
			
			
			if (cameraRand==1) then
				loadScenarioOne()
				addEventHandler("onClientRender", getRootElement(), renderWelcomeMessage)
			end
			fadeCamera(true)
			
			if (bChangeAccount) then
				destroyElement(bChangeAccount)
				bChangeAccount = nil
			end
		
			
			local width, height = 400, 200
			
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)

			if (scrWidth<1024) and (scrHeight<768) then
				outputChatBox("Your screen resolution is: "..scrWidth.." x "..scrHeight..".We recommend 800 x 600.", 255,255, 0)
			end
			guiSetAlpha(tabPanelMain,0.3)
			if (regFile) then -- User has already registered on this PC before.
				tabLogin = guiCreateTab("Login to Account", tabPanelMain)
				guiSetAlpha(tabLogin,0.3)
				tabRegister = guiCreateTab("Register Account", tabPanelMain)
				guiSetAlpha(tabRegister,0.3)
				tabForgot = guiCreateTab("Forgot Details", tabPanelMain)
				guiSetAlpha(tabForgot,0.3)
			else
				tabRegister = guiCreateTab("Register Account", tabPanelMain)
				guiSetAlpha(tabRegister,0.3)
				tabLogin = guiCreateTab("Login to Account", tabPanelMain)

				guiSetAlpha(tabLogin,0.3)
				tabForgot = guiCreateTab("Forgot Details", tabPanelMain)
				guiSetAlpha(tabForgot,0.3)
			end
			showCursor(true)
			guiSetAlpha(tabPanelMain, 0)
			x,y = guiGetScreenSize()
		      infol = guiCreateLabel(x/2,y/2.2,207,16,"Don't have an account on server? ",false)
			
		      error = guiCreateLabel(x/18,y/2.2,800,800,"",false)
			guiLabelSetColor(error,255,0,0)
			guiSetFont(error,"default-bold-small")
			breg =  guiCreateButton(x/1.4,y/2.2,67,21,"Register",false)
			blog =  guiCreateButton(x/1.4,y/2.2,67,21,"Login",false)
			guiSetInputEnabled ( true )
			guiSetVisible ( blog, false )
			addEventHandler("onClientGUIClick", breg, loginUpdate)
			addEventHandler("onClientGUIClick", blog, loginChange)
			userl = guiCreateLabel(x/2,y/2,77,31,"Username",false)
		
			usere = guiCreateEdit(x/1.7,y/2,164,19,"",false)
			regusere = guiCreateEdit(x/1.7,y/2,164,19,"",false)
			guiSetVisible ( regusere, false )
			passl =   guiCreateLabel(x/2,y/1.8,58,17,"Password",false)
		
			passe =   guiCreateEdit(x/1.7,y/1.8,164,19,"",false)
			
			regpasse =   guiCreateEdit(x/1.7,y/1.8,164,19,"",false)
			guiEditSetMasked(regpasse, true)
			guiSetVisible ( regpasse, false )
			guiEditSetMasked(passe, true)
			guiEditSetMaxLength(passl, 29)
			
			
			pass2 = guiCreateLabel(x/2.2,y/1.6,101,22,"Confirm Password",false)
			guiSetVisible ( pass2, false )
			passe2 = guiCreateEdit(x/1.7,y/1.6,164,19,"",false)
			
			 guiSetVisible ( passe2, false )
			guiEditSetMasked(passe2, true)
			guiEditSetMaxLength(passe2, 29)
			
			chkRemember = guiCreateCheckBox(x/2,y/1.6,200,16,"Remember details",false,false)
			chkAutoLogin =  guiCreateCheckBox(x/2,y/1.5,200,16,"Automatic Login",false,false)
			guiLabelSetColor(chkRemember,0,0,0)
			guiLabelSetColor(chkAutoLogin,0,0,0)
			addEventHandler("onClientGUIClick", chkRemember, updateLoginState)
			
			bLogin = guiCreateButton(x/2,y/1.4,110,29,"Login",false)
			addEventHandler("onClientGUIClick", bLogin, validateDetails, false)
			bRegister = guiCreateButton(x/2,y/1.4,110,29,"Register",false)
			addEventHandler("onClientGUIClick", bRegister, validateDetails, false)
		     guiSetVisible ( bRegister, false )
	
			
			-- LOAD SAVED USER INFO 
			local xmlRoot = xmlLoadFile( ip == "127.0.0.1" and "vgloginlocal.xml" or "vglogin.xml" )
			if (xmlRoot) then
				local usernameNode = xmlFindChild(xmlRoot, "username", 0)
				local passwordNode = xmlFindChild(xmlRoot, "hashcode", 0)
				local autologinNode = xmlFindChild(xmlRoot, "autologin", 0)
				
				if (usernameNode) then
					uname = xmlNodeGetValue(usernameNode)
					if (uname) and (uname~="") then
						guiSetText(usere, tostring(uname))
						guiCheckBoxSetSelected(chkRemember, true)
						if (passwordNode) then
							local pword = xmlNodeGetValue(passwordNode)
							if (pword) and (pword~="") then
								guiSetText(passe, tostring(pword))
								guiCheckBoxSetSelected(chkRemember, true)
							else
								guiSetEnabled(chkAutoLogin, false)
							end
								
							if (autologinNode) then
								local autolog = xmlNodeGetValue(autologinNode)
								if (autolog) and (autolog=="1") then		
									if(guiGetEnabled(chkAutoLogin)) then
										guiCheckBoxSetSelected(chkAutoLogin, true)
										if not (isChangeAccount) then
											triggerServerEvent("attemptLogin", getLocalPlayer(), guiGetText(usere), guiGetText(passe), nil, true) 
										end
									end
								end
							end
						else
							guiCheckBoxSetSelected(chkAutoLogin, false)
						end
					end
				end
			end
			
			if (toswindow) then
				guiBringToFront(toswindow)
			end
			setTimer(fadeWindow, 50, 20)
		
	end
end
--addEventHandler("onClientResourceStart", getRootElement(), createMainUI)

function retrieveDetails()
	if (source==bForgot) then
		local securityKey = guiGetText(tLostSecurityKey)
		
		clearChatBox()
		if (string.len(securityKey)<5) then
			outputChatBox("Your email must be 5 characters long.", 255, 0, 0)
		elseif (not string.find(securityKey, "@", 0))  then
			outputChatBox("Your email must contain an @ symbol.", 255, 0, 0)
		else
			guiSetText(tLostSecurityKey, "")
			showChat(true)
			triggerServerEvent("retrieveDetails", getLocalPlayer(), securityKey)
		end
	end
end

function updateLoginState()
	if (guiCheckBoxGetSelected(chkRemember)) then
		guiSetEnabled(chkAutoLogin, true)
	else
		guiSetEnabled(chkAutoLogin, false)
		guiCheckBoxSetSelected(chkAutoLogin, false)
	end
end

function loginUpdate()
	guiSetVisible ( pass2, true )
	guiSetVisible ( passe2, true )
	guiSetVisible ( regpasse, true )
	guiSetVisible ( regusere, true)
	guiSetVisible ( chkAutoLogin, false )
	guiSetVisible ( chkRemember, false )
	guiSetVisible ( breg, false )
	guiSetVisible ( blog, true )
	guiSetVisible ( bLogin, false )
	guiSetVisible ( bRegister, true )
	guiSetText ( infol, "Enter details then click register" )
	
end

function loginChange()
	guiSetVisible ( pass2, false )
	guiSetVisible ( passe2, false )
	guiSetVisible ( regpasse, false)
	guiSetVisible ( regusere, false)
	guiSetVisible ( chkAutoLogin, true )
	guiSetVisible ( chkRemember, true)
	guiSetVisible ( breg, true )
	guiSetVisible ( blog, false)
	guiSetVisible ( bLogin, true )
	guiSetVisible ( bRegister, false )
	guiSetText ( logins, "Login" )
	guiSetText ( infol, "Don't have an account on server? " )
	
	
end
addEvent("loginChange",true)
addEventHandler("loginChange", getLocalPlayer(),loginChange)

function validateDetails()
	if (source==bRegister) then
		local username = guiGetText(regusere)
		local password1 = guiGetText(regpasse)
		local password2 = guiGetText(passe2)
		
		local password = password1 .. password2
		
		clearChatBox()
		if (string.len(username)<3) then
			guiSetText ( error, "ERROR: Your username is too short" )
		elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) then
		
			guiSetText ( error, "ERROR: Your username cannot contain ;,@." )
		elseif (string.len(password1)<6) then
		
			guiSetText ( error, "ERROR: Your password is too short\nEnter more than 6 characters" )
		elseif (string.len(password1)>=30) then
			guiSetText ( error, "ERROR: Your password is too long.\nEnter less than 30 characters" )
			
		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
		
			guiSetText ( error, "ERROR: Your password cannot contain ;,@." )
		elseif (password1~=password2) then
			outputChatBox("The passwords you entered do not match.", 255, 0, 0)
		guiSetText ( error, "ERROR: The passwords you entered\nnot matching." )
		else
			showChat(true)
			triggerServerEvent("attemptRegister", getLocalPlayer(), username, password1) 
		end
	elseif (source==bLogin) then
		local username = guiGetText(usere)
		local password = guiGetText(passe)
		
		clearChatBox()
		if (string.len(username)<3) then
		
			guiSetText ( error, "ERROR: Your username is too short\nEnter more than 6 characters" )
		elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) then
			
			guiSetText ( error, "ERROR: Your username cannot contain ;,@." )
		elseif (string.len(password)<6) then
		guiSetText ( error, "ERROR: Your password is too short\nEnter more than 6 characters" )

		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
		
				guiSetText ( error, "ERROR: Your password cannot contain ;,@." )
		else	
			local vinfo = getVersion()
			local operatingsystem = vinfo.os
			local saveInfo = guiCheckBoxGetSelected(chkRemember)
			local autoLogin = guiCheckBoxGetSelected(chkAutoLogin)
			triggerServerEvent("attemptLogin", getLocalPlayer(), username, password, operatingsystem, saveInfo) 
			
			
			if (saveInfo) then
				appendSavedData("username", tostring(username))
				appendSavedData("hashcode", "") 
				appendSavedData("autologin", autoLogin and "1" or "0")
			else
				appendSavedData("username", "")
				appendSavedData("hashcode", "")
				appendSavedData("autologin", "0")
			end
		end
	end
end

function appendSavedData(parameter, value)
	local xmlFileName = "vglogin.xml"
	local xmlFile = xmlLoadFile ( xmlFileName ) --load an xml file
	if not (xmlFile) then
		xmlFile = xmlCreateFile( xmlFileName, "login" )
	end
	
	local xmlNode = xmlFindChild (xmlFile, parameter, 0)
	if not (xmlNode) then
		xmlNode = xmlCreateChild(xmlFile, parameter)
	end
	xmlNodeSetValue ( xmlNode, value )
	xmlSaveFile(xmlFile)
	xmlUnloadFile(xmlFile)
end

function receiveAutoHash(hashcode)
	outputDebugString("[Account] Received a new hashcode \o/")
	appendSavedData("hashcode", hashcode)
end
addEvent("account:onAutoLoginHashReceive", true)
addEventHandler("account:onAutoLoginHashReceive", getRootElement(), receiveAutoHash)

function fail()
	guiSetText(error,"You entered wrong username or password \nor your account is suspended.Try again")
end
addEvent("loginFail", true)
addEventHandler("loginFail", getRootElement(), fail)

function reg()
	guiSetText(error,"Account registered successfully!.\nNow you can login.")
	guiLabelSetColor(error,0,255,0)
end
addEvent("inforeg", true)
addEventHandler("inforeg", getRootElement(), reg)
function fadeWindow()
	if (tabPanelMain) then
		local alpha = guiGetAlpha(tabPanelMain)
		local newalpha = alpha + 0.05
		guiSetAlpha(tabPanelMain, newalpha)
			showCursor(true)
		
		if(newalpha>=0.7) then
			guiSetAlpha(tabPanelMain, 0.75)
			showCursor(true)
			guiSetInputEnabled(true)
		end
	end
end

function hideUI(regged)
	local xmlRoot = xmlCreateFile("vgrpreg.xml", "registered")
	if (xmlRoot) then
		xmlSaveFile(xmlRoot)
	end
	showCursor(false)
	guiSetInputEnabled(false)
	
	if guiGetVisible ( bLogin, true ) then
		
			showChat(true)
			guiSetVisible ( pass2, false )
			guiSetVisible ( passe2, false)
			guiSetVisible ( regpasse, false )
			guiSetVisible ( regusere, false)
			guiSetVisible ( chkAutoLogin, false )
			guiSetVisible ( chkRemember, false )
			guiSetVisible ( breg, false )
			guiSetVisible ( blog, false)
			guiSetVisible ( bLogin, false )
			guiSetVisible ( bRegister, false )
			
			guiSetVisible ( error, false )
			guiSetVisible ( infol, false)
			guiSetVisible ( bRegister, false )
			guiSetVisible ( usere, false )
			guiSetVisible ( passe, false)
			guiSetVisible ( userl, false )
			guiSetVisible ( passl, false)
		removeEventHandler("onClientRender", getRootElement(),renderWelcomeMessage)
	showPlayerHudComponent("ammo", true)
		--[[showPlayerHudComponent("vehicle_name", false)
		showPlayerHudComponent("money", true)
		showPlayerHudComponent("health", true)
		showPlayerHudComponent("armour", true)
		showPlayerHudComponent("breath", true)
		showPlayerHudComponent("radar", true)
		showPlayerHudComponent("area_name", true)]]
	end
	if (accountwindow) then
		destroyElement(tabPanelCharacter)
		destroyElement(accountwindow)
		accountwindow = nil
		tabPanelCharacter = nil
	end
	
	
	
	if (regged) then
		createMainUI(getThisResource())
	end
	
	if (bChangeAccount) then
		destroyElement(bChangeAccount)
		bChangeAccount = nil
	end
	
	if wDelConfirmation then
		destroyElement(wDelConfirmation)
		wDelConfirmation = nil
	end
end
addEvent("hideUI", true)
addEventHandler("hideUI", getRootElement(), hideUI)

tabPanelCharacter, tabCharacter, tabAccount, tabAchievements, tabStatistics, tableAccounts, lCharacters, paneCharacters, lCreateFakepane, lCreateBG, lCreateName, lCreateImage,accountwindow = nil
paneChars = { }
tableAchievements, tableStatistics, iAchievementCount, iAchievementPointsCount = nil
bEditChar = nil
bDeleteChar = nil
bChangeAccount = nil

sent = false
function changedTab(tab)
	if (tab==tabAchievements) and not (sent) then
		sent = true
		lLoading = guiCreateLabel(0.45, 0.4, 0.3, 0.3, "Loading...", true, tabAchievements)
		guiSetFont(lLoading, "default-bold-small")
		triggerServerEvent("requestAchievements", getLocalPlayer())
	end
end
function showCharacterUI(accounts)

	sent = false
	if (bChangeChar) then
		destroyElement(bChangeChar)
		bChangeChar = nil
	end

	setElementAlpha(getLocalPlayer(), 255)
	
setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)

	--setCameraMatrix(1417.66796875, -1624.4677734375, 54.605579376221,1418.1201171875, -1625.44140625, 54.6055793)
		--setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)

	fadeCamera(true)
	
	tableAccounts = accounts	
	toggleAllControls(false, true, false)

	local width, height = 420, 400
			
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	
	displayAccountManagement()

	-- Character Info
	local charsDead, charsAlive = 0, 0
	
	for key, value in pairs(accounts) do
		if (tonumber(accounts[key][3])==1) then
			charsDead = charsDead + 1
		else
			charsAlive = charsAlive + 1
		end
	end
	
	lCharacters = guiCreateLabel(0.05, 0.025, 0.9, 0.15, "Your Characters: [" .. #accounts .."]", true, tabCharacter)
	guiLabelSetColor(lCharacters,255,0,0)
	paneCharacters = guiCreateScrollPane(0.315,0.287, 0.4, 0.4, true, tabCharacter)
	
	paneChars = { }
	local y = 0.0
	local height = 0.2
	
	for key, value in pairs(accounts) do
		local charname = string.gsub(tostring(accounts[key][2]), "_", " ")
		local cked = tonumber(accounts[key][3])
		local area = accounts[key][4]
		local age = accounts[key][5]
		local gender = tonumber(accounts[key][6])
		local factionName = accounts[key][7]
		local factionRank = accounts[key][8]
		local skinID = tostring(accounts[key][9])
		local difference = tonumber(accounts[key][10])
		local login = ""
		hours = ( getElementData(getLocalPlayer(), "hoursplayed" ) or 0 )
		if (not difference) then
			login = "Never"
		else
			--local difference = yearday - charyearday
			
			if (difference==0) then
				login = "Today"
			elseif (difference==1) then
				login = tostring(difference) .. " day ago"
			else
				login = tostring(difference) .. " days ago"
			end
		end
		
		--Fix skin ID
		if (string.len(skinID)==2) then
			skinID = "0" .. skinID
		elseif (string.len(skinID)==1) then
			skinID = "00" .. skinID
		end
		
		-- Gender
		if (tonumber(gender)==0) then
			gender = "Male"
		else
			gender = "Female"
		end
		paneChars[key] = {}
		paneChars[key][7] = guiCreateScrollPane(0.0, y, 1.0, 0.5, true, paneCharacters)
		paneChars[key][1] = guiCreateStaticImage(0.6325,0.4933,0.0213,0.0133, "img/charbg0.png", true, paneChars[key][7])
		paneChars[key][8] = cked
		addEventHandler("onClientRender", getRootElement(),ground)	
		playasl = guiCreateLabel(0.0088,0.4167,0.2025,0.075,"",true)
		guiLabelSetVerticalAlign(playasl,"top")
		guiLabelSetHorizontalAlign(playasl,"left",false)
		if (cked==nil) then
			paneChars[key][2] = guiCreateLabel(0.3, 0.1, 0.5, 0.2,tostring(charname), true, paneChars[key][7])
		else
			
paneChars[key][2] = guiCreateLabel(0.3, 0.1,0.215,0.0733, tostring(charname) .. " (Deceased)", true, paneChars[key][7])
			end
		
		paneChars[key][3] = guiCreateStaticImage(0.05, 0.1, 0.2, 0.5, "img/" .. skinID .. ".png", true, paneChars[key][7])
		paneChars[key][4] = guiCreateLabel(0.3, 0.25, 0.5, 0.2,"Age: " ..age .. " years.", true, paneChars[key][7])
	
		
		if (login~="Never") then
			paneChars[key][6] = guiCreateLabel(0.3, 0.35, 0.5, 0.2, "Last seen: " .. login .. " at " .. area .. ".", true, paneChars[key][7])
		else
			paneChars[key][6] = guiCreateLabel(0.3, 0.35, 0.5, 0.2, "Last seen: Never", true, paneChars[key][7])
		end
		
		addEventHandler("onClientGUIClick", paneChars[key][1], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][2], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][3], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][4], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][5], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][6], selectedCharacter)
		addEventHandler("onClientGUIClick", paneChars[key][7], selectedCharacter)
		
		addEventHandler("onClientGUIDoubleClick", paneChars[key][1], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][2], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][3], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][4], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][5], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][6], dcselectedCharacter)
		addEventHandler("onClientGUIDoubleClick", paneChars[key][7], dcselectedCharacter)
		
		-- Set the fonts
		guiSetFont(paneChars[key][2], "default-bold-small")
		guiSetFont(paneChars[key][4], "default-small")
		guiSetFont(paneChars[key][5], "default-small")
		guiSetFont(paneChars[key][6], "default-small")
		
		y = y + 0.205
	end
	-- Edit Char button
	bCreateChar = guiCreateButton(0.7237,0.43,0.1238,0.046, "Create", true, tabCharacter)
	addEventHandler("onClientGUIClick", bCreateChar,characterCreation, false)
	

	bEditChar = guiCreateButton(0.7237,0.4933,0.1238,0.046, "Edit", true, tabCharacter)
	addEventHandler("onClientGUIClick", bEditChar, editSelectedCharacter, false)
	
	-- Delete char button
	bDeleteChar = guiCreateButton(0.725,0.566,0.1238,0.046, "Delete", true, tabCharacter)
	addEventHandler("onClientGUIClick", bDeleteChar, deleteSelectedCharacter, false)
	
	blogout = guiCreateButton(0.725,0.90,0.10,0.036, "Back", true, tabCharacter)
	addEventHandler("onClientGUIClick", blogout,changeAccount, false)

	guiSetVisible(bEditChar, false)
	guiSetVisible(bDeleteChar, false)
	
	guiSetAlpha(tabPanelCharacter, 0.75)
	showCursor(true)
	setElementAlpha(getLocalPlayer(), 0)
	fadeCamera(true, 2)
	
	guiSetInputEnabled(true)
end
addEvent("showCharacterSelection", true)
addEventHandler("showCharacterSelection", getRootElement(), showCharacterUI)

function changeAccount(button, state)
	if (source==blogout) and (button=="left") then
		local id = getElementData(getLocalPlayer(), "gameaccountid")
		showCursor(false)
		cancelCreation()
		hideUI()
		destroyElement(blogout)
		createMainUI(getThisResource(), true)
		hideback()
		triggerServerEvent("account:loggedout", getLocalPlayer())
	end
end

fading = false
tmrHideMouse = nil

function fadePlayerIn(newChar)
	local alpha = getElementAlpha(getLocalPlayer())
	setElementAlpha(getLocalPlayer(), alpha+25)
	if ((alpha+25)>=250) then
		setElementAlpha(getLocalPlayer(), 255)
		showCursor(true)
		fading = false
	end
end

triggering = false
spawned = false

function deleteSelectedCharacter(button, state)
	if (button=="left") and (state=="up") and (source==bDeleteChar) then
		if (selectedChar) and not wDelConfirmation then
			local charname = tostring(guiGetText(paneChars[selectedChar][2]))
			local sx, sy = guiGetScreenSize() 
			wDelConfirmation = guiCreateWindow(sx/2 - 125,sy/2 - 50,250,100,"Deletion Confirmation", false)
			local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Do you really want to delete the character "..charname.."?",true,wDelConfirmation)
							  guiLabelSetHorizontalAlign (lQuestion,"center",true)
			local bYes = guiCreateButton(0.1,0.65,0.37,0.23,"Yes",true,wDelConfirmation)
			local bNo = guiCreateButton(0.53,0.65,0.37,0.23,"No",true,wDelConfirmation)
			addEventHandler("onClientGUIClick", getRootElement(), 
				function(button)
					if (button=="left") then
						if source == bYes then
							hideback()
							triggerServerEvent("deleteCharacter", getLocalPlayer(), charname)
							deleteCharacter(charname)
						elseif source == bNo then
							if wDelConfirmation then
								destroyElement(wDelConfirmation)
								wDelConfirmation = nil
							end
						end
					end
				end
			)
		end
	end
end
function hideback()
	guiSetVisible (blogout, false )
	guiSetVisible (bEditChar, false )
	guiSetVisible (bDeleteChar, false )
	guiSetVisible (bCreateChar, false )
	guiSetVisible (paneCharacters, false )
	guiSetVisible (paneChars, false )
	guiSetVisible (lCharacters, false )
	removeEventHandler("onClientRender", getRootElement(),ground)
end
function showback()
	guiSetVisible (blogout,true)
	guiSetVisible (bEditChar, true )
	guiSetVisible (bDeleteChar, true )
	guiSetVisible (bCreateChar, true )
	guiSetVisible (paneCharacters, true )
	guiSetVisible (paneChars, true )
	guiSetVisible (lCharacters, true )
	addEventHandler("onClientRender", getRootElement(),ground)
end
	
					

function deleteCharacter(charname)
	hideUI()
	tableAccounts[selectedChar] = nil
	showCharacterUI(tableAccounts, false)
end
			
addEvent("onClientChooseCharacter", false)
function dcselectedCharacter(button, state)
	if (button=="left") and (state=="up") then
		if (source~=lCreateFakepane) and (source~=lCreateBG) and (source~=lCreateName) and (source~=lCreateImage) then
			if not (triggering) then
				triggering = true
			
				-- Find the key that was hit
				local foundkey = nil
				for key, value in pairs(paneChars) do
					for i, j in pairs(paneChars[key]) do
						if (j==source) then
							foundkey = key
						end
					end
				end
				
				local charname = tostring(guiGetText(paneChars[foundkey][2]))
				local cked = string.find(charname, "(Deceased)")

				if (cked==nil) then
					fadeCamera(false, 1)
					setCameraInterior(0)
					spawned = true
					hideback()

					playSoundFrontEnd(32)
					sent = false
					triggerServerEvent("spawnCharacter", getLocalPlayer(), charname, getVersion().mta)
					
					setTimer(resetTriggers, 100, 1)
					setTimer(showCursor, 50, 30, false)
					
					toggleAllControls(true, true, true)
					guiSetInputEnabled(false)
					showCursor(false)
					showChat(true)
					showLogoutPanel()
					showPlayerHudComponent("ammo", true)
					showPlayerHudComponent("clock", false)
					showPlayerHudComponent("radar", true)
				else
					triggering = false
					setTimer(playSoundFrontEnd, 500, 3, 20)
				end
			end
		else
			if (creation==false) then
				creation = true
				guiSetVisible(tabPanelCharacter, false)
				guiSetVisible(accountwindow, false)
				characterCreation()
				playSoundFrontEnd(32)
			end
		end
	end
end



bChangeChar = nil
selectedChar = nil
function showLogoutPanel()
if guiGetVisible(wBank)== true then 
destroyElement(bChangeChar)
end
end


addEvent("onClientChangeChar", false)
cars = createMarker ( 544.49,-1292, 17, "cylinder", 10, 255, 255, 0, 0 )
boats = createMarker ( 715,-1705, 2.42, "cylinder", 5, 255, 255, 0, 0 )
cheapcars = createMarker ( 2131.81,-1151.32, 24.06, "cylinder", 10, 255, 255, 0, 0 )

rentcars = createMarker ( 1359.81,-1646, 13, "cylinder", 10, 255, 255, 0, 0 )

function changeCharacter(button, state)
cur = isCursorShowing ( getLocalPlayer() )
if not cur then
if not isElementWithinMarker(getLocalPlayer(),cars)  then
if not isElementWithinMarker(getLocalPlayer(),boats)  then
if not isElementWithinMarker(getLocalPlayer(),cheapcars)  then
if not isElementWithinMarker(getLocalPlayer(),rentcars)  then
		local id = getElementData(getLocalPlayer(), "gameaccountid")
		showCursor(false)
		triggerEvent("onClientChangeChar", getLocalPlayer())
		triggerServerEvent("sendAccounts", getLocalPlayer(), getLocalPlayer(), id, true)
		triggerServerEvent("fades", getLocalPlayer())

		triggerServerEvent("player:loggedout", getLocalPlayer())
end
end
end
end
end
end
addCommandHandler("home",changeCharacter)
bindKey("end","down","home")


function resetTriggers()
	triggering = false
end

function unhideCursor()
	if not (spawned) then
		showCursor(true)
	else
		showCursor(false)
	end
end

function selectedCharacter(button, state)
	if (button=="left") and (state=="up") then
		playSoundFrontEnd(37)
		if (source~=lCreateFakepane) and (source~=lCreateBG) and (source~=lCreateName) and (source~=lCreateImage) then
			
			local found = false
			local key = 0
			for i, j in pairs(paneChars) do
				local isthis = false
				for k, v in pairs(paneChars[i]) do
					if (v==source) then
						isthis = true
						found = true
						key = i
					end
				end
			
				guiBringToFront(paneChars[i][2])
				guiBringToFront(paneChars[i][3])
				guiBringToFront(paneChars[i][4])
				guiBringToFront(paneChars[i][5])
				guiBringToFront(paneChars[i][6])
				guiBringToFront(paneChars[i][7])
				if not (isthis) then
					guiStaticImageLoadImage(paneChars[i][1], "img/charbg0.png")
					
				end
			end

			if (found) then
				guiStaticImageLoadImage(paneChars[key][1], "img/charbg1.png")
				selectedChar = key
				local skinID = tonumber(tableAccounts[key][9])
				local cked = tonumber(tableAccounts[key][3])
				setElementModel(getLocalPlayer(), skinID)
					
				local rand = math.random(1,6)
				if (rand==1) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "shift", -1, true, true, true)
				elseif (rand==2) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "shldr", -1, true, true, true)
				elseif (rand==3) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "stretch", -1, true, true, true)
				elseif (rand==4) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "strleg", -1, true, true, true)
				elseif (rand==5) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "time", -1, true, true, true)
				elseif (rand==6) then
					exports.global:applyAnimation(getLocalPlayer(), "ON_LOOKERS", "wave_loop", -1, true, true, true)
				end
				
				setElementAlpha(getLocalPlayer(), 0)
					
				if (cked==nil) then
					fading = true
						
					if (isTimer(tmrFadeIn)) then killTimer(tmrFadeIn) end
					
					tmrHideMouse = setTimer(unhideCursor, 200, 1)
					tmrFadeIn = setTimer(fadePlayerIn, 50, 10)
					
					guiSetVisible(bEditChar, true)
					guiSetVisible(bDeleteChar, true)
				else
					local x, y, z = getElementPosition(getLocalPlayer())
					setElementAlpha(getLocalPlayer(), 0)
					tmrFadeIn = setTimer(fadePlayerIn, 50, 10)
					exports.global:applyAnimation(getLocalPlayer(), "WUZI", "CS_Dead_Guy", -1, true, false, true)

					guiSetVisible(bEditChar, false)
					guiSetVisible(bDeleteChar, false)
				end
			end
			
		else
			if (isTimer(tmrFadeIn)) then killTimer(tmrFadeIn) end
			
			for key, value in ipairs(paneChars) do
				guiStaticImageLoadImage(paneChars[key][1], "img/charbg0.png")
					
			end
			selectedChar = nil
			-- Player effect
			setElementModel(getLocalPlayer(), 264)
			
			local rand = math.random(1,6)
				if (rand==1) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "shift", -1, true, false, true)
				elseif (rand==2) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "shldr", -1, true, false, true)
				elseif (rand==3) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "stretch", -1, true, false, true)
				elseif (rand==4) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "strleg", -1, true, false, true)
				elseif (rand==5) then
					exports.global:applyAnimation(getLocalPlayer(), "PLAYIDLES", "time", -1, true, false, true)
				elseif (rand==6) then
					exports.global:applyAnimation(getLocalPlayer(), "ON_LOOKERS", "wave_loop", -1, true, false, true)
				end
				
			setElementAlpha(getLocalPlayer(), 0)	
			fading = true
			
			tmrHideMouse = setTimer(unhideCursor, 200, 1)
			tmrFadeIn = setTimer(fadePlayerIn, 50, 10)
			
			guiSetVisible(bEditChar, false)
			guiSetVisible(bDeleteChar, false)
		end
	end
end

tabCreationOne, lName, tname, lRestrictions = nil

creation = false

GUIEditor_Label = {}
GUIEditor_Grid = {}
skinimage = {}
creationwindow = {}

function characterCreation()
gender = 0
skincolour = 1
curskin = 0
fatness = 0
muscles = 0
name = ""
			local playerid = getElementData(getLocalPlayer(), "playerid")
			setElementDimension(getLocalPlayer(), 65000+playerid)
			setElementPosition(getLocalPlayer(),2238.00390625, -1663.4208984375, 15.4765625)
			setPedRotation(getLocalPlayer(),323.82)
			  setElementAlpha(getLocalPlayer(), 255)
			setCameraMatrix(2241.96484375, -1658.7890625, 16.735620498657,2240.00390625, -1663.5595703125, 15.963521957397)
			fadeCamera(true)	
			hideback()


creationwindow = guiCreateWindow(0.0325,0.15,0.4938,0.671,"Create Character",true)
guiWindowSetMovable ( creationwindow, false )
guiWindowSetSizable ( creationwindow, false )
guiSetInputEnabled ( true )
lname = guiCreateLabel(18,31,41,23,"Name:",false,creationwindow)
guiLabelSetColor(lname,255,255,255)
guiLabelSetVerticalAlign(lname,"top")
guiLabelSetHorizontalAlign(lname,"left",false)
tname = guiCreateEdit(56,29,166,20,"",false,creationwindow)
addEventHandler("onClientGUIChanged", tname, checkName) 
addEventHandler("onClientGUIChanged", tname, loadNextPage) 
GUIEditor_Label[1] = guiCreateLabel(57,147,5,5,"",false,creationwindow)
guiLabelSetColor(GUIEditor_Label[1],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
lRestrictions = guiCreateLabel(21,60,200,46,"No underscores,No clan tags [] \nRealistic Name \n Example: Marcus Wayne",false,creationwindow)
guiLabelSetColor(lrestrictions,255,255,255)
guiLabelSetVerticalAlign(lrestrictions,"top")
guiLabelSetHorizontalAlign(lrestrictions,"left",false)
GUIEditor_Grid[1] = guiCreateGridList(174,75,5,5,false,creationwindow)
guiGridListSetSelectionMode(GUIEditor_Grid[1],2)
lGender = guiCreateLabel(14,120,52,20,"Gender:",false,creationwindow)
guiLabelSetColor(lGender,255,255,255)
guiLabelSetVerticalAlign(lGender,"top")
guiLabelSetHorizontalAlign(lGender,"left",false)
rMale = guiCreateCheckBox(83,119,51,21,"Male",false,false,creationwindow)
rFemale = guiCreateCheckBox(144,119,66,23,"Female",false,false,creationwindow)
addEventHandler("onClientGUIClick", rMale, normalSetMale, false)
addEventHandler("onClientGUIClick", rFemale, normalSetFemale, false)
guiCheckBoxSetSelected(rMale, true) 
lSkinColour = guiCreateLabel(12,156,67,20,"Skin Colour:",false,creationwindow)
guiLabelSetColor(lSkinColour,255,255,255)
guiLabelSetVerticalAlign(lSkinColour,"top")
guiLabelSetHorizontalAlign(lSkinColour,"left",false)
rBlack = guiCreateRadioButton(87,153,71,24,"Black",false,creationwindow)
rWhite = guiCreateRadioButton(148,154,71,24,"White",false,creationwindow)
rAsian = guiCreateRadioButton(220,154,71,24,"Asian",false,creationwindow)
guiRadioButtonSetSelected(rWhite, true)
addEventHandler("onClientGUIClick", rBlack, normalSetBlack, true, false, false)
addEventHandler("onClientGUIClick", rWhite, normalSetWhite, false, true, false)
addEventHandler("onClientGUIClick", rAsian, normalSetAsian, false, false, true)

GUIEditor_Label[2] = guiCreateLabel(19,310,67,20,"Skin",false,creationwindow)
guiLabelSetColor(GUIEditor_Label[2],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
lAge = guiCreateLabel(236,29,47,22,"Age:",false,creationwindow)
guiLabelSetColor(lAge,255,255,255)
guiLabelSetVerticalAlign(lAge,"top")
guiLabelSetHorizontalAlign(lAge,"left",false)
lHeight = guiCreateLabel(236,62,47,22,"Height:",false,creationwindow)
guiLabelSetColor(lHeight,255,255,255)
guiLabelSetVerticalAlign(lHeight,"top")
guiLabelSetHorizontalAlign(lHeight,"left",false)
lWeight = guiCreateLabel(235,91,47,22,"Weight:",false,creationwindow)
guiLabelSetColor(lWeight,255,255,255)
guiLabelSetVerticalAlign(lWeight,"top")
guiLabelSetHorizontalAlign(lWeight,"left",false)
tHeight = guiCreateEdit(288,61,64,19,"165",false,creationwindow)
addEventHandler("onClientGUIChanged", tHeight, checkInput)
tWeight = guiCreateEdit(290,90,64,19,"50",false,creationwindow)
addEventHandler("onClientGUIChanged", tWeight, checkInput)
tAge = guiCreateEdit(287,30,64,19,"24",false,creationwindow)
addEventHandler("onClientGUIChanged", tAge, checkInput)
nextSkin = guiCreateButton(58,310,40,14,"<",false,creationwindow)
prevSkin = guiCreateButton(116,310,40,14,">",false,creationwindow)
addEventHandler("onClientGUIClick", prevSkin, adjustNormalSkin, false)
addEventHandler("onClientGUIClick", nextSkin, adjustNormalSkin, false)
skinimage = guiCreateStaticImage(27,189,127,104,"img/nil.png",false,creationwindow)
tCharDesc = guiCreateEdit(200,206,181,124,"Default Description",false,creationwindow)
addEventHandler("onClientGUIChanged", tCharDesc, checkInput)
lCharDesc = guiCreateLabel(204,183,130,19,"Description",false,creationwindow)
informl = guiCreateLabel(215,114,161,39,"",false,creationwindow)
guiLabelSetColor(informl,255,0,0)
guiSetFont(informl, "default-bold-small")
guiLabelSetColor(lCharDesc ,255,255,255)
guiLabelSetVerticalAlign(lCharDesc,"top")
guiLabelSetHorizontalAlign(lCharDesc,"left",false)
cbutton= guiCreateButton(70,356,106,29,"Create",false,creationwindow)
canb = guiCreateButton(202,356,106,29,"Cancel",false,creationwindow)
addEventHandler("onClientGUIClick",canb,ccreation)
addEventHandler("onClientGUIClick",cbutton,characterCreationFinal)
addEventHandler("onClientGUIClick",cbutton,checkName)
end

function ccreation ()
	
	if (source==canb) and( guiGetVisible (creationwindow) == true ) then 
			guiSetVisible ( creationwindow,false ) 
			showback()
			showCursor(false)
			setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)
			fadeCamera(true)
	end
end
function closed()
	
	if ( guiGetVisible (creationwindow) == true ) then 
			guiSetVisible ( creationwindow,false ) 
			setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)
			fadeCamera(true)
			outputChatBox("Character Created Successfully!.",0,255,0,true)	
	end
end
addEvent("ccreation",true)
addEventHandler("ccreation", getRootElement(),closed)

function alreadyused()
	guiSetText(tname,"Already Inuse")
	outputChatBox("This Character Name Already Exists",255,0,0,true)
end
addEvent("alreadyused", true)
addEventHandler("alreadyused", getRootElement(), alreadyused)
function spawnNormal(button, state)
	if (button=="left") and (state=="up") then
		skinint = math.random(1, #blackMales)
		skin = blackMales[skinint]
		setElementModel(getLocalPlayer(), skin)
		curskin = skinint
	end
end

function checkName()
	if (source==tname) or (source==canb)  then
		local theText = guiGetText(source)
		
		local foundSpace, valid = false, true
		local lastChar, current = ' ', ''
		for i = 1, #theText do
			local char = theText:sub( i, i )
			if char == ' ' then -- it's a space
				if i == #theText then -- space at the end of name is not allowed
					valid = false
					break
				else
					foundSpace = true -- we have at least two name parts
				end
				
				if #current < 2 then -- check if name's part is at least 2 chars
					valid = false
					break
				end
				current = ''
			elseif lastChar == ' ' then -- this char follows a space, we need a capital letter
				if char < 'A' or char > 'Z' then
					valid = false

					break
				end
				current = current .. char
			elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) then -- can have letters anywhere in the name
				current = current .. char
			else -- unrecognized char (numbers, special chars)
				valid = false
				break
			end
			lastChar = char
		end
		
		if valid and foundSpace and #theText < 22 and #current >= 2 then
			guiLabelSetColor(lRestrictions, 0, 255, 0)
			namevalid = true
		else
			guiLabelSetColor(lRestrictions, 255, 0, 0)
			
		end
	end
end

function cancelCreation(button, state)
			removeEventHandler("onClientRender", getRootElement(), moveCameraToCreation)
			destroyElement(skinimage)
			if (isElement(bRotate)) then
				destroyElement(bRotate)
			end
			bRotate = nil
			local playerid = getElementData(getLocalPlayer(), "playerid")
			setElementDimension(getLocalPlayer(), 65000+playerid)
			setElementPosition(getLocalPlayer(), 1418.1923828125, -1628.998046875, 54.605579376221)
			setPedRotation(getLocalPlayer(), 8)
			
			creation = false
			
			if (isElement(tabPanelCreation)) then
				destroyElement(tabPanelCreation)
			end
			tabPanelCreation = nil
			setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)

			--setCameraMatrix(1417.66796875, -1624.4677734375, 54.605579376221,1418.1201171875, -1625.44140625, 54.6055793)
			fadeCamera(true)
			
end





blackMales = {007, 014, 015, 016, 017, 018, 020, 021, 022, 024, 025, 028, 035, 036, 050, 051, 066, 067, 078, 079, 080, 083, 084, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262 }
whiteMales = {023, 026, 027, 029, 030, 032, 033, 034, 035, 036, 037, 038, 043, 044, 045, 046, 047, 048, 050, 051, 052, 053, 058, 059, 060, 061, 062, 068, 070, 072, 073, 078, 081, 082, 094, 095, 096, 097, 098, 099, 100, 101, 108, 109, 110, 111, 112, 113, 114, 115, 116, 120, 121, 122, 124, 125, 126, 127, 128, 132, 133, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 170, 171, 173, 174, 175, 177, 179, 181, 184, 186, 187, 188, 189, 200, 202, 204, 206, 209, 212, 213, 217, 223, 230, 234, 235, 236, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264 }
asianMales = {049, 057, 058, 059, 060, 117, 118, 120, 121, 122, 123, 170, 186, 187, 203, 210, 227, 228, 229}
blackFemales = {009, 010, 011, 012, 013, 040, 041, 063, 064, 069, 076, 091, 139, 148, 190, 195, 207, 215, 218, 219, 238, 243, 244, 245, 256 }
whiteFemales = {012, 031, 038, 039, 040, 041, 053, 054, 055, 056, 064, 075, 077, 085, 086, 087, 088, 089, 090, 091, 092, 093, 129, 130, 131, 138, 140, 145, 150, 151, 152, 157, 172, 178, 192, 193, 194, 196, 197, 198, 199, 201, 205, 211, 214, 216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263 }
asianFemales = {038, 053, 054, 055, 056, 088, 141, 169, 178, 224, 225, 226, 263}


gender = 0
skincolour = 1
curskin = 23
skinimage = {}

function adjustNormalSkin(button, state)

 if ( guiGetVisible ( skinimage ) == false ) then 
	skinimage = guiCreateStaticImage(27,189,127,104,"img/nil.png",false,creationwindow)
end
	if (button=="left") and (state=="up") then
		if (source==nextSkin) then
			local array = nil
			if (skincolour==0) then -- BLACK
				if (gender==0) then -- BLACK MALE
					array = blackMales
				elseif (gender==1) then -- BLACK FEMALE
					array = blackFemales
				end
			elseif (skincolour==1) then -- WHITE
				if (gender==0) then -- WHITE MALE
					array = whiteMales
				elseif (gender==1) then -- WHITE FEMALE
					array = whiteFemales
				end
			elseif (skincolour==2) then -- ASIAN
				if (gender==0) then -- ASIAN MALE
					array = asianMales
				elseif (gender==1) then -- ASIAN FEMALE
					array = asianFemales
				end
			end
			
			if (curskin==#array) then
				curskin = 1
				skin = array[1]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
			else
				curskin = curskin + 1
				
				skin = array[curskin]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
			end
		elseif (source==prevSkin) then
			local array = nil
			if (skincolour==0) then -- BLACK
				if (gender==0) then -- BLACK MALE
					array = blackMales
				elseif (gender==1) then -- BLACK FEMALE
					array = blackFemales
				end
			elseif (skincolour==1) then -- WHITE
				if (gender==0) then -- WHITE MALE
					array = whiteMales
				elseif (gender==1) then -- WHITE FEMALE
					array = whiteFemales
				end
			elseif (skincolour==2) then -- ASIAN
				if (gender==0) then -- ASIAN MALE
					array = asianMales
				elseif (gender==1) then -- ASIAN FEMALE
					array = asianFemales
				end
			end
			
			-- Get the next skin
			if (curskin==1) then
				curskin = #array
				skin = array[1]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
			else
				curskin = curskin - 1
				skin = array[curskin]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
			end
		end
	end
end

function normalSetMale(button, state)
	if guiCheckBoxGetSelected(rFemale, true) then
		guiCheckBoxSetSelected (rFemale,false)
	end
	if (source==rMale) and (button=="left") and (state=="up") then
		guiSetAlpha (rFemale,75)
		guiSetAlpha (rMale,255)
		gender = 0
		generateSkin()
	end
end

function normalSetFemale(button, state)
	if guiCheckBoxGetSelected(rMale, true) then
		guiCheckBoxSetSelected (rMale,false)
	end

	if (source==rFemale) and (button=="left") and (state=="up") then
		guiSetAlpha (rMale,75)
		guiSetAlpha (rFemale,255)
		gender = 1
		generateSkin()
	end
end

function normalSetBlack(button, state)
	if (source==rBlack) and (button=="left") and (state=="up") then
		skincolour = 0
		generateSkin()
	end
end

function normalSetWhite(button, state)
	if (source==rWhite) and (button=="left") and (state=="up") then
		skincolour = 1
		generateSkin()
	end
end

function normalSetAsian(button, state)
	if (source==rAsian) and (button=="left") and (state=="up") then
		skincolour = 2
		generateSkin()
	end
end

function generateSkin()
	local skinint = 0
	if (gender==0) then -- MALE
		if (skincolour==0) then -- BLACK
			skinint = math.random(1, #blackMales)
			skin = blackMales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		elseif (skincolour==1) then -- WHITE
			skinint = math.random(1, #whiteMales)
			skin = whiteMales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		elseif (skincolour==2) then -- ASIAN
			skinint = math.random(1, #asianMales)
			skin = asianMales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		end
	elseif (gender==1) then -- FEMALE
		if (skincolour==0) then -- BLACK
			skinint = math.random(1, #blackFemales)
			skin = blackFemales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		elseif (skincolour==1) then -- WHITE
			skinint = math.random(1, #whiteFemales)
			skin = whiteFemales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		elseif (skincolour==2) then -- ASIAN
			skinint = math.random(1, #asianFemales)
			skin = asianFemales[skinint]
			setElementModel(getLocalPlayer(), skin)
			guiStaticImageLoadImage(skinimage,"img/"..skin..".png")
		end
	end
	curskin = skinint
end
heightvalid = true 
weightvalid = true
descvalid = true
agevalid = true
function checkInput()
	if (source==tHeight) then
		if not (tostring(type(tonumber(guiGetText(tHeight)))) == "number") then
			guiLabelSetColor(lHeight, 255, 0, 0)
			heightvalid = false
		elseif (tonumber(guiGetText(tHeight))<100) or (tonumber(guiGetText(tHeight))>200) then
			guiLabelSetColor(lHeight, 255, 0, 0)
			heightvalid = false
		else
			guiLabelSetColor(lHeight, 0, 255, 0)
			heightvalid = true
		end
	elseif (source==tWeight) then
		if not (tostring(type(tonumber(guiGetText(tWeight)))) == "number") then
			guiLabelSetColor(lWeight, 255, 0, 0)
			weightvalid = false
		elseif (tonumber(guiGetText(tWeight))<40) or (tonumber(guiGetText(tWeight))>200) then
			guiLabelSetColor(lWeight, 255, 0, 0)
			weightvalid = false
		else
			guiLabelSetColor(lWeight, 0, 255, 0)
			weightvalid = true
		end
	elseif (source==tAge) then
		if not (tostring(type(tonumber(guiGetText(tAge)))) == "number") then
			guiLabelSetColor(lAge, 255, 0, 0)
			agevalid = false
		elseif (tonumber(guiGetText(tAge))<18) or (tonumber(guiGetText(tAge))>80) then
			guiLabelSetColor(lAge, 255, 0, 0)
			agevalid = false
		else
			guiLabelSetColor(lAge, 0, 255, 0)
			agevalid = true
		end
	elseif (source==tCharDesc) then
		if (string.len(guiGetText(tCharDesc))<5) or (string.len(guiGetText(tCharDesc))>100) then
			guiLabelSetColor(lCharDesc, 255, 0, 0)
			descvalid = false
		else
			guiLabelSetColor(lCharDesc, 0, 255, 0)
			descvalid = true
		end
	end
end

function characterCreationFinal(button, state)
	if (source==cbutton) and (button=="left") and (state=="up") and not (anim) then
			local skin = getElementModel(getLocalPlayer())
			name =  guiGetText(tname)
		local foundSpace, valid = false, true
		local lastChar, current = ' ', ''
		for i = 1, #name do
			local char = name:sub( i, i )
			if char == ' ' then -- it's a space
				if i == #name then -- space at the end of name is not allowed
					valid = false
					break
				else
					foundSpace = true -- we have at least two name parts
				end
				
				if #current < 2 then -- check if name's part is at least 2 chars
					valid = false
					break
				end
				current = ''
			elseif lastChar == ' ' then -- this char follows a space, we need a capital letter
				if char < 'A' or char > 'Z' then
					valid = false
					break
				end
				current = current .. char
			elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) then -- can have letters anywhere in the name
				current = current .. char
			else -- unrecognized char (numbers, special chars)
				valid = false
				break
			end
			lastChar = char
		end
		
		if valid and foundSpace and #name < 22 and #current >= 2 then
			guiLabelSetColor(lRestrictions, 0, 255, 0)
		else
			guiLabelSetColor(lRestrictions, 255, 0, 0)
			guiSetText(informl,"Invalid Name.\nPlease use format.")
			return
		end


			if not (valid) then
				guiSetText(informl,"Invalid Name.\nPlease use format.")
				return
			end
			if not (heightvalid) then
			 	guiSetText(informl,"Invalid Height.")
			elseif not	(weightvalid) then
				guiSetText(informl,"Invalid Weight.")
			elseif not 	(descvalid)  then
				guiSetText(informl,"Invalid Desc. Enter\n from 5 to 100 char")
			elseif not	(agevalid)	then
				 guiSetText(informl,"Invalid Age.Enter\n from 18-99")

			else
				height = guiGetText(tHeight)
				weight = guiGetText(tWeight)
				age = guiGetText(tAge)
				description = guiGetText(tCharDesc)
			end
			
			if (skin==0) then -- CJ
				
				local clothes = { curhair, curhat, curneck, curface, curupper, curwrist, curlower, curfeet, curcostume, luTattoo, llTattoo, ruTattoo, rlTattoo, bTattoo, lcTattoo, rcTattoo, sTattoo, lbTattoo }
				triggerServerEvent("createCharacter", getLocalPlayer(), name, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language, clothes)
				
			else
				
				
				triggerServerEvent("createCharacter", getLocalPlayer(), name, gender, skincolour, weight, height, fatness, muscles, transport, description, age, skin, language)
				
			end
		
	end
end

lStatistics, lPoints, paneStatistics = nil
tabPanel, tabMystats, tabAllstats = nil

--/////////////////////////////////////////////////////////////////
--DISPLAY ACCOUNT MANAGEMENT
--////////////////////////////////////////////////////////////////
lDonator, lAdmin, lMuted, chkBlur, chkHelp, lChangePassword, lCurrPassword, tCurrPassword, lNewPassword1, NewPassword1, lNewPassword2, tNewPassword2, bSavePass = nil
function displayAccountManagement()
		-- CHANGE PASSWORD
	--[[lChangePassword = guiCreateLabel(0.375, 0.35, 0.5, 0.05, "Change Password", true, tabAccount)
	guiSetFont(lChangePassword, "default-bold-small")
	
	lCurrPassword = guiCreateLabel(0.1, 0.405, 0.5, 0.05, "Current Password: ", true, tabAccount)
	guiSetFont(lCurrPassword, "default-bold-small")
	tCurrPassword = guiCreateEdit(0.4, 0.4, 0.4, 0.05, "", true, tabAccount)
	guiEditSetMasked(tCurrPassword, true)
	
	lNewPassword1 = guiCreateLabel(0.1, 0.505, 0.5, 0.05, "New Password: ", true, tabAccount)
	guiSetFont(lNewPassword1, "default-bold-small")
	tNewPassword1 = guiCreateEdit(0.4, 0.5, 0.4, 0.05, "", true, tabAccount)
	guiEditSetMasked(tNewPassword1, true)
	
	lNewPassword2 = guiCreateLabel(0.1, 0.56, 0.5, 0.05, "New Password: ", true, tabAccount)
	guiSetFont(lNewPassword2, "default-bold-small")
	tNewPassword2 = guiCreateEdit(0.4, 0.555, 0.4, 0.05, "", true, tabAccount)
	guiEditSetMasked(tNewPassword2, true)
	
	bSavePass = guiCreateButton(0.25, 0.65, 0.5, 0.1, "Save Password", true, tabAccount)
	addEventHandler("onClientGUIClick", bSavePass, savePassword, false)]]
end

function savePassword(button, state)
	if (source==bSavePass) and (button=="left") and (state=="up") then
		showChat(true)
		local password = guiGetText(tCurrPassword)
		local password1 = guiGetText(tNewPassword1)
		local password2 = guiGetText(tNewPassword2)
		
		
		if (string.len(password1)<6) or (string.len(password2)<6) then
			outputChatBox("Your new password is too short. You must enter 6 or more characters.", 255, 0, 0)
		elseif (string.len(password)<6)  then
			outputChatBox("Your current password is too short. You must enter 6 or more characters.", 255, 0, 0)
		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
			outputChatBox("Your current password cannot contain ;,@'.", 255, 0, 0)
		elseif (string.find(password1, ";", 0)) or (string.find(password1, "'", 0)) or (string.find(password1, "@", 0)) or (string.find(password1, ",", 0)) then
			outputChatBox("Your new password cannot contain ;,@'.", 255, 0, 0)
		elseif (password1~=password2) then
			outputChatBox("The new passwords you entered do not match.", 255, 0, 0)
		else
			triggerServerEvent("cguiSavePassword", getLocalPlayer(), password, password1)
		end
	end
end


-- ////////////////// tognametags
local nametags = true
function toggleNametags()
	if (nametags) then
		nametags = false
		outputChatBox("Nametags are no longer visible.", 255, 0, 0)
		triggerEvent("hidenametags", getLocalPlayer())
	elseif not (nametags) then
		nametags = true
		outputChatBox("Nametags are now visible.", 0, 255, 0)
		triggerEvent("shownametags", getLocalPlayer())
	end
end
addCommandHandler("tognametags", toggleNametags)
addCommandHandler("togglenametags", toggleNametags)



--/////////////////////////////////////////////////////////////////
--DISPLAY CHARACTER EDITING
--////////////////////////////////////////////////////////////////
local charGender = 0
function editSelectedCharacter(button, state)
	if button=="left" and state=="up" and selectedChar and paneChars[selectedChar] then
		triggerServerEvent("requestEditCharInformation", getLocalPlayer(), guiGetText(paneChars[selectedChar][2]))
	end
end
function editCharacter(height, weight, age, description, gender)
	if selectedChar and paneChars[selectedChar] then
		charGender = gender
		
		guiSetVisible(tabPanelCharacter, false)
		guiSetVisible(accountwindow, false)
		
		local xwidth, xheight = 400, 400
		
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (xwidth/2)
		local y = scrHeight/2 - (xheight/2)
		
		tabPanelCreation = guiCreateTabPanel(5, y, xwidth, xheight, false)
		tabCreationFive = guiCreateTab("Edit Character", tabPanelCreation)
		guiSetAlpha(tabPanelCreation, 1)
		
		lInformation = guiCreateLabel(0.1, 0.025, 0.8, 0.15, tostring(guiGetText(paneChars[selectedChar][2])), true, tabCreationFive) 
		guiSetFont(lInformation, "sa-header")
		lHeight = guiCreateLabel(0.1, 0.145, 0.5, 0.15, "Height (cm)(between 100 and 200):", true, tabCreationFive)
		guiSetFont(lHeight, "default-bold-small")
		guiLabelSetColor(lHeight, 0, 255, 0)
		
		tHeight = guiCreateEdit(0.635, 0.143, 0.15, 0.05, height, true, tabCreationFive)
		addEventHandler("onClientGUIChanged", tHeight, checkInput)
		

		lWeight = guiCreateLabel(0.1, 0.215, 0.5, 0.15, "Weight (kg)(between 40 and 200):", true, tabCreationFive)
		guiSetFont(lWeight, "default-bold-small")
		guiLabelSetColor(lWeight, 0, 255, 0)
		
		tWeight = guiCreateEdit(0.635, 0.213, 0.15, 0.05, weight, true, tabCreationFive)
		addEventHandler("onClientGUIChanged", tWeight, checkInput)
	
		lAge = guiCreateLabel(0.1, 0.285, 0.5, 0.15, "Age (between 18 and 80):", true, tabCreationFive)
		guiSetFont(lAge, "default-bold-small")
		guiLabelSetColor(lAge, 0, 255, 0)
		
		tAge = guiCreateEdit(0.635, 0.283, 0.15, 0.05, age, true, tabCreationFive)
		addEventHandler("onClientGUIChanged", tAge, checkInput)

		lCharDesc = guiCreateLabel(0.1, 0.385, 0.8, 0.15, "Description(between 30 and 100 characters):", true, tabCreationFive)
		guiSetFont(lCharDesc, "default-bold-small")
		guiLabelSetColor(lCharDesc, 0, 255, 0)
		
		tCharDesc = guiCreateMemo(0.1, 0.455, 0.8, 0.25, description, true, tabCreationFive)
		addEventHandler("onClientGUIChanged", tCharDesc, checkInput)

		bNext = guiCreateButton(0.05, 0.75, 0.9, 0.1, "Save", true, tabCreationFive)
		addEventHandler("onClientGUIClick", bNext, updateEditedCharacter, false)
		
		bCancel = guiCreateButton(0.05, 0.85, 0.9, 0.1, "Cancel", true, tabCreationFive)
		addEventHandler("onClientGUIClick", bCancel,
			function()
				destroyElement(tabPanelCreation)
	
				tabPanelCreation = nil
				guiSetVisible(tabPanelCharacter, true)
				guiSetVisible(accountwindow, true)
			end, false)
	end
end
addEvent("sendEditingInformation", true)
addEventHandler("sendEditingInformation", getLocalPlayer(), editCharacter)

function updateEditedCharacter()
	if heightvalid and weightvalid and descvalid and agevalid and selectedChar then
		height = tonumber(guiGetText(tHeight))
		weight = tonumber(guiGetText(tWeight))
		age = tonumber(guiGetText(tAge))
		description = guiGetText(tCharDesc)
		
		triggerServerEvent("updateEditedCharacter", getLocalPlayer(), guiGetText(paneChars[selectedChar][2]), height, weight, age, description)
		
		destroyElement(tabPanelCreation)
		tabPanelCreation = nil
		guiSetVisible(tabPanelCharacter, true)
		guiSetVisible(accountwindow, true)
		
		-- update character screen (avoids us from reloading all accounts)
		local gender = "Male" 
		if charGender == 1 then
			gender = "Female"
		end
		guiSetText(paneChars[selectedChar][4], age .. " year old " .. gender .. ".", true)
	end
end

local oldvisible, changeAcc, changeChar
function checkForRadarMap()
	local visible = not isPlayerMapVisible() and isCursorShowing()
	if bChangeChar and isElement(bChangeChar) and ( guiGetAlpha(bChangeChar) > 0 ) ~= visible then
		guiSetAlpha(bChangeChar, visible and 0.75 or 0)
		visible = false
	end
	if bChangeAccount and isElement(bChangeAccount) and ( guiGetAlpha(bChangeAccount) > 0 ) ~= visible then
		guiSetAlpha(bChangeAccount, visible and 0.75 or 0)
	end
end
addEventHandler( "onClientRender", getRootElement(), checkForRadarMap )

addEvent("updateName", true)