col = engineLoadCOL("quadro.col")
engineReplaceCOL (col , 943)
txd = engineLoadTXD("quadro.txd")
engineImportTXD(txd , 943) 
dff = engineLoadDFF("quadro.dff")
engineReplaceModel(dff , 943)
