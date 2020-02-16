 local modelss = {
	{"models/lamp.col","models/lamp.dff","models/lamp.txd",1897,"metal"},
    {"models/fountain.col","models/fountain.dff","models/fountain.txd",1904,"whttile"},
 	{"models/1_lamp.col","models/1_lamp.dff","models/window.txd",1910,"metal"},
 	{"models/tvled.col","models/tvled.dff","models/tvled.txd",1877,"metal"},
 	{"models/newtree.col","models/newtree.dff","models/newtree.txd",1953,"none"}, --PADRAO
 	

 	 }

 
for p = 1,#modelss do
		txd=engineLoadTXD ( tostring(modelss[p][3]))
		engineImportTXD ( txd, tonumber(modelss[p][4]) )
		
		dff=engineLoadDFF ( tostring(modelss[p][2]), tonumber(modelss[p][4]) )
		engineReplaceModel ( dff, tonumber(modelss[p][4]) )
		
		col = engineLoadCOL ( tostring(modelss[p][1]))
		engineReplaceCOL ( col, tonumber(modelss[p][4]))
		
		engineSetModelLODDistance(tonumber(modelss[p][4]), 20000)
		

end	   
