txd = engineLoadTXD("placa.txd")
engineImportTXD(txd,2681)
col = engineLoadCOL("placa.col")
engineReplaceCOL(col,2681)
dff = engineLoadDFF("placa.dff",2681)
engineReplaceModel(dff,2681)

createObject(2681,2556.1689453125,-947.728515625,85.20206451416,0,0,271.48455810547)