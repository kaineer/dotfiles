--
return  {
  "garymjr/nvim-snippets",

  config = function ()
    require("nvim-snippets").setup {
      create_autocmd = true,
      friendly_snippets = true,
    }
  end,
}
