addEventHandler("onPlayerLogin", root,
function( _, acc )
 CarregarLoginPlay ( acc )
 end
)

function CarregarLoginPlay ( conta )
	if not isGuestAccount ( conta ) then
		if conta then	
			local source = getAccountPlayer ( conta )
			local emp = getAccountData ( conta, "AirNew_PossuiRG" ) or "N/C"
			setElementData ( source, "AirNew_PossuiRG", emp )
			local emp = getAccountData ( conta, "AirNew_DataExpedicao" ) or "N/C"
			setElementData ( source, "AirNew_DataExpedicao", emp )
			local emp = getAccountData ( conta, "AirNew_RG_NomeCompleto" ) or "N/C"
			setElementData ( source, "AirNew_RG_NomeCompleto", emp )
			local emp = getAccountData ( conta, "AirNew_RG_DataDeNascimento" ) or "N/C"
			setElementData ( source, "AirNew_RG_DataDeNascimento", emp )
			local emp = getAccountData ( conta, "AirNew_RG_LocalDeNascimento" ) or "N/C"
			setElementData ( source, "AirNew_RG_LocalDeNascimento", emp )
			
			local Serial = getPlayerSerial ( source )
			setElementData ( source, "AirNew_RG", ""..Serial.."" )
			
			if getElementData ( source, "AirNew_PossuiRG" ) == "Sim" then
			    return
			end
			
			local time = getRealTime() or 0
			local hora = time.hour + 1 or 0
			local minuto = time.minute or 0
			local dia = time.monthday or 0
			local mes = time.month + 1 or 0
			local ano = time.year + 1900 or 0
			
			setElementData ( source, "AirNew_DataExpedicao", ""..dia.."/"..mes.."/"..ano.." - "..hora..":"..minuto.."" )
			setElementData ( source, "AirNew_SolicitarCriarRG", "Sim" )
		end
	end	
end

function ReiniciarScript ( res )
	if res == getThisResource ( ) then
		for i, player in ipairs ( getElementsByType ( "player" ) ) do
			local acc = getPlayerAccount ( player )
			if not isGuestAccount ( acc ) then
				CarregarLoginPlay ( acc )
			end
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement ( ), ReiniciarScript )

--

function SalvarLoginPlay ( conta )
	if conta then
	local source = getAccountPlayer ( conta )
	local RG = getElementData ( source, "AirNew_PossuiRG" ) or "N/C"
	setAccountData ( conta, "AirNew_PossuiRG", RG )
	local Data = getElementData ( source, "AirNew_DataExpedicao" ) or "N/C"
	setAccountData ( conta, "AirNew_DataExpedicao", Data )
	local Nome = getElementData ( source, "AirNew_RG_NomeCompleto" ) or "N/C"
	setAccountData ( conta, "AirNew_RG_NomeCompleto", Nome )
	local DataNas = getElementData ( source, "AirNew_RG_DataDeNascimento" ) or "N/C"
	setAccountData ( conta, "AirNew_RG_DataDeNascimento", DataNas )
	local LocalNas = getElementData ( source, "AirNew_RG_LocalDeNascimento" ) or "N/C"
	setAccountData ( conta, "AirNew_RG_LocalDeNascimento", LocalNas )
	end	
end

function DesligarScript ( res )
    if res == getThisResource ( ) then
		for i, player in ipairs ( getElementsByType ( "player" ) ) do
			local acc = getPlayerAccount ( player )
			if not isGuestAccount ( acc ) then
				SalvarLoginPlay ( acc )
			end
		end
	end
end 
addEventHandler ( "onResourceStop", getRootElement ( ), DesligarScript )

function JogadorQuit ( quitType )
	local acc = getPlayerAccount ( source )
	if not isGuestAccount ( acc ) then
		if acc then
			SalvarLoginPlay ( acc )
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement ( ), JogadorQuit )