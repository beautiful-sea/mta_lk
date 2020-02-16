-------------------------
-- Created by #Flavio  --
--    Developer MTA    --
--  2014 - 2015 - 2016 --
-------------------------
blip2 = {}

local abrirpainel = createMarker(1777.2235107422, -1891.1002197266, 12.3,"cylinder", 2, 252, 149, 2, 100)
local entrega = createMarker(1759.6647949219, -1669.6209716797, 13.556806564331, "cylinder", 5, 0, 255, 0, 0)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
local bliptrabalho = createBlip(0,0,0, 53, 0, 0, 0, 0, 0, 0, 250)
setBlipVisibleDistance(bliptrabalho, 400)
attachElements (bliptrabalho, abrirpainel)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function mostrarpainel(thePlayer)
		triggerClientEvent(thePlayer, "LixeiroEmpregoDX", getRootElement())
end
addEventHandler("onMarkerHit", abrirpainel, mostrarpainel)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function onClientCrapBox2(player, test1, test2, test3)
	triggerClientEvent(getRootElement(), "onClientCrapBox2", getRootElement(), test1, test2, test3)
end
lixeirocar = {}
function DarCarroLixeiro2 ()
    if lixeirocar[source] and isElement( lixeirocar[source] ) then destroyElement( lixeirocar[source] ) 
 lixeirocar[source] = nil 
 end
    local x,y,z = getElementPosition(source)
    lixeirocar[source] = createVehicle(408, 1786.0692138672, -1891.2706298828, 13.393762588501)
	setElementRotation(lixeirocar[source],0,0,267.61938476563)
    warpPedIntoVehicle (source,lixeirocar[source])
	outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Se você sair do veiculo, o trabalho sera cancelado.",source,255,255,255,true)
	setElementData(source,"LixeiroBVH",true)
	onClientCrapBox2(source, "info", "#FF0000TRABALHO: #00FFFF"..getPlayerName(source).."#FFFFFF agora é o lixeiro da cidade.")
	--outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Virou lixeiro da cidade. Use '#00FF00/lixeiro#bebebe' para ser um também.",getRootElement(),255,255,255,true)
end
addEvent("DarCarroLixeiro",true)
addEventHandler("DarCarroLixeiro",root,DarCarroLixeiro2)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function DestroyVeiculo ()
if lixeirocar[source] and isElement( lixeirocar[source] ) then
destroyElement (lixeirocar[source])
end
end
addEventHandler ("onPlayerLogout", root, DestroyVeiculo)
addEventHandler ("onPlayerQuit", root, DestroyVeiculo)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Destruir (source)
destroyElement (lixeirocar[source])
end
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
local rootElement = getRootElement()
local lixeirotruck = {[408] = true}
local Lixeriotabela = {
[1]={1898.8569335938, -1934.9417724609, 13.3828125},[2]={2027.1402587891, -1940.6293945313, 13.350769996643},[3]={2183.6965332031, -1897.0151367188, 13.35663318634},[4]={2218.5395507813, -1765.9461669922, 13.347891807556},[5]={2284.4763183594, -1661.6453857422, 14.957333564758},
[6]={2345.0297851563, -1548.2351074219, 23.836153030396},[7]={2250.3859863281, -1481.6564941406, 23.140300750732},[8]={2270.6125488281, -1432.7271728516, 23.835834503174},[9]={2169.5354003906, -1340.8875732422, 23.82808303833},[10]={2073.7807617188, -1260.4652099609, 23.828107833862},
[11]={1973.3278808594, -1235.2452392578, 20.050930023193},[12]={1845.4704589844, -1356.6219482422, 13.398416519165},[13]={1801.1939697266, -1585.5128173828, 13.505581855774},--[[[14]={-284.8, -1642.00, 15.5116},[15]={-354.4, -1831.65, 22.2320},
[16]={-348.6, -2125.50, 28.3879},[17]={-174.6, -2413.64, 35.6235},[18]={-36.62, -2711.40, 42.0042},[19]={-315.0, -2800.08, 57.5757},[20]={-757.3, -2764.34, 74.7090},
[21]={-1141, -2850.020, 67.7570},[22]={-1569, -2742.080, 48.5795},[23]={-1966, -2547.510, 38.2349},[24]={-2191, -2370.410, 30.5065},[25]={-2212, -2264.740, 30.5055},
[26]={-2102, -2078.130, 63.1302},[27]={-1820, -1726.650, 29.1070},[28]={-1400, -1648.350, 45.1570},[29]={-1144, -1899.890, 77.5020},[30]={-802.3, -1785.11, 92.2070},
[31]={-758.6, -1454.05, 87.8020},[32]={-652.7, -1420.18, 90.4095},[33]={-572.8, -1070.35, 23.5500},[34]={-372.0, -823.054, 28.4015},[35]={-189.6, -938.291, 35.3530},
[36]={-55.70, -858.507, 13.7823},[37]={-113.0, -402.609, 1.10380},[38]={-221.9, 187.8397, 8.88888},[39]={-63.88, 551.1700, 9.22222},[40]={323.85, 753.2600, 6.15222},
[41]={740.54, 657.1210, 10.7505},[42]={1099.8, 803.8835, 10.7070},[43]={1556.6, 831.4191, 6.80807},[44]={1785.1, 798.4346, 11.2008},[45]={1605.7, 116.6938, 37.2020},
[46]={1701.3, -644.311, 41.8010},[47]={1635.6, -884.206, 52.5121},[48]={1798.2, -1037.61, 39.4545},[49]={2223.8, -1137.70, 25.6588},[50]={2269.0, -1209.68, 23.9119},
[51]={2196.8, -1382.42, 23.8575},[52]={2110.5, -1427.29, 23.8566},[53]={2002.0, -1459.51, 13.4255},[54]={1842.8, -1508.62, 13.3936},[55]={1819.2, -1865.68, 13.4469},
[56]={1779.7, -1917.97, 13.4165},[57]={1811.2, -1890.22, 13.4372},[58]={1798.6, -1830.07, 13.4257},[59]={1680.3, -1859.67, 13.4131},[60]={1468.2, -1869.85, 13.4074},]]
}
function getNewBusLocation(thePlayer, ID)
local x, y, z = Lixeriotabela[ID][1], Lixeriotabela[ID][2], Lixeriotabela[ID][3]
triggerClientEvent(thePlayer,"Lixeiro_Localizacao",thePlayer,x,y,z)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Lixeiro(thePlayer)
	local theVehicle = getPedOccupiedVehicle (thePlayer)
	local id = getElementModel(theVehicle)
	if id == 408 then
		local x, y, z = getNewBusLocation(thePlayer, 1)
		setElementData(thePlayer,"lixeiro",0)
		setElementData(thePlayer,"lixeirodata",1)
	else
	end
