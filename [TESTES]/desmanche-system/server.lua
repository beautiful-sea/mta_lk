mysql = exports.mysql

function desmontarPecas(door,veiculo )
    --destroyElement(lookAtVehicle)
    local player = source;
    
    if (veiculo) and (getElementType(veiculo) == "vehicle" ) then
        local doorRatio = getVehicleDoorOpenRatio(veiculo, door);
        local doorStateS = getElementData(veiculo, tostring(door), true);
        
        if not (doorStateS) then
            setElementData(veiculo, door, "closed", true);
        end
        --interactWith(player, veiculo, door);
        if((getVehicleDoorState (veiculo,0) < 4)) then
            if(getVehicleDoorState (veiculo,0) == 0) then
                local x,y,z = getElementPosition(client)
                local vx,vy,vz =  getElementRotation(veiculo)
                setElementRotation(client,0,0,vz)
                setElementPosition(client,x,y+0.5,z,true)
                exports.global:applyAnimation( client, "CAR", "Fixn_Car_loop", -1, true, false, false)
                setVehicleDoorState ( veiculo, 0, 1 )  

            elseif(getVehicleDoorState (veiculo,0) == 1) then
                setVehicleDoorState ( veiculo, 0, 2 )  
            elseif(getVehicleDoorState (veiculo,0) == 2) then
                setVehicleDoorState ( veiculo, 0, 3 )  

            elseif(getVehicleDoorState (veiculo,0) == 3) then
                setVehicleDoorState ( veiculo, 0, 4 )  
            end
        elseif((getVehicleDoorState (veiculo,1) < 4))then
            if(getVehicleDoorState (veiculo,1) == 0) then

                setVehicleDoorState ( veiculo, 1, 1 )  

            elseif(getVehicleDoorState (veiculo,1) == 1) then
                setVehicleDoorState ( veiculo, 1, 2 )  
            elseif(getVehicleDoorState (veiculo,1) == 2) then
                setVehicleDoorState ( veiculo, 1, 3 )  

            elseif(getVehicleDoorState (veiculo,1) == 3) then
                setVehicleDoorState ( veiculo, 1, 4 )  
            end
        elseif((getVehicleDoorState (veiculo,2) < 4))then
            if(getVehicleDoorState (veiculo,2) == 0) then

                setVehicleDoorState ( veiculo, 2, 1 )  

            elseif(getVehicleDoorState (veiculo,2) == 1) then
                setVehicleDoorState ( veiculo, 2, 2 )  
            elseif(getVehicleDoorState (veiculo,2) == 2) then
                setVehicleDoorState ( veiculo, 2, 3 )  

            elseif(getVehicleDoorState (veiculo,2) == 3) then
                setVehicleDoorState ( veiculo, 2, 4 )  
            end
        elseif((getVehicleDoorState (veiculo,3) < 4))then
            if(getVehicleDoorState (veiculo,3) == 0) then

                setVehicleDoorState ( veiculo, 3, 1 )  

            elseif(getVehicleDoorState (veiculo,3) == 1) then
                setVehicleDoorState ( veiculo, 3, 2 )  
            elseif(getVehicleDoorState (veiculo,3) == 2) then
                setVehicleDoorState ( veiculo, 3, 3 )  

            elseif(getVehicleDoorState (veiculo,3) == 3) then
                setVehicleDoorState ( veiculo, 3, 4 )  
            end
        else
            if(getVehicleDoorState (veiculo,4) == 0) then

                setVehicleDoorState ( veiculo, 4, 1 )  

            elseif(getVehicleDoorState (veiculo,4) == 1) then
                setVehicleDoorState ( veiculo, 4, 2 )  
            elseif(getVehicleDoorState (veiculo,4) == 2) then
                setVehicleDoorState ( veiculo, 4, 3 )  

            elseif(getVehicleDoorState (veiculo,4) == 3) then
                setVehicleDoorState ( veiculo, 4, 4 )  
            end
        end


    end
end

addEvent("desmontarPecas", true)
addEventHandler("desmontarPecas", root, desmontarPecas)

