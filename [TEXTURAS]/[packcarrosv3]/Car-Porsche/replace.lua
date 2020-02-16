txd = engineLoadTXD("Porsche.txd")
engineImportTXD(txd, 480)
dff = engineLoadDFF("Porsche.dff", 480)
engineReplaceModel(dff, 480)

-- generated with http://mta.dzek.eu/