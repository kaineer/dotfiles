return {
  name = "DirEnv",
  config = function(cmd)
    cmd("BufWritePost", {
      pattern = ".envrc",
      callback = function()
        vim.cmd(":!direnv allow " .. vim.fn.expand("%:p:h"))
      end,
    })
  end,
}
