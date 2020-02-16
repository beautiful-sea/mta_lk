--========================= TUTORIAL SCRIPT ==============================================

-- Concrete Gaming Roleplay Server - Tutorial and Quiz script for un-registerd players - written by Peter Gibbons (aka Jason Moore)

local tutorialStage = {}
	tutorialStage[1] = {1942.0830078125, -1738.974609375, 16.3828125, 1942.0830078125, -1760.5703125, 13.3828125} -- idlewood gas station//
	tutorialStage[2] = {1538.626953125, -1675.9375, 19.546875, 1553.8388671875, -1675.6708984375, 16.1953125} --LSPD//
	tutorialStage[3] = {2317.6123046875, -1664.6640625, 17.215812683105, 2317.4755859375, -1651.1640625, 17.221110343933} -- 10 green bottles//
	tutorialStage[4] = {1742.623046875, -1847.7109375, 16.579560279846, 1742.1884765625, -1861.3564453125, 13.577615737915} -- Unity Station//
	tutorialStage[5] = {1685.3681640625, -2309.9150390625, 16.546875, 1685.583984375, -2329.4443359375, 13.546875} -- Airport//
	tutorialStage[6] = {368.0419921875, -2008.1494140625, 7.671875, 383.765625, -2020.935546875, 10.8359375} -- Pier//
	--tutorialStage[7] = {1411.384765625, -870.787109375, 78.552024841309, 1415.9248046875, -810.15234375, 78.552024841309} -- Vinewood sign//
	tutorialStage[7] = {1893.955078125, -1165.79296875, 27.048973083496, 1960.4404296875, -1197.3486328125, 26.849721908569} -- Glen Park//
	tutorialStage[8] = {1813.59375, -1682.1796875, 13.546875, 1834.3828125, -1682.400390625, 14.433801651001} -- Alhambra//
	tutorialStage[9] = {2421.8271484375, -1261.2265625, 25.833599090576, 2432.0537109375, -1246.919921875, 25.874616622925} -- Pig Pen//
	tutorialStage[10] = {2817.37890625, -1865.7998046875, 14.219080924988, 2858.4248046875, -1849.91796875, 14.084205627441} -- East Beach
	
local stageTime = 15000
local fadeTime = 2000
local fadeDelay = 300

local tutorialTitles = {}
	tutorialTitles[1] = "BEM VINDO"
	tutorialTitles[2] = "SEU NOME"
	tutorialTitles[3] = "ROLEPLAY"
	tutorialTitles[4] = "EP E RP"
	tutorialTitles[5] = "ROLEPLAY REGRAS"
	tutorialTitles[6] = "EXPLORANDO"
	--tutorialTitles[7] = ""
	tutorialTitles[7] = "SERVER REGRAS"
	tutorialTitles[8] = "COMEÇANDO"
	tutorialTitles[9] = "ADMINS"
	tutorialTitles[10] = "MAIS INFORMAÇÕES"
	

