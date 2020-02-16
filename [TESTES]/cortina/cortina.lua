
txd = engineLoadTXD("cortina.txd")
engineImportTXD(txd,18079)
dff = engineLoadDFF("cortina.dff",18079)
engineReplaceModel(dff,18079)
col = engineLoadCOL("cortina.col")
engineReplaceCOL(col,18097)