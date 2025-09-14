return {
  name = "JSON",
  config = function(cmd)
    cmd("FileType", {
      pattern = "json",
      callback = function()
        vim.cmd("Videre")
      end,
    })
  end,
}
