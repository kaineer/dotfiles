-- lua/plugins/colorscheme/nord.lua

--
-- documentation: https://www.nordtheme.com/docs/ports/vim
-- github: https://github.com/nordtheme/vim
--
return {
  -- 'arcticicestudio/nord-vim',
  'shaunsingh/nord.nvim',
  config = function()
    local assign = require("kaineer.fn").assign

    vim.cmd('colorscheme nord')

    assign(vim.g, {
      nord_disable_background = true,
      nord_contrast = false,
      -- nord_borders = false,
    })

    vim.cmd(':hi Delimiter ctermfg=15')

    require("plugins.colorscheme.focus").setup({
      colors = {
        active = " guibg=#2e3440",
	      inactive = " guibg=#4b556a",
      },
      backgrounds = {
	      "Normal", "LineNr", "SignColumn",
      },
    })
  end,
}
