vim.pack.add {
  -- color scheme
  { src = "https://github.com/shaunsingh/nord.nvim" },

  -- navigation
  { src = "https://github.com/justinmk/vim-dirvish" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },

  -- TODO: telescope
  -- TODO: git
  -- TODO: languages
  -- TODO: completion

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup {
  ensure_installed = {
    "lua_ls",
    "jsonls",
    "shfmt",
  },
}

vim.cmd([[colorscheme nord]])
vim.cmd([[highlight Normal guibg=none]])

local dirvishConfig = function()
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

dirvishConfig()

-- TMUX
local tmuxNavigatorSetup = function()
  local assign = require("core.utils").assign
  assign(vim.g, {
    -- 1 - use your own mappings
    tmux_navigator_no_mappings = 1,
    -- 1 - write current buffer, only if changed
    -- 2 - write all buffer
    tmux_navigator_save_on_switch = 1,
    -- 1 - use your own mappings
    tmux_navigator_disable_when_zoomed = 1,
  })
end
local tmuxNavigatorConfig = function()
  local map = require("core.map")

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
end

tmuxNavigatorSetup()
tmuxNavigatorConfig()
