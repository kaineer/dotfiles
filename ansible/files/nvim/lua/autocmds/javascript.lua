return {
  name = "Javascript",
  config = function(cmd)
    local bindings = {
      { '<c-r>', ':!node %<cr>' },
      { '<c-d>', ':lua vim.diagnostic.disable()<cr>' },
      { '<c-e>', ':lua vim.diagnostic.enable()<cr>' },
    }
    local opts = { silent = true, noremap = false, }
    cmd("FileType", {
      pattern = "javascript",
      callback = function()
        vim.diagnostic.disable()
        require("kaineer.map").buffer(bindings, opts)
      end,
    })
  end,
}