local tutorialText = {}
		tutorialText[1] = {"Olá e bem-vindo ao LK: Roleplay Server.",
					"Vejo que você é novo aqui, por isso, dê-nos 2 minutos para apresentar o servidor. ",
"Atualmente, somos o único servidor estruturado de roleplay completo no MTA, com uma constante",
"atualização."}
	
	tutorialText[2] = 		{"Roleplay (RP) é um gênero de jogo em que os jogadores assumem o papel de um ficcional ",
"personagem. No nosso servidor, seu nome é sua identidade e deve estar no formato",
"Nome Sobrenome. Pode ser o que você quiser, desde que seja realista e",
"não um nome de celebridade. Um exemplo de nome válido é: 'Denilson Freitas'."}
	
	tutorialText[3] = 		{"Você deve interpretar o tempo todo. Isso significa agir como você faria ",
"vida real. Só porque é possível no GTA, não significa que é bom fazer aqui.",
"Embora tenhamos facções de servidores, você pode interpretar o que quiser",
"desde que siga as regras do servidor."}
	
	tutorialText[4] = 		{"Em Personagem (EP) e Fora de Personagem (FP) é fundamental para uma boa interpretação ",
"FP refere-se a você, o jogador, falando sobre coisas não relevantes e fora de tópico.",
"Para conversar sobre o FP, use /o, /b e /pm. EP refere-se às palavras de seus personagens",
"sendo falado com outros personagens - tente não confundir os dois."}
	
	tutorialText[5] = 		{"Há vários termos de roleplay que você precisa entender, como 'Metagaming' (usando ",
"Informações do FP em uma situação de EP) ou 'Powergaming' (forçando sua representação em outras pessoas.)",
"Para obter mais informações sobre esses termos, pressione F1 no jogo e todas as informações necessárias",
"estarão lá. Nós não gostamos de pessoas que jogam com metagame ou powergaming, então não faça isso!"}
	
	tutorialText[6] = 		{"Ganhar uma vantagem injusta sobre outros jogadores, usando truques ou abusando ",
"de erros não serão tolerados de forma alguma e resultarão em uma proibição instantânea"}
					  
	--tutorialText[7] = 		{""}
	
	tutorialText[7] = 		{"Nosso conjunto de regras de servidor provavelmente é muito diferente em comparação com outros servidores MTA. ",
"Existe uma lista completa disponível no site, mas alguns dos mais comuns são:",
"Sem Anti RP, anunciando outros servidores e trapaceando ou invadindo (obviamente ...)",
"Não é necessário enviar spam ao bate-papo ou comandos, por favor, e não use letras maiúsculas, obrigado!"}

	tutorialText[8] =		 {"Então você acabou de chegar em Los Santos, o que você faz? Há muitos",
" empregos para você se candidatar - apenas roleplay com outros jogadores",
"e em breve você se encontrará subindo na categoria de facções. Algumas facções, como",
"o Exército exige mais tempo de jogo para poder participar."}
	
	tutorialText[9] = 	{"Nossos administradores estão aqui para ajudá-lo, caso você precise. Se precisar de ajuda, faça uma pergunta rápida ",
"ou deseja denunciar alguém por violar as regras, não tenha medo de usar /denunciar e alguém",
"virá e ajudará o mais rápido possível. "}
				   
	tutorialText[10] = 	{"Para mais informações sobre o servidor, como já mencionado, pressione F1 durante o jogo. ",
"Uma lista de comandos do jogador pode ser encontrada fazendo /helpcmds, então leia e",
"familiarize-se com eles. Como alternativa, pergunte a um dos administradores ou jogadores do jogo.",
"Isso marca o final do tutorial. Obrigado por jogar. "}
					
					

-- function starts the tutorial
function showTutorial()

	local thePlayer = getLocalPlayer()

	-- set the player to not logged in so they don't see any other random chat
	triggerServerEvent("player:loggedout", getLocalPlayer())
		
	-- if the player hasn't got an element data, set it to 1
	if not (getElementData(thePlayer, "tutorialStage")) then
		setElementData(thePlayer, "tutorialStage", 0, false)
	end
	
	-- ionc
	setElementData(thePlayer, "tutorialStage", getElementData(thePlayer, "tutorialStage")+1, false)

	
	-- stop the player from using any controls to move around or chat
	toggleAllControls (  false )
	-- fade the camera to black so they don't see the teleporting renders
	fadeCamera ( false, fadeTime/1000 ,0,0,0)
	
	-- timer to move the camera to the first location as soon as the screen has gone black.
	setTimer(function()
		
		-- timer to set camera position and fade in after the camera has faded out to black
		setTimer(function()
				
			local stage = getElementData(thePlayer, "tutorialStage")
			
			local camX = tutorialStage[stage][1]
			local camY = tutorialStage[stage][2]
			local camZ = tutorialStage[stage][3]
			local lookX = tutorialStage[stage][4]
			local lookY = tutorialStage[stage][5]
			local lookZ = tutorialStage[stage][6]
			
			setCameraMatrix(camX, camY, camZ, lookX, lookY, lookZ)
			
			-- set the element to outside and dimension 0 so they see th eother players
			setElementInterior(thePlayer, 0)
			setElementDimension(thePlayer, 0)
			
			-- fade the camera in
			fadeCamera( true, fadeTime/1000)
			
			-- call function to output the text
			outputTutorialText(stage)
			
			-- function to fade out after message has been displayed a read
			setTimer(function()
								
				local lastStage = getLastStage()
				
				-- if the player is on the last stage of the tutorial, fade their camera out and...
				if(stage == lastStage) then
					fadeCamera( false, fadeTime/1000, 0,0,0)
					
					setTimer(function()

						-- show the quiz after a certain time
						endTutorial()
						
						setElementData ( thePlayer, "tutorialStage", 0, false )
						
					end, fadeTime+fadeDelay,1 )
				else -- else more stages to go, show the next stage
					showTutorial(thePlayer)
				end
			end, stageTime, 1)
		end, 150, 1)
	end, fadeTime+fadeDelay , 1)
