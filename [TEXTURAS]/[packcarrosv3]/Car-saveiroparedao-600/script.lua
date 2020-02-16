-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'picador.txd' ) 
engineImportTXD( txd, 600 ) 
dff = engineLoadDFF('picador.dff', 600) 
engineReplaceModel( dff, 600 )
end)
