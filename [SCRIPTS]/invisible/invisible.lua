--[[
Copyright (c) 2010 ShoDown Gaming.
This script may not be used without permission under any circumstance's.
]]
GARAGE_ID = 13
  
-- create a collision shape and attach event handlers to it when the resource starts
function gate(player,command,id)
	if id then
		local id = tonumber(id)
		id = id - 233
		if (not isGarageOpen(id)) then
			-- open the door
			setGarageOpen(id, true)
		else
			setGarageOpen(id,false)
		end
	end
end
addCommandHandler("gate",gate)

function addHelmetOnEnter ( thePlayer, seat, jacked )
    if ( getElementModel ( source ) == 522 ) then -- if its a nrg
        addPedClothes ( thePlayer, "moto", "moto", 16 ) -- add the helmet
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), addHelmetOnEnter )
 
function removeHelmetOnExit ( thePlayer, seat, jacked )
    if ( getElementModel ( source ) == 522 ) then -- if its a nrg
        removePedClothes ( thePlayer, 16 ) -- remove the helmet
    end
end
addEventHandler ( "onVehicleExit", getRootElement(), removeHelmetOnExit )
local blackmarker = 
createMarker(1128.95, -1.72, 1000.67,"cylinder",2,0,22,222,0)
local blackped=createPed(171, 1126.7, -1.75, 1000.6)
setElementInterior(blackmarker,12)
setElementDimension(blackmarker,69)

setElementInterior(blackped,12)
setPedRotation(blackped,270)
setElementDimension(blackped,69)
function MarkerHit( hitElement, matchingDimension )
        if getElementType( hitElement ) == "player" then
          	if getElementData(source,"blackjack")== true then
			
			local message="You are still in middle of a game.((/hit or /stay))"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
		else
			local message="Welcome to Casino.Want to play blackjack? ((/blackjack money))"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
		end
         end
end
addEventHandler( "onMarkerHit",blackmarker, MarkerHit )
local black=""
local add = 0
local dtotal=0
function blackjack(source, command,ace)
        black="Your total = 0 \n Dealer's total =0"
	local x= math.random(1,13)
	if not ace then
		local card=x
		local color=math.random(4)
		if color == 1 then
			setElementData(source,"color","Spade")
		elseif color==2 then
			setElementData(source,"color","Heart")
		elseif color==3 then
			setElementData(source,"color","Diamond")
		elseif color==4 then
			setElementData(source,"color","Club")
		end
		if card == 13 then
			setElementData(source,"card","King")
		elseif card==12 then
			setElementData(	source,"card","Queen")
		elseif card==11 then
			setElementData(	source,"card","Jack")
		elseif card==1 then
			setElementData(	source,"card","Ace")
		else
			setElementData(source,"card",card)
		end
		
		local message="takes out a card. It shows " .. getElementData(source,"card") .. " ["..getElementData(source,"color").."].(Card deck)" 
		exports.chat:localizedMessage2( source, "Dealer ", message, 255, 40, 80, 13 )
		
	end
	if x>=2 and x<=10 then
		add=x
	elseif x==1 then
		if command == 0 then
			
			local message="Ace. You want it 1 or 11? ((/ace1 or /ace11))"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
		
			setElementData(source,"blackhit",false)
			setElementData(source,"ace",true)
			setElementData(source,"blackstay",false)
			return
		else
			local dtotal=getElementData(source,"dblack")+11
			
			if dtotal>=22 then
				add=1
			else
				add=11
			end
		end
	else
		add=10
	end
	if ace then
		add= ace
	end
	if command==0 then
		local ptotal = getElementData(source,"pblack")
		ptotal=ptotal+ add
		if ptotal >=22 then
			
			local message="Your total is greater than 21.You lost!"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
			setElementData(source,"pblack",0)
			setElementData(source,"dblack",0)
			setElementData(source,"blackbet",0)
			setElementData(source,"blackjack",false)
			setElementData(source,"blackhit",false)
		elseif ptotal==21 then
			local money= getElementData(source,"blackbet")
			if exports.global:giveMoney(source, money*2) then
				local message="Your total is 21. You won!"
				exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
				setElementData(source,"pblack",0)
				setElementData(source,"dblack",0)
				setElementData(source,"blackbet",0)
				setElementData(source,"blackjack",false)
				setElementData(source,"blackhit",false)
			end
		else
			setElementData(source,"pblack",ptotal)
			setElementData(source,"blackstay",true)
			setElementData(source,"blackhit",true)
			
			local message= "Its a "..add.." .Your total "..ptotal..". Hit or Stay?(( /hit or /stay))"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )
		end
	else
		local ptotal = getElementData(source,"pblack")
		local dtotal = getElementData(source,"dblack")
		dtotal=dtotal+ add
		if dtotal>=22 then
			local money= getElementData(source,"blackbet")
			exports.global:giveMoney(source, money*2)
			setElementData(source,"dblack",0)
			setElementData(source,"blackjack",false)
			setElementData(source,"blackhit",false)
			setElementData(source,"blackbet",0)
			setElementData(source,"pblack",0)
			local message="My total is greater than 21.You won"
			exports.chat:localizedMessage2( source, "Dealer says: ", message, 255, 255, 255, 13 )

		else
			if dtotal>= ptotal then
				if dtotal == ptotal then
					local message = "Draw. House wins! You lost."
					exports.chat:localizedMessage2( source, " Dealer says: ", message, 255, 255, 255, 13 )
				else
					local message="My total is greater than yours.So I won. You lost."
					exports.chat:localizedMessage2( source, " Dealer says: ", message, 255, 255, 255, 13 )
				end
				setElementData(source,"dblack",0)
				setElementData(source,"blackjack",false)
				setElementData(source,"blackhit",false)
				setElementData(source,"blackbet",0)
				setElementData(source,"pblack",0)
				
			else
				local message ="Its a "..add..". My total becomes "..dtotal.."."
				exports.chat:localizedMessage2( source, " Dealer says: ", message, 255, 255, 255, 13 )
				setTimer ( blackjack, 3000, 1, source,1)
				setElementData(source,"dblack",dtotal)
			end
		end
	end
	black="Your total = "..getElementData(source,"pblack").." \n Dealer's total = "..getElementData(source,"dblack")
