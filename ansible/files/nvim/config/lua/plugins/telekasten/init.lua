-- lua/plugins/telekasten/init.lua

return function(use)
  use('renerocksai/calendar-vim')
  use {
    'renerocksai/telekasten.nvim',
    requires = 'renerocksai/calendar-vim',
    config = require('plugins.telekasten.config'),
  }
end
