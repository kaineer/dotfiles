-- core/keymaps.lua

local map = require("core.map")
local assign = require("core.utils").assign

assign(vim.g, {
	mapleader = " ",
	maplocalleader = " ",
})

local mkcmd = function(name, message, title)
	return function()
		vim.api.nvim_command(":" .. name)
	end
end

local window = {
	splith = mkcmd("sp"),
	splitv = mkcmd("vs"),
	quit = mkcmd("qa!"),
	close = function()
		pcall(function()
			vim.api.nvim_win_close(0, true)
		end)
	end,
	only = mkcmd("only"),
}

local diagnostics = {
	prev = function()
		vim.diagnostic.goto_next()
	end,
	next = function()
		vim.diagnostic.goto_prev()
	end,
}

local troubles = {
	toggle = mkcmd("TroubleToggle"),
	refresh = mkcmd("TroubleRefresh", "List is refreshed", "Troubles"),
}

local tabs = {
	new = mkcmd("tabnew", "created", "Tabs"),
	close = mkcmd("tabclose"),
	next = mkcmd("tabnext", "next", "Tabs"),
	prev = mkcmd("tabprevious", "previous", "Tabs"),
}

local tmux = {
	rename = mkcmd("!n"),
  split = function()
    -- @link: https://chat.deepseek.com/share/yuyucfni0l3fsvh4sj 
    -- split into current directory
    local current_file = vim.fn.expand('%:p')
    local current_dir = vim.fn.expand('%:p:h')
    local target_dir

    -- Проверяем, открыт ли dirvish
    if vim.bo.filetype == 'dirvish' then
      target_dir = vim.fn.expand('%:p')
    else
      -- Иначе используем директорию текущего файла
      if current_file == '' then
        target_dir = vim.fn.getcwd()
      else
        target_dir = current_dir
      end
    end

    print('target_dir = ' .. target_dir)

    vim.fn.jobstart({'tmux', 'split-window', '-c', target_dir}, {
      detach = true,
      cwd = target_dir,
      on_exit = function() end
    })
  end,
}

map.normal({
	{ "<leader>td", ":colorscheme shine<cr>" },
	{ "<leader>tn", ":colorscheme nord<cr>" },
})

map.normal({
	-- emacs way window bindings
	{ "<c-x>0", window.close },
	{ "<c-x>1", window.only },
	{ "<c-x>2", window.splith },
	{ "<c-x>3", window.splitv },
	{ "<c-x><c-s>", mkcmd("w") },
	{ "<c-x><c-c>", mkcmd("qa!") },
	--
	{ "<m-i>", ":sp<cr><m-k>gg" },
	{ "<m-w>", ":close<cr>" },
	--
	{ "<leader>ws", window.splith },
	{ "<leader>w2", window.splith },
	{ "<leader>wv", window.splitv },
	{ "<leader>w3", window.splitv },
	{ "<leader>wc", window.close },
	{ "<leader>w0", window.close },
	{ "<leader>w1", window.only },
	{ "<leader>wq", window.quit },
	{ "<leader>0", window.close },
	{ "<leader>1", window.only },
	{ "<leader>2", window.splith },
	{ "<leader>3", window.splitv },
	{ "<leader>k", diagnostics.next },
	{ "<leader>j", diagnostics.prev },
	{ "<leader>tc", tabs.new },
	{ "<leader>tx", tabs.close },
	{ "<leader>tl", tabs.next },
	{ "<leader>th", tabs.prev },
	{ "<leader>n", tmux.rename },
  { "<leader><c-j>", tmux.split },

	{ "<leader>gm", mkcmd("GitMessenger") },
	{ "<leader>gs", mkcmd("G") },
	{ "<leader>gl", mkcmd("GV") },


	{ "zz", "V$%zf" },
})

map.visual({
	{ ";", 'y<c-[>:!browse "https://translate.google.com/?sl=ja&tl=ru&text=<c-r>""<cr>' },
	{ "<m-n>", ":norm " },
})

map.normal({
	{ "<space>tj", ':!browse "https://translate.google.com/?sl=ja&tl=ru&text=<c-r>""<cr>' },
	{ "<m-n>", ":set number!<cr>" },
	{ "<m-m>", ":set relativenumber!<cr>" },
})

map.normal({
	{ "<space>mf", ":MkdnTableFormat<cr>" },
})

-- vim pack commands
map.normal({
  { "<space>vpu", vim.pack.update },
})
