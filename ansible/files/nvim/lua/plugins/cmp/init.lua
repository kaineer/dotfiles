-- lua/plugins/cmp/init.lua

return {
  'hrsh7th/nvim-cmp',
  requires = {
    -- sources
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'andersevenrud/cmp-tmux',
    -- icons
    'onsails/lspkind.nvim',
  },
  config = require("plugins.cmp.setup"),
}
