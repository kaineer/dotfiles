return {
  name = "Whitespaces",
  config = function(cmd)
    cmd("BufWritePre", { command = "%s/\\s\\+$//e" })
  end,
}
