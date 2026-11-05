local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local configs = ['yazi.toml', 'keymap.toml', 'theme.toml'];
local plugins = ['on-enter.yazi'];
local pluginSrc = ctx.files + '/yazi/plugins';

[
  F.Dir(
    ctx.home + '/.config/yazi',
    name='Mkdir for yazi config',
    recurse=true,
  ),
] + [
  F.Link(
    ctx.files + '/yazi/' + item,
    ctx.home + '/.config/yazi/' + item,
    name='Link yazi config files: ' + item,
    mode='644',
  )
  for item in configs
] + [
  F.Dir(
    ctx.home + '/.config/yazi/plugins',
    name='Mkdir for yazi plugins',
    recurse=true,
  ),
  {
    name: 'Stat yazi plugins',
    'ansible.builtin.stat': {
      path: ctx.home + '/.config/yazi/plugins/{{ item }}',
    },
    loop: plugins,
    register: 'yazi_plugin_stats',
  },
  {
    name: 'Remove yazi plugin dest unless already linked',
    'ansible.builtin.file': {
      path: ctx.home + '/.config/yazi/plugins/{{ item.item }}',
      state: 'absent',
    },
    loop: '{{ yazi_plugin_stats.results }}',
    when: [
      'item.stat.exists | default(false)',
      "not ((item.stat.islnk | default(false)) and item.stat.lnk_source == (playbook_dir ~ '/files/yazi/plugins/' ~ item.item))",
    ],
  },
] + [
  F.Link(
    pluginSrc + '/' + item,
    ctx.home + '/.config/yazi/plugins/' + item,
    name='Link yazi plugins: ' + item,
  )
  for item in plugins
] + [
  {
    name: 'Install yazi via cargo',
    become_user: ctx.user.name,
    environment: {
      PATH: ctx.home + '/.cargo/bin:{{ ansible_env.PATH }}',
      HOME: ctx.home,
      CARGO_HOME: ctx.home + '/.cargo',
      RUSTUP_HOME: ctx.home + '/.rustup',
    },
    'community.general.cargo': {
      name: ['yazi-build'],
    },
  },
] + [
  F.Absent(
    ctx.home + '/bin/' + item,
    name='Remove stale yazi binaries from ~/bin: ' + item,
  )
  for item in ['yazi', 'ya']
]
