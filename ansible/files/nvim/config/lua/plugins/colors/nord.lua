-- plugins/colors/nord.lua
--
-- gh: https://github.com/shaunsingh/nord.nvim
--
return {
	"shaunsingh/nord.nvim",
	config = function()
		vim.cmd([[colorscheme nord]])
		vim.cmd([[ highlight Normal guibg=none ]])
	end,
}
