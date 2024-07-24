-- lua/kaineer/types.lua
--
-- check object type

local types = {}

function types.fn(obj)
  return type(obj) == "function"
end

function types.number(obj)
  return type(obj) == "number"
end

function types.string(obj)
  return type(obj) == "string"
end

function types.none(obj)
  return type(obj) == "nil"
end

function types.boolean(obj)
  return type(obj) == "boolean"
end

function types.table(obj)
  return type(obj) == "table"
end

return types
