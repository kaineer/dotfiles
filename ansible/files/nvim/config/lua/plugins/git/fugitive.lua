return {
  url = "https://github.com/tpope/vim-fugitive",
  githubUrl = "https://github.com/tpope/vim-rhubarb",
  versionsUrl = "https://github.com/junegunn/gv.vim",
  gutterUrl = "https://github.com/airblade/vim-gitgutter",

  setup = function()
    require("fugitive").setup({})
  end,
}
