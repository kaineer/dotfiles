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
    local utils = require("core.utils")
    local each = utils.each
    local merge = utils.merge
    local map = utils.map
    local filter = utils.filter

    local custom_defaults = {
      file_ignore_patterns = { "node_modules" },
      borderchars = { " ", " " },
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
		})
	end,
}
