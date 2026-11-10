local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local herdr_home = ctx.home + '/.config/herdr-app';
local herdr_files = ctx.files + '/herdr';

// Personal Nord overlay (settings, keys, theme, layout, tabs-nord).
local link_herdr_config = true;

local link_dirs = [
  'themes',
  'layouts',
  'mods/tabs-nord',
  'mods/files-toggle',
  'mods/changes-toggle',
];

local link_files = [
  { path: 'settings.json', name: 'settings' },
  { path: 'keys.json', name: 'keys' },
  { path: 'programs.json', name: 'programs' },
  { path: 'themes/nord.json', name: 'nord theme' },
  { path: 'layouts/main-nord.json', name: 'nord theme layout' },
  { path: 'mods/tabs-nord/main.js', name: 'nord theme tabs main.js' },
  { path: 'mods/tabs-nord/mod.json', name: 'nord theme tabs mod.json' },
  { path: 'mods/files-toggle/main.js', name: 'files-toggle main.js' },
  { path: 'mods/files-toggle/mod.json', name: 'files-toggle mod.json' },
  { path: 'mods/changes-toggle/main.js', name: 'changes-toggle main.js' },
  { path: 'mods/changes-toggle/mod.json', name: 'changes-toggle mod.json' },
];

[
  {
    name: 'Check herdr presence',
    stat: {
      path: ctx.home + '/.local/bin/herdr-app',
    },
    register: 'herdr_bin',
  },
  {
    name: 'Install herdr',
    when: 'not herdr_bin.stat.exists',
    block: [
      {
        name: 'Download herdr install script',
        get_url: {
          url: 'https://releases.herdr.dev/app/install.sh',
          dest: '/tmp/herdr-install.sh',
          mode: '0755',
        },
      },
      {
        name: 'Run herdr install script',
        become_user: ctx.user.name,
        environment: {
          HOME: ctx.home,
        },
        command: '/tmp/herdr-install.sh',
      },
      {
        name: 'Remove herdr install script',
        file: {
          path: '/tmp/herdr-install.sh',
          state: 'absent',
        },
      },
    ],
  },
  {
    name: 'Link herdr personal config',
    when: link_herdr_config,
    block:
      [
        F.Dir(
          herdr_home + '/' + dir,
          name='Ensure herdr ' + dir + ' dir',
        )
        for dir in link_dirs
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
