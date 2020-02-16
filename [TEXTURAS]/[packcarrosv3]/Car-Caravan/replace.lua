txd = engineLoadTXD("540.txd")
engineImportTXD(txd, 540)
dff = engineLoadDFF("540.dff", 540)
engineReplaceModel(dff, 540)



