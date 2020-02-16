-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( '550.txd' ) 
engineImportTXD( txd, 550 ) 
dff = engineLoadDFF('550.dff', 550) 
engineReplaceModel( dff, 550 )
end)
