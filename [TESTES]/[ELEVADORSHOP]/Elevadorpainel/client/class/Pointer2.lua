--[[----------------------------------------------------
-- client class Pointer
-- @author Banex
-- @update 30/05/2015 
----------------------------------------------------]]-- 

Pointer = {}
Pointer.__index = Pointer
Pointer.instances = {}
Pointer.CIRCLE = dxCreateTexture("gfx/circle.png","dxt3")
Pointer.ICON = dxCreateTexture("gfx/icon.png","dxt3")
Pointer.RENDERT = dxCreateRenderTarget(1024, 1024, true)
Pointer.RENDERT2 = dxCreateRenderTarget(1024, 1024, true)

function Pointer.create(posX,posY,posZ)
	local self = setmetatable({}, Pointer)
	self.x = posX
	self.y = posY
	self.z = posZ
	self.size = 2
	self.color = {255,255,255,255}
	self.marker = createMarker(posX,posY,posZ,"cylinder",2.2,0,0,0,0)
	
	if(#Pointer.instances == 0) then
		addEventHandler("onClientRender", getRootElement(), Pointer.render)
	end
	
	table.insert(Pointer.instances, self)
	return self
	
end

function Pointer.onStreamIn()
	for k,self in pairs(Pointer.instances) do
		if source == self.marker then
			self:setVisible(true)
			return
		end
	end
end
addEventHandler('onClientElementStreamIn', resourceRoot,Pointer.onStreamIn)

function Pointer.onStreamOut()
		for k,self in pairs(Pointer.instances) do
		if source == self.marker then
			self:setVisible(false)
			return
		end
	end
end
addEventHandler('onClientElementStreamOut', resourceRoot,Pointer.onStreamOut)

function Pointer.onClientMarkerHit(player,matchingDimension)
	for k,self in pairs(Pointer.instances) do
		if source == self.marker and self.onHit and player == localPlayer and matchingDimension then
			self:onHit()
			return
		end
	end
end
addEventHandler('onClientMarkerHit', resourceRoot,Pointer.onClientMarkerHit)


function Pointer.onClientMarkerLeave(player,matchingDimension)
	for k,self in pairs(Pointer.instances) do
		if source == self.marker and self.onLeave and player == localPlayer and matchingDimension then
			self:onLeave()
			return
		end
	end
end
addEventHandler('onClientMarkerLeave', resourceRoot,Pointer.onClientMarkerLeave)


function Pointer:destroy()
	for k, v in pairs(Pointer.instances) do
		if ( v == self ) then
			table.remove(Pointer.instances, k)
			if(#Pointer.instances == 0) then
				removeEventHandler("onClientRender", getRootElement(), Pointer.render)
			end
			return true
		end
	end
	return false
end

function Pointer:setVisible(bool)
	self.visible = bool
	return true
end

function Pointer:setPosition(posX,posY,posZ)
	setElementPosition(self.marker,posX,posY,posZ)
	self.x = posX
	self.y = posY
	self.z = posZ
	return true
end

function Pointer:getPosition()
	return self.x, self.y, self.z
end

function Pointer:setColor(r,g,b,a)
	self.color = {r,g,b,a}
	return true
end

function Pointer:getColor()
	return self.color
end

function Pointer:setSize(value)
	self.size = value
	return true
end

function Pointer:draw()
	if self.visible then
		local camX, camY, camZ = getCameraMatrix()
		local scX, scY = getScreenFromWorldPosition(self.x, self.y, self.z+2.2,0,false)
		local sX, sY = guiGetScreenSize()
		local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
		local dist = getDistanceBetweenPoints3D(cx, cy, cz, self.x, self.y, self.z+2.2 )
		local sizeX,sizeY = 120,100

		dxDrawMaterialLine3D(self.x, self.y-self.size, self.z+0.15, self.x, self.y+self.size, self.z+0.15,Pointer.RENDERT, self.size*2, tocolor(unpack(self.color)), self.x, self.y, self.z+500000000)
		dxDrawMaterialLine3D(self.x, self.y-self.size, self.z+0.05, self.x, self.y+self.size, self.z+0.05,Pointer.RENDERT2, self.size*2,tocolor(unpack(self.color)), self.x, self.y, self.z+500000000)

		if scX then
			if(isLineOfSightClear(cx, cy, cz, self.x, self.y, self.z+2.2, true, true, false) ) then
				dxDrawImage(scX-(1000/dist)*sX/800/sizeX*cfov, scY-(100/dist)*sY/600/sizeY*cfov, (1000/dist)*sX/400/sizeX*cfov, (1000/dist)*sY/400/sizeY*cfov,Pointer.ICON, 0, 0, 0,tocolor(255,255,255,200*math.abs(getTickCount()%1000-5000)/5000))
			end
		end
	end
end

function Pointer.render()
	local width, height = dxGetMaterialSize(Pointer.CIRCLE)

	dxSetRenderTarget(Pointer.RENDERT, true)
	dxDrawImage(260, 260, width-260*2, height-260*2, Pointer.CIRCLE, getTickCount()/20%360,0,0,tocolor(255,255,255,220))
	dxSetRenderTarget()
		
	dxSetRenderTarget(Pointer.RENDERT2, true)
	dxDrawImage(0, 0, width, height, Pointer.CIRCLE, -getTickCount()/20%360,0,0,tocolor(255,255,255,220))
	dxSetRenderTarget()
	
	for k,v in pairs(Pointer.instances) do
		v:draw()
	end
end