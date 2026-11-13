local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local DL = import 'download-install.jsonnet';

local herdr_home = ctx.home + '/.config/herdr-app';
local herdr_files = ctx.files + '/herdr';

// Personal Nord overlay (settings, keys, theme, layout, mods).
local link_herdr_config = true;

// Dirs that hold per-file links. Multi-file mods with relative imports
// (on-screen) must be a directory symlink — Herdr rejects ./foo.js that
// resolves outside the mod folder through file symlinks.
local herdr_dirs = [
  'themes',
  'layouts',
  'mods/tabs-nord',
  'mods/spaces-nord',
  'mods/files-toggle',
  'mods/changes-toggle',
  'mods/cursor-status',
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
  // Whole folder: relative imports stay inside the mod.
  { path: 'mods/on-screen', name: 'on-screen mod' },
  { path: 'sounds', name: 'notification sounds' },
];

local user_path =
  ctx.home + '/.cargo/bin:'
  + ctx.home + '/.local/bin:'
  + ctx.home + '/bin:'
  + '{{ ansible_env.PATH }}';

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
      ] + [
        F.Absent(
          herdr_home + '/mods/vim-nav',
          name='Remove unused vim-nav mod',
        ),
        {
          name: 'Install cursor-status Cursor hooks',
          become_user: ctx.user.name,
          environment: {
            HOME: ctx.home,
            PATH: user_path,
            HERDR_APP_HOME: herdr_home,
          },
          script: herdr_files + '/scripts/install-cursor-status-hooks.sh',
        },
        {
          name: 'Check herdr-gitview binary',
          stat: {
            path: herdr_home + '/mods/gitview/bin/herdr-gitview',
          },
          register: 'gitview_bin',
        },
        {
          name: 'Install herdr-gitview when missing',
          when: 'not gitview_bin.stat.exists',
          become_user: ctx.user.name,
          environment: {
            HOME: ctx.home,
            PATH: user_path,
            HERDR_APP_HOME: herdr_home,
            HERDR_APP_BIN: ctx.home + '/.local/bin/herdr-app',
            CARGO_HOME: ctx.home + '/.cargo',
            RUSTUP_HOME: ctx.home + '/.rustup',
          },
          script: herdr_files + '/scripts/install-gitview.sh',
        },
      ],
  },
]
