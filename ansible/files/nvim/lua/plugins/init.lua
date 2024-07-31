-- lua/plugins/init.lua

local kp = require("kaineer.packer")
local kf = require("kaineer.fn")

local packer_bootstrap = kp.ensure_packer()

local packer = require("packer")

return packer.startup(function(use)
  local handle = kp.create_handle(use)

  use "wbthomason/packer.nvim"

  use {
    "gpanders/editorconfig.nvim"
  }

  kf.forEach(kf.prefix("plugins.", {
    "colorscheme",     -- color scheme
    "telescope",       -- fuzzy search system
    "navigation",      -- fs, tmux navigation
    "cmp",             -- completion
    "status",          -- status line
    "eyeliner",
    -- "neorg",
    "which-key",
    "git",             -- git
    "gist",            -- making gists
    "telekasten",      -- telekasten notes
    "lsp",             -- language server protocol
    "treesitter",
    "comments",        -- commenting
    "languages",       -- programming languages
    "markup",          -- markup-related packages
  }), handle)

  use "maxbrunsfeld/vim-yankstack"

  if packer_bootstrap then
    packer.sync()
  end
end)
