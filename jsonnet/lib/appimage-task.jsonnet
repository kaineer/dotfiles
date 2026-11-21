// Helpers for "ensure ~/bin/appimages → download AppImage → link ~/bin/<name>".
local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local appimagesDir = ctx.home + '/bin/appimages';

{
  dir:: appimagesDir,

  // name: short label; also default ~/bin/<name> and register <name>_appimage
  // url: download URL
  // image: remote/local AppImage filename (stored under appimages/ unless store_as)
  // bin: symlink basename in ~/bin (default: name)
  // store_as: optional on-disk filename under appimages/ (default: image)
  // Returns a flat task list (Dir + Check + Download + Link).
  Install(name, url, image, bin=null, store_as=null)::
    local binName = if bin != null then bin else name;
    local binPath = ctx.home + '/bin/' + binName;
    local destName = if store_as != null then store_as else image;
    local dest = appimagesDir + '/' + destName;
    local reg = std.strReplace(name, '-', '_') + '_appimage';
    [
      F.Dir(
        appimagesDir,
        name='Create appimages dir',
      ),
      {
        name: 'Check if ' + name + ' appimage is linked',
        stat: {
          path: binPath,
          follow: true,
        },
        register: reg,
      },
      {
        name: 'Download ' + name + ' appimage',
        when: 'not ' + reg + '.stat.exists',
        get_url: {
          url: url,
          dest: dest,
          owner: ctx.user.name,
          group: ctx.user.name,
          mode: '755',
        },
      },
      F.Link(
        dest,
        binPath,
        name='Link ' + name + ' appimage',
        when='not ' + reg + '.stat.exists',
      ),
    ],
}
