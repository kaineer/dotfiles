return {
  urls = {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  setup = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
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
