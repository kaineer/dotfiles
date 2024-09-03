-- lua/plugins/http/init.lua
-- @link: https://kulala.mwco.app/
-- config: https://kulala.mwco.app/docs/getting-started/configuration-options

return {
  "mistweaverco/kulala.nvim",
  config = function()
    require("kulala").setup({})
  end,
}

