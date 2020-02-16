txd = engineLoadTXD("462.txd")
engineImportTXD(txd, 462)
dff = engineLoadDFF("462.dff", 462)
engineReplaceModel(dff, 462)