end
addEventHandler("onVehicleEnter",rootElement,Lixeiro)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
addEvent("lixeiro_concluiu",true)
addEventHandler("lixeiro_concluiu",rootElement,
function (client)
if not isPedInVehicle(client) then return end
if not lixeirotruck[getElementModel(getPedOccupiedVehicle(client))] then return end
local zarp = getElementData(client, "lixeiro")
local money = math.random(1000,5000)
setElementData(client, "lixeiro", zarp + money)
if #Lixeriotabela == tonumber(getElementData(client,"lixeirodata")) then
setElementData(client,"lixeirodata",1)
else
setElementData(client,"lixeirodata",tonumber(getElementData(client,"lixeirodata"))+1)
end
getNewBusLocation(client, tonumber(getElementData(client,"lixeirodata")))
end)
-----------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function SaiuDoVeiculo (source)
if getElementData (source, "LixeiroBVH", true) then
outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Trabalho cancelado, você saiu do veiculo.",source,255,255,255,true)
setPlayerTeam ( source, nil )
setTimer(Destruir, 1500, 1, source)
triggerClientEvent ( source, "SaiuVeiculoDX3", source )
setMarkerColor(entrega,0,0,255, 0)
setElementData(source, "CanceloTrab3", false)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH2", false)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH", false)
setTimer (setElementData, 1000, 1, source, "CanceloTrab3", false)
triggerClientEvent(source, "removeblip", source)
if blip2[source] and isElement(blip2[source]) then
	destroyElement(blip2[source]);
	blip2[source] = nil
end
end
end
addEventHandler ( "onVehicleExit", getRootElement(), SaiuDoVeiculo )
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--[[function teste (source)
if getElementData (source, "LixeiroBVH", true) then
outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Volte para o veiculo em 10 segundos.",source,255,255,255,true)
lixeiro = setTimer ( SaiuDoVeiculo, 10000, 1, source)
end
end
addEventHandler ( "onVehicleExit", getRootElement(), teste )
function teste2 (source)
if getElementData (source, "LixeiroBVH", true) then
killTimer(lixeiro)
end
end
addEventHandler ( "onVehicleEnter", getRootElement(), teste2 )]]
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
local dinheiro = {25000, 27000, 30000, 35000, 37000, 40000, 45000, 47000, 50000, 55000, 57000, 60000}
function EnregouCarga(source)
local theVehicle = getPedOccupiedVehicle (source)
local id = getElementModel(theVehicle)
if id == 408  then
if getElementData (source, "LixeiroBVH2", true) then
local dim = math.random(25000,80000)
givePlayerMoney (source,dim)
setTimer(Destruir, 500, 1, source)
outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Você concluiu o trabalho e recebeu #00FF00R$#bebebe"..dim.."#bebebe.",source,255,255,255,true)
--outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Concluiu o trabalho e ganhou #00FF00R$#bebebe"..dim.."#bebebe.",getRootElement(),255,255,255,true)
onClientCrapBox2(source, "info", "#FC9502LIXEIRO#FFFFFF : "..getPlayerName(source).." #FFFFFFrecebeu #00FF00R$#ffffff"..dim..".")
triggerClientEvent ( source, "RecompensaDX3", source )
setTimer (setElementData, 1000, 1, source, "LixeiroBVH2", false)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH", false)
setTimer (setElementData, 1000, 1, source, "CanceloTrab3", false)
triggerClientEvent(source, "removeblip", source)
setPlayerTeam ( source, nil )
setMarkerColor(entrega,0,0,255, 0)
if blip2[source] and isElement(blip2[source]) then
	destroyElement(blip2[source]);
	blip2[source] = nil
