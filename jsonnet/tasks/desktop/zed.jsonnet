local ctx = import 'ctx.jsonnet';
local DL = import 'download-install.jsonnet';
local F = import 'file-task.jsonnet';

local zed_home = ctx.home + '/.config/zed';
local zed_src = ctx.files + '/zed';

local zed_dirs = [
  zed_home,
  zed_home + '/themes',
];

local zed_files = [
  { path: 'settings.json', name: 'settings' },
  { path: 'keymap.json', name: 'user bindings' },
];

[
  {
    name: 'Check zed presence',
    stat: {
      path: ctx.home + '/.local/bin/zed',
    },
    register: 'zed_bin',
  },
  DL.Install(
    'zed',
    binary='zed_bin',
    url='https://zed.dev/install.sh',
  ),
] + [
  F.Dir(
    dir,
    name='Ensure zed dir ' + dir,
    mode='0755',
  )
  for dir in zed_dirs
] + [
  F.Link(
    zed_src + '/' + item.path,
    zed_home + '/' + item.path,
    name='Link zed ' + item.name,
  )
  for item in zed_files
] + [
  {
    name: 'Download nordic theme',
    get_url: {
      url: 'https://raw.githubusercontent.com/bIaqat/nordic-theme-zed/refs/heads/main/themes/nordic.json',
      dest: zed_home + '/themes/nordic.json',
      owner: ctx.user.name,
      group: ctx.user.name,
      force: false,
    },
  },
]
