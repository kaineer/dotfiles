-- lua/options/init.lua

local assign = require("kaineer.fn").assign

if vim.g.nvui then
  require("options.nvui")()
end

if vim.g.neovide then
  require("options.neovide")()
end

assign(vim.opt, {
  -- Indent
  expandtab = true,
  smarttab = true,
  shiftwidth = 2,
  tabstop = 2,

  -- Search
  hlsearch = false,
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  -- Interface
  splitbelow = true,
  splitright = true,
  number = true,           -- sure
  relativenumber = false,  -- I am not a fan of relative numbering
  cursorline = true,       -- because it is convenient
  wrap = true,             -- code should not hide after right edge
  termguicolors = true,    -- because nord theme needs rgb colors

  clipboard = "unnamedplus", -- system clipboard

  swapfile = false,
  fileencoding = "utf-8",

  hidden = true,

  cmdheight = 0,
})

assign(vim.g, {
  markdown_fenced_languages = {
    "html", "python", "lua", "vim",
    "typescript", "javascript", "json",
  },
  mapleader = " ",
})
