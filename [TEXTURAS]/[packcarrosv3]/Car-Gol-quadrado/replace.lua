txd = engineLoadTXD("436.txd")
engineImportTXD(txd, 436)
dff = engineLoadDFF("436.dff", 436)
engineReplaceModel(dff, 436)
