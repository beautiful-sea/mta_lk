local screenWidth, screenHeight = guiGetScreenSize();
local root = getRootElement();
local player = getLocalPlayer();
local minDistance = 5;
local interactButton = "L";
local isDebug = "false";
local lookAtVehicle = nil;
local doorName = "";
local screenW, screenH = guiGetScreenSize() 
local door = nil
local desmanchado = false
-- Assign a local variable to know if it is currently drawing or not. 
local isCurrentlyDrawing = false 
-- Variable for telling the script whether the timer is active or not. 
local progressTimer = false 
-- The total and current progress, this should always be between 0-100. 
local totalProgress = 0 
-- Math for converting the width. Originally the relative size to the screen was 2.575. So when totalProgress is at 100, renderProgress will be at 2.575. This will display the progress bar as full. 
local renderProgress = (totalProgress/100)/2.575 
local veiculo = nil

blip =  createBlip (2553.216796875,-951.5244140625,82.675132 ,27, 2, 255,  0,  0, 255)
setElementData(blip,"blipName", "Desmanche")
--area de desmanche
areaDesmanche = createColSphere(2553.216796875,-951.5244140625,82.675132,3)
veiculo_na_area = false

function interactVehicle()
	lookAtVehicle = getPedTarget(player);

	if not (isPedInVehicle(player)) then
		if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle" ) and isElementWithinColShape ( lookAtVehicle, areaDesmanche ) then
			local vx, vy, vz = getElementPosition(lookAtVehicle);
			local rxv, ryv, rzv = getElementRotation(lookAtVehicle)
			local px, py, pz = getElementPosition(player);
			local distanceToVehicle = getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz);

			if (isDebug == "true") then

				if(isInteractableVehicle(lookAtVehicle) == "true") then
					dxDrawText("Interações Possíveis Para Este Veiculo", screenWidth/2, screenHeight/2 - 140, screenWidth/2, screenHeight/2 - 140, tocolor(255, 0, 255, 255), 1, "arial", "center", "center", false, false, true);
				else
					dxDrawText("Não É Possivel Interagir Com Este Veiculo", screenWidth/2, screenHeight/2 - 140, screenWidth/2, screenHeight/2 - 140, tocolor(255, 0, 0, 255), 1, "arial", "center", "center", false, false, true);
				end

				dxDrawLine3D(vx, vy, vz, px, py, vz, tocolor(0, 120, 0, 150), 2);
			end

			if(isInteractableVehicle(lookAtVehicle) == "true") then                
				if (distanceToVehicle < minDistance) and (getDoor(lookAtVehicle)) then
					if (not isVehicleLocked(lookAtVehicle)) then
						local checkDoor = getVehicleDoorState(lookAtVehicle, getDoor(lookAtVehicle));

						if (getDoor(lookAtVehicle) == 0) then
							doorName = "Capô";
						elseif (getDoor(lookAtVehicle) == 1) then
							doorName = "Porta Malas";
						elseif (getDoor(lookAtVehicle) == 2) then
							doorName = "Porta Da Frente Esquerda";
						elseif (getDoor(lookAtVehicle) == 3) then
							doorName = "Porta Da Frente Direita";
						elseif (getDoor(lookAtVehicle) == 4) then
							doorName = "Porta Traseira Esquerda";
						elseif (getDoor(lookAtVehicle) == 5) then
							doorName = "Porta Traseira Direita";
						end

						if (checkDoor ~= 4 and getDoor(lookAtVehicle) == 0) then
							local doorRatio = getVehicleDoorOpenRatio(lookAtVehicle, getDoor(lookAtVehicle));

							if (doorRatio <= 0) then
								dxDrawText("#FFFFFFAperte #00FF00" .. interactButton .. "#FFFFFF Para abrir o #00FF00" .. doorName .. "#FFFFFF e desmontar as peças do carro!", screenWidth/4, screenHeight/4, screenWidth/1.5, screenHeight/4, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, false, true, true);
								end 
							end
						else
							dxDrawRectangle ( screenWidth/2 - 100, screenHeight/2 - 8, 200, 16, tocolor( 0, 0, 0, 90 ));
							dxDrawText("#FF0000 Veiculo Trancado", screenWidth/2, screenHeight/2, screenWidth/2, screenHeight/2, tocolor(255, 255, 255, 255), 1, "arial", "center", "center", false, false, false, true, true);
						end           
					end
				end
			end
		end
	end
	addEventHandler("onClientRender", root, interactVehicle);




	bindKey(interactButton, "down",
		function()
			if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle") and (getDoor(lookAtVehicle)) and isElementWithinColShape ( lookAtVehicle, areaDesmanche )  then
				local checkDoor = getVehicleDoorState(lookAtVehicle, getDoor(lookAtVehicle));
				if (checkDoor == 0 ) then
					if not(isVehicleLocked(lookAtVehicle)) then
						veiculo = lookAtVehicle
						door = getDoor(lookAtVehicle)
						triggerEvent("iniciarDesmanche", root);
						local x, y, z = getElementPosition(player);
						local per = 0 

					end
				end
			end
		end);


	function portaDesmontada(x, y, z)
		local sound = playSound3D("sounds/onDoorOpened.wav", x, y, z, false)
		setSoundMaxDistance(sound, 5);
	end
	addEvent("onDoorOpened", true);
	addEventHandler("onDoorOpened", root, portaDesmontada);

	bindKey("space", "down",
		function()
			if(isCurrentlyDrawing == true) then 
				removeEventHandler("onClientRender", getRootElement(), desenharBarraDeProgresso)
				isCurrentlyDrawing = false 
			end 
		end);

	function iniciarDesmanche()
		-- Check if it is currently not drawing the rectangle. 
		if(isCurrentlyDrawing == false) then 
			-- Add the event handler to the function containing the drawings. 
			addEventHandler("onClientRender", getRootElement(), desenharBarraDeProgresso ) 
			-- Change the variable to true since you are now drawing it with every frame. 
			isCurrentlyDrawing = true 
		elseif(isCurrentlyDrawing == true) then 
			removeEventHandler("onClientRender", getRootElement(), desenharBarraDeProgresso)
			isCurrentlyDrawing = false 
		end
		triggerEvent("progredirDesmanche",root)
	end 
	addEvent("iniciarDesmanche",true)
	addEventHandler("iniciarDesmanche",root, iniciarDesmanche) 

	function progredirDesmanche() 
		-- setVehicleDoorState ( veiculo, 0, 4 ) 
		-- Check so the timer isn't already running. 
		if(progressTimer == false) then 
			-- Change the variable, you know the drill about those from now on.  
			progressTimer = true 
			-- Start the timer, and assign it a variable so it can be killed later. 
			theTimer = setTimer(function() 
				if(isCurrentlyDrawing) then
					-- Increase the totalProgress with a random value between 0 to 10. 
					local randomProgress = math.random(0, 7) 
					-- Increase the totalProgress with the returned integer from above. 
					totalProgress = totalProgress+randomProgress 
					-- For debugging, will out put the random number and total progress in the format of randomNumber(totalProgress). 
					--outputChatBox(tostring(randomProgress).."("..tostring(totalProgress)..")") 
					-- Update the renderProgress variable. 
					renderProgress = (totalProgress/100)/2.575 
					--outputChatBox(tostring(getVehicleDoorState (lookAtVehicle,door)))
					--outputChatBox(lookAtVehicle)
					triggerServerEvent("desmontarPecas", root, 0,veiculo);
					playSoundFrontEnd (  46 )

					-- Check if the totalProgress becomes equal to or greater than 100. 
					if(totalProgress >= 100) then 
						-- Set the total progress to 100, in case it became greater than 100. This is to prevent the actual progress bar from becoming wider than the background. 
						totalProgress = 100 
						-- Update the renderProgress variable, since you change totalProgress above. 
						renderProgress = (totalProgress/100)/2.575 
						-- Update the timer variable. 
						progressTimer = false 
						-- Message to tell you that the progress became greater than or equal to 100. 

						if(getVehicleDoorState (veiculo,0) == 4 and getVehicleDoorState (veiculo,1) == 4 and getVehicleDoorState (veiculo,2) == 4 and getVehicleDoorState (veiculo,3) == 4 and getVehicleDoorState (veiculo,4) == 4) then
							triggerServerEvent("finalizarDesmanche",root,veiculo)
							desmanchado = true
						end
						-- Kill the timer so it doesn't keep running. 
						killTimer(theTimer) 
					end 
				else
					progressTimer = true
				end
			end, 1000, 0) 
		else 
			outputChatBox("Ops.. Parece que você tentou desmontar o carro muitas vezes e não conseguiu, que pena!", 255,255,255) 
		end 
	end 
	addEvent("progredirDesmanche",true)
	addEventHandler("progredirDesmanche", root,progredirDesmanche) 

	function desenharBarraDeProgresso() 
		-- Add the drawings you want in here. Do note that this code will be run with every frame. So 30-60 times PER SECOND. Be careful when using other code attached to onClientRender and onClientPreRender. 
		backgroundRectangle = dxDrawRectangle(screenW/3.0, screenH/1.4, screenW/2.5, screenH/15.0, tocolor(0, 0, 0, 200)) 
		if(not desmanchado) then 
			progressRectangle = dxDrawRectangle(screenW/2.95, screenH/1.38, screenW*renderProgress, screenH/22, tocolor(255, 0, 0, 255)) 
			progressText = dxDrawText("Progresso: ("..totalProgress.."%)", screenW/2.15, screenH/1.37, screenW/2.575, screenH/22, tocolor(255, 255, 255, 255), 1, "pricedown") 
		else
			progressRectangle = dxDrawRectangle(screenW/2.95, screenH/1.38, screenW*renderProgress, screenH/22, tocolor(0, 250, 0, 255)) 
			progressText = dxDrawText("Boa malandro! Peças desmontadas.", screenW/2.15, screenH/1.37, screenW/2.575, screenH/22, tocolor(0, 0, 0, 255), 1, "pricedown") 
		end
	end 


	function getPlayerToVehicleRelatedPosition()    
		if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle") then   
			local vx, vy, vz = getElementPosition(lookAtVehicle);
			local rxv, ryv, rzv = getElementRotation(lookAtVehicle);
			local px, py, pz = getElementPosition(player);
			local anglePlayerToVehicle = math.atan2(px - vx, py - vy);
			local formattedAnglePlayerToVehicle = math.deg(anglePlayerToVehicle) + 180;
			local vehicleRelatedPosition = formattedAnglePlayerToVehicle + rzv;

			if (vehicleRelatedPosition < 0) then
				vehicleRelatedPosition = vehicleRelatedPosition + 360
			elseif (vehicleRelatedPosition > 360) then
				vehicleRelatedPosition = vehicleRelatedPosition - 360
			end

			return math.floor(vehicleRelatedPosition) + 0.5;
		else
			return "false";
		end
	end


	function getDoor(lookAtVehicle)
		local vehicle = lookAtVehicle;

		if (getInteractableVehicleType(vehicle)) == "2 Portas" then
			if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
				return 1;
			end

			if (getPlayerToVehicleRelatedPosition() >= 65) and (getPlayerToVehicleRelatedPosition() <= 120) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 295) then
				return 3;
			end
		elseif (getInteractableVehicleType(vehicle)) == "2 Portas Sem Porta Malas" then
			if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 65) and (getPlayerToVehicleRelatedPosition() <= 120) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 295) then
				return 3;
			end
		elseif (getInteractableVehicleType(vehicle)) == "4 Portas" then
			if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
				return 1;
			end

			if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 120) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 270) then
				return 3;
			end

			if (getPlayerToVehicleRelatedPosition() >= 60) and (getPlayerToVehicleRelatedPosition() <= 90) then
				return 4;
			end

			if (getPlayerToVehicleRelatedPosition() >= 271) and (getPlayerToVehicleRelatedPosition() <= 300) then
				return 5;
			end
		elseif (getInteractableVehicleType(vehicle)) == "Van" then
			if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 130) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 230) and (getPlayerToVehicleRelatedPosition() <= 270) then
				return 3;
			end

			if (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
				return 4;
			end

			if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360) then
				return 5;
			end
		elseif (getInteractableVehicleType(vehicle)) == "Caminhão" then
			if (getPlayerToVehicleRelatedPosition() >= 160) and (getPlayerToVehicleRelatedPosition() <= 200) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 120) and (getPlayerToVehicleRelatedPosition() <= 155) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 205) and (getPlayerToVehicleRelatedPosition() <= 230) then
				return 3;
			end
		elseif (getInteractableVehicleType(vehicle)) == "Especial" then  
			if (getPlayerToVehicleRelatedPosition() >= 120) and (getPlayerToVehicleRelatedPosition() <= 155) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 205) and (getPlayerToVehicleRelatedPosition() <= 230) then
				return 3;
			end
		elseif (getInteractableVehicleType(vehicle)) == "Stretch" then
			if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
				return 0;
			end

			if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
				return 1;
			end

			if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 120) then
				return 2;
			end

			if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 270) then
				return 3;
			end

			if (getPlayerToVehicleRelatedPosition() >= 60) and (getPlayerToVehicleRelatedPosition() <= 90) then
				return 4;
			end

			if (getPlayerToVehicleRelatedPosition() >= 271) and (getPlayerToVehicleRelatedPosition() <= 300) then
				return 5;
			end
		end

		return nil;
	end


	function isInteractableVehicle(lookAtVehicle)
		local vehicle = lookAtVehicle;
		local interactableVehicles = {  602, 429, 402, 541, 415, 480, 562, 587, 565, 559, 603, 506, 558, 555, 536, 575,
			518, 419, 534, 576, 412, 496, 401, 527, 542, 533, 526, 474, 545, 517, 410, 436,
			475, 439, 549, 491, 599, 552, 499, 422, 414, 600, 543, 478, 456, 554, 589, 500, 
			489, 442, 495, 560, 567, 445, 438, 507, 585, 466, 492, 546, 551, 516, 467, 426, 
			547, 405, 580, 550, 566, 420, 540, 421, 529, 490, 596, 598, 597, 418, 579, 400, 
			470, 404, 479, 458, 561, 411, 451, 477, 535, 528, 525, 508, 494, 502, 503, 423,
			416, 427, 609, 498, 428, 459, 482, 582, 413, 440, 433, 524, 455, 403, 443, 515, 
		514, 408, 407, 544, 601, 573, 574, 483, 588, 434, 444, 583, 409};

		for i, v in pairs(interactableVehicles) do
			if (v == getElementModel(vehicle)) then
				return "true";
			end
		end  
	end


	function getInteractableVehicleType(lookAtVehicle)
		local vehicle = lookAtVehicle;

		local twoDoors = {  602, 429, 402, 541, 415, 480, 562, 587, 565, 559, 603, 506, 558, 555, 536, 575,
			518, 419, 534, 576, 412, 496, 401, 527, 542, 533, 526, 474, 545, 517, 410, 436,
			475, 439, 549, 491, 599, 552, 499, 422, 414, 600, 543, 478, 456, 554, 589, 500, 
		489, 442, 495, };

		local fourDoors = { 560, 567, 445, 438, 507, 585, 466, 492, 546, 551, 516, 467, 426, 547, 405, 580,
			550, 566, 420, 540, 421, 529, 490, 596, 598, 597, 418, 579, 400, 470, 404, 479,
		458, 561};

		local twoDoorsNoTrunk = {411, 451, 477, 535, 528, 525, 508, 494, 502, 503, 423};

		local vans = {416, 427, 609, 498, 428, 459, 482, 582, 413, 440}; 

		local trucks = {433, 524, 455, 403, 443, 515, 514, 408};

		local special = {407, 544, 601, 573, 574, 483, 588, 434, 444, 583};

		local stretch = {409};

		if (isInteractableVehicle(vehicle)) == "true" then
			for i, v in pairs(twoDoors) do
				if (v == getElementModel(vehicle)) then
					return "2 Portas";
				end
			end

			for i, v in pairs(twoDoorsNoTrunk) do
				if (v == getElementModel(vehicle)) then
					return "2 Portas Sem Porta Malas";
				end
			end

			for i, v in pairs(fourDoors) do
				if (v == getElementModel(vehicle)) then
					return "4 Portas";
				end
			end

			for i, v in pairs(vans) do
				if (v == getElementModel(vehicle)) then
					return "Van";
				end
			end

			for i, v in pairs(trucks) do
				if (v == getElementModel(vehicle)) then
					return "Caminhão";
				end
			end

			for i, v in pairs(special) do
				if (v == getElementModel(vehicle)) then
					return "Special";
				end
			end

			for i, v in pairs(stretch) do
				if (v == getElementModel(vehicle)) then
					return "Stretch";
				end
			end
		else
			return "Não Utilizável";
		end
	end