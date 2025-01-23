-- plugins/navigation/dirvish/config.lua
--
return function()
  local au = require("core.autocmd").au
  local map = require("core.map")

  local bindings = {
    -- Movements
    {'h', '-'},            -- move through directories
    {'l', '<cr>'},         --   with left/right "arrows"

    {'m', ':!mkdir -p %'}, -- create subdirectory
    {'e', ':e %'},         -- create/edit file in current directory
    {'t', ':!touch %'},    -- touch file in current directory

    {'r', '.rm -rf'},      -- remove current file (after <cr>)

    -- Shell commands
    {'<m-o>', ':!nemo % &<cr><cr>'},    -- try to open nemo
  }

  au("DirvishNav", function(cmd)
    cmd("FileType", {
      pattern = "dirvish",
      callback = function()
        vim.opt_local.number = false
        map.buffer(bindings, { noremap = false, silent = false })
      end,
    })
  end)
end
