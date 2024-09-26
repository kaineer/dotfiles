-- treesitter

return {
  "nvim-treesitter/nvim-treesitter",
  run = function()
    local ts_update = require('nvim-treesitter.install').update({
      with_sync = true
    })
    ts_update()
  end,
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "yaml",
        "lua",
        "http",
        "cpp",
        "python",
        "ruby",
        "rust",
        "make",
        "javascript",
        "vimdoc"
      }
    }
  end,
}

