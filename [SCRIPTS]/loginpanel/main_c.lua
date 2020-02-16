function stopNameChange(oldNick, newNick)
	if (source==getLocalPlayer()) then
		local legitNameChange = getElementData(getLocalPlayer(), "legitnamechange")
		local paused = getElementData(getLocalPlayer(), "paused")
		
		if (oldNick~=newNick) and (legitNameChange==0) and (paused==false) then
			triggerServerEvent("resetName", getLocalPlayer(), oldNick, newNick) 
			outputChatBox("Nick changing is not allowed.Press End to change character.", 255, 0, 0)
		end
	end
end
addEventHandler("onClientPlayerChangeNick", getRootElement(), stopNameChange)

local sizex,sizey = guiGetScreenSize()
local sizex = sizex - 300
local sizey = sizey - 300
local logospeed = 0.8
local alphaAction = 1
local alphaStep = 0
function renderWelcomeMessage()
	local screenX, screenY = guiGetScreenSize()
	motd = getElementData(getLocalPlayer(),"motd")
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0,100), false)
	if guiGetVisible(bLogin) == true then
		dxDrawText( "LK: Roleplay", screenX/2 - 299, screenY/10, 300, 199, tocolor ( 0,0,0, 255 ), 1.2, "bankgothic" )
		dxDrawText( "LK: Roleplay", screenX/2 - 300, screenY/10, 300, 200, tocolor ( 255, 255, 255, 255 ), 1.2, "bankgothic" )
		--dxDrawText( "  Mensagem do dia:  "..motd, screenX/8, screenY/6.5, screenX, screenY, tocolor ( 203, 255, 255, 255 ), 1, "default-bold" ) 
	elseif guiGetVisible(bRegister) == true then
		dxDrawText( "LK: Roleplay", screenX/2 - 299, screenY/10, 300, 199, tocolor ( 0,0,0, 255 ), 1.2, "bankgothic" )
		dxDrawText( "LK: Roleplay", screenX/2 - 300, screenY/10, 300, 200, tocolor ( 255, 255, 255, 255 ), 1.2, "bankgothic" )
		--dxDrawText( "  Mensagem do dia:  "..motd, screenX/8, screenY/6.5, screenX, screenY, tocolor ( 203, 255, 255, 255 ), 1, "default-bold" ) 
	end
	motd = getElementData(getLocalPlayer(),"motd")
	if not motd then
		motd = "Não configurado. Admins podem setar a mensagem usando /setmsg comando."
	end
		alphaStep = alphaStep + alphaAction
	if (alphaStep > 55) or (alphaStep < 0) then
		alphaAction = alphaAction - alphaAction - alphaAction
	end

	sizex = sizex + logospeed
	sizey = sizey - logospeed 
	if (sizex>sizex+300) then
		sizex = guiGetScreenSize()
	end
	if (sizey>sizey+300) then
		sizey = guiGetScreenSize()
	end

	 --dxDrawText("Welcome Message: \n"..motd, screenX/2.5, screenY/4.9, screenX, screenY, tocolor ( 204, 255, 255, 255 ), 0.6, "bankgothic","center","top",true,true ) 
end

function renderstats()
	local screenX, screenY = guiGetScreenSize()
	amount = getElementData(getLocalPlayer(),"amount")
	chars = getElementData(getLocalPlayer(),"chars")
	username = getElementData(getLocalPlayer(),"latest")
	vehicles = getElementData(getLocalPlayer(),"vehicles")
	history = getElementData(getLocalPlayer(),"history")
	interiors = getElementData(getLocalPlayer(),"interiors")
	dxDrawText( "ESTATISTICAS DO SERVIDOR:\n\nContas: "..amount..", \n~-~-~-~-~-~\nPlayers: "..chars..", \n~-~-~-~-~-~\nNovos: "..username..", \n~-~-~-~-~-~\nVeiculos: " ..vehicles..", \n~-~-~-~-~-~\nBanimentos: "..history..", \n~-~-~-~-~-~\nInteriores: "..interiors, screenX/2.5 - 299, screenY/10, 300, 349, tocolor (255, 255, 255, 255 ), 1, "default-bold","left","bottom",true,true ) 		
end

function showstats(amount,chars,username,vehicles,history,interiors)
	amount = setElementData(getLocalPlayer(),"amount",amount)
	chars = setElementData(getLocalPlayer(),"chars",chars)
	latest = setElementData(getLocalPlayer(),"latest",username)
	chars = setElementData(getLocalPlayer(),"vehicles",vehicles)
	latest = setElementData(getLocalPlayer(),"history",history)
	latest = setElementData(getLocalPlayer(),"interiors",interiors)
	addEventHandler("onClientRender",getRootElement(),renderstats)
end
addEvent("showstats",true)
addEventHandler("showstats",getLocalPlayer(),showstats)

function onPlayerSpawn()
	showCursor(false)
	
	local interior = getElementInterior(source)
	setCameraInterior(interior)
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), onPlayerSpawn)


function hideInterfaceComponents()
	setPlayerHudComponentVisible("weapon", false)
	setPlayerHudComponentVisible("ammo", false)
	setPlayerHudComponentVisible("vehicle_name", false)
	setPlayerHudComponentVisible("money", false)
	setPlayerHudComponentVisible("clock", false)
	setPlayerHudComponentVisible("health", false)
	setPlayerHudComponentVisible("armour", false)
	setPlayerHudComponentVisible("breath", false)
	setPlayerHudComponentVisible("area_name", false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), hideInterfaceComponents)

lLostSecurityKey, tLostSecurityKey, bForgot, chkRemember, chkAutoLogin, bLogin, lLogUsername, lLogUsernameNote,usee, passe, lLogPassword, tabPanelMain, tabLogin, tab, tabForgot, lRegUsername, tRegUsername, lRegUsernameNote, lRegPassword, tRegPassword, lRegPassword2, tRegPassword2, bRegister, wDelConfirmation = nil
tosversion = 101

function loadScenarioOne()
	local id = getElementData(getLocalPlayer(), "playerid")
	
	if not (id) then
		id = 0
	end
	setCameraMatrix(1456.8134765625, -1097.8125, 226.2836151123,  1446.8408203125, -1098.6904296875, 85.98332214)

		setCameraMatrix( 1368.48, -896.26, 84.25,   1411.72, -809.58, 77.58)
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

function showupdates()
	if guiGetVisible(updatewindow) == false then
		updatewindow = guiCreateWindow(204,106,394,369,"Updates",false)
	memo = guiCreateMemo(10,24,390,298,"LK [S4Z 1.0] (Some changes you may have already noticed)\n\nNEW FEATURES\n*RGB Vehicle colour.Any RGB color can be used to set a vehicle's colour\n*New friend list.Press 'O'\n*Serial lock.Prevents account hacking.\n*Odometer.Distance travelled tops\n*Cheat codes.\n*Special skins in character creation\n*Time gap between newbie chat to reduce spam\n\nFIXES/IMPROVEMENTS:\n*Improved vehicle lights colour.\n*Hotwire script updates\n*PD arrest fix.Player will spawn in jail not at hospital after death.\n*Weapon bug fix.\n*IP ban changed to serial ban.\n*Changes in hud.",false,updatewindow)
