addEventHandler( "onClientElementDataChange", getResourceRootElement( ),
	function( name )
		if name == "door:closed" then
			setElementFrozen( source, getElementData( source, name ) )
		end
	end
)

addEventHandler( "onClientResourceStart", getResourceRootElement( ),
	function( )
		for key, value in pairs( getElementsByType( "object" ) ) do
			setElementFrozen( value, getElementData( value, "door:closed" ) )
		end
	end
)