return {
  name = "Javascript",
  config = function(cmd)
    local bindings = {
      { '<c-r>', ':!node %<cr>' },
    }
    local opts = { silent = true, noremap = false, }
    cmd("FileType", {
      pattern = "javascript",
      callback = function()
        require("kaineer.map").buffer(bindings, opts)
      end,
    })
  end,
}
