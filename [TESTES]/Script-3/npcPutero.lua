striper1 = createPed(178,1223.40234375,-7.583984375,1001.328125,85.735900878906)
striper2 = createPed(246,1215.7353515625,-6.4140625,1001.328125,257.00436401367)
striper3 = createPed(244,1208.2802734375,-6.505859375,1001.328125,5.9739074707031)
setPedAnimation(striper1,"STRIP","STR_loop_A",0,true)
setElementInterior(striper1,2)
setPedAnimation(striper2,"STRIP","STR_loop_A",0,true)
setElementInterior(striper2,2)
setPedAnimation(striper3,"STRIP","STR_loop_A",0,true)
setElementInterior(striper3,2)
atendente = createPed(11,1215.279296875,-15.2666015625,1000.921,358.45364379883)
setElementInterior ( atendente, 2 )
setPedFrozen ( atendente, true )



function cancelarPedDano() 
    cancelEvent() 
end 
addEventHandler("onClientPedDamage", atendente, cancelarPedDano)  

vidro1 = createObject(3858,1221.09765625,-9.5609375,1001.328125,0,0,40)
vidro2 = createObject(3858,1219.09765625,-4.0517578125,1001.328125,0,0,50)
vidro3 = createObject(3851,1213.979296875,-6.5244140625,1000.921875,90,0,20)

vidro4 = createObject(1649,1209.2880859375,-6.3388671875,1001.328125,0,0,268.72692871094)
vidro5 = createObject(1649,1208.240234375,-4.4853515625,1001.328125,0,90,1.2991638183594)
vidro6 = createObject(1649,1206.4443359375,-6.498046875,1000.921875,0,0,271.30328369141)
vidro7 = createObject(1649,1208.23046875,-8.4697265625,1001.328125,0,90,176.87432861328)

seguranca1 = createPed(111,1219.109375,2.662109375,1000.921875,177.19293212891)
setElementInterior(seguranca1,2)
setPedAnimation(seguranca1,"BAR","Barserve_give")
seguranca2 = createPed(112,1216.1044921875,0.134765625,1000.921875,97.348571777344)
setElementInterior(seguranca2,2)

