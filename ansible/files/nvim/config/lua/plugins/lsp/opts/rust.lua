return {
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = { command = 'clippy' },
      cargo = {
        allFeatures = true,
      },
      -- можно добавить/убрать по вкусу:
      inlayHints = { bindingModeHints = { enable = false } },
      -- procMacro = { enable = true },
    },
  },
}
