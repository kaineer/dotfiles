--

return function()
  local au = require("kaineer.autocmd").au

  au("RofiThemesHighlight", function(cmd)
    cmd("BufRead", {
      pattern = "*.rasi",
      command = "set ft=css"
    })
  end)
end
