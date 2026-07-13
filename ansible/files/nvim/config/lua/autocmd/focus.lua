return {
  name = "FocusColors",
  config = function(cmd)
    local fnEnter = function()
      -- vim.api.nvim_set_hl(0, 'Normal', { bg='#2e3440' })
      -- vim.api.nvim_set_hl(0, 'NormalNC', { bg='#2e3440' })
      vim.cmd([[ highlight Normal guibg=#2e3440 ]])
    end
    local fnLeave = function()
      -- vim.api.nvim_set_hl(0, 'Normal', { bg='#3b4252' })
      -- vim.api.nvim_set_hl(0, 'NormalNC', { bg='#3b4252' })
      vim.cmd([[ highlight Normal guibg=#3b4252 ]])
    end

    cmd("FocusGained", { callback = fnEnter })
    cmd("FocusLost", { callback = fnLeave })
    cmd("WinEnter", { callback = fnEnter })
    cmd("WinLeave", { callback = fnLeave })
  end,
}
