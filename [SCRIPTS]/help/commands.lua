local myCommandsWindow = nil
local sourcePlayer = getLocalPlayer()

function commandsHelp()
	local loggedIn = getElementData(sourcePlayer, "loggedin")
	if (loggedIn == 1) then
		if (myCommandsWindow == nil) then
			guiSetInputEnabled(true)
			local screenx, screeny = guiGetScreenSize()
			myCommandsWindow = guiCreateWindow ((screenx-700)/2, (screeny-500)/2,500,440, "List of Server Commands", false)
			local tabPanel = guiCreateTabPanel (0, 0.1, 1, 1, true, myCommandsWindow)
			local tlBackButton = guiCreateButton(0.8, 0.05, 0.2, 0.07, "Close", true, myCommandsWindow) 

			local commands =
			{

				{
					name = "Chat",
					{ "/n", "/n Text" },
					{ "'t'", "Press 't' [IC Text]"},
					{ "'y' or /r", "/r [IC Text]"},
					{ "/tuneradio", "/tuneradio [radio id] [frequency]" },
					{ "/toggleradio", "/toggleradio [slot]"},
					{ "/ad", "/ad [IC Text] | /ad 1 to show number"},
					{ "'b' or /b", "/b [OOC Text]" },
					{ "'u' or /o", "/o [OOC Text]"},
					{ "/toggleooc", "/toggleooc"},
					{ "/me", "/me [IC Action]" },
					{ "/do", "/do [IC Event]" },
					{ "/pm", "/pm [player] [OOC Text]" },
					{ "/togpm", "Toggles PM'S"},
					{ "/s", "/s [IC Text]" },
					{ "/f", "/f [OOC Text]"},
					{ "/m", "/m [IC Text]" },
					{ "/w", "/w [player] [IC Text]"},
					{ "/cw", "/cw [IC Text]"},
					{ "/c", "/c [IC Text]" },
					{ "/d or /department","Visible to govt factions.IC"},
					{ "/gov", "/gov [IC Text]"},
					{ "/district", "/district [IC Text]" },
					
				},
				{
					name = "Factions",
					{ "'F3'", "Press 'F3'", "Shows the faction menu.", "'F3'" },
					{ "/duty", "/duty", "Gives you items/weapons required for your job in an official faction.", "/duty" },
					{ "/issuebadge", "/issuebadge [player] [number/name]", "Issues a badge or ID to the player.", "/issuebadge Nathan_Daniels N.Daniels.64" },
					{ "Leaders", "/fpark", "Sets the faction vehicle's parking position where it respawns at.", "/fpark"},
					{ "Leaders", "/togglef", "Sets the Faction's OOC chat on/off.", "/togglef" },
					{ "PD", "/armor", "Gives you full armor back.", "/armor" },
					{ "PD", "/swat", "Goes on SWAT duty. Requires a SWAT Authorization.", "/swat" },
					{ "PD", "/authswat", "Gives SWAT authorization for a few minutes, allows PD members to use /swat", "/authswat" },
					{ "PD", "/cadet", "Goes on Cadet duty.", "/cadet" },
					{ "PD", "/dduty", "Goes on Detective duty", "/dduty" },
					{ "PD", "/backup", "Puts a backup blip on your char showing other PD members where you are.", "/backup" },
					{ "PD", "/resetbackup", "Removes the backup blip.", "/resetbackup" },
					{ "PD", "/fingerprint [player]", "Takes the fingerprint of the player.", "/fingerprint Richard_Banks" },
					{ "PD", "/ticket [player] [fine] [reason]", "Issues a ticket to the player.", "/ticket Richard_Banks 500 Speeding" },
					{ "PD", "/takelicense [player] [license] [hours=0]", "Takes the license from a player. They have to re-do the license later.", "/takelicense Daniela_Lane 1 20" },
					{ "PD", "/arrest [player] [fine] [minutes] [crimes]", "Arrests a player for a given amount of time.", "/arrest Daniela_Lane 500 15 Evading" },
					{ "PD", "/release [player]", "Releases a player from his arrest before the time is over.", "/release Daniela_Lane" },
					{ "PD", "/jailtime", "Shows how much time in jail you have left.", "/jailtime" },
					{ "PD", "/mdc", "Opens the Mobile Data Computer.", "/mdc" },
					{ "PD", "/rbs", "Opens the roadblock system", "/rbs" },
					{ "PD", "/nearbyrb", "Shows the nearby roadblock's id.", "/nearbyrb" },
					{ "PD", "/delrb [id] or /delroadblock [id]", "Deletes the roadblock with that id.", "/delrb 3" },
					{ "PD", "/delallrbs or /delallroadblocks", "Deletes all roadblocks.", "/delallrbs" },
					{ "PD", "/deployspikes", "Deploys Spikes.", "/deployspikes" },
					{ "PD", "/throwspikes", "Throws Spikes.", "/throwspikes" },
					{ "PD", "/removespikes [id]", "Removes the spikes with that ID.", "/removespikes 3" },
					{ "ES", "/heal [player]", "Heals a player from all injuries and gives them full health.", "/heal Joe" },
					{ "ES", "/examine [player]", "Shows the player's injuries.", "/examine Harry" },
					{ "ES", "/firefighter", "Goes on FD Duty", "/firefighter" },
					{ "ES", "/assist", "Puts an assist beacon on your char showing other members where you are.", "/assist"},
					{ "GOV", "/setbudget [faction] [amount]", "Gives a Government faction some cash into their faction bank.", "/setbudget 1 2000000" },
					{ "GOV", "/settax [percent]", "Sets the General Taxes, e.g. for buying items.", "/settax 12" },
					{ "GOV", "/setincometax [percent]", "Sets the income tax that is deducted from the wage each payday.", "/setincometax 10" },
					{ "GOV", "/setwelfare [amount]", "Sets the State Benefits unemployed people get (not in a company) per payday.", "/setwelfare 150" },
					{ "GOV", "/gettax", "Shows Tax, Income Tax and Welfare.", "/gettax" },
					{ "SAN", "/n [IC Text]", "Broadcasts a news line.", "/n Good Morning, Los Santos!" },
					{ "SAN", "/interview [player]", "Invites someone for an interview.", "/interview Hans_Vanderburg" },
					{ "SAN", "/endinterview [player]", "Ends an Interview.", "/endinterview Hans_Vanderburg" },
					{ "SAN", "/i [IC Text]", "Talks on the news if you're being interviewed.", "/i Yeah, it was pretty hard to come up with that idea." },
					{ "SAN", "/tognews", "Toggles News broadcast for you on or off.", "/tognews" },
					{ "SAN", "/news", "Sends a message to SAN. Your Phone number is included.", "/news I want to talk about Kraff." },
					{ "SAN", "/forecast", "Shows a weather forecast.", "/forecast" },
					{ "SAN", "/pollresults", "Shows the results of the elections.", "/pollresults" },
					{ "LSTR", "/towtruck", "Calls a towtruck to your current location.", "/towtruck" },
					{ "LSTR", "/resettowbackup", "Removes the blip created with /towtruck.", "/resettowbackup" },
					{ "LSTR", "/impoundbike", "Sets a Bike that is in the impound lot as impounded.", "/impoundbike" },
					{ "LSTR", "/unimpound [vehicle id]", "Sets a vehicle in the LSTR Lot and unimpounded.", "/unimpound" }
				},
				{
					name = "Vehicles",
					{ "'J'", "Press 'J'", "Turns the engine on or off.", "'J'" },
					{ "'K'", "Press 'K'", "Locks or Unlocks the vehicle you're currently driving, or the nearest vehicle which you have a key of.", "'K'" },
					{ "/elock", "/elock near vehicle", "Disables electric lock in vehicle if you have it installed.", "/elock" },
					{ "'L'", "Press 'L'", "Switches the lights on or off.", "'L'" },
					{ "'P'", "Press 'P'", "Toggles the Emergency Light Beacon.", "'P'" },
					{ "/door", "/door [number]", "Open vehicle's hood and doors.", "/door 1" },
					{ "/seatbelt", "/seatbelt inside car", "Wear seatbelt to reduce damage.", "/seatbelt" },
					{ "/hotwire", "/hotwire inside car", "Gives options to hotwire a car.", "/hotwire" },
					{ "/detach", "/detach", "Detaches your vehicle's trailer (if any).", "/detach" },
					{ "/park", "/park", "Sets the vehicle's parking position where it respawns at.", "/park" },
					{ "/sell", "/sell [player]", "Sells the vehicle you're currently in to another player.", "/sell Nathan_Daniels" },
					{ "/handbrake", "/handbrake", "Applies or releases your handbrakes.", "/handbrake" },
					{ "/eject", "/eject [player]", "Throws a player out of your car.", "/eject Nathan_Daniels" },
					{ "/indicator_right", "/indicator_right", "Toggles your right indicators.", "/indicator_left" },
					{ "/cc or /cruisecontrol", "/cc [speed]", "Enables or disables cruise control.", "/cc or /cc 90" },
					{ "/togwindow", "/togwindow", "Toggles your vehicles windoes up/down.", "/togwindow" },
					
				},
				{
					name = "Properties",
					{ "'F'", "Press 'F'", "Enters or Exits an Interior", "'F'" },
					{ "'K'", "Press 'K'", "Locks or unlocks the nearest interior you have the key for.", "'K'" },
					{ "/sell", "/sell [player]", "Sells the interior you're in to another player.", "/sell Hans_vanderburg" },
					{ "/sellproperty", "/sellproperty", "Sells the interior you're in back to the Government", "/sellproperty" },
					{ "/unrent", "/unrent", "Unrents a place you're renting.", "/unrent" },
					{ "/setfee", "/setfee [amount]", "Specifies the fee people have to pay when they enter your club/restaurant.", "/setfee 20" },
					{ "/movesafe", "/movesafe", "Moves the safe in the interior you're in.", "/movesafe" },
					{ "/checksupplies", "/checksupplies", "Shows how many supplies you have in stock.", "/checksupplies" },
					{ "/ordersupplies", "/ordersupplies [amount]", "Orders new supplies for your business.", "/ordersupplies 10" },
				},
				{
					name = "Items",
					{ "'I'", "Press 'I'", "Opens your inventory.", "'I'" },
					{ "/breathtest", "/breathtest [player]", "Checks a player's breath for alcohol.", "/breathtest Nathan_Daniels" },
					{ "/issuepilotcertificate", "/issuepilotcertificate [player]", "Issues a pilot certificate to the player.", "/issuepilotcertificate Hansie" },
					{ "/togglecradar", "/togglecradar", "Toggles the Police Radar.", "/togglecradar" },
					{ "/call", "/call [number]", "Calls a person's phone.", "/call 12444" },
					{ "/pickup", "/pickup", "Picks up the phone when you're called.", "/pickup" },
					{ "/p", "/p [IC Text]", "Talks into the phone.", "/p Hey, how are you?" },
					{ "/loudspeaker", "/loudspeaker", "Toggles the phone's loudspeaker, letting other people around you hear the call.", "/loudspeaker" },
					{ "/hangup", "/hangup", "Hangs the phone up.", "/hangup" },
					{ "/togglephone", "/togglephone", "Toggles your phone on or off. Donators only.", "/togglephone" },
					{ "/sms", "/sms [number] [IC Text]", "Sends a text message to another phone.", "/sms 12444 I'm short on time right now, see you later." },
				},
				{
					name = "Jobs",
					{ "/startbus", "/startbus", "Starts the bus route at Unity Station.", "/startbus" },
					{ "/fish", "/fish", "Casts your line for fishing.", "/fish" },
					{ "/totalcatch", "/totalcatch", "Shows you how much lbs of fish you caught.", "/totalcatch" },
					{ "/sellfish", "/sellfish", "Sells your caught fish at the fish market.", "/sellfish" },
					{ "/copykey", "/copykey [type] [id]", "Copies a house, business or vehicle key.", "/copykey 1 50" },
					{ "/totalvalue", "/totalvalue", "Shows you the collection value of your taken photos.", "/totalvalue" },
					{ "/endjob or /quitjob", "/endjob or /quitjob", "Leaves your current job.", "/endjob" },
					{ "'Horn'", "Tap 'Horn' (short)", "Toggle your taxi lights.", "'Horn'" },
					{ "/sellgun", "Sell weapons by arms dealer job", "Copies a house, business or vehicle key.", "/copykey 1 50" },
					{ "/sellmats", "Sell materials by arms dealer job", "Shows you the collection value of your taken photos.", "/totalvalue" },
					{ "/sellvest", "Sell armour by bodyguard job", "Leaves your current job.", "/endjob" },
					{ "/accept", "/accept mats or /accept gun or /accept vest", "Toggle your taxi lights.", "'Horn'" }
				},
				{
					name = "Misc",
					{ "/cj", "Customize CJ skin", "Shows a basic help interface.", "/?" },
					{ "'M'", "Press 'M' to view cursor.You can interact with atm/players/vehicles with it" },
					{ "'F1'", "Toggle Jetpack" },
					{ "/setmuscle", "/setmuscle for CJ skin. 0-999" },
					{ "/setfat", "/setfat for CJ skin. 0-999" },
					{ "/togglenametags", "/togglenametags", "Enables or disables the nametags on other players.", "/togglenametags" },
					{ "/togglespeedo", "/togglespeedo", "Enables or disables the speedometer.", "/togglespeedo" },
					{ "/togglelaser", "/togglelaser", "Toggles your weapon laser.", "/togglelaser" },
					{ "/setwaveforme", "Sets wave height for you.It can be seen working near water", "Toggles your weapon laser.", "/togglelaser" },
					{ "/id", "/id [player]", "Shows the ID and name for a player with the given name/ID.", "/id Medwin_Metz" },
					{ "/settag", "/settag [1-8]", "Changes the tag you're spraying with a spraycan.", "/settag 2" },
					{ "/animlist", "/animlist", "Shows a list of animations.", "/animlist" },
					{ "/look", "/look [player]", "Shows age, race and a description of that character.", "/look Nathan_Daniels" },
					{ "/charity", "/charity [amount]", "Donates money to the hungry orphans.", "/charity 1337" },
					{ "/pay", "/pay [player] [amount]", "Gives the player some money from your wallet.", "/pay Ari_Viere 400" },
					{ "/stats", "/stats", "Shows your hours played, house ids, vehicle ids, languages etc.", "/stats" },
					{ "/timesaved", "/timesaved", "Shows how much time you have left until another payday will get you money.", "/timesaved" },
					{ "/gate", "/gate", "Opens various doors, some might require faction membership, a badge or a password", "/gate" },
					{ "/glue", "/glue", "Glues yourself or the vehicle you're driving to the nearest vehicle.", "/glue" },
					{ "/showfps", "/showfps", "Toggles the FPS counter.", "/showfps" },
					{ "/showlicenses", "/showlicenses [player]", "Shows your driving and gun license to the player.", "/showlicenses Darren_Baker" }
					
				}
			}

			
			for _, levelcmds in pairs( commands ) do
				local tab = guiCreateTab( levelcmds.name, tabPanel)
				local list = guiCreateGridList(0.02, 0.02, 0.96, 0.96, true, tab)
				guiGridListAddColumn (list, "Command", 0.15)
				guiGridListAddColumn (list, "Use", 0.7)

				for _, command in ipairs( levelcmds ) do
					local row = guiGridListAddRow ( list )
					guiGridListSetItemText ( list, row, 1, command[1], false, false)
					guiGridListSetItemText ( list, row, 2, command[2], false, false)
				end
			end
			
			addEventHandler ("onClientGUIClick", tlBackButton, function(button, state)
				if (button == "left") then
					if (state == "up") then
						guiSetVisible(myCommandsWindow, false)
						showCursor (false)
						guiSetInputEnabled(false)
						myCommandsWindow = nil
					end
				end
			end, false)

			guiBringToFront (tlBackButton)
			guiSetVisible (myadminWindow, true)
		else
			local visible = guiGetVisible (myCommandsWindow)
			if (visible == false) then
				guiSetVisible( myCommandsWindow, true)
				showCursor (true)
			else
				showCursor(false)
			end
		end
	end
end
addCommandHandler("helpcmds", commandsHelp)
addEvent("helpcmds",true)
addEventHandler("helpcmds",getRootElement(),commandsHelp)