addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD("479.txd")
engineImportTXD(txd, 479) 
dff = engineLoadDFF("479.dff", 479)
engineReplaceModel(dff, 479)
end)