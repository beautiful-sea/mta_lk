txd = engineLoadTXD("522.txd")
engineImportTXD(txd, 522)
dff = engineLoadDFF("522.dff", 522)
engineReplaceModel(dff, 522)



