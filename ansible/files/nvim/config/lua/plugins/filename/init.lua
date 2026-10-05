return {
  url = "https://github.com/kaineer/nvim-filename",
  setup = function()
    vim.api.nvim_set_hl(0, "FilenameFloat", { bg = "#81a1c1", fg = "#ffffff" })

    require("nvim-filename").setup({
      timeout = 500,
      highlight = "FilenameFloat",
    })
  end,
}
