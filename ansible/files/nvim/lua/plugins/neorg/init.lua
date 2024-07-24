return {
  "nvim-neorg/neorg",
  config = function()
    require("neorg").setup {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/git/notes",
          },
        },
      },
    }
  end,
  run = ":Neorg sync-parsers",
  requires = "nvim-lua/plenary.nvim",
}
