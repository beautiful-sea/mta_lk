local ips = 
{
	"72.186.*.*", -- 2dop banned ip
	"72.187.*.*",-- 2dope range 1
	"72.185.*.*" -- 2dope range 2
}

local serials = 
{
	"401F3B7508DD40F71FB5E35EF8538702" --2dope;s serial
}

addEventHandler ("onPlayerConnect", getRootElement(), 
function(playerNick, playerIP, playerUsername, playerSerial, playerVersion)
for _, v in pairs(ips ) do
if string.find( playerIP, "^" .. v .. "$" ) then
cancelEvent( true, "You are banned from this server." )
end
end

for _, v in pairs( serials ) do
if (playerSerial == v) then
outputDebugString("found ".. v)
cancelEvent( true, "You are banned from this server." )
end
end
end
)