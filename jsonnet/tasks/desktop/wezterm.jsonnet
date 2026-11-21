local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local AI = import 'appimage-task.jsonnet';

local image_name = 'WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage';
local image_tag = '20240203-110809-5046fc22';
local image_url = 'https://github.com/wez/wezterm/releases/download/' + image_tag + '/' + image_name;

AI.Install(
  'wezterm',
  url=image_url,
  image=image_name,
  store_as='wezterm.AppImage',
) + [
  {
    name: 'Check wezterm config directory',
    stat: { path: ctx.home + '/.config/wezterm' },
    register: 'wezterm_config_directory',
  },
  F.Link(
    ctx.files + '/wezterm/',
    ctx.home + '/.config/wezterm',
    name='Link wezterm config',
    when='not wezterm_config_directory.stat.exists',
  ),
]
