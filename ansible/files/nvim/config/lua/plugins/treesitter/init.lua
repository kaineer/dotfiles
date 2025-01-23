-- plugins/treesitter/init.lua

local languages = {
	"bash",
	"yaml",
	"lua",
	"http",
	"hurl",
	"cpp",
	"python",
	"ruby",
	"rust",
	"make",
	"tsx",
	"javascript",
	"vimdoc",
}

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