closeupdate = guiCreateButton(144,326,97,34,"Close",false,updatewindow)
			addEventHandler("onClientGUIClick",closeupdate, showupdates)
	else
		guiSetVisible(updatewindow,false)
		guiSetVisible(wLogin,false)
	end
end

function ver( )
local screenX, screenY = guiGetScreenSize( )
local label = guiCreateLabel( 0, 0, screenX, 15, "LK 1.0", false )
guiSetSize( label, guiLabelGetTextExtent( label ) + 5, 14, false )
guiSetPosition( label, screenX - guiLabelGetTextExtent( label ) - 5, screenY - 27, false )
guiSetAlpha( label, 0.5 )
end
addEventHandler( "onClientResourceStart", resourceRoot,ver)
function createrefresh()
	local width, height = guiGetScreenSize()
	if guiGetVisible(bRefresh) == false then
	--refreshl = guiCreateLabel(width /1.4, height /1.2,230,60, "Latest:", false, wLogin)
	--bRefresh = guiCreateButton(width/1.2, height /1.2, 75, 17, "Updates", false, wLogin)
	addEventHandler("onClientGUIClick", bRefresh,showupdates, false)
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(),createrefresh)
function createMainUI(res, isChangeAccount)

	if (res==getThisResource()) then
		fadeCamera(true)
		showChat(false)
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
			end
		
			
			if (bChangeAccount) then
				destroyElement(bChangeAccount)
				bChangeAccount = nil
			end
		
			
			local width, height = 400, 200
			
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth/2 - (width/2)
			local y = scrHeight/2 - (height/2)
			createrefresh()
			
			triggerServerEvent("getstats",getLocalPlayer())
			addEventHandler("onClientRender", getRootElement(), renderWelcomeMessage)	
			local width, height = guiGetScreenSize()
			showCursor(true)
			birth = guiCreateFont( "birth.ttf", 20 ) 
			x,y = guiGetScreenSize()
			--uBar = guiCreateWindow(0,0.97,1,0,"/ ! \\ --( ( Force Gaming Roleplay \\\\ forcebeta.tk || Los Santos // MTA 1.3 ) )-- / ! \\",true)
			--guiWindowSetMovable (uBar, false)
			--guiWindowSetSizable (uBar, false)
			dLogin = guiCreateWindow(0.2813,0.23,0.4638,0.5517,"", true )
			guiWindowSetMovable (dLogin, false)
			guiWindowSetSizable (dLogin, false)
			wLogin = guiCreateTabPanel(0.0243,0.0634,0.9515,0.9094,true, dLogin)
			logTab = guiCreateTab("Login", wLogin)
			regTab = guiCreateTab("Cadastro", wLogin)
			welcomeMSG = guiCreateLabel(53,27,270,70,"Bem vindo visitante,\n por favor, leve em consideração que\n nós somos uma comunidade\n roleplay, você NÃO pode\n desobedecer as regras do servidor.",false,logTab)
			welcomeMSG2 = guiCreateLabel(width /15, height /27, 270, 50, "Bem vindo ao nosso painel de cadastro.\n Você pode realizar o cadastro a seguir.", false, regTab)
			guiLabelSetColor(welcomeMSG,255,0,0)
			guiSetFont ( welcomeMSG, "default-bold-small" )
			guiSetFont ( welcomeMSG2, "default-bold-small" )
			error =   guiCreateLabel(width /10, height /5.8, 400, 20, "", false, logTab)
			rError =   guiCreateLabel(width /10, height /8.5, 400, 15, "", false, regTab)
			guiLabelSetColor(error,255,0,0)
			guiSetFont(error,"birth")
			--breg =  guiCreateButton(width /4, height /2.8, 85, 25, "Sign Up", false, logTab) -- login sign
			blog =  guiCreateButton(width /10, height /2.8, 85, 25, "Voltar", false, regTab)
			guiSetInputEnabled ( true )
			--addEventHandler("onClientGUIClick", breg, loginUpdate)
			addEventHandler("onClientGUIClick", blog,
		function ( )
refresh()
end, false )	
			userl = guiCreateLabel(0.2266,0.4513,0.2233,0.1,"Usuário:",true,logTab)
			usere =  guiCreateEdit(width /5, height /4.8, 100, 17, "", false, logTab)
			addEventHandler("onClientGUIChanged",usere,checkuser,true)
			regusere = guiCreateEdit(width /5, height /6.8, 100, 17,"",false, regTab)
			addEventHandler("onClientGUIChanged",regusere,checkuser)
			passl =   guiCreateLabel(0.2266,0.5415,0.2233,0.1,"Senha:",true,logTab)
		
			passe =  guiCreateEdit(width /5, height /4, 100, 17, "", false, logTab)
			-- reg password
			regpasse = guiCreateEdit(width /5, height /4.8, 100, 17,"",false, regTab)
			addEventHandler("onClientGUIChanged",regpasse,checkpass,true)
			guiEditSetMasked(regpasse, true)
			guiEditSetMasked(passe, true)
			guiEditSetMaxLength(passl, 29)
			user2 = guiCreateLabel(width /10, height /6.8, 70, 20, "Usuário:", false, regTab)
			pass2 =   guiCreateLabel(width /10, height /4.8, 70, 20, "Senha:", false, regTab)
			pass3 = guiCreateLabel(width /10, height /3.8, 95, 20,"Confirmar senha:",false, regTab)
			passe2 = guiCreateEdit(width /5, height /3.8, 100, 17,"",false,regTab)
			addEventHandler("onClientGUIChanged",passe2,checkpass,true)
			guiEditSetMasked(passe2, true)
			guiEditSetMaxLength(passe2, 29)
			
			chkRemember = guiCreateCheckBox(width /4, height /2.9,124,20,"Lembrar",false,false,logTab)
			chkAutoLogin =  guiCreateCheckBox(width /4, height /2.6,124,20,"Login Automático",false,false,logTab)
			guiLabelSetColor(chkRemember,0,0,0)
			guiLabelSetColor(chkAutoLogin,0,0,0)
			addEventHandler("onClientGUIClick", chkRemember, updateLoginState)
			bLogin = guiCreateButton(width /10, height /2.8, 85, 25, "Login", false, logTab)
			addEventHandler("onClientGUIClick", bLogin, validateDetails, false)
		
			bRegister =  guiCreateButton(width /4, height /2.8, 85, 25, "Cadastro", false, regTab) --SHOWWWWW
			-- register fo real
			addEventHandler("onClientGUIClick", bRegister, validateDetails, false)
		
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


function updateLoginState()
	if (guiCheckBoxGetSelected(chkRemember)) then
		guiSetEnabled(chkAutoLogin, true)
	else
		guiSetEnabled(chkAutoLogin, false)
		guiCheckBoxSetSelected(chkAutoLogin, false)
	end
