--
-- plugins/git/init.lua
--

local gitPlugins = {
  -- magit
  'tpope/vim-fugitive',
  -- github
  'tpope/vim-rhubarb',
  -- gitlab
  'shumphrey/fugitive-gitlab.vim',
  -- versions history
  'junegunn/gv.vim',
  -- marks at gutter
  'airblade/vim-gitgutter',
}

local gitlab = function(use)
  use {
    'shumphrey/fugitive-gitlab.vim',
    requires = {
      'tpope/vim-fugitive',
    },
    setup = function()
      vim.g.fugitive_gitlab_domains = {
        'https://gitlab.com',
        'https://gitlab.htmlacademy.dev',
      }
    end,
  }
end

local gitMessenger = function(use)
  use {
    'rhysd/git-messenger.vim',
    setup = function()
      vim.g.git_messenger_always_into_popup = true
      vim.g.git_messenger_date_format = "%Y.%m.%d -- %H:%M:%S"
      vim.g.git_messenger_floating_win_opts = {
        border = 'single'
      }

      local mkcmd = require("kaineer.cmd").buildMkcmd("WTF")
      require("which-key").add({
        { " gs", mkcmd("G"), desc = "Git status" },
        { " ga", mkcmd("Git add ."), desc = "Git add current file" },
        { " gl", mkcmd("GV"), desc = "Git log" },
        { " gm", mkcmd("GitMessenger"), desc = "Annotate current line" },
      });

      require('kaineer.map').visual({
        { '<c-o>', ':GBrowse<cr>' },
      })
    end,
  }
end

local lazyGit = function(use)
  use {
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
end

return function(use)
  use(gitPlugins)

  gitMessenger(use)
  gitlab(use)
  lazyGit(use)
end

