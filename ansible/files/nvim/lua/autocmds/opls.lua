return {
  name = "OpLs",
  config = function(cmd)
    local bindings = {
      { 'l', 'Vy:!<c-r>" >/dev/null<cr><cr>' },
    }
    local opts = { silent = true, noremap = false, }

    cmd("BufReadPre", {
      pattern = "op.ls.sh",
      callback = function()
        require("kaineer.map").buffer(bindings, opts)
      end,
    })
  end,
}
