// Desktop / GUI workstation tasks (gui_workstations only).
local S = import 'split.jsonnet';
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

local parts = S.Merge([
  packages,
  wezterm,
  rofi,
  gnome,
  pinta,
  brave,
  eog,
  obsidian,
  telegram,
  zathura,
  zed,
  fonts,
]);

local gate(name, tasks) =
  if std.length(tasks) == 0 then
    []
  else
    [{
      name: name,
      when: 'ansible_nodename in gui_workstations',
      block: tasks,
    }];

S.Merge([
  S.System(gate('Desktop workstation tasks (system)', parts.system)),
  S.User(gate('Desktop workstation tasks (user)', parts.user)),
])
