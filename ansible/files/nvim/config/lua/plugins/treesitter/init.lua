-- plugins/treesitter/init.lua

local languages = require("plugins.treesitter.languages")
local enabled = { enable = true }

return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = enabled,
			indent = enabled,
			ensure_installed = languages,
		})
	end,
}
