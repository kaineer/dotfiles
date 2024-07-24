-- lua/plugins/lsp/init.lua

local lspPrerequisites = {
  'jose-elias-alvarez/nvim-lsp-ts-utils'
  -- TODO: then use lspPrerequisites in function below
}

local lspConfig = {
  'neovim/nvim-lspconfig',
  config = function()
    require('plugins.lsp.servers')()
    require('plugins.lsp.mason')()
  end,
}

local lspUtils = {
  'jose-elias-alvarez/nvim-lsp-ts-utils',
  'williamboman/mason.nvim',
}

return function(use)
  use(lspPrerequisites)
  use(lspUtils)
  use(lspConfig)
end
