function replaceModel()


-- http://top-mods-mta-br.blogspot.com/ --



col_lombada = engineLoadCOL ( "data/lombada.col" )
engineReplaceCOL ( col_lombada, 1900 )



txd_lombada = engineLoadTXD ( "data/lombada.txd" )
engineImportTXD ( txd_lombada, 1900 )



dff_lombada = engineLoadDFF ( "data/lombada.dff", 1900 )
engineReplaceModel ( dff_lombada, 1900 )



end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ( "reloadcar", replaceModel )