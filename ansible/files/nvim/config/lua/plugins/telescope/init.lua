--

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },

		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},

	config = function()
		local theme = require("telescope.themes").get_ivy()
		local pkg = require("telescope")
		local each = require("core.utils").each
		local load_extension = pkg.load_extension
		local merge = require("core.utils").merge
		local ignore_files = {
			file_ignore_patterns = {
				"node_modules",
			},
		}

		local defaults = merge({}, theme, ignore_files, { borderchars = { " ", " " } })

		local settings = {
			defaults = defaults,
			extensions = {
				project = {
					base_dirs = {
						{ path = "/home/kaineer/git", max_depth = 3 },
						{ path = "/home/kaineer/devel/itc", max_depth = 3 },
						{ path = "/home/kaineer/devel/kaineer", max_depth = 3 },
					},
					theme = "ivy",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		}

		pkg.setup(settings)

		each({ "project", "ui-select" }, load_extension)

		local builtin = require("telescope.builtin")
		local extensions = pkg.extensions

		local wk = require("which-key")

		wk.add({
			{ "<leader>of", builtin.find_files, desc = "Open file" },
			{ "<leader>od", builtin.diagnostics, desc = "Open diagnostics" },
			{ "<leader>oh", builtin.oldfiles, desc = "Open history" },
			{ "<leader>op", extensions.project.project, desc = "Select project" },
			{ "<leader>rg", builtin.live_grep, desc = "RG in files" },
			{ "<leader>/", builtin.current_buffer_fuzzy_find, desc = "grep in buffer" },
			{ "<leader>ogf", builtin.git_files, desc = "Open git files" },
			{ "<leader>ogb", builtin.git_branches, desc = "Open git branches" },
			{ "<leader>ogs", builtin.git_stash, desc = "Open git stash" },
		})
	end,
}
