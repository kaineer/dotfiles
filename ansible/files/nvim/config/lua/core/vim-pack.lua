require("core.vim-pack.config")({
  "plugins.colors.pack",
  "plugins.edit.colorizer",
  "plugins.edit/jsonnet",
  "plugins.incline.pack",
  "plugins.filename.init",
  "plugins.navigation.pack",
  "plugins.telescope.pack",
  "plugins.lsp.pack",
  "plugins.git.pack",
  "plugins.completion.pack",
  "plugins.snippets.pack",
})

require("which-key").add({
  { "<leader>pu", function() 
    vim.pack.update(nil, { force = true })
    vim.schedule(function()
      vim.notify("vim.pack: update finished", vim.log.levels.INFO)
    end)
  end, desc = "Force update" },
})
