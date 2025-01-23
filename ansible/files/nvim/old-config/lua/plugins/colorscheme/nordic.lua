return {
  'AlexvZyl/nordic.nvim',
  config = function()
    require('nordic').load()

    require("plugins.colorscheme.focus").setup({
      colors = {
        active = " guibg=#2e3440",
	      inactive = " guibg=#3b4252",
      },
      backgrounds = {
	      "Normal", "LineNr", "SignColumn",
      },
    })
  end,
}
