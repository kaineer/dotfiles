-- lua/plugins/lsp/mason.lua

local configMason = function()
  require('mason').setup{
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  }
end

return configMason
