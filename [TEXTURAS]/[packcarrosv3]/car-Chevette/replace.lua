txd = engineLoadTXD("401.txd")
engineImportTXD(txd, 401)
dff = engineLoadDFF("401.dff", 401)
engineReplaceModel(dff, 401)



