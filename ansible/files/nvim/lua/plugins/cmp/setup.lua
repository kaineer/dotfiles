-- lua/plugins/cmp/setup.lua

return function()
  local cmp = require("cmp")
  local cmp_map = cmp.mapping
  local cmp_src = cmp.config.sources

  local kf = require("kaineer.fn")
  local forEach = kf.forEach
  local tap = kf.tap
  local lkicons = require("lspkind")

  local as_names = function(...)
    local args = {...}
    return tap({}, function(result)
      forEach(args, function(value)
        table.insert(result, { name = value })
      end)
    end)
  end

  cmp.setup {
    matching = {
      disallow_fuzzy_matching = false,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ['<c-n>'] = cmp_map.select_next_item(),
      ['<c-p>'] = cmp_map.select_prev_item(),
      ['<c-e>'] = cmp_map.abort(),
      ['<c-.>'] = cmp_map.complete(),
      ['<cr>'] = cmp_map.confirm({ select = true }),
    },
    sources = cmp_src(
      as_names('nvim_lsp', 'vsnip', 'buffer', 'path', 'tmux'),
      as_names('buffer')
    ),
    formatting = {
      format = lkicons.cmp_format({
        with_text = true,
        maxwidth = 50,
        mode = 'symbol_text',

        before = function(_, vim_item)
          return vim_item
        end,
      }),
    },
  }

  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = as_names('buffer'),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp_map.preset.cmdline(),
    sources = cmp_src(
      as_names('path'),
      as_names('cmdline')
    ),
  })

  vim.cmd([[
    " Expand
    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  ]])
end
