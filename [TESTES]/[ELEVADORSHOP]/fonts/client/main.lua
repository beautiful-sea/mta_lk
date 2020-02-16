
Fonts = {}
Fonts.__index = Fonts
Fonts.font = {}

function createFont(name,size,bold)
	local b = bold and "_" or ""
	if not Fonts.font[name..size..b] then
		Fonts.font[name..size..b] = dxCreateFont("gfx/"..name..".ttf",size,bold)
	end
	return Fonts.font[name..size..b]
end


--[[
function Fonts.create()
	local self = {}
	setmetatable(self, Fonts)
	return self
end

function Fonts:fileName(str)
	local result = ""
	for i = 1, (4 - string.len(str)) do
		result = result .. string.char(48)
	end
	return result .. str
end

-- returns table
function Fonts:getSplitStr(str, font)
	local tbl = {}
	local charTbl = {}
	if (str ~= "") then
		for i = 1, string.len(str) do
			-- get ASCII codes and create path
			table.insert(tbl,"gfx/"..font.."/"..self:fileName(string.byte(string.sub(str, i, i))) ..".png")
			table.insert(charTbl, self:fileName(string.byte(string.sub(str, i, i))))
		end
	end
	return tbl, charTbl
end

--]]