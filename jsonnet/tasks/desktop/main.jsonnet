// Desktop / GUI workstation tasks (gui_workstations only).
// Add gui/* modules here as they migrate.
local wezterm = import 'wezterm.jsonnet';
local rofi = import 'rofi.jsonnet';
local gnome = import 'gnome.jsonnet';
local pinta = import 'pinta.jsonnet';
local brave = import 'brave.jsonnet';

[
  {
    name: 'Desktop workstation tasks',
    when: 'ansible_nodename in gui_workstations',
    block: wezterm + rofi + gnome + pinta + brave,
  },
]

