-- plugins/navigation/dirvish.lua
--
-- gh link: https://github.com/justinmk/vim-dirvish
--
-- setup link: https://github.com/folke/lazy.nvim/discussions/451
--
local dirvish = {
  'justinmk/vim-dirvish',
  init = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) then
      require('lazy').load({
        plugins = {'vim-dirvish'}
      })
    end
  end,
  config = require('plugins.navigation.dirvish.config'),
}

return {
  dirvish,
}
