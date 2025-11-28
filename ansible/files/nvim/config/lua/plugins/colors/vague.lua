return {
	"vague2k/vague.nvim",
	config = function()
		require("vague").setup({})
		vim.cmd("colorscheme vague")
		vim.cmd([[ highlight Normal guibg=none ]])
	end,
}