end
end
end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
local showmarker = createMarker(1805.8029785156, -1580.4243164063, 13.47766494751, "cylinder", 5, 0, 255, 0, 0)
function EnregouCarga2(source)
local theVehicle = getPedOccupiedVehicle (source)
local id = getElementModel(theVehicle)
if id == 408  then
if getElementData (source, "LixeiroBVH", true) then
setMarkerColor(entrega,252,149,2, 255)
setElementData(source, "LixeiroBVH2", true)
setElementData(source, "lixeiro", 0)
blip2[source] = createBlip( 0, 0, 0, 19, 0, 0, 0, 255 )
attachElements (blip2[source], entrega)
setMarkerColor(entrega,0,0,255, 255)
setBlipVisibleDistance(blip2[source], 180)
triggerClientEvent(source, "removeblip", source)
setElementVisibleTo (blip2[source], root, false )
for k, v in ipairs(getPlayersInTeam(getTeamFromName ("LIXEIRO"))) do
setElementVisibleTo (blip2[source], v, true)
addEventHandler("onMarkerHit", entrega, EnregouCarga)
end
end
end
end
addEventHandler("onMarkerHit", showmarker, EnregouCarga2)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function CanceloTrab ()
if getElementData (source, "LixeiroBVH", true) then
outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Trabalho cancelado.",source,255,255,255,true)
setPlayerTeam ( source, nil )
setTimer(Destruir, 1500, 1, source)
triggerClientEvent ( source, "CanceloTrabDX3", source )
setElementData(source, "CanceloTrab3", false)
setMarkerColor(entrega,0,0,255, 0)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH2", false)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH", false)
setTimer (setElementData, 1000, 1, source, "CanceloTrab3", false)
triggerClientEvent(source, "removeblip", source)
if blip2[source] and isElement(blip2[source]) then
	destroyElement(blip2[source]);
	blip2[source] = nil
end
end
end
addEvent("CanceloTrab3",true)
addEventHandler("CanceloTrab3",root,CanceloTrab)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function trafico ()
traf = createTeam ( "LIXEIRO", 252, 149, 2 )
end
addEventHandler("onResourceStart", resourceRoot, trafico)  
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function AceitoTraf ()
setPlayerTeam ( source, traf )
setPedSkin(source,137)
end
addEvent("aceitoLixeiro",true)
addEventHandler("aceitoLixeiro",root,AceitoTraf)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function traficantemorreu()
if getElementData (source, "LixeiroBVH", true) then
outputChatBox ( "#FFFFFF✗ #FC9502LIXEIRO#FFFFFF ✗ #bebebe: "..getPlayerName(source).."#bebebe - Você morreu, o trabalho foi cancelado#bebebe.",source,255,255,255,true)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH", false)
setPlayerTeam ( source, nil )
setTimer(Destruir, 1000, 1, source)
setMarkerColor(entrega,0,0,255, 0)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH2", false)
setTimer (setElementData, 1000, 1, source, "LixeiroBVH", false)
setTimer (setElementData, 1000, 1, source, "CanceloTrab3", false)
triggerClientEvent(source, "removeblip", source)
if blip2[source] and isElement(blip2[source]) then
	destroyElement(blip2[source]);
	blip2[source] = nil
end
end
end
addEventHandler ("onPlayerWasted", root, traficantemorreu )
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function destruirblip()
if getElementData (source, "LixeiroBVH", true) then
if blip2[source] and isElement(blip2[source]) then
	destroyElement(blip2[source]);
	blip2[source] = nil
end
end
end
--addEventHandler("onPlayerQuit",root,destruirblip)
--addEventHandler("onPlayerLogout",root,destruirblip)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Restart ()
    local they = getResourceFromName ( "[Scr]Trabalho-lixeiro" )
    if getResourceFromName then
    restartResource(they)
end
end
--setTimer ( Restart, 2200000, 0, getRootElement() )
--------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------