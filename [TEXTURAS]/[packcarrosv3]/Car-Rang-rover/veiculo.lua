addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	txd = engineLoadTXD ( "400.txd" )
	engineImportTXD ( txd, 400 )
        
	dff = engineLoadDFF ( "400.dff", 400 )
        engineReplaceModel ( dff, 400 )
end 
)