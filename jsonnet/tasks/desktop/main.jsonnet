// Desktop / GUI workstation tasks (gui_workstations only).
local packages = import 'packages.jsonnet';
local wezterm = import 'wezterm.jsonnet';
local rofi = import 'rofi.jsonnet';
local gnome = import 'gnome.jsonnet';
local pinta = import 'pinta.jsonnet';
local brave = import 'brave.jsonnet';
local eog = import 'eog.jsonnet';
local obsidian = import 'obsidian.jsonnet';
local telegram = import 'telegram.jsonnet';
local zathura = import 'zathura.jsonnet';
local zed = import 'zed.jsonnet';
local fonts = import 'fonts.jsonnet';

[
  {
    name: 'Desktop workstation tasks',
    when: 'ansible_nodename in gui_workstations',
    block:
      packages
      + wezterm
      + rofi
      + gnome
      + pinta
      + brave
      + eog
      + obsidian
      + telegram
      + zathura
      + zed
      + fonts,
  },
]


