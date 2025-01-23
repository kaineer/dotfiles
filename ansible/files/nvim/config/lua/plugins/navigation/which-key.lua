-- gh link: https://github.com/folke/which-key.nvim

return {
  "folke/which-key.nvim",
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  event = "VeryLazy",
  opts = {
    preset = 'modern',
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
