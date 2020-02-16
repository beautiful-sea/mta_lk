janela = guiCreateWindow(517, 223, 295, 129, "Parque automotivo DETRAN", false)
guiWindowSetSizable(janela, false)
guiSetVisible(janela, false)
btn_abrir = guiCreateButton(166, 49, 113, 47, "ABRIR PORTÃO", false, janela)
btn_fechar = guiCreateButton(17, 50, 113, 46, "FECHAR PORTAO", false, janela)  

markerPortao = createMarker ( 1144.1916796875,-1290.8447265625,13.607897 ,"cylinder", 6.0,  0, 0, 255,  255)
setElementAlpha(markerPortao,0)

function abrirMenuPortao(thePlayer)
	if(thePlayer == getLocalPlayer()) then
		guiSetVisible(janela, true)
		showCursor( true)
	end
end

addEventHandler("onClientMarkerHit",markerPortao, abrirMenuPortao)
addEventHandler("onClientGUIClick",btn_abrir, function() 
	triggerServerEvent ( "abrirPortao", resourceRoot) 
	guiSetVisible(janela, false)
	showCursor( false)
end)
addEventHandler("onClientGUIClick",btn_fechar, function()
	triggerServerEvent ( "fecharPortao", resourceRoot )
	guiSetVisible(janela, false)
	showCursor( false)
end)