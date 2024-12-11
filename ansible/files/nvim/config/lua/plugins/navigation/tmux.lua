-- lua/plugins/navigation/tmux.lua

-- DONE: bind alt-hjkl to switching between windows/tmux panes
-- DONE: bind alt-o to switch to previous pane
-- DONE: prepend escape sequence for normal, insert and terminal modes

return {
  "christoomey/vim-tmux-navigator",
  setup = function()
    local assign = require("kaineer.fn").assign
    assign(vim.g, {
      -- 1 - use your own mappings
      tmux_navigator_no_mappings = 1,
      -- 1 - write current buffer, only if changed
      -- 2 - write all buffer
      tmux_navigator_save_on_switch = 1,
      -- 1 - use your own mappings
      tmux_navigator_disable_when_zoomed = 1,
    })
  end,
  config = function()
    local map = require("kaineer.map")

    local makeKey = function(key)
      return "<m-" .. key .. ">"
    end

    local makeCommand = function(prefix, nav)
      return prefix .. ":TmuxNavigate" .. nav .. "<cr>"
    end

    local modes = {
      n = '',           -- do nothing
      i = '<c-[>',      -- exit insert mode
      t = '<c-\\><c-n>' -- exit terminal mode
    }

    local directions = {
      h = 'Left',
      j = 'Down',
      k = 'Up',
      l = 'Right',
      o = 'Previous',
    }

    for mode, prefix in pairs(modes) do
      for key, dir in pairs(directions) do
        map.mode({
          { makeKey(key), makeCommand(prefix, dir) }
        }, mode)
      end
    end
  end,
}
