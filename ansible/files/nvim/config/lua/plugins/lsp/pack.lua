return {
  urls = {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  setup = function()
    require("mason").setup()

    local on_attach = require("plugins.lsp.opts.keymaps")

    vim.lsp.config['ts_ls'] = require("plugins.lsp.opts.ts")
    vim.lsp.config['lua_ls'] = require("plugins.lsp.opts.lua")
    vim.lsp.config['jsonls'] = require("plugins.lsp.opts.json")

    -- Включаем LSP серверы
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('jsonls')

    -- Настройка автокоманд для on_attach
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          on_attach(client, args.buf)
        end
      end,
    })

    require("mason-lspconfig").setup({
      automatic_installation = true,
      automatic_enable = {
        "ts_ls",
      }
    })

    require("mason-tool-installer").setup {
      ensure_installed = {
        "lua_ls",
        "jsonls",
        "shfmt",
        "ts_ls",
      },
    }
  end,
}
