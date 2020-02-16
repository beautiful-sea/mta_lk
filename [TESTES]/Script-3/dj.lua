local markerDJ	=	createMarker(1210.8515625,2.740234375,1000.92187,"checkpoint",0.5, 0, 0,  0, 0)
setElementAlpha(markerDJ,150)
local preco_musica = 50
local musicas  = exports['musicasDJ']:getNomeMusicasNoDiretorio()
local tocando  = nil
local janela_dj = guiCreateWindow(260, 270, 450, 300, "DJ", false)
guiSetVisible(janela_dj,false)
guiWindowSetSizable(janela_dj, false)
local escolher_musica_label = guiCreateLabel(9, 26, 286, 38, "Escolha uma música:", false, janela_dj)
guiSetFont(escolher_musica_label, "default-bold-small")
local scrollpane = guiCreateScrollPane(11, 70, 394, 80, false, janela_dj)
local label_valor_info = guiCreateLabel ( 9, 180, 286, 38, "Preço: ",false,janela_dj )
local separador = guiCreateLabel ( 9, 185, 450, 38, "____________________________________________________________________________________________________________________________ ",false,janela_dj )
local label_valor = guiCreateLabel ( 380, 180, 286, 38, "R$50,00 ",false,janela_dj )
local combobox = guiCreateComboBox(1, 60, 383, 60, "Nenhuma música selecionada", false,janela_dj)
local width = guiGetSize ( combobox, false )
guiSetSize ( combobox, width, ( 3 * 20 ) + 20, false )
no_interior = false

for i=1,#musicas do
	guiComboBoxAddItem ( combobox, musicas[i]..".mp3" )
end

btn_tocar = guiCreateButton(343, 250, 97, 64, "Tocar", false, janela_dj)
btn_sair = guiCreateButton(9, 250, 84, 64, "Sair", false, janela_dj)
btn_pausar = guiCreateButton(235, 250, 97, 64, "Pausar", false, janela_dj)

mesa = createObject(2762,1210.724609375,3.644921875,1000.321875,0,0,180.3961730957)
setElementInterior ( mesa, 2 )
ddj = createObject(14820,1210.8080078125,3.5119140625,1000.8198730469,0,0,179.02838134766)
setElementInterior (ddj, 2)
dj = createPed(142,1210.740234375,4.662109375,1000.921875,184.88900756836) 
setElementInterior(dj,2)


function cancelarPedDano() 
	cancelEvent() 
end 
addEventHandler("onClientPedDamage", dj, cancelarPedDano)  

setElementFrozen(dj,true)



function abrirPainelDJ(thePlayer)
	if(thePlayer == getLocalPlayer())then
		guiSetVisible(janela_dj,true)
		showCursor( true )
	end
end

function fecharPainelDJ(thePlayer)
	guiSetVisible(janela_dj,false)
	showCursor( false )
end

function tocarMusica(thePlayer)
	index_musica = guiComboBoxGetSelected (combobox )
	musica = guiComboBoxGetItemText(combobox, index_musica)

	if(musica == "Nenhuma música selecionada") then return end
	
	if(tocando) then
		stopSound( tocando )
	end
	
	if (tonumber(getElementData(getLocalPlayer(),"money"))>=preco_musica)then
		tocando = playSound3D(":musicasDJ/musicas/"..musica,1214.7333984375,-5.048828125,1001.32,false,false)

		setElementData(getLocalPlayer(),"money",tonumber(getElementData(getLocalPlayer(),"money"))-preco_musica)
		setPlayerMoney(tonumber(getElementData(getLocalPlayer(),"money"))-preco_musica)
		outputChatBox("#0cff00Você escolheu a faixa #FFFFFF"..musica.."#0cff00 para tocar na boate.\n Foi cobrado #FFFFFFR$50,00.",150,250,150,true)
	else
		outputChatBox("Não tem dinheiro então VAZA.",255,250,255,true)
	end
	
end

function pausarMusica()
	if(tocando) then stopSound( tocando ) end
	tocando = nil
end
toggleControl ( 'sprint ', false)
toggleControl ( 'jump ', true)

function jogadorEntrou()
	no_interior = true
	tocando = playSound3D(":musicasDJ/musicas/sexy.mp3",1214.7333984375,-5.048828125,1001.32,true,true)
end

function jogadorSaiu()
	no_interior = false
	stopSound( tocando )
	tocando = nil
end

addEvent("jogadorSaiu",true)
addEventHandler("jogadorSaiu", root, jogadorSaiu)  
addEvent("jogadorEntrou",true)
addEventHandler("jogadorEntrou", root, jogadorEntrou) 

addEventHandler( "onClientMarkerHit", markerDJ, abrirPainelDJ )
addEventHandler( "onClientGUIClick", btn_sair, fecharPainelDJ )
addEventHandler( "onClientGUIClick", btn_tocar, tocarMusica )
addEventHandler( "onClientGUIClick", btn_pausar, pausarMusica )

addEventHandler( "onClientKey", getRootElement(), function(button,press) 
	if (button == "lshift" or button == "rctrl" or button == "mouse1" or button == "lctrl") and no_interior == true then
		cancelEvent()
		return true
	end
	return false
end )