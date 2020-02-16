function newNames(modelId)
	a = {}
	a[481] = "BMX"
	a[586] = "Biz"
	a[462] = "Pop"
	a[461] = "CB 600"
	a[521] = "XJ6" 
	a[468] = "Xt660" 
	a[581] = "CB 1000" 

	a[522] = "S1000" 
	a[463] = "Harley" 
	a[545] = "Fusca" 
	a[436] = "Gol Quadrado" 

	a[405] = "Gol G4" 

	a[401] = "Chevette"
	a[551] = "Uno" 
	a[529] = "Monza" 
	a[479] = "Gol G5" 

	a[516] = "HB20" 
	a[547] = "BMW M5" 

	a[560] = "BMW M7" 

	a[439] = "BMW Z4" 

	a[445] = "Audi S6" 

	a[589] = "Audi S8" 

	a[492] = "Audi Q7" 

	a[400] = "Range Rover" 

	a[496] = "Punto" 
	a[580] = "Lance EVO" 

	a[600] = "Saveiro Paredao" 

	a[579] = "Hilux" 
	a[550] = "S10" 
	a[527] = "Bugatti Veyron" 

	if not a[modelId] then return getVehicleNameFromModel(modelId)end

	return a[modelId]
end