-- core/types.lua

-- check argument type

local hasType = function(typeName)
	return function(obj)
		return type(obj) == typeName
	end
end

return {
	fn = hasType("function"),
	boolean = hasType("boolean"),
	number = hasType("number"),
	string = hasType("string"),
	table = hasType("table"),
	none = hasType("nil"),
}
