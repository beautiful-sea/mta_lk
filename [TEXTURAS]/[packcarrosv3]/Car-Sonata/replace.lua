txd = engineLoadTXD("585.txd")
engineImportTXD(txd, 585)
dff = engineLoadDFF("585.dff",585)
engineReplaceModel(dff,585)



