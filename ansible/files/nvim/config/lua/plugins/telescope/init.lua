--

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-github.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "LinArcX/telescope-changes.nvim" },

		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},

	config = function()
		local theme = require("telescope.themes").get_ivy()
		local telescope = require("telescope")
		local each = require("core.utils").each
		local load_extension = telescope.load_extension

		local settings = {
			defaults = theme,
			borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			extensions = {
				project = {
					base_dirs = {
						{ path = "/home/kaineer/git", max_depth = 3 },
						{ path = "/home/kaineer/devel/itc", max_depth = 3 },
						{ path = "/home/kaineer/devel/kaineer", max_depth = 3 },
					},
					theme = "ivy",
				},
				gh = {
					theme = "ivy",
				},
			},
		}

		telescope.setup(settings)

		each({ "project", "gh" }, load_extension)

		local builtin = require("telescope.builtin")
		local extensions = telescope.extensions

		-- vim.keymap.set("n", "<leader>of", builtin.find_files, { desc = "Open file" })
		-- vim.keymap.set("n", "<leader>rg", builtin.live_grep, { desc = "Ripgrep text in files" })
		-- vim.keymap.set("n", "<leader>od", builtin.diagnostics, { desc = "Open diagnostics" })
		-- vim.keymap.set("n", "<leader>oh", builtin.oldfiles, { desc = "Open from history" })
		-- vim.keymap.set("n", "<leader>og", builtin.git_files, { desc = "Open from git" })
		-- vim.keymap.set("n", "<leader>op", telescope.extensions.project.project, { desc = "Select project" })
		-- vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search in current buffer" })

		local wk = require("which-key")

		wk.add({
			{ "<leader>of", builtin.find_files, desc = "Open file" },
			{ "<leader>og", builtin.git_files, desc = "Open from git" },
			{ "<leader>od", builtin.diagnostics, desc = "Open diagnostics" },
			{ "<leader>oh", builtin.oldfiles, desc = "Open history" },
			{ "<leader>op", extensions.project.project, desc = "Select project" },
			{ "<leader>rg", builtin.live_grep, desc = "RG in files" },
		})
	end,
}