end

function checkpass()
	if guiGetText(regpasse) == guiGetText(passe2) then
		guiSetText(rError,"As senhas inseridas são correspondentes")
		guiLabelSetColor(rError,0,255,0)
	else
		guiSetText(rError,"As senhas inseridas não correspondem")
		guiLabelSetColor(rError,255,0,0)
	end
end
function checkuser()
	if guiGetVisible(regusere) == true then
		local username= guiGetText(regusere)
		guiSetText(rError,"Usuário '"..username.."' disponivel")
		triggerServerEvent("checkuser",getLocalPlayer(),username,1)
		guiLabelSetColor(rError,0,255,0)
	else
		local username= guiGetText(usere)
		guiSetText(rError,"Usuário '"..username.."' não existe")
		triggerServerEvent("checkuser",getLocalPlayer(),username)
			guiLabelSetColor(rError,255,0,0)
	end
end

function userfound(register)
	if register ==1 then
		local username= guiGetText(regusere)
		guiSetText(rError,"Usuário '"..username.."' não está disponível")	
		guiLabelSetColor(rError,255,0,0)
	else
		local username= guiGetText(usere)
		guiSetText(rError,"Usuário '"..username.."' encontrado")	
		guiLabelSetColor(error,0,255,0)
	end
end
addEvent("userfound", true)
addEventHandler("userfound", getRootElement(),userfound)

function loginUpdate()
	guiSetVisible ( dLogin, true )
	guiSetVisible ( usere, true )
	guiSetVisible ( passe, true )
	guiSetVisible ( pass2, true )
	guiSetVisible ( wLogin, true )
	guiSetVisible ( passe2, true )
	guiSetVisible ( regpasse, true )
	guiSetVisible ( regusere, true)
	guiSetVisible ( chkAutoLogin, true )
	guiSetVisible ( chkRemember, true )
	guiSetVisible ( breg, true )
	guiSetVisible ( blog, true )
	guiSetVisible ( bLogin, true )
	guiSetVisible ( bRegister, true )
	playSoundFrontEnd(32)
end
function hidepanel()
	guiSetVisible ( dLogin, false )
	guiSetVisible ( wLogin, false )
	guiSetVisible ( error, false )
	guiSetVisible ( refreshl, false )
	guiSetVisible ( bRefresh, false )
	guiSetVisible ( userl, false )
	guiSetVisible ( passl, false )
	guiSetVisible ( usere, false )
	guiSetVisible ( passe, false )
	guiSetVisible ( pass2, false )
	guiSetVisible ( passe2, false )
	guiSetVisible ( regpasse,false)
	guiSetVisible ( regusere, false)
	guiSetVisible ( chkAutoLogin, false )
	guiSetVisible ( chkRemember, true )
	guiSetVisible ( breg, false )
	guiSetVisible ( blog, false )
	guiSetVisible ( bLogin, false )
	guiSetVisible ( bRegister, false )
end

function loginChange()
	guiSetVisible ( pass2, false )
	guiSetVisible ( pass3, false )
		guiSetVisible ( user2, false )
	guiSetVisible ( passe2, false )
	guiSetVisible ( usere, true )
	guiSetVisible ( passe, true )
	guiSetVisible ( regpasse, false)
	guiSetVisible ( regusere, false)
	guiSetVisible ( chkAutoLogin, true )
	guiSetVisible ( chkRemember, true)
	guiSetVisible ( breg, true )
	guiSetVisible ( blog, false)
	guiSetVisible ( bLogin, true )
	guiSetVisible ( bRegister, false )
	playSoundFrontEnd(32)
	
end
addEvent("loginChange",true)
addEventHandler("loginChange", getLocalPlayer(),loginChange)

function refresh()
	hidepanel()
	removeEventHandler("onClientRender", getRootElement(),renderWelcomeMessage)
	removeEventHandler("onClientRender", getRootElement(),renderstats)
	createMainUI(getThisResource())
end

function validateDetails()
	if (source==bRegister) then
		local username = guiGetText(regusere)
		local password1 = guiGetText(regpasse)
		local password2 = guiGetText(passe2)
		
		local password = password1 .. password2
		if (string.len(username)<3) then
			guiSetText(rError,"Usuário muito curto, coloque mais que 3 caracteres")
			--outputChatBox("Username is too short.Enter more than 3 characters",255,0,0)
		elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) then
			--outputChatBox("Your username cannot contain ;@.",255,0,0)
			guiSetText(rError,"Seu Usuário não pode conter ;@.")
		elseif (string.len(password1)<3) then
			--outputChatBox("Your password is too short.Enter more than 3 characters.",255,0,0)
			guiSetText(rError,"Sua senha é muito curta, colque mais que 3 caracteres")
		elseif (string.len(password1)>=30) then
		--	outputChatBox("Your password is too long.Enter less than 30 characters.",255,0,0)
		guiSetText(rError,"Sua senha é muito longa, coloque menos que 30 caracteres")
			
		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
			--outputChatBox("Your password cannot contain .",255,0,0)
			guiSetText(rError,"Sua senha não pode conter .")
			
		elseif (password1~=password2) then
		--	outputChatBox("The passwords you entered do not match.", 255, 0, 0)
			guiSetText(rError,"As senhas não combinam")
		else
			showChat(true)
			refresh()
			triggerServerEvent("attemptRegister", getLocalPlayer(), username, password1) 
		end
	elseif (source==bLogin) then
		local username = guiGetText(usere)
		local password = guiGetText(passe)

		if (string.len(username)<3) then
					--outputChatBox("Username is too short.Enter more than 3 characters",255,0,0)
					guiSetText(error,"Usuário muito curto, coloque mais que 3 caracteres")
		elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) then
					--outputChatBox("Your username cannot contain @;",255,0,0)
					guiSetText(error,"Seu usuário não pode conter @;")
		elseif (string.len(password)<3) then
					--outputChatBox("Your password is too short.Enter more than 3 characters",255,0,0)
					guiSetText(error,"Sua senha é muito curta, colque mais que 3 caracteres")
		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
		--outputChatBox("Your password cannot contain @;'",255,0,0)
			guiSetText(error,"Sua senha não pode conter @;'")
		
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
	outputDebugString("[Account] Recebido um novo HasCode \o/")
	appendSavedData("hashcode", hashcode)
end
addEvent("account:onAutoLoginHashReceive", true)
addEventHandler("account:onAutoLoginHashReceive", getRootElement(), receiveAutoHash)

function fail()
	guiSetText(error,"Usuário ou senha inválidos \nou sua conta foi suspensa.Tente novamente")
end
addEvent("loginFail", true)
addEventHandler("loginFail", getRootElement(), fail)

