
--Marcador do DJ
	markerDJ = createMarker ( 2445.8720703125,-779.181640625,124.75536346436, "cylinder", 2, 0, 255, 255, 255)
	setElementAlpha(markerDJ,30)
	musicas  = {"mano_chega_ai","baile-de-favela",'ser-ou-nao-ser','auto-incentivo'}
	tocando  = nil
	janela_dj = guiCreateWindow(260, 216, 450, 193, "DJ", false)
	guiSetVisible(janela_dj,false)
	guiWindowSetSizable(janela_dj, false)
	escolher_musica_label = guiCreateLabel(9, 26, 286, 38, "Escolha uma música:", false, janela_dj)
	guiSetFont(escolher_musica_label, "default-bold-small")
	scrollpane = guiCreateScrollPane(11, 70, 394, 65, false, janela_dj)

	combobox = guiCreateComboBox(1, 60, 383, 23, "Nenhuma música selecionada", false,janela_dj)
	width = guiGetSize ( combobox, false )
	guiSetSize ( combobox, width, ( 3 * 20 ) + 20, false )

	for i=1,#musicas do
		guiComboBoxAddItem ( combobox, musicas[i]..".mp3" )
	end

	btn_tocar = guiCreateButton(343, 149, 97, 34, "Tocar", false, janela_dj)
	btn_sair = guiCreateButton(9, 152, 84, 31, "Sair", false, janela_dj)
	btn_pausar = guiCreateButton(235, 149, 97, 34, "Pausar", false, janela_dj)

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

	function tocarMusica()
		index_musica = guiComboBoxGetSelected (combobox )
		musica = guiComboBoxGetItemText(combobox, index_musica)
		if(tocando) then
			stopSound( tocando )
		end
		tocando = playSound3D("dj-system/musicas/"..musica,2442.7138671875,-778.412109375,125.7553634643)
	end

	function pausarMusica()
		if(tocando) then stopSound( tocando ) end
		tocando = nil
	end
	addEventHandler( "onClientMarkerHit", markerDJ, abrirPainelDJ )
	addEventHandler( "onClientGUIClick", btn_sair, fecharPainelDJ )
	addEventHandler( "onClientGUIClick", btn_tocar, tocarMusica )
	addEventHandler( "onClientGUIClick", btn_pausar, pausarMusica )




