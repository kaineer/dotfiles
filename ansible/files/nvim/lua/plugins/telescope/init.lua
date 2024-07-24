-- lua/plugins/telescope/init.lua

local configTelescope = function()
  local forEach = require('kaineer.fn').forEach
  local telescope = require('telescope')
  local map = require('kaineer.map')

  local cmd = function(value)
    return ":" .. value .. "<cr>"
  end

  local telescope_cmd = function(name)
    return cmd("Telescope " .. name)
  end

  local extensionsToLoad = {
    'project', 'ui-select', 'file_browser',
  }

  local load_extension = function(name)
    telescope.load_extension(name)
  end

  local theme = require('telescope.themes').get_ivy()

  forEach(extensionsToLoad, load_extension)

  telescope.setup {
    defaults = theme,
    extensions = {
      project = {
        base_dirs = {
          { path = '/home/kaineer/git', max_depth = 3 },
          { path = '/home/kaineer/devel/htmlacademy', max_depth = 3 },
        },
        theme = 'ivy',
      },
      ["ui-select"] = {
        require('telescope.themes').get_cursor {}
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = false,
      },
    },
  }

  map.normal({
    { '<leader>of', telescope_cmd('find_files') },
    { '<leader>ob', telescope_cmd('buffers') },
    { '<leader>ot', telescope_cmd('file_browser') },
    { '<leader>oh', telescope_cmd('oldfiles') },
    { '<leader>og', telescope_cmd('git_files') },
    { '<leader>om', telescope_cmd('keymaps') },
    { '<leader>or', telescope_cmd('registers') },
    { '<leader>ol', telescope_cmd('current_buffer_fuzzy_find') },
    { '<leader>/',  telescope_cmd('current_buffer_fuzzy_find') },
    { '<leader>od', telescope_cmd('diagnostics') },
    { '<leader>rg', telescope_cmd('live_grep') },
    { '<leader>op', telescope_cmd('project') },

    { '<leader>ouu', ":UrlView<cr>" },
    { '<leader>oup', ":UrlView packer<cr>" },
    -- { '<leader>gi', cmd('gh issues') },
    -- { '<leader>gr', cmd('gh run') },
    -- { '<leader>gg', cmd('gh gist') },
    -- { '<leader>gp', cmd('gh pull_requests') },

    -- notifications
    -- { '<leader>on', cmd('notify') },
  })
end

local telescopeRequires = {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope-github.nvim',
  'nvim-telescope/telescope-project.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
}

local telescopeData = {
  'nvim-telescope/telescope.nvim',
  requires = telescopeRequires,
  config = configTelescope,
}

return function(use)
  use(telescopeRequires)
  use(telescopeData)
end
