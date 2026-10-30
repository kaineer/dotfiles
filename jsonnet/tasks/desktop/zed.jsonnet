local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  {
    name: 'Install Zed using the official install script',
    become_user: ctx.user.name,
    shell: 'curl -fsSL https://zed.dev/install.sh | sh',
    args: {
      creates: ctx.home + '/.local/bin/zed',
    },
  },
  F.Dir(
    ctx.home + '/.config/zed',
    name='Create configuration dir',
    mode='0755',
  ),
  F.Link(
    ctx.files + '/zed/settings.json',
    ctx.home + '/.config/zed/settings.json',
    name='Create link to settings.json',
  ),
  F.Link(
    ctx.files + '/zed/keymap.json',
    ctx.home + '/.config/zed/keymap.json',
    name='Create link to keymap.json',
  ),
  F.Dir(
    ctx.home + '/.config/zed/themes',
    name='Create theme directory',
    mode='0755',
  ),
  {
    name: 'Download nordic theme',
    get_url: {
      url: 'https://raw.githubusercontent.com/bIaqat/nordic-theme-zed/refs/heads/main/themes/nordic.json',
      dest: ctx.home + '/.config/zed/themes/nordic.json',
      owner: ctx.user.name,
      group: ctx.user.name,
      force: false,
    },
  },
]