end



-- function returns the number of stages
function getLastStage()

	local lastStage = 0
	
	if(tutorialStage) then
		for i, j in pairs(tutorialStage) do
			lastStage = lastStage + 1
		end
	end
	
	return lastStage
end


-- function outputs the text during the tutorial
function outputTutorialText( stage)
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(" ")
	outputChatBox(tutorialTitles[stage],  255, 0,0, true)
	outputChatBox(" ")
	
	if(tutorialText[stage]) then
		for i, j in pairs(tutorialText[stage]) do
				outputChatBox(j)
		end
	end

end

-- function fade in the camera and sets the player to the quiz room so they can do the quiz
function endTutorial()

	local thePlayer = getLocalPlayer()
	
	-- set the player to not logged in so they don't see the chat
	triggerServerEvent("player:loggedout", getLocalPlayer())
	toggleAllControls(false)
			
	
	setTimer(function()
		setCameraMatrix(368.0419921875, -2008.1494140625, 7.671875, 383.765625, -2020.935546875, 10.8359375)
		
		-- fade the players camera in
		fadeCamera(true, 2)
		
		-- trigger the client to start showing the quiz
		setTimer(function()
			triggerEvent("onClientStartQuiz", thePlayer)
			
		end, 2000, 1)
		
		
	end, 100, 1)

end

