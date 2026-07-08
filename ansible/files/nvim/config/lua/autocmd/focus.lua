return {
  name = "FocusColors",
  config = function(cmd)
    cmd("FocusGained", {
      callback = function()
        vim.cmd([[ highlight Normal guibg=#3b4252 ]])
      end,
    })
    
    cmd("FocusLost", {
      callback = function()
        vim.cmd([[ highlight Normal guibg=#2e3440 ]])
      end,
    })
  end,
}
