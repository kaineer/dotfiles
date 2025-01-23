-- lua/plugins/navigation/dirvish.lua

-- DONE: run Dirvish on dash from file
-- DONE: bind hl in Divish buffer
-- DONE: bind e for editing new file in buffer
-- DONE: bind m for making directory in buffer
-- DONE: bind r for removing file in buffer
-- DONE: bind m-enter for opening nemo
-- DONE: start Dirvish on neovim start
--   (works for now, but throws an error while dirvish not installed)

local setupDirvish = function()
  local assign = require("kaineer.fn").assign

  --
  -- Override netrw
  --
  vim.cmd([[
    command! -nargs=? -complete=dir Explore Dirvish <args>
    command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
    command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
  ]])
  -- end

  assign(vim.g, {
    dirvish_mode = ':sort ,^\\v(.*[\\/])|\\ze,',
    loaded_netrwPlugin = 1,
  })
end

-- NOTE: the only way to replace netrw, as it seems
pcall(setupDirvish)

local configDirvish = function()
  local au = require("kaineer.autocmd").au
  local map = require("kaineer.map")

  local opts = {
    noremap = false,
    silent = false
  }

  local bindings = {
    -- Movements
    {'h', '-'},           -- move through directories
    {'l', '<cr>'},        --   with left/right "arrows"
    {'e', ':e %'},        -- edit file in current directory
    {'r', '.rm -rf'},         -- remove current file (after <cr>)

    -- Shell commands
    {'m', ':!mkdir %'},   -- create subdirectory
    {'<m-enter>', ':!nemo % &<cr><cr>'},    -- try to open nemo
  }

  au("DirvishNav", function(cmd)
    cmd("FileType", {
      pattern = "dirvish",
      callback = function()
        vim.opt_local.number = false
        map.buffer(bindings, opts)
      end,
    })
  end)
end

return {
  "justinmk/vim-dirvish",
  setup = setupDirvish,
  config = configDirvish,
}
