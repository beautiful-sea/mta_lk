txd = engineLoadTXD("402.txd")
engineImportTXD(txd, 402)
dff = engineLoadDFF("402.dff", 402)
engineReplaceModel(dff, 402)

