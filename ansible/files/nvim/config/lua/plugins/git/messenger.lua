return {
	"rhysd/git-messenger.vim",
	config = function()
		vim.g.git_messenger_always_into_popup = true
		vim.g.git_messenger_date_format = "%Y.%m.%d -- %H:%M:%S"
		vim.g.git_messenger_floating_win_opts = {
			border = "single",
		}

		local mkcmd = require("core.utils").buildMkcmd("WTF")
		require("which-key").add({
			{ " gs", mkcmd("G"), desc = "Git status" },
			{ " ga", mkcmd("Git add ."), desc = "Git add current file" },
			{ " gl", mkcmd("GV"), desc = "Git log" },
			{ " gm", mkcmd("GitMessenger"), desc = "Annotate current line" },
		})

		require("core.map").visual({
			{ "<c-o>", ":GBrowse<cr>" },
		})
	end,
}
