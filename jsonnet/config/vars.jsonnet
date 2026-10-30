// Ansible vars emitted as ansible/vars.json (JSON ⊂ YAML).
{
  user: {
    name: std.extVar('USER'),
    email: 'kaineer@gmail.com',
  },

  system_packages: import 'packages/system.jsonnet',
  gui_packages: import 'packages/gui.jsonnet',
  obsolete_packages: import 'packages/obsolete.jsonnet',

  gui_workstations: import 'workstations.jsonnet',

  // Kept for completeness; task loops are expanded at jsonnet build time.
  scripts: import 'bash-scripts.jsonnet',
  rust_scripts: import 'rust-scripts.jsonnet',
  logs: import 'logs.jsonnet',
}
