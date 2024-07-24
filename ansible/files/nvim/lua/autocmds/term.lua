return {
  name = "Terminal",
  config = function(cmd)
    cmd("TermOpen", {
      pattern = "*",
      callback = function()
        vim.cmd(":startinsert")
        vim.cmd("setlocal listchars= nonumber norelativenumber")
      end,
    })
  end,
}
