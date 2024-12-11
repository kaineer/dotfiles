--
-- lua/lsp/servers/sumneko_lua.lua
--

-- DONE: installed sumneko_lua and attached it to neovim
--  How: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/

local globals = { 'vim', 'use' }

return {
  name = 'lua_ls',
  opts = {
    settings = {
      Lua = {
        diagnostics = {
          globals = globals
        },
      },
    },
  },
}
