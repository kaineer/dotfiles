-- plugins/colors/onenord.lua
--
-- gh: https://github.com/rmehri01/onenord.nvim
--
return {
	"rmehri01/onenord.nvim",
	config = function()
		require("onenord").setup({
			theme = "dark",
			fade_nc = true,
		})
		vim.cmd([[ highlight Normal guibg=none ]])
	end,
}
