-- lua/kaineer/fn.lua
-- Functions to work with tables

local types = require("kaineer.types")
local M = {}

-- For each table element
--
-- 1. forEach({}, fn)
-- 2. forEach({})(fn)
function M.forEach(tbl, cb)
  local fn = function(lcb)
    for _, item in ipairs(tbl) do
      lcb(item)
    end

    return tbl
  end

  if types.fn(cb) then
    return fn(cb)
  else
    return fn
  end
end

-- for each entry (with a key)
function M.forEachEntry(tbl, cb)
  local fn = function(lcb)
    for key, item in pairs(tbl) do
      lcb(item, key)
    end

    return tbl
  end

  if types.fn(cb) then
    return fn(cb)
  else
    return fn
  end
end

function M.tap(obj, fn)
  fn(obj)
  return obj
end

function M.map(tbl, fn)
  local result = {}
  for i, v in ipairs(tbl) do
    table.insert(result, fn(v, i))
  end
  return result
end

function M.assign(target, source)
  for key, value in pairs(source) do
    target[key] = value
  end
end

function M.merge(target, source)
  local result = {}
  for key, value in pairs(target) do
    result[key] = value
  end
  M.assign(result, source)
  return result
end

function M.prefix(pre, table)
  return M.map(table, function(value)
    return pre .. value
  end)
end

function M.rqtap(paths, fn)
  local objtab = {}
  for i, v in ipairs(paths) do
    objtab.insert(require(v))
  end
  return fn(objtab)
end

return M
