--
-- lua/lsp/null_ls.lua
--

return function()
  local null_ls = require("null-ls")

  local formatting  = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local sources = {
    null_ls.builtins.formatting.eslint,
  }

  null_ls.setup{
    sources = sources,
    debug = true,
    --
    --   on_attach = function(client, bufnr)
    --     -- if client.supports_method "textDocument/formatting" then
    --     --   vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    --     --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     --     group = augroup,
    --     --     buffer = bufnr,
    --     --     callback = function()
    --     --       vim.lsp.buf.format({ bufnr = bufnr })
    --     --     end,
    --     --   })
    --     -- end
    --   end,
  }
end

