return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {},
		gui_style = { fg = "NONE", bg = "BOLD" },
		highlight = { multiline = true, multiline_pattern = "^.", multiline_context = 10 },
		signs = true,
		sign_priority = 8,
	},

	config = function()
		require("todo-comments").setup()

		local wk = require("which-key")

		wk.add({
			{ "<leader>tf", ":TodoTelescope<cr>", desc = "TODO comments in telescope" },
			{ "<leader>tl", ":TodoTrouble<cr>", desc = "TODO comments in troubles tree" },
		})
	end,
}