[[--


   ------------ TUTORIAL QUIZ SECTION - SCRIPTED BY PETER GIBBONS, AKA JASON MOORE --------------
   
   
   
   questions = { }
questions[1] = {"What does the term RP stand for?", "Nothing", "Role Playing", "Record Playing", "Race Player", 2}
questions[2] = {"When are you allowed to advertise other servers?", "Using /ad", "In out of character chat", "Via PM's (/pm)", "Never", 4}
questions[3] = {"What should you do if you see someone hacking?", "Tell an admin using /report", "Ignore it", "Download sobiet and start following him", "Go and kill the hacker", 1}
questions[4] = {"What is the address of the website and forums?", "www.shodown.cz.cc", "I don't know", "www.google.com", "www.yahoo.co.in", 1} 
questions[5] = {"I want to get to the other side of Los Santos, how should I do it?", "Ask an admin to teleport you.", "Find a roleplay way to get there, like a taxi.", "Start bunnyhopping to get there faster", "Jump in a random players car and demand them to take you.", 2}
questions[6] = {"What is the correct format for your in game name?", "Firstname", "firstname lastname", "Firstname Lastname", "There is no format", 3}
questions[7] = {"Which one of the following names would be acceptable", "[RDC]","Micheal Thomas", "Roleplayer 150", "They are all acceptable", 2}
questions[8] = {"When must you roleplay in this server?", "At all times", "Never", "When you feel like it", "Only when other people are", 1}
questions[9] = {"What should you do if you accidently drive your car off a cliff?", "Carry on driving because the car didn't blow up", "Ask an admin to move you to the top of the cliff", "Say it was an OOC accident", "Stop and roleplay a car accident", 4}
questions[10] = {"I want to join a particular gang or mafia, how should I do it?", "Ask an admin to move you into the faction", "Ask in OOC to join the faction", "Roleplay with the gang/mafia until they invite you.", "nil", 3}
questions[11] = {"What does OOC stand for?", "Out of Control", "Out of Character", "Out of Chance", "Out of Coffee", 2}
questions[12] = {"What does IC stand for?", "In Character", "In Chaos", "In Car", "nil", 1}
questions[13] = {"What is Metagaming?", "Killing someone for no reason", "Doing something that is unrealistic in real life", "Forcing your roleplay on other players", "Using Out of Character knowledge in In Character situations", 4}
questions[14] = {"What language should you use in this server?", "French", "English", "Hewbrew", "Anything", 2}
questions[15] = {"When can you talk to another player in your native language?", "In Character chat", "In any Out of Character chat", "Through private messages only.", "Never", 3}
questions[16] = {"Which ones of these is a server rule?", "No Roleplaying", "No Deathmatching", "No Driving", "No Shooting", 2}
questions[17] = {"What would you do if you wanted to contact an admin?", "Use the admin /report system", "Ask in global OOC for an admin", "Private message the admin", "Ask In Character for an admin.", 1}

-- variable for the max number of possible questions
local NoQuestions = 17
local NoQuestionToAnswer = 6
local correctAnswers = 0
local passPercent = 50
		
selection = {}


-- functon makes the intro window for the quiz
function createQuizIntroWindow()

	local screenwidth, screenheight = guiGetScreenSize ()
	
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	
	guiIntroWindow = guiCreateWindow ( X , Y , Width , Height , "Roleplay Quiz" , false )
	
	guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "banner.png", true, guiIntroWindow)
	
	guiIntroLabel1 = guiCreateLabel(0, 0.3,1, 0.5, "	You will now proceed with a short roleplay quiz. This quiz isn't\
										 hard and is only to check that you've followed the tutorial. All \
										of the answers are hidden in the tutorial, and you don't need to \
										get every question correct.\
										\
										Good luck!", true, guiIntroWindow)
	
	guiLabelSetHorizontalAlign ( guiIntroLabel1, "center")
	guiSetFont ( guiIntroLabel1,"default-bold-small")
	
	guiIntroProceedButton = guiCreateButton ( 0.4 , 0.75 , 0.2, 0.1 , "Start Quiz" , true ,guiIntroWindow)
	
	guiSetVisible(guiIntroWindow, true)
	
	addEventHandler ( "onClientGUIClick", guiIntroProceedButton,  function(button, state)
		if(button == "left" and state == "up") then
		
			-- start the quiz and hide the intro window
			startQuiz()
			guiSetVisible(guiIntroWindow, false)
		
		end
	end, false)

end


-- function create the question window
function createQuestionWindow(number)

	local screenwidth, screenheight = guiGetScreenSize ()
	
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	
	-- create the window
	guiQuestionWindow = guiCreateWindow ( X , Y , Width , Height , "Question "..number.." of "..NoQuestionToAnswer , false )
	
	guiQuestionLabel = guiCreateLabel(0.1, 0.2, 0.9, 0.1, selection[number][1], true, guiQuestionWindow)
	guiSetFont ( guiQuestionLabel,"default-bold-small")
	
	
	if not(selection[number][2]== "nil") then
		guiQuestionAnswer1Radio = guiCreateRadioButton(0.1, 0.3, 0.9,0.1, selection[number][2], true,guiQuestionWindow)
	end
	
	if not(selection[number][3] == "nil") then
		guiQuestionAnswer2Radio = guiCreateRadioButton(0.1, 0.4, 0.9,0.1, selection[number][3], true,guiQuestionWindow)
	end
	
	if not(selection[number][4]== "nil") then
		guiQuestionAnswer3Radio = guiCreateRadioButton(0.1, 0.5, 0.9,0.1, selection[number][4], true,guiQuestionWindow)
	end
	
	if not(selection[number][5] == "nil") then
		guiQuestionAnswer4Radio = guiCreateRadioButton(0.1, 0.6, 0.9,0.1, selection[number][5], true,guiQuestionWindow)
	end
	
	-- if there are more questions to go, then create a "next question" button
	if(number < NoQuestionToAnswer) then
		guiQuestionNextButton = guiCreateButton ( 0.4 , 0.75 , 0.2, 0.1 , "Next Question" , true ,guiQuestionWindow)
		
		addEventHandler ( "onClientGUIClick", guiQuestionNextButton,  function(button, state)
			if(button == "left" and state == "up") then
				
				local selectedAnswer = 0
			
				-- check all the radio buttons and seleted the selectedAnswer variabe to the answer that has been selected
				if(guiRadioButtonGetSelected(guiQuestionAnswer1Radio)) then
					selectedAnswer = 1
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer2Radio)) then
					selectedAnswer = 2
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer3Radio)) then
					selectedAnswer = 3
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer4Radio)) then
					selectedAnswer = 4
				else
					selectedAnswer = 0
				end
				
				-- don't let the player continue if they havn't selected an answer
				if(selectedAnswer ~= 0) then
					
					-- if the selection is the same as the correct answer, increase correct answers by 1
					if(selectedAnswer == selection[number][6]) then
						correctAnswers = correctAnswers + 1
					end
				
					-- hide the current window, then create a new window for the next question
					guiSetVisible(guiQuestionWindow, false)
					createQuestionWindow(number+1)
				end
			end
		end, false)
		
	else
		guiQuestionSumbitButton = guiCreateButton ( 0.4 , 0.75 , 0.3, 0.1 , "Submit Answers" , true ,guiQuestionWindow)
		
		-- handler for when the player clicks submit
		addEventHandler ( "onClientGUIClick", guiQuestionSumbitButton,  function(button, state)
			if(button == "left" and state == "up") then
				
				local selectedAnswer = 0
			
				-- check all the radio buttons and seleted the selectedAnswer variabe to the answer that has been selected
				if(guiRadioButtonGetSelected(guiQuestionAnswer1Radio)) then
					selectedAnswer = 1
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer2Radio)) then
					selectedAnswer = 2
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer3Radio)) then
					selectedAnswer = 3
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer4Radio)) then
					selectedAnswer = 4
				else
					selectedAnswer = 0
				end
				
				-- don't let the player continue if they havn't selected an answer
				if(selectedAnswer ~= 0) then
					
					-- if the selection is the same as the correct answer, increase correct answers by 1
					if(selectedAnswer == selection[number][6]) then
						correctAnswers = correctAnswers + 1
					end
				
					-- hide the current window, then create the finish window
					guiSetVisible(guiQuestionWindow, false)
					createFinishQuizWindow()


				end
			end
		end, false)
	end
