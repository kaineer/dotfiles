return {
  {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({
        trim_on_write = true,
        trim_trailing = true,
        trim_last_line = true,

        highlight = true,
      })
    end,
  },
}
