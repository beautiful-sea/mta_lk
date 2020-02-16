local super = Class("Database", LuaObject, function()
	static.getInstance = function()
		return LuaObject.getSingleton(static)
	end

end).getSuperclass()

function Database:init()
	super.init(self)
	self.connection = Connection("sqlite", "database.db")
	if(self.connection) then
		outputDebugString('Banco de dados conectado com sucesso')

	else
		outputDebugString('Banco de dados falhou para se conectar, utilizando banco de dados de backup.')
	end

	return self
end


function Database:getConnection ()
    return self.connection
end

function Database:isConnected()
	return isElement(self.connection)
end

function Database:queryAsync(call, arguments, query, ...)
	if not (self:isConnected()) then 
		return false
	end

    return self.connection:query(function(handle, arguments) call(handle:poll(0) or handle:free(), arguments) end, arguments, query, ...)
end

function Database:query(query, ...)
	if not (query) or not (self:isConnected()) then
		return false
	end

	local qh = self.connection:query(query, ...)
	if (qh) then
		return qh:poll(-1)
	end

	return false
end

function Database:execute(...)
	if not (self:isConnected()) then 
		return false
	end

    return self.connection:exec(...) 
end

function Query (query, ...)
    return Database.getInstance():query(query,...)
end

function Exec (...)
    return Database.getInstance():execute(...)
end

function getConnection ()
    return Database.getInstance():getConnection()
end

function isConnected ()
    return Database.getInstance():isConnected()
end



addEventHandler("onResourceStart", resourceRoot,
function ()
	Database.getInstance()
end)