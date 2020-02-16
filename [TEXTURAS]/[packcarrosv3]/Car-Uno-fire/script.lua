-- mods-mta.blogspot.com

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function () 
txd = engineLoadTXD ( 'merit.txd' ) 
engineImportTXD ( txd, 551 ) 
dff = engineLoadDFF('merit.dff', 551) 
engineReplaceModel ( dff, 551 )
end)
