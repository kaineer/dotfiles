-- lua/plugins/status/init.lua

local icons_repo = "nvim-tree/nvim-web-devicons"

local lualine = {
  "nvim-lualine/lualine.nvim",
  requires = {
    icons_repo,
    opt = true,
  },
  config = require("plugins.status.lualine"),
}

local devicons = {
  icons_repo,
}

return function(use)
  use(devicons)
  use(lualine)
end
