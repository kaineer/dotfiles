--

return {
  'elzr/vim-json',
  config = function()
    local au = require('kaineer.autocmd').au
    au("JsonFolding", function(cmd)
      cmd("FileType", {
        pattern = "json",
        callback = function()
          vim.cmd "set foldmethod=syntax"
          vim.cmd "set foldlevel=1"
        end,
      })
    end)
    au("BufRead", {
      pattern = {
        ".swcrc",
        ".eslintrc",
      },
      command = "set ft=json"
    })
  end,
}
