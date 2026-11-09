local ctx = import 'ctx.jsonnet';
local rust_scripts = import 'rust-scripts.jsonnet';

local cargoEnv = {
  PATH: ctx.home + '/.cargo/bin:{{ ansible_env.PATH }}',
  HOME: ctx.home,
  CARGO_HOME: ctx.home + '/.cargo',
  RUSTUP_HOME: ctx.home + '/.rustup',
};

local cliRs = ctx.home + '/git/config/cli-rs';

[
  {
    name: 'Install rust CLI from cli-rs via cargo: ' + name,
    become_user: ctx.user.name,
    environment: cargoEnv,
    'ansible.builtin.command': {
      cmd: 'cargo install --path ' + cliRs + '/' + name + ' --force',
      creates: ctx.home + '/.cargo/bin/' + name,
    },
  }
  for name in rust_scripts
] + [
  {
    name: 'Stat leftover ~/bin entries for rust CLIs',
    'ansible.builtin.stat': {
      path: ctx.home + '/bin/{{ item }}',
    },
    loop: rust_scripts,
    register: 'rust_scripts_bin_stats',
  },
  {
    name: 'Remove ~/bin symlinks that shadow cargo installs',
    'ansible.builtin.file': {
      path: ctx.home + '/bin/{{ item.item }}',
      state: 'absent',
    },
    loop: '{{ rust_scripts_bin_stats.results }}',
    when: [
      'item.stat.exists | default(false)',
      'item.stat.islnk | default(false)',
    ],
  },
]
