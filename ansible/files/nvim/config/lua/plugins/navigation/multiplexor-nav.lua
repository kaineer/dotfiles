-- Alt+hjkl via Herdr vim-nav: Herdr intercepts Alt and injects F13–F16 into
-- nvim (unbound in keys.json). Those call the same wincmd path as C-w, then
-- herdr-app pane.go at a window edge. Direct Alt maps remain as a fallback
-- if passthrough is enabled.

local herdr_direction = {
  Left = "left",
  Down = "down",
  Up = "up",
  Right = "right",
}

local win_direction = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  Previous = "p",
}

-- Injected by herdr vim-nav (hc keys f13..f16). Not bound in keys.json.
local inject_keys = {
  Left = "<F13>",
  Down = "<F14>",
  Up = "<F15>",
  Right = "<F16>",
}

local function in_tmux()
  local tmux = vim.env.TMUX
  return tmux ~= nil and tmux ~= ""
end

local function in_herdr_app()
  local id = vim.env.HC_TERMINAL_ID
  return id ~= nil and id ~= ""
end

local function herdr_nav_sock()
  local id = vim.env.HC_TERMINAL_ID
  if not id or id == "" then
    return nil
  end
  local runtime = vim.env.XDG_RUNTIME_DIR
  if not runtime or runtime == "" then
    runtime = vim.fn.stdpath("run")
  end
  return runtime .. "/herdr-nav-" .. id .. ".sock"
end

local function ensure_herdr_server()
  local sock = herdr_nav_sock()
  if not sock then
    return
  end
  for _, existing in ipairs(vim.fn.serverlist()) do
    if existing == sock then
      return
    end
  end
  pcall(vim.fn.serverstart, sock)
end

local function herdr_navigate(nav)
  local win = win_direction[nav]
  if not win then
    return
  end

  local before = vim.fn.winnr()
  vim.cmd("wincmd " .. win)
  if vim.fn.winnr() ~= before then
    return
  end

  local direction = herdr_direction[nav]
  if not direction then
    return
  end

  vim.fn.jobstart({
    "herdr-app",
    "do",
    "pane.go",
    "--direction",
    direction,
  }, { detach = true })
end

local function aware_navigate(nav)
  if in_tmux() then
    vim.cmd("TmuxNavigate" .. nav)
  elseif in_herdr_app() then
    herdr_navigate(nav)
  else
    vim.cmd("TmuxNavigate" .. nav)
  end
end

return {
  url = "https://github.com/christoomey/vim-tmux-navigator",
  setup = function()
    local assign = require("core.utils").assign
    assign(vim.g, {
      tmux_navigator_no_mappings = 1,
      tmux_navigator_save_on_switch = 1,
      tmux_navigator_disable_when_zoomed = 1,
    })
  end,
  config = function()
    -- Keycode timeouts: Alt sometimes arrives as ESC+letter without Kitty.
    vim.o.ttimeoutlen = 10

    ensure_herdr_server()
    vim.api.nvim_create_autocmd({ "UIEnter", "VimEnter", "FocusGained" }, {
      group = vim.api.nvim_create_augroup("HerdrNavServer", { clear = true }),
      callback = ensure_herdr_server,
    })

    _G.HerdrNavigate = aware_navigate

    vim.api.nvim_create_user_command("TmuxOrHerdrNavigate", function(opts)
      aware_navigate(opts.args)
    end, {
      nargs = 1,
      complete = function()
        return { "Left", "Down", "Up", "Right", "Previous" }
      end,
    })

    local directions = {
      h = "Left",
      j = "Down",
      k = "Up",
      l = "Right",
      o = "Previous",
    }

    local map_opts = {
      silent = true,
      nowait = true,
      noremap = true,
      desc = "which_key_ignore",
    }

    for key, dir in pairs(directions) do
      local function go()
        print("Go" .. dir)
        aware_navigate(dir)
      end

      -- Fallback if Alt reaches nvim directly.
      vim.keymap.set("n", "<M-" .. key .. ">", go, map_opts)
      vim.keymap.set("i", "<M-" .. key .. ">", function()
        vim.cmd.stopinsert()
        go()
      end, map_opts)
      vim.keymap.set("t", "<M-" .. key .. ">", function()
        local esc = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
        vim.api.nvim_feedkeys(esc, "n", false)
        vim.schedule(go)
      end, map_opts)

      -- Primary path from herdr vim-nav (hc keys f13..f16).
      local fkey = inject_keys[dir]
      if fkey then
        vim.keymap.set({ "n", "i", "t" }, fkey, go, map_opts)
      end
    end
  end,
}
