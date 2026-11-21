local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local AI = import 'appimage-task.jsonnet';

local obsidian_version = '1.14.4';
local obsidian_repo = 'https://github.com/obsidianmd/obsidian-releases';
local image_name = 'Obsidian-' + obsidian_version + '.AppImage';
local image_url = obsidian_repo + '/releases/download/v' + obsidian_version + '/' + image_name;
local obsidian_bin = ctx.home + '/bin/obsidian';
local icon_src = ctx.files + '/obsidian/obsidian.svg';
local icon_dest = ctx.home + '/.local/share/icons/hicolor/scalable/apps/obsidian.svg';

AI.Install(
  'obsidian',
  url=image_url,
  image=image_name,
) + [
  F.Dir(
    ctx.home + '/.local/share/icons/hicolor/scalable/apps',
    name='Create icons dir for obsidian',
  ),
  {
    name: 'Install obsidian icon',
    copy: {
      src: icon_src,
      dest: icon_dest,
      owner: ctx.user.name,
      group: ctx.user.name,
      mode: '644',
    },
  },
  {
    name: 'Find theme obsidian icons to override',
    find: {
      paths: [
        ctx.home + '/.icons',
        ctx.home + '/.local/share/icons',
      ],
      patterns: [
        'obsidian.svg',
        'md.obsidian.Obsidian.svg',
      ],
      file_type: 'file',
    },
    register: 'obsidian_theme_icons',
  },
  {
    name: 'Override theme obsidian icons',
    copy: {
      src: icon_src,
      dest: '{{ item.path }}',
      owner: ctx.user.name,
      group: ctx.user.name,
      mode: '644',
    },
    loop: '{{ obsidian_theme_icons.files }}',
    loop_control: {
      label: '{{ item.path }}',
    },
  },
  F.Dir(
    ctx.home + '/.local/share/applications',
    name='Create applications dir',
  ),
  F.Absent(
    ctx.home + '/.local/share/applications/obsidian.desktop',
    name='Remove legacy obsidian desktop entry',
  ),
  {
    name: 'Install obsidian desktop entry',
    copy: {
      dest: ctx.home + '/.local/share/applications/md.obsidian.Obsidian.desktop',
      owner: ctx.user.name,
      group: ctx.user.name,
      mode: '644',
      content: |||
        [Desktop Entry]
        Type=Application
        Name=Obsidian
        Comment=Markdown knowledge base
        Exec=%(bin)s %%U
        Icon=%(icon)s
        Terminal=false
        Categories=Office;
        MimeType=x-scheme-handler/obsidian;
        StartupWMClass=md.obsidian.Obsidian
      ||| % { bin: obsidian_bin, icon: icon_dest },
    },
  },
  {
    name: 'Refresh icon and desktop caches',
    shell: |||
      gtk-update-icon-cache -f "%(home)s/.local/share/icons/hicolor" 2>/dev/null || true
      update-desktop-database "%(home)s/.local/share/applications" 2>/dev/null || true
    ||| % { home: ctx.home },
    changed_when: false,
  },
]
