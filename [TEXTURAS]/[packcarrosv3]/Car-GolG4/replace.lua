txd = engineLoadTXD("405.txd")
engineImportTXD(txd, 405)
dff = engineLoadDFF("405.dff", 405)
engineReplaceModel(dff, 405)

-- generated with http://mta.dzek.metal.info/