end


-- funciton create the window that tells the
function createFinishQuizWindow()

	local score = (correctAnswers/NoQuestionToAnswer)*100

	local screenwidth, screenheight = guiGetScreenSize ()
		
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
		
	-- create the window
	guiFinishWindow = guiCreateWindow ( X , Y , Width , Height , "End of Quiz", false )
	
	if(score >= passPercent) then
	
		local xmlRoot = xmlCreateFile("vgrptut.xml", "passedtutorial")
		xmlSaveFile(xmlRoot)
		guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "pass.png", true, guiFinishWindow)
	
		guiFinalPassLabel = guiCreateLabel(0, 0.3, 1, 0.1, "Congratulations! You have passed!", true, guiFinishWindow)
		guiSetFont ( guiFinalPassLabel,"default-bold-small")
		guiLabelSetHorizontalAlign ( guiFinalPassLabel, "center")
		guiLabelSetColor ( guiFinalPassLabel ,0, 255, 0 )
		
		guiFinalPassTextLabel = guiCreateLabel(0, 0.4, 1, 0.4, "You scored "..score.."%, and the pass mark is "..passPercent.."%. Well done!\
											Please remember to register at the forums (www.shodown.cz.cc)\
											if you have not done so.\
											\
											Thank you for playing at ShoDown Gaming MTA!" ,true, guiFinishWindow)
		guiLabelSetHorizontalAlign ( guiFinalPassTextLabel, "center")
		
		guiFinalRegisterButton = guiCreateButton ( 0.35 , 0.8 , 0.3, 0.1 , "Continue" , true ,guiFinishWindow)
		
		-- if the player has passed the quiz and clicks on register
		addEventHandler ( "onClientGUIClick", guiFinalRegisterButton,  function(button, state)
			if(button == "left" and state == "up") then
				-- reset their correct answers
				correctAnswers = 0
				guiSetVisible(guiFinishWindow, false)
				toggleAllControls ( true )
				
				if createXMB then
					createXMB()
				else
					createMainUI(getThisResource())
				end
			end
		end, false)
		
	else -- player has failed, 
	
		guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "fail.png", true, guiFinishWindow)
	
		guiFinalFailLabel = guiCreateLabel(0, 0.3, 1, 0.1, "Sorry, you have not passed this time.", true, guiFinishWindow)
		guiSetFont ( guiFinalFailLabel,"default-bold-small")
		guiLabelSetHorizontalAlign ( guiFinalFailLabel, "center")
		guiLabelSetColor ( guiFinalFailLabel ,255, 0, 0 )
		
		guiFinalFailTextLabel = guiCreateLabel(0, 0.4, 1, 0.4, "You scored "..math.ceil(score).."%, and the pass mark is "..passPercent.."%.\
											You can retake the quiz as many times as you like, so have another shot!\
											\
											Thank you for playing at ShoDown Gaming MTA!" ,true, guiFinishWindow)
		guiLabelSetHorizontalAlign ( guiFinalFailTextLabel, "center")
		
		guiFinalRetakeButton = guiCreateButton ( 0.2 , 0.8 , 0.25, 0.1 , "Take Quiz Again" , true ,guiFinishWindow)
		guiFinalTutorialButton = guiCreateButton ( 0.55 , 0.8 , 0.25, 0.1 , "Show Tutorial" , true ,guiFinishWindow)
		
		-- if player click the retake button
		addEventHandler ( "onClientGUIClick", guiFinalRetakeButton,  function(button, state)
			if(button == "left" and state == "up") then
				-- reset their correct answers
				correctAnswers = 0
				guiSetVisible(guiFinishWindow, false)
				startShowQuizIntro()
			end
		end, false)
		
		-- if player click the show tutorial
		addEventHandler ( "onClientGUIClick", guiFinalTutorialButton,  function(button, state)
			if(button == "left" and state == "up") then
				-- reset their correct answers and hide the window
				correctAnswers = 0
				guiSetVisible(guiFinishWindow, false)
				guiSetInputEnabled(false)
				
				-- trigger server event to show the tutorial
				showTutorial()
			end
		end, false)
	
	
	
	end

