function Loja ()
Lojatxd = engineLoadTXD ( "8326.txd" )
engineImportTXD ( Lojatxd, 8326 )

end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Loja )