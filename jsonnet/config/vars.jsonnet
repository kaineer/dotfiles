// Ansible vars emitted as ansible/vars.json (JSON ⊂ YAML).
local packages = import 'packages/index.jsonnet';
local scripts = import 'scripts-data.jsonnet';
local workstations = import 'workstations.jsonnet';

{
  user: {
    name: std.extVar('USER'),
    email: 'kaineer@gmail.com',
  },

  system_packages: packages.system,
  gui_packages: packages.gui,
  obsolete_packages: packages.obsolete,

  gui_workstations: workstations.gui_workstations,

  // Kept for completeness; task loops are expanded at jsonnet build time.
  scripts: scripts.scripts,
  rust_scripts: scripts.rust_scripts,
  logs: scripts.logs,
}
