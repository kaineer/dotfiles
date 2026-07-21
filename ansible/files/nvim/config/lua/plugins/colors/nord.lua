-- plugins/colors/nord.lua
--
-- gh: https://github.com/shaunsingh/nord.nvim
--

return {
  url = "https://github.com/shaunsingh/nord.nvim",
  setup = function()
    vim.cmd.colorscheme("nord")
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#3b4252" })
  end,
}
