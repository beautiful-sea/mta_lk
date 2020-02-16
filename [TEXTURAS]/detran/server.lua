portao = createObject(971,1144.1916796875,-1290.8447265625,12.4607897)
setObjectScale ( portao,1.14)




function abrirPortao()
	moveObject(portao,8000,1144.1916796875,-1290.8447265625,7.407897)

end

function fecharPortao()
	moveObject(portao,8000,1144.1916796875,-1290.8447265625,12.4607897)
end


addEvent( "abrirPortao", true )
addEventHandler( "abrirPortao", resourceRoot, abrirPortao )

addEvent( "fecharPortao", true )
addEventHandler( "fecharPortao", resourceRoot, fecharPortao )