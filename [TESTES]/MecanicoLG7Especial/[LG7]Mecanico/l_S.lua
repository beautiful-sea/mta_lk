-- [ Desenvolvido por: SRGRINGO MTA
-- [ Pagina: https://www.facebook.com/srgringomta/
-- [ Grupo: https://www.facebook.com/groups/mtaresourcesfree/
-- [ Discord: Avicii~#1634
-- [ Data de criação: 19.10.2019

acls = {
	"Mecanico",
}

marcacao = createMarker(-77.18364, -1136.46802, 1.07813 -1, "cylinder", 1.1,255,255,255,70)
marcacao2 = createMarker(-72.53238, -1138.68555, 1.07813 -1, "cylinder", 1.1,255,255,0,70)

function Permicao()
    for _, v in pairs(getElementsByType("player")) do
	    for _, acl in ipairs (acls) do
			if ACL(v, acl) then
			    setElementData(v, "SRG.Permitido", true)
			else
				setElementData(v, "SRG.Permitido", false)
			end
		end
    end
end
setTimer(Permicao, 1000, 0)

function ACL(player, acl)
   local accountName = getAccountName(getPlayerAccount(player))
   if accountName ~= "guest" and type(aclGetGroup(acl)) == "userdata" then
      return isObjectInACLGroup("user."..accountName, aclGetGroup(acl))
   end
   return false
end


function abrirdx(source)
	if getElementData(source,"SRG.Permitido") == true then
	triggerClientEvent(source, "L:AbrirDx", source)
end
end
addEventHandler("onMarkerHit",marcacao,abrirdx)

veh = {}
function spawnve(player)
	local perm = getElementData(player,"SRG.Permitido")
	if perm == true then
	if isElementWithinMarker(player,marcacao2) then
	if veh[player] and isElement(veh[player]) then destroyElement(veh[player])
	veh[player] = nil
	end
	veh[player] = createVehicle(525,-63.16028, -1139.52637, 1.29142)
	warpPedIntoVehicle(player, veh[player])
	exports.Scripts_Dxmessages:outputDx(player, "Você pegou seu guincho, para guardar, vá até a marcação e digite /guardar.", "success")
end
end
end
addCommandHandler("guincho", spawnve)

function tirarguincho(source,cmd)
	if isElementWithinMarker(source,marcacao2) then
	if getElementData(source,"SRG.Permitido") == true then
	destroyElement(veh[source])
	exports.Scripts_Dxmessages:outputDx(source, "Você guardou seu guincho com sucesso.", "success")
end
end
    end
addCommandHandler("guardar",tirarguincho)

function msg(source)
	if getElementData(source,"SRG.Permitido") == true then
	exports.Scripts_Dxmessages:outputDx(source, "Digite /guincho para pegar guincho e /guardar para guardar.", "success")
end
end
addEventHandler("onMarkerHit",marcacao2,msg)

function sairserver()
	destroyElement(veh[source])
end
addEventHandler ( "onPlayerQuit", root, sairserver )

function _Colocar()
local veiculo = getElementData(source,"SRG.Selecionado")
if getElementData(source,"SRG.Permitido") == true then
if getElementData(source, "Kits:Reparo") > 0 then	
	setElementData(source,"Reparando", true)
				triggerClientEvent(source, "L:CKIT", source)
	        	setElementData(source,"Kits:Reparo",(getElementData(source,"Kits:Reparo")-1))
	        	setPedAnimation( source, "CAMERA", "piccrch_take", 3000, true, false, false, false)
	        	triggerClientEvent (source, "DNL:RepararStart", source)
	        	exports.Scripts_Dxmessages:outputDx(source, "GTeste.", "success")
		        setTimer ( function()	
		        fixVehicle(veiculo)
		        outputChatBox("teste",source,255,255,255)
				setVehicleDoorOpenRatio (veiculo, 0, 0)
				setVehicleDoorOpenRatio (veiculo, 1, 0)
				setVehicleDoorOpenRatio (veiculo, 2, 0)
				setVehicleDoorOpenRatio (veiculo, 3, 0)
				setVehicleDoorOpenRatio (veiculo, 4, 0)
				setVehicleDoorOpenRatio (veiculo, 5, 0)
				setElementData(source,"Reparando", false)
	            end, 3000, 1 )	
else
	triggerClientEvent(source, "L:SKIT", source)
end
else
	outputChatBox("Sem perm",source,255,255,255)
end
end
addEvent(":Reparar", true)
addEventHandler(":Reparar", root, _Colocar)



function comprar()
	local kits = getElementData(source,"Kits:Reparo")
	local money = getPlayerMoney(source)
	if money >= 500 then
	if kits <10 then
	exports.Scripts_Dxmessages:outputDx(source, "Você comprou +1 kit reparo por $500.", "success")
	setElementData(source,"Kits:Reparo", kits+1)
	takePlayerMoney(source, 500)
else
	exports.Scripts_Dxmessages:outputDx(source, "Você atingiu o limite de kits reparo.", "error")
end
else
	exports.Scripts_Dxmessages:outputDx(source, "Você não tem dinheiro suficiente.", "error")
end
end
addEvent("L:ComprarK", true)
addEventHandler("L:ComprarK", root, comprar)

	function jogarfora()
	exports.Scripts_Dxmessages:outputDx(source, "Você jogou todos os seus kits reparos fora.", "success")
end
addEvent("L:JogarFora", true)
addEventHandler("L:JogarFora", root, jogarfora)


addEventHandler ("onPlayerLogin",root,function(_,Acc)
local SedeAcc2 = getAccountData ( Acc, "Kits:Reparo" )

  if SedeAcc2 > 0 then
   setElementData (source, "Kits:Reparo", SedeAcc2)
else
	setElementData(source,"Kits:Reparo",0)
end
local contar = getElementData(source,"Kits:Reparo") or 0
setElementData(source,"Kits:Reparo",contar+0)
end)

function times()
	local ac = getElementData(source,"Kits:Reparo") or 0
	setTimer(function ()
		setElementData(source, "Kits:Reparo", ac+0)
	end,100,0)
end


----------------------------------------------------------------------------------------------------------------------------------------

function saveAccountDataSede ( account )
if isGuestAccount ( account ) then return false end
Player = getAccountPlayer (account)
Sedes = getElementData (Player, "Kits:Reparo")
if getElementData(Player,"Kits:Reparo") > 0 then
setAccountData (account,"Kits:Reparo", Sedes)
else
setElementData(Player, "Kits:Reparo", 0)
setAccountData (account,"Kits:Reparo", 0)
end
end

----------------------------------------------------------------------------------------------------------------------------------------

addEventHandler ( 'onPlayerQuit', root, function ( )
    local acc = getPlayerAccount ( source )
    saveAccountDataSede ( acc )
end )