function reg()
	guiSetText(error,"Cadastro criado com sucesso!.\nFaça login.")
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
	showChat(true)
	hidepanel()

	setPlayerHudComponentVisible("ammo", true)
	setPlayerHudComponentVisible("weapon", true)
		--[[setPlayerHudComponentVisible("vehicle_name", false)
		setPlayerHudComponentVisible("money", true)
		setPlayerHudComponentVisible("health", true)
		setPlayerHudComponentVisible("armour", true)
		setPlayerHudComponentVisible("breath", true)
		setPlayerHudComponentVisible("radar", true)
		setPlayerHudComponentVisible("area_name", true)]]
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


setCameraMatrix( 1368.48, -896.26, 84.25, 1411.72, -809.58, 77.58)
	
	tableAccounts = accounts	
	toggleAllControls(false, true, false)

	local width, height = 420, 400
			
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	-- Character Info
	local charsDead, charsAlive = 0, 0
	
	for key, value in pairs(accounts) do
		if (tonumber(accounts[key][3])==1) then
			charsDead = charsDead + 1
		else
			charsAlive = charsAlive + 1
		end
	end
		
	--lCharacters = guiCreateLabel(0.05, 0.025, 0.9, 0.15, "Your Characters: [" .. #accounts .."]", true, tabCharacter)
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
			login = "Nunca"
		else
			--local difference = yearday - charyearday
			
			if (difference==0) then
				login = "Hoje"
			elseif (difference==1) then
				login = tostring(difference) .. " dia atrás"
			else
				login = tostring(difference) .. " dias atrás"
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
			gender = "Masculino"
		else
			gender = "Feminino"
		end
		paneChars[key] = {}
		paneChars[key][7] = guiCreateScrollPane(0.0, y, 1.0, 0.5, true, paneCharacters)
		paneChars[key][1] = guiCreateStaticImage(0.6325,0.4933,0.0213,0.0133, "img/charbg0.png", true, paneChars[key][7])
		paneChars[key][8] = cked	
		playasl = guiCreateLabel(0.0088,0.4167,0.2025,0.075,"",true)
		guiLabelSetVerticalAlign(playasl,"top")
		guiLabelSetHorizontalAlign(playasl,"left",false)
		if (cked==nil) then
			paneChars[key][2] = guiCreateLabel(0.3, 0.1, 0.5, 0.2,tostring(charname), true, paneChars[key][7])
		else
			
		paneChars[key][2] = guiCreateLabel(0.3, 0.1,0.215,0.0733, tostring(charname) .. " (Deceased)", true, paneChars[key][7])
			end
		
		paneChars[key][3] = guiCreateStaticImage(0.05, 0.1, 0.2, 0.5, "img/" .. skinID .. ".png", true, paneChars[key][7])
		paneChars[key][4] = guiCreateLabel(0.3, 0.25, 0.5, 0.2,"Idade: " ..age .. " anos.", true, paneChars[key][7])
	
		
		if (login~="Never") then
			paneChars[key][6] = guiCreateLabel(0.3, 0.35, 0.5, 0.2, "Mais recente: " .. login .. " em " .. area .. ".", true, paneChars[key][7])
		else
			paneChars[key][6] = guiCreateLabel(0.3, 0.35, 0.5, 0.2, "Mais recente: Nunca", true, paneChars[key][7])
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
		if paneChars[key][2] then guiSetFont(paneChars[key][2], "default-bold-small") end
		if paneChars[key][4] then guiSetFont(paneChars[key][4], "default-small")end
		if paneChars[key][5] then guiSetFont(paneChars[key][5], "default-small")end
		if paneChars[key][6] then guiSetFont(paneChars[key][6], "default-small")end
		
		y = y + 0.205
	end
	-- Edit Char button
	bCreateChar = guiCreateButton(0.7237,0.43,0.1238,0.046, "Criar", true, tabCharacter)
	addEventHandler("onClientGUIClick", bCreateChar,characterCreation, false)

	bEditChar = guiCreateButton(0.7237,0.4933,0.1238,0.046, "Editar", true, tabCharacter)
	addEventHandler("onClientGUIClick", bEditChar, editSelectedCharacter, false)
	
	-- Delete char button
	bDeleteChar = guiCreateButton(0.725,0.566,0.1238,0.046, "Deletar", true, tabCharacter)
	addEventHandler("onClientGUIClick", bDeleteChar, deleteSelectedCharacter, false)
	
	blogout = guiCreateButton(0.725,0.90,0.10,0.036, "Voltar", true, tabCharacter)
	addEventHandler("onClientGUIClick", blogout,changeAccount, false)
	
	changepass = guiCreateButton(0.600,0.90,0.10,0.036, "Mudar Senha", true, tabCharacter)
	addEventHandler("onClientGUIClick", changepass,
	function ( )
    changepassword()	
end, false )
	
	guiSetVisible(bEditChar, false)
	guiSetVisible(bDeleteChar, false)
	
	if(tabPanelCharacter) then guiSetAlpha(tabPanelCharacter, 0.75) end
	showCursor(true)
	setElementAlpha(getLocalPlayer(), 0)
	
	
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
			wDelConfirmation = guiCreateWindow(sx/2 - 125,sy/2 - 50,250,100,"Confirmação", false)
			local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Deseja realmente apagar esse jogador: "..charname.."?",true,wDelConfirmation)
							  guiLabelSetHorizontalAlign (lQuestion,"center",true)
			local bYes = guiCreateButton(0.1,0.65,0.37,0.23,"Sim",true,wDelConfirmation)
			local bNo = guiCreateButton(0.53,0.65,0.37,0.23,"Não",true,wDelConfirmation)
			addEventHandler("onClientGUIClick", getRootElement(), 
				function(button)
					if (button=="left") then
						if source == bYes then
							hideback()
							destroyElement(wDelConfirmation)
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
	if(changepass) then guiSetVisible (changepass, false ) end
	if(blogout) then guiSetVisible (blogout, false ) end
	if(bEditChar) then guiSetVisible (bEditChar, false ) end
	if(bDeleteChar) then guiSetVisible (bDeleteChar, false ) end
	if(bCreateChar) then guiSetVisible (bCreateChar, false ) end
	if(paneCharacters) then guiSetVisible (paneCharacters, false ) end
	if(paneChars) then guiSetVisible (paneChars, false ) end
	if(lCharacters) then guiSetVisible (lCharacters, false ) end
	removeEventHandler("onClientRender", getRootElement(),renderWelcomeMessage)
	removeEventHandler("onClientRender", getRootElement(),renderstats)
end
function showback()
	if(changepass) then guiSetVisible (changepass, true ) end
	if(blogout) then guiSetVisible (blogout,true) end
	if(bEditChar) then guiSetVisible (bEditChar, true ) end
	if(bDeleteChar) then guiSetVisible (bDeleteChar, true ) end
	if(bCreateChar) then guiSetVisible (bCreateChar, true ) end
	if(paneCharacters) then guiSetVisible (paneCharacters, true ) end
	if(paneChars) then guiSetVisible (paneChars, true ) end
	if(lCharacters) then guiSetVisible (lCharacters, true ) end
	addEventHandler("onClientRender", getRootElement(),renderWelcomeMessage)
	addEventHandler("onClientRender", getRootElement(),renderstats)
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
					--showLogoutPanel()
					setPlayerHudComponentVisible("ammo", true)
						setPlayerHudComponentVisible("weapon", true)
					setPlayerHudComponentVisible("clock", false)
					setPlayerHudComponentVisible("radar", true)
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

addEvent("onClientChangeChar", false)
cars = createMarker ( 544.49,-1292, 17, "cylinder", 10, 255, 255, 0, 0 )
boats = createMarker ( 715,-1705, 2.42, "cylinder", 5, 255, 255, 0, 0 )
cheapcars = createMarker ( 2131.81,-1151.32, 24.06, "cylinder", 10, 255, 255, 0, 0 )

rentcars = createMarker ( 1359.81,-1646, 13, "cylinder", 10, 255, 255, 0, 0 )

function changeCharacter(button, state)
	addEventHandler("onClientRender", getRootElement(), renderWelcomeMessage)	
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
	--if (button=="left") and (state=="up") then
		playSoundFrontEnd(37)
		--if (source~=lCreateFakepane) and (source~=lCreateBG) and (source~=lCreateName) and (source~=lCreateImage) then
			
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

			--if (found) then
				guiStaticImageLoadImage(paneChars[key][1], "img/charbg1.png")
				selectedChar = key
				local skinID = tonumber(tableAccounts[key][9])
				local cked = tonumber(tableAccounts[key][3])
				local area = tonumber(tableAccounts[key][4])
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
				
				--setElementAlpha(getLocalPlayer(), 0)
					
				if (cked==nil) then
					fading = true
						
					if (isTimer(tmrFadeIn)) then killTimer(tmrFadeIn) end
					
					tmrHideMouse = setTimer(unhideCursor, 200, 1)
					tmrFadeIn = setTimer(fadePlayerIn, 50, 10)
					
					guiSetVisible(bEditChar, true)
					guiSetVisible(bDeleteChar, true)
				else
					local x, y, z = getElementPosition(getLocalPlayer())
					--setElementAlpha(getLocalPlayer(), 0)
					tmrFadeIn = setTimer(fadePlayerIn, 50, 10)
					exports.global:applyAnimation(getLocalPlayer(), "WUZI", "CS_Dead_Guy", -1, true, false, true)

					guiSetVisible(bEditChar, false)
					guiSetVisible(bDeleteChar, false)
				end

end
addEvent("showx",true)
addEventHandler("showx",getRootElement(),selectedCharacter)

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
	
			hideback()


creationwindow = guiCreateWindow(0.0325,0.15,0.4938,0.671,"Criar Personagem",true)
guiWindowSetMovable ( creationwindow, false )
guiWindowSetSizable ( creationwindow, false )
guiSetInputEnabled ( true )
lname = guiCreateLabel(18,31,41,23,"Nome:",false,creationwindow)
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
lRestrictions = guiCreateLabel(21,60,200,46,"Sem pontos,Sem Facções [] \nUse um nome Realista \nExemplo de nome: Denilson Freitas",false,creationwindow)
guiLabelSetColor(lrestrictions,255,255,255)
guiLabelSetVerticalAlign(lrestrictions,"top")
guiLabelSetHorizontalAlign(lrestrictions,"left",false)
GUIEditor_Grid[1] = guiCreateGridList(174,75,5,5,false,creationwindow)
guiGridListSetSelectionMode(GUIEditor_Grid[1],2)
lGender = guiCreateLabel(14,120,52,20,"Gênero:",false,creationwindow)
guiLabelSetColor(lGender,255,255,255)
guiLabelSetVerticalAlign(lGender,"top")
guiLabelSetHorizontalAlign(lGender,"left",false)
rMale = guiCreateCheckBox(83,119,51,21,"Masculino",false,false,creationwindow)
rFemale = guiCreateCheckBox(144,119,66,23,"Feminino",false,false,creationwindow)
addEventHandler("onClientGUIClick", rMale, normalSetMale, false)
addEventHandler("onClientGUIClick", rFemale, normalSetFemale, false)
guiCheckBoxSetSelected(rMale, true) 
lSkinColour = guiCreateLabel(12,156,67,20,"Cor da Skin:",false,creationwindow)
guiLabelSetColor(lSkinColour,255,255,255)
guiLabelSetVerticalAlign(lSkinColour,"top")
guiLabelSetHorizontalAlign(lSkinColour,"left",false)
rBlack = guiCreateRadioButton(87,153,71,24,"Negro",false,creationwindow)
rWhite = guiCreateRadioButton(148,154,71,24,"Branco",false,creationwindow)
rAsian = guiCreateRadioButton(220,154,71,24,"Asiático",false,creationwindow)
guiRadioButtonSetSelected(rWhite, true)
addEventHandler("onClientGUIClick", rBlack, normalSetBlack, true, false, false)
addEventHandler("onClientGUIClick", rWhite, normalSetWhite, false, true, false)
addEventHandler("onClientGUIClick", rAsian, normalSetAsian, false, false, true)

GUIEditor_Label[2] = guiCreateLabel(19,310,67,20,"Skin",false,creationwindow)
guiLabelSetColor(GUIEditor_Label[2],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
lAge = guiCreateLabel(236,29,47,22,"Idade:",false,creationwindow)
guiLabelSetColor(lAge,255,255,255)
guiLabelSetVerticalAlign(lAge,"top")
guiLabelSetHorizontalAlign(lAge,"left",false)
lHeight = guiCreateLabel(236,62,47,22,"Altura:",false,creationwindow)
guiLabelSetColor(lHeight,255,255,255)
guiLabelSetVerticalAlign(lHeight,"top")
guiLabelSetHorizontalAlign(lHeight,"left",false)
lWeight = guiCreateLabel(235,91,47,22,"Peso:",false,creationwindow)
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
skinimage = guiCreateLabel(27,189,127,104,"Selecione genêro \n& cor da Skin",false,creationwindow)
tCharDesc = guiCreateEdit(200,206,181,124,"Descrição padrão",false,creationwindow)
addEventHandler("onClientGUIChanged", tCharDesc, checkInput)
lCharDesc = guiCreateLabel(204,183,130,19,"Descrição",false,creationwindow)
informl = guiCreateLabel(215,114,161,39,"",false,creationwindow)
guiLabelSetColor(informl,255,0,0)
guiSetFont(informl, "default-bold-small")
guiLabelSetColor(lCharDesc ,255,255,255)
guiLabelSetVerticalAlign(lCharDesc,"top")
guiLabelSetHorizontalAlign(lCharDesc,"left",false)
cbutton= guiCreateButton(70,356,106,29,"Criar",false,creationwindow)
canb = guiCreateButton(202,356,106,29,"Cancelar",false,creationwindow)
addEventHandler("onClientGUIClick",canb,ccreation)
addEventHandler("onClientGUIClick",cbutton,characterCreationFinal)
addEventHandler("onClientGUIClick",cbutton,checkName)
end

function ccreation ()
	
	if (source==canb) and( guiGetVisible (creationwindow) == true ) then 
			guiSetVisible ( creationwindow,false ) 
			showback()
			showCursor(false)
			setCameraMatrix( 1368.48, -896.26, 84.25,   1411.72, -809.58, 77.58)
	
	end
end
function closed()
	
	if ( guiGetVisible (creationwindow) == true ) then 
			guiSetVisible ( creationwindow,false ) 
			setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)
		
			outputChatBox("Jogador criado com sucesso!.",0,255,0,true)	
	end
end
addEvent("ccreation",true)
addEventHandler("ccreation", getRootElement(),closed)

function alreadyused()
	guiSetText(tname,"Em uso")
	outputChatBox("Esse nome já existe",255,0,0,true)
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
			--setCameraMatrix(1254.1640625, -1211.552734375, 182.0015411377,  1480.748046875, -1354.154296875, 139.98262023926)

end





blackMales = {000,007, 014, 015, 016, 017, 018, 020, 021, 022, 024, 025, 028, 035, 036, 050, 051, 066, 067, 078, 079, 080, 083, 084, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262 ,269,270,271,293,296,297,300,301,310,311}
whiteMales = {001,002,268,023, 026, 027, 029, 030, 032, 033, 034, 035, 036, 037, 038, 043, 044, 045, 046, 047, 048, 050, 051, 052, 053, 058, 059, 060, 061, 062, 068, 070, 072, 073, 078, 081, 082, 094, 095, 096, 097, 098, 099, 100, 101, 108, 109, 110, 111, 112, 113, 114, 115, 116, 120, 121, 122, 124, 125, 126, 127, 128, 132, 133, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 170, 171, 173, 174, 175, 177, 179, 181, 184, 186, 187, 188, 189, 200, 202, 204, 206, 209, 212, 213, 217, 223, 230, 234, 235, 236, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264 ,272,290,291,292,295,299,303,305,306,308,312}
asianMales = {049, 057, 058, 059, 060, 117, 118, 120, 121, 122, 123, 170, 186, 187, 203, 210, 227, 228, 229,294}
blackFemales = {009, 010, 011, 012, 013, 040, 041, 063, 064, 069, 076, 091, 139, 148, 190, 195, 207, 215, 218, 219, 238, 243, 244, 245, 256 ,298,304}
whiteFemales = {012, 031, 038, 039, 040, 041, 053, 054, 055, 056, 064, 075, 077, 085, 086, 087, 088, 089, 090, 091, 092, 093, 129, 130, 131, 138, 140, 145, 150, 151, 152, 157, 172, 178, 192, 193, 194, 196, 197, 198, 199, 201, 205, 211, 214, 216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263 }
asianFemales = {038, 053, 054, 055, 056, 088, 141, 169, 178, 224, 225, 226, 263}


gender = 0
skincolour = 1
curskin = 23
skinimage = {}

function adjustNormalSkin(button, state)

 if ( guiGetVisible ( skinimage ) == false ) then 
	skinimage = guiCreateLabel(100,189,127,104,"Please Select a skin",false,creationwindow)
	guiLabelSetFont(skinimage,"default-bold")
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
				skin = 23
				curskin = 1
				skin = array[1]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiSetText(skinimage,"Skin ID: "..skin)
		
			else
				curskin = curskin + 1
				skin = 23
				skin = array[curskin]
				setElementModel(getLocalPlayer(), tonumber(skin))
				guiSetText(skinimage,"Skin ID: "..skin)
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
			if not skin then
				guiSetText(skinimage,"Selecione a cor da Skin \n e o gênero primeiro")
				guiLabelSetColor(skinimage,255,0,0)
			end
				guiSetText(skinimage,"Skin ID: "..skin)
				guiLabelSetColor(skinimage,255,255,255)
			else
				
				curskin = curskin - 1
				skin = array[curskin]
			if not skin then
				guiSetText(skinimage,"Selecione a cor da Skin\n e o gênero primeiro")
				guiLabelSetColor(skinimage,255,0,0)
			end

				setElementModel(getLocalPlayer(), tonumber(skin))
				guiSetText(skinimage,"Skin ID: "..skin)
				guiLabelSetColor(skinimage,255,255,255)
			end
		end
	end
end

function normalSetMale(button, state)
	if guiCheckBoxGetSelected(rFemale, true) then
		guiCheckBoxSetSelected (rFemale,false)
	end
	--if (source==rMale) and (button=="left") and (state=="up") then
		guiSetAlpha (rFemale,75)
		guiSetAlpha (rMale,255)
		gender = 0
		generateSkin()
		guiSetText(skinimage,"Skin ID: 0")
		guiLabelSetColor(skinimage,255,255,255)

	--end
end

function normalSetFemale(button, state)
	if guiCheckBoxGetSelected(rMale, true) then
		guiCheckBoxSetSelected (rMale,false)
	end

	--if (source==rFemale) and (button=="left") and (state=="up") then
		guiSetAlpha (rMale,75)
		guiSetAlpha (rFemale,255)
		gender = 1
		generateSkin()
		guiSetText(skinimage,"Skin ID: 0")
		guiLabelSetColor(skinimage,255,255,255)
	--end
end

function normalSetBlack(button, state)
	if (source==rBlack) and (button=="left") and (state=="up") then
		skincolour = 0
		generateSkin()
		guiSetText(skinimage,"Skin ID: 0")
		guiLabelSetColor(skinimage,255,255,255)

	end
end

function normalSetWhite(button, state)
	if (source==rWhite) and (button=="left") and (state=="up") then
		skincolour = 1
		generateSkin()
		guiSetText(skinimage,"Skin ID: 0")
		guiLabelSetColor(skinimage,255,255,255)

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
			guiSetText(informl,"Nome inválido.\nPlease use format.")
			return
		end


			if not (valid) then
				guiSetText(informl,"Invalid Name.\nPor favor, use o formato.")
				return
			end
			if not (heightvalid) then
			 	guiSetText(informl,"Altura inválida.")
			elseif not	(weightvalid) then
				guiSetText(informl,"Peso inválido.")
			elseif not 	(descvalid)  then
				guiSetText(informl,"Descrição inválida. Digite\n de 5-100 caracteres")
			elseif not	(agevalid)	then
				 guiSetText(informl,"Idade Inválida. Digite\n de 18-99")

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

lDonator, lAdmin, lMuted, chkBlur, chkHelp, lChangePassword, lCurrPassword, tCurrPassword, lNewPassword1, NewPassword1, lNewPassword2, tNewPassword2, bSavePass = nil
function changepassword()
	changewindow = guiCreateWindow(205,186,315,268,"Trocar Senha",false)
	guiSetVisible(changewindow,true)
	lCurrPassword = guiCreateLabel(22,56,113,28,"Senha atual:",false,changewindow)
	guiSetFont(lCurrPassword, "default-bold-small")
	tCurrPassword = guiCreateEdit(149,56,148,23,"",false,changewindow)
	guiEditSetMasked(tCurrPassword, true)

	lNewPassword1 = guiCreateLabel(23,112,113,28,"Nova Senha:",false,changewindow)
	guiSetFont(lNewPassword1, "default-bold-small")
	tNewPassword1 = guiCreateEdit(150,111,148,23,"",false,changewindow)
	guiEditSetMasked(tNewPassword1, true)
	
	lNewPassword2 = guiCreateLabel(22,166,113,28,"Confirmar senha:",false,changewindow)
	guiSetFont(lNewPassword2, "default-bold-small")
	tNewPassword2 = guiCreateEdit(152,163,148,23,"",false,changewindow)
	guiEditSetMasked(tNewPassword2, true)
	
	bSavePass = guiCreateButton(27,207,97,34,"Aceitar",false,changewindow)
	addEventHandler("onClientGUIClick", bSavePass,
		function ( )
    guiSetVisible ( changewindow, false )
 savePassword()
 end, false )
 ----------------------
	closeb = guiCreateButton(182,207,97,34,"Fechar",false,changewindow)
	addEventHandler("onClientGUIClick",closeb,
	function ( )
    guiSetVisible ( changewindow, false )
 closepasschange()
end, false )
end

function closepasschange()
		guiSetVisible(changewindow,false)
end

function savePassword(button, state)
	if (source==bSavePass) and (button=="left") and (state=="up") then
		showChat(true)
		local password = guiGetText(tCurrPassword)
		local password1 = guiGetText(tNewPassword1)
		local password2 = guiGetText(tNewPassword2)
		
		
		if (string.len(password1)<6) or (string.len(password2)<6) then
			outputChatBox("Sua nova senha é muito curta. Você deve digitar 6 ou mais caracteres.", 255, 0, 0)
		elseif (string.len(password)<6)  then
			outputChatBox("Sua nova senha é muito curta. Você deve digitar 6 ou mais caracteres.", 255, 0, 0)
		elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
			outputChatBox("Sua nova senha não pode conter ;,@'.", 255, 0, 0)
		elseif (string.find(password1, ";", 0)) or (string.find(password1, "'", 0)) or (string.find(password1, "@", 0)) or (string.find(password1, ",", 0)) then
			outputChatBox("Sua nova senha não pode conter ;,@'.", 255, 0, 0)
		elseif (password1~=password2) then
			outputChatBox("Sua nova senha não confere.", 255, 0, 0)
		else
			triggerServerEvent("cguiSavePassword", getLocalPlayer(), password, password1)
		end
	end
end
local nametags = true
function toggleNametags()
	if (nametags) then
		nametags = false
		outputChatBox("As Tagas não estão mais visíveis.", 255, 0, 0)
		triggerEvent("hidenametags", getLocalPlayer())
	elseif not (nametags) then
		nametags = true
		outputChatBox("As Tags agora estão visíveis.", 0, 255, 0)
		triggerEvent("shownametags", getLocalPlayer())
	end
end
addCommandHandler("tognametags", toggleNametags)
addCommandHandler("togglenametags", toggleNametags)

local charGender = 0
function editSelectedCharacter(button, state)
	if button=="left" and state=="up" and selectedChar and paneChars[selectedChar] then
		triggerServerEvent("requestEditCharInformation", getLocalPlayer(), guiGetText(paneChars[selectedChar][2]))
	end
end
function editCharacter(height, weight, age, description, gender)
	if selectedChar and paneChars[selectedChar] then
	local screenX, screenY = guiGetScreenSize()
	function blackOut()
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0,150), false)
	end
		addEventHandler("onClientRender", root,blackOut)
        hideback()	
        clearChatBox()
		guiSetVisible(tabPanelCharacter, false)
		guiSetVisible(accountwindow, false)
			
	
		lInformation = guiCreateLabel(0.3, 0.15, 0.8, 0.15, tostring(guiGetText(paneChars[selectedChar][2])), true )
		guiSetFont(lInformation, "default-bold-small")		
		
		--text shadow
		lHeightShadow = guiCreateLabel(0.301, 0.25, 0.5, 0.15, "Altura em centímetros:(100-200):", true )
		guiSetFont(lHeightShadow, "default-bold-small")
		guiLabelSetColor(lHeightShadow, 0, 0, 0)
		
		lHeight = guiCreateLabel(0.3, 0.25, 0.5, 0.15, "Altura em centímetros:(100-200):", true )
		guiSetFont(lHeight, "default-bold-small")
		guiLabelSetColor(lHeight, 0, 255, 0)
		
		tHeight = guiCreateEdit(0.535, 0.25, 0.15, 0.05, height, true, tabCreationFive)
		addEventHandler("onClientGUIChanged", tHeight, checkInput)
		
		--text shadow
		lWeightShadow = guiCreateLabel(0.301, 0.35, 0.5, 0.15, "Peso em Kgs:(40-200):", true )
		guiSetFont(lWeightShadow, "default-bold-small")
		guiLabelSetColor(lWeightShadow, 0, 0, 0)

		lWeight = guiCreateLabel(0.3, 0.35, 0.5, 0.15, "Peso em Kgs:(40-200):", true )
		guiSetFont(lWeight, "default-bold-small")
		guiLabelSetColor(lWeight, 0, 255, 0)
		
		tWeight = guiCreateEdit(0.535, 0.35, 0.15, 0.05, weight, true )
		addEventHandler("onClientGUIChanged", tWeight, checkInput)
		
		--text shadow
		lAgeShadow = guiCreateLabel(0.301, 0.45, 0.5, 0.15, "Idade:(18-80):", true )
		guiSetFont(lAgeShadow, "default-bold-small")
		guiLabelSetColor(lAgeShadow, 0, 0, 0)
	
		lAge = guiCreateLabel(0.3, 0.45, 0.5, 0.15, "Idade:(18-80):", true )
		guiSetFont(lAge, "default-bold-small")
		guiLabelSetColor(lAge, 0, 255, 0)
		
		tAge = guiCreateEdit(0.535, 0.45, 0.15, 0.05, age, true )
		addEventHandler("onClientGUIChanged", tAge, checkInput)

		--text shadow
		lCharDescShadow = guiCreateLabel(0.301, 0.53, 0.8, 0.15, "Descrição do jogador:", true )	
		guiSetFont(lCharDescShadow, "default-bold-small")
		guiLabelSetColor(lCharDescShadow, 0, 0, 0)			

		lCharDesc = guiCreateLabel(0.3, 0.53, 0.8, 0.15, "Descrição do jogador:", true )	
		guiSetFont(lCharDesc, "default-bold-small")
		guiLabelSetColor(lCharDesc, 0, 255, 0)

		-- help
		miniTipShadow = guiCreateLabel(0.0364,0.2867,0.2475,0.0567,"Dicas equanto edita o jogador:",true)		
        miniTip = guiCreateLabel(0.0362,0.2867,0.2475,0.0567,"Dicas equanto edita o jogador:",true)
		tMiniTipShadow = guiCreateLabel(0.0373,0.3433,0.2225,0.41,"Enquanto cria um jogador, \nsua vida tem que ficar\n dentro de um alcance realista.\n Dito isto, você não pode \nter 500M de altura. Não pode -\n Você ter qualquer idade \n portanto,\n limites são definidos para evitar isso.",true)	
        tMiniTip = guiCreateLabel(0.0375,0.3433,0.2225,0.41,"Enquanto cria um jogador, \nsua vida tem que ficar\n dentro de um alcance realista.\n Dito isto, você não pode \nter 500M de altura. Não pode -\n Você ter qualquer idade \nportanto,\n limites são definidos para evitar isso.",true)		
		guiSetFont(miniTip,"default-bold-small")		
		guiLabelSetColor(miniTip,255,255,255)
		guiLabelSetColor(miniTipShadow,0, 0, 0)
		guiLabelSetColor(tMiniTipShadow,0, 0, 0)
		guiSetFont(miniTipShadow,"default-bold-small")
		
		tCharDesc = guiCreateMemo(0.3, 0.555, 0.4, 0.25, description, true )
		addEventHandler("onClientGUIChanged", tCharDesc, checkInput)
		

		
		dHelp = guiCreateButton(0.6,0.515,0.0938,0.0367, "O que é isso?", true )
				addEventHandler("onClientGUIClick", dHelp,
		function ( )
dHelpLabelShadow = guiCreateLabel(0.2962,0.2333,0.2887,0.4817,"Descrição do jogador - o que é isso? \nJogadores podem \nver a sua descrição\n para ter uma ideia\n sobre você. \n\n Uma descrição pode incluir:\n\nAparência física\nTom de pele\nAparência facial\nCor do cabelo\nEstilo de cabelo\nAcessórios no corpo \nVestimenta \netc",true)
dHelpLabel = guiCreateLabel(0.2962,0.2333,0.2887,0.4817,"Descrição do jogador - o que é isso? \nJogadores podem \nver a sua descrição\n para ter uma ideia\n sobre você. \n\n Uma descrição pode incluir:\n\nAparência física\nTom de pele\nAparência facial\nCor do cabelo\nEstilo de cabelo\nAcessórios no corpo \nVestimenta \netc",true)
guiLabelSetColor(dHelpLabelShadow,0,0,0)
		guiSetFont(dHelpLabel, "default-bold-small")
				guiSetFont(dHelpLabelShadow, "default-bold-small")
dHelpBack = guiCreateButton(0.6,0.515,0.0938,0.0367, "Voltar", true )
addEventHandler( "onClientGUIClick", dHelpBack, stepBack, false)
		
-- line break
	guiSetVisible(dHelp, false)
	guiSetVisible(miniTipShadow, false)
	guiSetVisible(miniTip, false)
	guiSetVisible(tMiniTipShadow, false)
	guiSetVisible(tMiniTip, false)
		guiSetVisible(bNext, false)
		guiSetVisible (tCharDesc, false)
		guiSetVisible (lCharDesc, false)
		guiSetVisible (lCharDescShadow, false)
		guiSetVisible (lAgeShadow, false)
		guiSetVisible (tAge, false)
		guiSetVisible (lAge, false)
		guiSetVisible (lWeight, false)
		guiSetVisible (tWeight, false)
		guiSetVisible (lInformation, false)
		guiSetVisible (lHeightShadow, false)
		guiSetVisible (lHeight, false)
		guiSetVisible (tHeight, false)
		guiSetVisible (lWeightShadow, false)
		guiSetVisible (bCancel, false)
end, false )

