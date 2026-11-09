local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local image_name = 'WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage';
local image_tag = '20240203-110809-5046fc22';
local appimage = ctx.home + '/bin/appimages/wezterm.AppImage';
local wezterm_bin = ctx.home + '/bin/wezterm';

[
  F.Dir(
    ctx.home + '/bin/appimages',
    name='Create appimages dir',
  ),
  {
    name: 'Check if wezterm is installed',
    stat: { path: wezterm_bin },
    register: 'wezterm_binary',
  },
  {
    name: 'Check wezterm config directory',
    stat: { path: ctx.home + '/.config/wezterm' },
    register: 'wezterm_config_directory',
  },
  {
    name: 'Download wezterm appimage',
    when: 'not wezterm_binary.stat.exists',
    get_url: {
      url: 'https://github.com/wez/wezterm/releases/download/' + image_tag + '/' + image_name,
      dest: appimage,
      owner: ctx.user.name,
      group: ctx.user.name,
      mode: '755',
    },
  },
  F.Link(
    appimage,
    wezterm_bin,
    name='Link wezterm appimage',
    when='not wezterm_binary.stat.exists',
  ),
  F.Link(
    ctx.files + '/wezterm/',
    ctx.home + '/.config/wezterm',
    name='Link wezterm config',
    when='not wezterm_config_directory.stat.exists',
  ),
]
