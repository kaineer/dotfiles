-- lazy bootstrap
require("core.bootstrap")
require("core.options")
require("core.keymaps")
-- require("autocmd")

-- setup plugins
require("lazy").setup({
  require("plugins.colors.nord"),
  -- require("plugins.colors.vague"),
  require("plugins.telescope"),
  require("plugins.navigation"),
  require("plugins.treesitter"),
  require("plugins.git"),
  require("plugins.languages"),
  require("plugins.completion"),
  require("plugins.edit"),
  require("plugins.lsp"),
  require("plugins.none-ls"),
  -- require("plugins.lualine"),
  require("plugins.telekasten"),

  -- {
  -- 	dir = "~/devel/kaineer/skk-lua.nvim",
  -- 	config = function() end,
  -- },

  -- require("plugins.skk.plugin"),

  -- {
  -- 	"kaineer/skk",
  -- 	dir = "~/.config/nvim/lua/plugins/skk",
  -- 	config = function()
  -- 		require("plugins.skk").setup()
  -- 	end,
  -- },
})
