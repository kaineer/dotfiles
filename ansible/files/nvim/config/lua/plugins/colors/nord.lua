-- plugins/colors/nord.lua
--
-- gh: https://github.com/shaunsingh/nord.nvim
--

return {
  url = "https://github.com/shaunsingh/nord.nvim",
  setup = function()
		vim.cmd([[colorscheme nord]])
		vim.cmd([[ highlight Normal guibg=none ]])
  end,
}
