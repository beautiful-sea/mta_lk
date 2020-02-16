
janela_senha_portao = guiCreateWindow(727, 331, 266, 62, "DIGITE A SENHA:", false)
guiWindowSetSizable(janela_senha_portao, false)
guiSetVisible(janela_senha_portao, false)

btn_ir = guiCreateButton(176, 24, 80, 28, "IR", false, janela_senha_portao)
campo_senha_portao = guiCreateEdit(11, 26, 155, 26, "", false, janela_senha_portao)   

markerPortao = createMarker ( 2425.9873046875,-788.5224609375,125.75536 ,"cylinder", 2.0,  0, 0, 255,  255)
setElementAlpha(markerPortao,0)

function solicitarSenha(thePlayer)
	if getLocalPlayer() == thePlayer then
		guiSetVisible(janela_senha_portao, true)
		showCursor( true)
	end
end

addEventHandler("onClientMarkerHit",markerPortao, solicitarSenha)
addEventHandler("onClientGUIClick",btn_ir, function() 
	guiSetVisible(janela_senha_portao, false)
	showCursor( false)
	triggerServerEvent ( "abrirPortao", resourceRoot,guiGetText(campo_senha_portao))
	guiSetText(campo_senha_portao,"") 
end)
