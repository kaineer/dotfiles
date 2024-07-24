-- lua/plugins/lsp/servers.lua

-- TODO: see https://github.com/williamboman/mason.nvim
-- TODO: make prettier work in ts, js etc

local types = require('kaineer.types')
local fns = require('kaineer.fn')
local merge = fns.merge
local forEachEntry = fns.forEachEntry
local forEach = fns.forEach
local tap = fns.tap

local on_attach = function(_, bufnr)
  local buf = vim.lsp.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }

  forEachEntry({
    gd = buf.definition,
    gD = buf.declaration,
    gr = buf.references,
    K  = buf.hover,
    ['<leader>rn'] = buf.rename,
    ['<leader>ca'] = buf.code_action,
    ['<leader>f'] = buf.formatting
  }, function(fn, key) vim.keymap.set('n', key, fn, opts)
  end)
end

local servers = {
  'html',
  'bashls',
  require('lsp.servers.typescript-language-server'),
  require('lsp.servers.lua-language-server'),
  require('lsp.servers.python')
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local get_name = function(lsp)
  if types.fn(lsp) then
    lsp = lsp(on_attach)
  end
  if types.string(lsp) then
    return lsp
  end
  return lsp.name
end

local get_opts = function(lsp)
  local opts = {}
  if types.table(lsp) then
    if types.fn(lsp.opts) then
      opts = lsp.opts()
    elseif types.table(lsp.opts) then
      opts = lsp.opts
    end
  end
  return opts
end

local merge_with_defaults = function(lsp)
  if types.fn(lsp) then
    lsp = lsp(on_attach)
  end
  return merge({
    on_attach = on_attach,
    -- capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }, get_opts(lsp))
end

local load_servers = function()
  tap(require('lspconfig'), function(nvim_lsp)
    forEach(servers, function(lsp)
      nvim_lsp[get_name(lsp)].setup(merge_with_defaults(lsp))
    end)
  end)
end

return load_servers

-- TODO: I'm not so sure about this
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
