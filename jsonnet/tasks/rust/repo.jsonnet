local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local cliRs = ctx.home + '/git/config/cli-rs';
local userEnv = {
  HOME: ctx.home,
  SSH_AUTH_SOCK: "{{ lookup('env', 'SSH_AUTH_SOCK') }}",
};

[
  F.Dir(
    ctx.home + '/git/config',
    name='Ensure ~/git/config directory exists',
  ),
  {
    name: 'Check if cli-rs repository exists',
    'ansible.builtin.stat': {
      path: cliRs + '/.git',
    },
    register: 'cli_rs_git',
  },
  {
    name: 'Clone cli-rs repository',
    when: 'not cli_rs_git.stat.exists',
    become_user: ctx.user.name,
    environment: userEnv,
    'ansible.builtin.git': {
      repo: 'git@github.com:kaineer/cli-rs.git',
      dest: cliRs,
      version: 'master',
      accept_hostkey: true,
      update: false,
    },
  },
  {
    name: 'Pull cli-rs repository',
    when: 'cli_rs_git.stat.exists',
    become_user: ctx.user.name,
    environment: userEnv,
    'ansible.builtin.command': {
      cmd: 'git pull origin master',
      chdir: cliRs,
    },
    register: 'cli_rs_pull',
    changed_when: "'Already up to date' not in cli_rs_pull.stdout",
  },
]
