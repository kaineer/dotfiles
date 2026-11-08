local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local herdr_home = ctx.home + '/.config/herdr-app';
local herdr_files = ctx.files + '/herdr';

// Personal Nord overlay (settings, theme, layout, tabs-nord).
// Intentionally omits keys.json — keep machine-local keybindings.
// Disabled until work machine has its keys.json sorted; flip when to true then.
local link_herdr_config = false;

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
    block: [
      F.Dir(herdr_home + '/themes', name='Ensure herdr themes dir'),
      F.Dir(herdr_home + '/layouts', name='Ensure herdr layouts dir'),
      F.Dir(herdr_home + '/mods/tabs-nord', name='Ensure herdr tabs-nord dir'),
      F.Link(
        herdr_files + '/settings.json',
        herdr_home + '/settings.json',
        name='Link herdr settings.json',
      ),
      F.Link(
        herdr_files + '/themes/nord.json',
        herdr_home + '/themes/nord.json',
        name='Link herdr nord theme',
      ),
      F.Link(
        herdr_files + '/layouts/main-nord.json',
        herdr_home + '/layouts/main-nord.json',
        name='Link herdr main-nord layout',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/main.js',
        herdr_home + '/mods/tabs-nord/main.js',
        name='Link herdr tabs-nord main.js',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/mod.json',
        herdr_home + '/mods/tabs-nord/mod.json',
        name='Link herdr tabs-nord mod.json',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/win-close.svg',
        herdr_home + '/mods/tabs-nord/win-close.svg',
        name='Link herdr tabs-nord win-close.svg',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/win-max.svg',
        herdr_home + '/mods/tabs-nord/win-max.svg',
        name='Link herdr tabs-nord win-max.svg',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/win-min.svg',
        herdr_home + '/mods/tabs-nord/win-min.svg',
        name='Link herdr tabs-nord win-min.svg',
      ),
      F.Link(
        herdr_files + '/mods/tabs-nord/win-restore.svg',
        herdr_home + '/mods/tabs-nord/win-restore.svg',
        name='Link herdr tabs-nord win-restore.svg',
      ),
    ],
  },
]
