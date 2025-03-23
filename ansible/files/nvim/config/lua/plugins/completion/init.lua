-- plugins/completion/init.lua

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
		"hrsh7th/cmp-emoji",
		"andersevenrud/cmp-tmux",
		"dmitmel/cmp-digraphs",

		-- icons
		"onsails/lspkind.nvim",
	},
	config = require("plugins.completion.setup"),
}