end


-- function is triggerd by the server when it is time for the player to take the quiz
function startShowQuizIntro()
	
	clearChatBox()
	-- reset the players correct answers to 0
	correctAnswers = 0
	-- create the intro window
	createQuizIntroWindow()
	-- Set input enabled
	guiSetInputEnabled(true)

end
 addEvent("onClientStartQuiz", true)
 addEventHandler( "onClientStartQuiz", getLocalPlayer() ,  startShowQuizIntro)
 
 
 -- function starts the quiz
 function startQuiz()
 
	-- choose a random set of questions
	chooseQuizQuestions()
	-- create the question window with question number 1
	createQuestionWindow(1)
 
 end
 
 
 
 
 -- functions chooses the questions to be used for the quiz
 function chooseQuizQuestions()
 
	-- loop through selections and make each one a random question
	for i=1, 10 do
		-- pick a random number between 1 and the max number of questions
		local number = math.random(1, NoQuestions)
		
		-- check to see if the question has already been selected
		if(questionAlreadyUsed(number)) then
			repeat -- if it has, keep changing the number until it hasn't
				number = math.random(1, NoQuestions)
			until (questionAlreadyUsed(number) == false)
		end
		
		-- set the question to the random one
		selection[i] = questions[number]
	end
 end
 
 
 -- function returns true if the queston is already used
 function questionAlreadyUsed(number)
 
	local same = 0
 
	-- loop through all the current selected questions
	for i, j in pairs(selection) do
		-- if a selected question is the same as the new question
		if(j[1] == questions[number][1]) then
			same = 1 -- set same to 1
		end
		
	end
	
	-- if same is 1, question already selected to return true
	if(same == 1) then
		return true
	else
		return false
	end
  
 end
--]]