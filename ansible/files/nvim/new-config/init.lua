-- lazy bootstrap
require('core.bootstrap')
require('core.options')
require('core.keymaps')

-- History
--  * [vim] dirvish to navigate
--  * [nvim] nordic to color files
--  * options from previous config
--  * copy bindings from previous config
--  * [nvim,tmux] tmux navigation
--  * [nvim] telescope
--
-- TODO
--  * git utils
--  * lsp

-- setup plugins
require('lazy').setup({
  require('plugins.colors.nordic'),
  require('plugins.telescope'),
  require('plugins.navigation'),
})
