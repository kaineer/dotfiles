local bindings = {
  { '<c-r>', ':!node %<cr>' },
  { '<c-d>', ':lua vim.diagnostic.disable()<cr>' },
  { '<c-e>', ':lua vim.diagnostic.enable()<cr>' },
}

local opts = { silent = true, noremap = false }

return {
  name = "Javascript",
  config = function(cmd)
    cmd("FileType", {
      pattern = "javascript",
      callback = function()
        vim.diagnostic.disable()
        require("core.map").buffer(bindings, { silent = true })
      end,
    })
  end,
}
