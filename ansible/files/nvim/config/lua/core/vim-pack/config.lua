local applyConfig = function(path)
  local config = require(path)
  local urls = config.urls

  local map = require("core.utils").map
  local pkgs = map(urls, function(url)
    return { src = url }
  end)

  vim.pack.add(pkgs)

  local is = require("core.types")
  if is.fn(config.setup) then
    config.setup()
  end
end

return function(tbl)
  local each = require("core.utils").each
  each(tbl, applyConfig)
end
