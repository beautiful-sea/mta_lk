
txd = engineLoadTXD("caixam.txd")
engineImportTXD(txd,1355)
col = engineLoadCOL("caixam.col")
engineReplaceCOL(col,1355)
dff = engineLoadDFF("caixam.dff",1355)
engineReplaceModel(dff,1355)