-- line break

		bNext = guiCreateButton(0.375,0.845,0.0775,0.0367, "Salvar", true )
		addEventHandler("onClientGUIClick", bNext,
		function ( )
	removeEventHandler("onClientRender", root, blackOut)
    updateEditedCharacter()
	destroyElement(dHelp)
	destroyElement(miniTipShadow)
	destroyElement(miniTip)
	destroyElement(tMiniTipShadow)
	destroyElement(tMiniTip)
		destroyElement(bNext)
		destroyElement (tCharDesc)
		destroyElement (lCharDesc)
		destroyElement (lCharDescShadow)
		destroyElement (lAgeShadow)
		destroyElement (tAge)
		destroyElement (lAge)
		destroyElement (lWeight)
		destroyElement (tWeight)
		destroyElement (lInformation)
		destroyElement (lHeightShadow)
		destroyElement (lHeight)
		destroyElement (tHeight)
		destroyElement (lWeightShadow)
		destroyElement (bCancel)		
                showback()
end, false )
		
		bCancel = guiCreateButton(0.5425,0.845,0.0938,0.0367, "Cancelar", true )
		addEventHandler("onClientGUIClick", bCancel,
			function()
	removeEventHandler("onClientRender", root, blackOut)
	destroyElement(dHelp)
	destroyElement(miniTipShadow)
	destroyElement(miniTip)
	destroyElement(tMiniTipShadow)
	destroyElement(tMiniTip)	
		destroyElement(bNext)
		destroyElement (tCharDesc)
		destroyElement (lCharDesc)
		destroyElement (lCharDescShadow)
		destroyElement (lAgeShadow)
		destroyElement (tAge)
		destroyElement (lAge)
		destroyElement (lWeight)
		destroyElement (tWeight)
		destroyElement (lInformation)
		destroyElement (lHeightShadow)
		destroyElement (lHeight)
		destroyElement (tHeight)
		destroyElement (lWeightShadow)
		destroyElement (bCancel)			
                showback()
				guiSetVisible(tabPanelCharacter, true)
				guiSetVisible(accountwindow, true)
			end, false)
	end
