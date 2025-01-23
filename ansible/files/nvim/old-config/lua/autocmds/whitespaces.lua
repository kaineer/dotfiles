return {
  name = "Whitespaces",
  config = function(cmd)
    cmd("BufWritePre", { command = "%s/\\s\\+$//e" })
    -- cmd("BufWritePre", { command = "%s/($\\n\\s*)+%$//" })
  end,
}
