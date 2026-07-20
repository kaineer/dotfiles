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
      -- extended_filetypes = {},
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


  -- urls = {
  --   "https://github.com/L3MON4D3/LuaSnip",
  -- },
  -- setup = function()
  --   local ls = require("luasnip")
  --
  --   vim.keymap.set({"i"}, "<tab>", function() ls.expand() end, {silent = true})
  --   vim.keymap.set({"i", "s"}, "<C-n>", function() ls.jump( 1) end, {silent = true})
  --   vim.keymap.set({"i", "s"}, "<C-p>", function() ls.jump(-1) end, {silent = true})
  --
  --   vim.keymap.set({"i", "s"}, "<c-e>", function()
  --     if ls.choice_active() then
  --       ls.change_choice(1)
  --     end
  --   end, {silent = true})
  -- end,
}

