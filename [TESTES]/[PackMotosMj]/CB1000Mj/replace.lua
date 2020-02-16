txd = engineLoadTXD("581.txd")
engineImportTXD(txd, 581)
dff = engineLoadDFF("581.dff", 581)
engineReplaceModel(dff, 581)



