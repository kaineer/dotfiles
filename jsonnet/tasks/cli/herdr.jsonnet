local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local DL = import 'download-install.jsonnet';

local herdr_home = ctx.home + '/.config/herdr-app';
local herdr_files = ctx.files + '/herdr';

// Personal Nord overlay (settings, keys, theme, layout, tabs-nord).
local link_herdr_config = true;

local herdr_dirs = [
  'themes',
  'layouts',
  /**
   * Themes and panel shortcuts
   */
  'mods/tabs-nord',  // nord theme
  'mods/spaces-nord',  // nord theme spaces
  'mods/files-toggle',  // files panel
  'mods/changes-toggle',  // changes panel
  'mods/cursor-status',  // Cursor Agent CLI → Herdr Agents
];

local link_files = [
  { path: 'settings.json', name: 'settings' },
  { path: 'keys.json', name: 'keys' },
  { path: 'programs.json', name: 'programs' },
  { path: 'themes/nord.json', name: 'nord theme' },
  { path: 'layouts/main-nord.json', name: 'nord theme layout' },
  { path: 'mods/tabs-nord/main.js', name: 'nord theme tabs main.js' },
  { path: 'mods/tabs-nord/mod.json', name: 'nord theme tabs mod.json' },
  { path: 'mods/spaces-nord/main.js', name: 'nord theme spaces main.js' },
  { path: 'mods/spaces-nord/mod.json', name: 'nord theme spaces mod.json' },
  { path: 'mods/files-toggle/main.js', name: 'files panel main.js' },
  { path: 'mods/files-toggle/mod.json', name: 'files panel mod.json' },
  { path: 'mods/changes-toggle/main.js', name: 'changes panel main.js' },
  { path: 'mods/changes-toggle/mod.json', name: 'changes panel mod.json' },
  { path: 'mods/cursor-status/main.js', name: 'cursor-status main.js' },
  { path: 'mods/cursor-status/mod.json', name: 'cursor-status mod.json' },
  { path: 'mods/cursor-status/package.json', name: 'cursor-status package.json' },
  { path: 'mods/cursor-status/status.mjs', name: 'cursor-status status.mjs' },
];

[
  {
    name: 'Check herdr presence',
    stat: {
      path: ctx.home + '/.local/bin/herdr-app',
    },
    register: 'herdr_bin',
  },
  DL.Install(
    'herdr',
    binary='herdr_bin',
    url='https://releases.herdr.dev/app/install.sh',
  ),
  {
    name: 'Link herdr personal config',
    when: link_herdr_config,
    block:
      [
        F.Dir(
          herdr_home + '/' + dir,
          name='Ensure herdr ' + dir + ' dir',
        )
        for dir in herdr_dirs
      ] + [
        F.Link(
          herdr_files + '/' + item.path,
          herdr_home + '/' + item.path,
          name='Link herdr ' + item.name,
        )
        for item in link_files
      ],
  },
]
