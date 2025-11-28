-- plugins/colors/nordic.lua
--
-- gh: https://github.com/AlexvZyl/nordic.nvim
--
return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nordic").load()
		vim.cmd([[ highlight Normal guibg=none ]])
	end,
}
