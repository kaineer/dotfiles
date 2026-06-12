return {
  urls = {
 	  "https://github.com/hrsh7th/nvim-cmp",
		"https://github.com/hrsh7th/cmp-nvim-lsp",
		"https://github.com/hrsh7th/cmp-buffer",
		"https://github.com/hrsh7th/cmp-cmdline",
		"https://github.com/hrsh7th/cmp-path",
		"https://github.com/hrsh7th/cmp-vsnip", -- did not work without it
		"https://github.com/hrsh7th/vim-vsnip",
		"https://github.com/hrsh7th/vim-vsnip-integ",
		"https://github.com/hrsh7th/cmp-emoji",
		"https://github.com/andersevenrud/cmp-tmux",
		"https://github.com/onsails/lspkind.nvim",
  },
  setup = function()
    local cmp = require("cmp")
    local cmp_map = cmp.mapping
    local cmp_src = cmp.config.sources

    local cu = require("core.utils")
    local forEach = cu.each
    local tap = cu.tap

    local custom_source = function(name)
      return { name = name }
    end

    local as_names = function(...)
      local args = { ... }
      return tap({}, function(result)
        forEach(args, function(value)
          table.insert(result, custom_source(value))
        end)
      end)
    end

    cmp.setup({
      matching = {
        disallow_fuzzy_matching = false,
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ["<c-n>"] = cmp_map.select_next_item(),
        ["<c-p>"] = cmp_map.select_prev_item(),
        ["<c-e>"] = cmp_map.abort(),
        ["<c-.>"] = cmp_map.complete(),
        ["<cr>"] = cmp_map.confirm({ select = true }),
        ["<c-j>"] = cmp_map.confirm({ select = true }),
      },
      sources = cmp_src(as_names("nvim_lsp", "vsnip", "buffer", "path", "tmux"), as_names("buffer")),
      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true,
          maxwidth = 50,
          mode = "symbol",

          before = function(_, vim_item)
            return vim_item
          end,
        }),
      },
    })

    forEach({ "markdown", "html" }, function(ft)
      cmp.setup.buffer({
        filetype = ft,
        -- sources = cmp_src(as_names("snippets", "buffer", "path", "tmux", "digraphs", "emoji"), as_names("buffer")),
        sources = cmp_src(as_names("snippets", "buffer", "path", "tmux", "emoji"), as_names("buffer")),
      })
    end)

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp_map.preset.cmdline(),
      sources = as_names("buffer"),
    })

    cmp.setup.cmdline(":", {
      mapping = cmp_map.preset.cmdline(),
      sources = cmp_src(as_names("path"), as_names("cmdline")),
    })

    vim.cmd([[
    " Expand
    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    ]])

    vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/snippets/")
  end,
}
