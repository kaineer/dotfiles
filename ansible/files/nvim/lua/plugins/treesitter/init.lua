--
local treesitter = require("plugins.treesitter.treesitter")
local context = require("plugins.treesitter.context")

return function(use)
  use(treesitter)
  use(context)
end
