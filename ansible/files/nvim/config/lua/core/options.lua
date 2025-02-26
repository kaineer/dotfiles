-- core/options.lua

local assign = require("core.utils").assign

-- Options
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
	number = true, -- sure
	relativenumber = false, -- I am not a fan of relative numbering
	cursorline = true, -- because it is convenient
	wrap = true, -- code should not hide after right edge
	termguicolors = true, -- because nord theme needs rgb colors

	clipboard = "unnamedplus", -- system clipboard

	swapfile = false,
	fileencoding = "utf-8",

	hidden = true,

	cmdheight = 0,
})

-- Global options
assign(vim.g, {
	markdown_fenced_languages = {
		"html",
		"python",
		"lua",
		"vim",
		"typescript",
		"javascript",
		"json",
	},
})
