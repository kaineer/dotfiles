local M = {}

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

return M
