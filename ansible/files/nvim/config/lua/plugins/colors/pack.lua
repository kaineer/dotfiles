local nord = require("plugins.colors.nord")

return {
  urls = {
    nord.url,
    -- "https://github.com/norcalli/nvim-colorizer.lua",
  },
  setup = function()
    nord.setup()
    -- require("colorizer").setup()
  end,
}
