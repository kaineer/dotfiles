-- Функция, которая выполняется при подключении LSP
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- Маппинги для навигации
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)        -- переход к определению
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)       -- переход к объявлению
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)    -- переход к реализации
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)        -- показать использования
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)              -- информация под курсором
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- сигнатура функции
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)    -- переименование
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- действия с кодом
end

return on_attach