end
function blackcommand(source,command,bet)
	if isElementWithinMarker(source,blackmarker) then
		if getElementData(source,"blackjack")== false  then
			if bet then
		
				local bet = tonumber(bet)
	
				if bet>=100 and bet<= 5000 then
					if exports.global:takeMoney( source, bet ) then
						setElementData(source,"pblack",0)
						setElementData(source,"dblack",0)
						setElementData(source,"blackbet",bet)
						setElementData(source,"blackjack",true)
						blackjack(source,0)
						setElementData(source,"blackhit",true)
					else
						outputChatBox("Not enough cash",source,250,2,2)
					end
				else
					outputChatBox("Enter money between 100 and 5000",source,222,22,22)
				end
			else
				outputChatBox("/blackjack money(Between 100 and 5000)",source,222,22,22)
			end
		else
			outputChatBox("You are in middle of a blackjack game.",source,250,2,2)
		end
	else
		outputChatBox("You are not near dealer of casino",source,250,22,22)
	end
end
addCommandHandler("blackjack",blackcommand)
function hit(source,command)
	if isElementWithinMarker(source, blackmarker) then
		if getElementData(source,"blackjack")== true then
			if getElementData(source,"blackhit")== true then
			
				blackjack(source,0)
			else
				outputChatBox("Dealer says : What do you mean by hit now?",source,222,22,22)
			end
		else
			outputChatBox("You are not playing blackjack.",source,222,22,22)
		end
	else
		outputChatBox("You are not near dealer of casino",source,250,22,22)
	end
	
end
addCommandHandler("hit",hit)
function ace1(source,command)
	if isElementWithinMarker(source,blackmarker) then
		if getElementData(source,"blackjack")== true then
			if getElementData(source,"ace")== true then
			
				blackjack(source,0,1)
				setElementData(source,"ace",false)
			else
				outputChatBox("Ace time over",source,222,22,22)
			end
		else
			outputChatBox("You are not playing blackjack.",source,222,22,22)
		end
	else
		outputChatBox("You are not near dealer of casino",source,250,22,22)
	end
end
addCommandHandler("ace1",ace1)
function ace11(source,command)
	if isElementWithinMarker(source,blackmarker) then
		if getElementData(source,"blackjack")== true then
			if getElementData(source,"ace")== true then
			
				blackjack(source,0,11)
				setElementData(source,"ace",false)
			else
				outputChatBox("Ace time over",source,222,22,22)
			end
		else
			outputChatBox("You are not playing blackjack.",source,222,22,22)
		end
	else
		outputChatBox("You are not near dealer of casino",source,250,22,22)
	end
end
addCommandHandler("ace11",ace11)
function stay(source,command,bet)
	if isElementWithinMarker(source,blackmarker) then
		if getElementData(source,"blackjack")== true then
			setElementData(source,"blackhit",false)
			blackjack(source,1)
		else
			outputChatBox("You are not playing blackjack.",source,222,22,22)
		end
	else
		outputChatBox("You are not near dealer of casino",source,250,22,22)
	end
end
addCommandHandler("stay",stay)
local ped = nil

addEventHandler( "onVehicleStartEnter", root,
	function( player, seat )
		if seat==0 then
		local driver = getVehicleOccupant ( source )
		local veh = getPedOccupiedVehicle(driver) 
		local occupants = getVehicleOccupants(veh) -- Get all vehicle occupants
       		local seats = getVehicleMaxPassengers(veh) -- Get the amount of passenger seats
 
        
 		local occupant 
		local occupantname
        	for sea = 0, seats do 
			if sea == 0 then 
            			occupant = occupants[sea] -- Get the occupant
 
            			if occupant and getElementType(occupant)=="player" then -- If the seat is occupied by a player...
                			occupantname = getPlayerName(occupant) -- ... get his name
            			end
            		end
		end

		if driver and occupant and getElementType(occupant)=="player"  and veh and getElementType( driver ) == "player"  then
			if seat == 0 and player ~= occupant then
				--outputChatBox( "(( Ninja-jacking is not allowed.Read F1. ))", player, 255, 0, 0 )
					triggerClientEvent(player,"aoutput",player,"Error","Ninja-jacking is not allowed.Read F1 for rules",3)
				cancelEvent( )
			end
		end
		end
	end
)
mysql = exports.mysql

function count(player)
local user =  mysql:query("SELECT username,id  FROM accounts ORDER BY username DESC LIMIT 10")
local users = mysql:query_fetch_assoc("SELECT COUNT(*) as username FROM accounts WHERE LIMIT 1")
			
	outputChatBox(users, player, 255, 0, 0 )
 outputChatBox(user, player, 255, 0, 0 )
end
addCommandHandler("users",count)


