local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local herdr_home = ctx.home + '/.config/herdr-app';
local herdr_files = ctx.files + '/herdr';

// Personal Nord overlay (settings, theme, layout, tabs-nord).
// Intentionally omits keys.json — keep machine-local keybindings.
// Disabled until work machine has its keys.json sorted; flip when to true then.
local link_herdr_config = false;

local herdr_dirs = [
  'themes',
  'layouts',
  'mods/tabs-nord',
];

local link_files = [
  'settings.json',
  'themes/nord.json',
  'layouts/main-nord.json',
  'mods/tabs-nord/main.js',
  'mods/tabs-nord/mod.json',
  'mods/tabs-nord/win-close.svg',
  'mods/tabs-nord/win-max.svg',
  'mods/tabs-nord/win-min.svg',
  'mods/tabs-nord/win-restore.svg',
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
        for dir in herdr_dirs
      ] + [
        F.Link(
          herdr_files + '/' + path,
          herdr_home + '/' + path,
          name='Link herdr ' + path,
        )
        for path in link_files
      ],
  },
]
