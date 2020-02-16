function createTheGate ()
 
         myGate1 = createObject ( 16773, 1206.2998046875, -1480, 14.699999809265 , 0, 0, 90 )

 
      end
 
      addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate )
 
 
 
 
 
 function openMyGate ( )
 moveObject ( myGate1, 2500, 1206.3000488281, -1480, 8.6000003814697 )
 end
 addCommandHandler("TenorioL",openMyGate)
 
 
 function movingMyGateBack ()
 moveObject ( myGate1, 2500, 1206.2998046875, -1480, 14.699999809265 )
 end
 addCommandHandler("SnackM",movingMyGateBack) 