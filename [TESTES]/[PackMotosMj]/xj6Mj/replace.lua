txd = engineLoadTXD("521.txd")
engineImportTXD(txd,521)
dff = engineLoadDFF("521.dff",521)
engineReplaceModel(dff,521)



