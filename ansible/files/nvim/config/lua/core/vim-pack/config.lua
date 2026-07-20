local applyConfig = function(path)
  local is = require("core.types")

  local config = require(path)
  local urls = config.urls

  if not urls and is.string(config.url) then
    urls = { config.url }
  end

  local map = require("core.utils").map
  local pkgs = map(urls, function(url)
    return { src = url }
  end)

  vim.pack.add(pkgs)

  if is.fn(config.setup) then
    config.setup()
  end
end

return function(tbl)
  local each = require("core.utils").each
  each(tbl, applyConfig)
end
