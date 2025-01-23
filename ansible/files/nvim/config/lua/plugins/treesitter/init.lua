-- plugins/treesitter/init.lua

local languages = require("plugins.treesitter.languages")

return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			indent = {
				enable = true,
			},
			ensure_installed = languages,
		})
	end,
}
