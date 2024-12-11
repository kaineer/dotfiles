-- lua/plugins/status/lualine.lua

return function()
  local csl = ''
  local csr = ''
  local ssl = ''
  local ssr = ''

  require('lualine').setup {
    options = {
      icons_enabled = true,
      -- theme = 'powerline',
      -- theme = 'wombat',
      theme = 'nord',
      component_separators = { left = csl, right = csr },
      section_separators = { left = ssl, right = ssr },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {
        {
          'filename',
          path = 2,
          symbols = {
            modified = '[+]', -- Text to show when the file is modified.
            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[ ]', -- Text to show for unnamed buffers.
            newfile = '[×]', -- Text to show for new created file before first writting
          }
        }
      },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    -- inactive_sections = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {'location'},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end
