-- plugins/colors/nord.lua
--
-- gh: https://github.com/shaunsingh/nord.nvim
--

return {
  url = "https://github.com/shaunsingh/nord.nvim",
  setup = function()
		vim.cmd([[ colorscheme nord ]])
		-- vim.cmd([[ highlight Normal guibg=#2e3440 ]])
		-- vim.cmd([[ highlight NormalNC guibg=#3b4252 ]])
		--
		-- vim.cmd([[ highlight GitGutterAdd guibg=#2e3440 ]])
		-- vim.cmd([[ highlight GitGutterChange guibg=#2e3440 ]])
		-- vim.cmd([[ highlight GitGutterDelete guibg=#2e3440 ]])
  end,
}

