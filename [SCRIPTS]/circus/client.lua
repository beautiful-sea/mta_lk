function stopfire()
	 toggleControl ( "fire", false )
end
addEvent("stopfire",true)
addEventHandler("stopfire",getRootElement(),stopfire)

function startfire()
	 toggleControl ( "fire", true )
end
addEvent("startfire",true)
addEventHandler("startfire",getRootElement(),startfire)