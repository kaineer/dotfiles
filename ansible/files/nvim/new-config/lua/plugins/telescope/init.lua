--
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-github.nvim' },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'LinArcX/telescope-changes.nvim' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },

  config = function()
    local theme = require('telescope.themes').get_ivy()

    require('telescope').setup({
      defaults = theme
    })

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>of', builtin.find_files, { desc = 'Open file' })
    vim.keymap.set('n', '<leader>rg', builtin.live_grep, { desc = 'Ripgrep text in files' })
    vim.keymap.set('n', '<leader>od', builtin.diagnostics, { desc = 'Open diagnostics' })
    vim.keymap.set('n', '<leader>oh', builtin.oldfiles, { desc = 'Open from history' })
    vim.keymap.set('n', '<leader>og', builtin.git_files, { desc = 'Open from git' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search in current buffer' })
  end,
}
