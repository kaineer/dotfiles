vim.pack.add {
  -- color scheme
  { src = "https://github.com/shaunsingh/nord.nvim" },

  -- navigation
  { src = "https://github.com/justinmk/vim-dirvish" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },

  -- which key
  { src = "https://github.com/folke/which-key.nvim" },

  -- telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-project.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

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

local telescopeConfig = function()
  local theme = require("telescope.themes").get_ivy()
  local pkg = require("telescope")
  local utils = require("core.utils")
  local each = utils.each
  local merge = utils.merge
  local map = utils.map
  local filter = utils.filter

  local custom_defaults = {
    file_ignore_patterns = { "node_modules" },
    borderchars = { " ", " " },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    shorten_path = true,
    color_devicons = true,
  }

  local base_dirs = filter({
    "/git",
    "/devel/kaineer",
    "/devel/htmlacademy",
    "/devel/itc",
  }, function(dir)
    local path = vim.fn.expand("~") .. dir
    return vim.fn.isdirectory(path) ~= 0
  end)

  local settings = {
    defaults = merge({}, theme, custom_defaults),
    extensions = {
      project = {
        base_dirs = map(base_dirs, function(partial)
          return {
            path = vim.fn.expand("~") .. partial,
            max_depth = 3,
          }
        end),
        theme = "ivy",
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  }

  pkg.setup(settings)

  each({ "project", "ui-select" }, pkg.load_extension)

  local builtin = require("telescope.builtin")
  local extensions = pkg.extensions

  local wk = require("which-key")

  wk.add({
    { "<leader>of", builtin.find_files, desc = "Open file" },
    { "<leader>od", builtin.diagnostics, desc = "Open diagnostics" },
    { "<leader>ob", builtin.buffers, desc = "Open buffers" },
    { "<leader>oh", builtin.oldfiles, desc = "Open history" },
    { "<leader>om", builtin.marks, desc = "Open marks" },
    { "<leader>op", extensions.project.project, desc = "Select project" },
    { "<leader>oq", builtin.quickfixhistory, desc = "Quickfix history" },
    { "<leader>rg", builtin.live_grep, desc = "RG in files" },
    { "<leader>/", builtin.current_buffer_fuzzy_find, desc = "grep in buffer" },
    { "<leader>ogf", builtin.git_files, desc = "Open git files" },
    { "<leader>ogb", builtin.git_branches, desc = "Open git branches" },
    { "<leader>ogs", builtin.git_stash, desc = "Open git stash" },
    { "<leader>ogg", builtin.git_status, desc = "Open git status" },
    { "<leader>ov", ":Videre<cr>", desc = "Videre" },
  })
end

telescopeConfig()
