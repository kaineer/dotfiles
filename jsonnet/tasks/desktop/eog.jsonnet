local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local plugins = ['jk-nav.plugin', 'jk-nav.py'];

[
  F.Dir(
    ctx.home + '/.local/share/eog/plugins',
    name='Mkdir for eog plugins',
    recurse=true,
  ),
] + [
  F.Link(
    ctx.files + '/eog/' + item,
    ctx.home + '/.local/share/eog/plugins/' + item,
    name='Link eog plugins: ' + item,
  )
  for item in plugins
] + [
  {
    name: 'Enable eog jk-nav plugin',
    become_user: ctx.user.name,
    dconf: {
      key: '/org/gnome/eog/plugins/active-plugins',
      value: "['fullscreen', 'jk-nav']",
    },
  },
]
