function replaceModel()
txd_palco = engineLoadTXD ( "glenpark6_lae.txd" )
engineImportTXD ( txd_palco, 5463 )


end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ( "recarregar", replaceModel )