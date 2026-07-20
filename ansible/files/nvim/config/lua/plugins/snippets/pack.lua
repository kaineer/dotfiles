return {
  urls = {
    "https://github.com/garymjr/nvim-snippets",
    "https://github.com/rafamadriz/friendly-snippets",
  },

  setup = function()
    require("snippets").setup({
      create_autocmd = true,
      create_cmp_source = true,
      friendly_snippets = true,
      search_paths = {
        vim.fn.expand("~/.config/snippets"),
        vim.fn.stdpath("config").."/snippets",
      },
      keys = {
        {
          "<Tab>",
          function()
            if vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
              return
            end
            return "<Tab>"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
        {
          "<Tab>",
          function()
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          end,
          expr = true,
          silent = true,
          mode = "s",
        },
        {
          "<S-Tab>",
          function()
            if vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
              return
            end
            return "<S-Tab>"
          end,
          expr = true,
          silent = true,
          mode = { "i", "s" },
        },
      },
    })
  end,
}
