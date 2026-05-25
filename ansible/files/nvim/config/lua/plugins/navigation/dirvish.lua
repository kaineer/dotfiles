-- plugins/navigation/dirvish.lua
--
-- gh link: https://github.com/justinmk/vim-dirvish
--
-- setup link: https://github.com/folke/lazy.nvim/discussions/451
--
return {
  url = "https://github.com/justinmk/vim-dirvish",
  config = function()
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
  end,
}