end
addEvent("sendEditingInformation", true)
addEventHandler("sendEditingInformation", getLocalPlayer(), editCharacter)

function stepBack()
			guiSetVisible(dHelpLabelShadow, false)
			guiSetVisible(dHelp, true)
	guiSetVisible(miniTipShadow, true)
	guiSetVisible(dHelpLabel, false)
	guiSetVisible(dHelpBack, false)
	guiSetVisible(miniTip, true)
	guiSetVisible(tMiniTipShadow, true)
	guiSetVisible(tMiniTip, true)
		guiSetVisible(bNext, true)
		guiSetVisible (tCharDesc, true)
		guiSetVisible (lCharDesc, true)
		guiSetVisible (lCharDescShadow, true)
		guiSetVisible (lAgeShadow, true)
		guiSetVisible (tAge, true)
		guiSetVisible (lAge, true)
		guiSetVisible (lWeight, true)
		guiSetVisible (tWeight, true)
		guiSetVisible (lInformation, true)
		guiSetVisible (lHeightShadow, true)
		guiSetVisible (lHeight, true)
		guiSetVisible (tHeight, true)
		guiSetVisible (lWeightShadow, true)
		guiSetVisible (bCancel, true)
end

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

		local gender = "Masculino" 
		if charGender == 1 then
			gender = "Feminino"
		end
		guiSetText(paneChars[selectedChar][4], age .. " anos " .. gender .. ".", true)
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


function clearChatBox(localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
	outputChatBox(" ", localPlayer)
end
addCommandHandler("clearclientchat", clearChatBox)