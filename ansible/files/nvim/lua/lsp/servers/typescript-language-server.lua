--
-- lua/lsp/servers/tsserver.lua
--


local create_on_attach = function(on_attach)
  return function(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')

    on_attach(client, bufnr)

    ts_utils.setup({
      filter_out_diagnostics_by_code = { 80001, },
    })

    ts_utils.setup_client(client)
  end
end

--
-- Использует on_attach, чтобы его дополнить
--
return function(on_attach)
  return {
    name = 'tsserver',
    on_attach = create_on_attach(on_attach),
  }
end
