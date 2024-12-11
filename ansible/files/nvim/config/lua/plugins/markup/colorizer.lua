-- lua/plugins/markup/colorizer.lua

return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup {
      javascript = {
        mode = "virtual"
      }
    }
  end,
}
