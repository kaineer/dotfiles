--
-- plugins/languages/markdown.lua
-- gh:jakewvincent/mkdnflow.nvim
--

return {
  'jakewvincent/mkdnflow.nvim',
  rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
  config = function()
    require('mkdnflow').setup {
      silent = true,
      modules = {
        folds = true,
        tables = true,
      },
      links = {
        conceal = true,
      },
      filetypes = {
        md = true,
        markdown = true,
      },
      mappings = {
        -- Free - key
        -- (I need it for dirvish navigation, you know)
        MkdnIncreaseHeading = false,
        MkdnDecreaseHeading = false,
        MkdnEnter = {{'n', 'v', 'i'}, '<c-j>'},
        MkdnTableFormat = {{'n'}, '<leader>mf' },
      }
    }
  end,
}
