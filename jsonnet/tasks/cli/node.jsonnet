local ctx = import 'ctx.jsonnet';

[
  {
    name: 'Check if fnm is installed',
    stat: {
      path: ctx.home + '/.local/bin/fnm',
    },
    register: 'fnm_binary',
  },
  {
    name: 'Install fnm',
    when: 'not fnm_binary.stat.exists',
    include_role: {
      name: 'ansible-fnm',
    },
    vars: {
      fnm_user: ctx.user.name,
      fnm_root_suffix: '.fnm',
      fnm_skip_shell: true,
      fnm_nodejs_versions: [20],
      fnm_npm_global_packages: [],
    },
  },
]
