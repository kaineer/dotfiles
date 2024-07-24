-- lua/plugins/which-key/init.lua
-- link: https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  config = function()
    require("kaineer.fn").assign(vim.o, {
      timeout = true,
      timeoutlen = 800,
    })

    require("which-key").setup {
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "CR",
        ["<tab>"] = "TAB",
      },
      plugins = {
        registers = false,
      },
    }
  end,
}
