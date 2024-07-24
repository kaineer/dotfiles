--
-- link: https://github.com/numToStr/Comment.nvim#configuration-optional
--

return {
  "numToStr/Comment.nvim",

  config = function()
    require("Comment").setup {
      padding = true,
      sticky = true,
    }
  end,
}