function finalizarDesmanche(veiculo)
    dinheiro_ganho = math.random(1000, 5000)
    local query = mysql:query_free("UPDATE characters SET money = money+ "..dinheiro_ganho.." WHERE charactername = '"..mysql:escape_string(getPlayerName ( client )).."'")
    outputChatBox("As peças do veículo foram desmontadas. Você recebeu R$"..dinheiro_ganho.." por isso.",client,150,255,150) 
        outputChatBox("Aperte 'espaço' para sair.",client,0,0,250)
        setPlayerMoney(client,tonumber(getPlayerMoney(client))+2153)
        destroyElement ( veiculo )
        setPedAnimation(client)

        
    end

    addEvent("finalizarDesmanche", true)
    addEventHandler("finalizarDesmanche", root, finalizarDesmanche)


    local canInterActWith = "true";

    function interactWith(source, vehicle, door)
        local player = source;
        doorRatio = getVehicleDoorOpenRatio(vehicle, door);
        doorState = getElementData(vehicle, door);

        if (doorRatio <= 0) then
            doorState = "closed";
        elseif (doorRatio >= 1) then
            doorState = "open";
        end

        if (canInterActWith == "true") then 
            if (doorState == "closed") then
                setTimer(function()
                    canInterActWith = "false";

                    if (doorRatio <= 1) then
                        doorRatio = doorRatio + 0.1;
                        if (doorRatio >= 1) then
                            doorRatio = 1;
                            setElementData(vehicle, door, "open", true);
                            canInterActWith = "true";
                            triggerOpenEvents(player, door);
                            killTimers(50);
                        end
                    end
                    setElementData(vehicle, door, "closed", true);
                    setVehicleDoorOpenRatio(vehicle, door, doorRatio);        
                end, 50, 11);

            elseif (doorState == "open") then
                setTimer ( function()
                    canInterActWith = "false";

                    if (doorRatio > 0) then
                        doorRatio = doorRatio - 0.1;

                        if (doorRatio <= 0) then
                            doorRatio = 0;
                            setElementData(vehicle, door, "closed", true);
                            canInterActWith = "true";
                            triggerCloseEvents(player, door);
                            killTimers(50);
                        end                
                    end
                    setElementData(vehicle, door, "open", true);
                    setVehicleDoorOpenRatio(vehicle, door, doorRatio);
                end, 50, 11);
            end
        end   
    end

    function triggerOpenEvents(source, door)
        if (source) and (door) then   
            if (door == 0) then
                triggerClientEvent(source, "onHoodOpened", root);
            elseif (door == 1) then
                triggerClientEvent(source, "onTrunkOpened", root);
            elseif (door == 2) then
                triggerClientEvent(source, "onLeftFrontDoorOpened", root);
            elseif (door == 3) then
                triggerClientEvent(source, "onRightFrontDoorOpened", root);
            elseif (door == 4) then
                triggerClientEvent(source, "onLeftRearDoorOpened", root);
            elseif (door == 5) then
                triggerClientEvent(source, "onRightRearDoorOpened", root);       
            end
        end
    end

    function triggerCloseEvents(source, door)
        if (source) and (door) then
            local x, y, z = getElementPosition(source)

            if (door == 0) then
                triggerClientEvent(source, "onHoodClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);
            elseif (door == 1) then
                triggerClientEvent(source, "onTrunkClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);
            elseif (door == 2) then
                triggerClientEvent(source, "onLeftFrontDoorClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);
            elseif (door == 3) then
                triggerClientEvent(source, "onRightFrontDoorClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);
            elseif (door == 4) then
                triggerClientEvent(source, "onLeftRearDoorClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);
            elseif (door == 5) then
                triggerClientEvent(source, "onRightRearDoorClosed", root);
                triggerClientEvent(root, "onDoorClosed", root, x, y, z);            
            end
        end
    end

    function killTimers(time)
        local timers = getTimers(time);

        for i, v in ipairs(timers) do
            killTimer(v);
        end
    end