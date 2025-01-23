--

return {
  "nvim-treesitter/nvim-treesitter",
  -- run = function()
  --   local ts_update = require('nvim-treesitter.install').update({
  --     with_sync = true
  --   })
  --   ts_update()
  -- end,
  config = function()
    require("nvim-treesitter.configs").setup {
      indent = {
        enable = true,
      },
      ensure_installed = {
        "bash",
        "yaml",
        "lua",
        "http",
        "hurl",
        "cpp",
        "python",
        "ruby",
        "rust",
        "make",
        "tsx",
        "javascript",
        "vimdoc",
      }
    }
  end,
}
