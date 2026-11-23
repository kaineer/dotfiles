local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local AI = import 'appimage-task.jsonnet';

local image_name = 'Pinta-3.1.2-anylinux-x86_64.AppImage';
local image_url = 'https://github.com/pkgforge-dev/Pinta-AppImage/releases/download/3.1.2%402026-09-07_1788768837/' + image_name;

// GUI image editor — included from desktop/main (gui_workstations).
AI.Install(
  'pinta',
  url=image_url,
  image=image_name,
) + [
  F.Dir(
    ctx.home + '/.config/Pinta',
    name='Create pinta config dir',
  ),
  F.Link(
    ctx.files + '/pinta/settings.xml',
    ctx.home + '/.config/Pinta/settings.xml',
    name='Link pinta settings.xml',
  ),
]
