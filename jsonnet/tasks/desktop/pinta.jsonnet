local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local image_name = 'Pinta-3.1.2-anylinux-x86_64.AppImage';
local image_url = 'https://github.com/pkgforge-dev/Pinta-AppImage/releases/download/3.1.2%402026-09-07_1788768837/' + image_name;
local appimage = ctx.home + '/bin/appimages/' + image_name;
local pinta_bin = ctx.home + '/bin/pinta';

// GUI image editor — included from desktop/main (gui_workstations).
[
  F.Dir(
    ctx.home + '/bin/appimages',
    name='Create appimages dir',
  ),
  {
    name: 'Check if pinta is installed',
    stat: {
      path: pinta_bin,
      follow: true,
    },
    register: 'pinta_binary',
  },
  {
    name: 'Download pinta appimage',
    when: 'not pinta_binary.stat.exists',
    get_url: {
      url: image_url,
      dest: appimage,
      owner: ctx.user.name,
      group: ctx.user.name,
      mode: '755',
    },
  },
  F.Link(
    appimage,
    pinta_bin,
    name='Link pinta appimage',
    when='not pinta_binary.stat.exists',
  ),
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
