local ctx = import 'ctx.jsonnet';

[
  {
    name: 'Check herdr presence',
    stat: {
      path: ctx.home + '/.local/bin/herdr-app',
    },
    register: 'herdr_bin',
  },
  {
    name: 'Install herdr',
    when: 'not herdr_bin.stat.exists',
    block: [
      {
        name: 'Download herdr install script',
        get_url: {
          url: 'https://releases.herdr.dev/app/install.sh',
          dest: '/tmp/herdr-install.sh',
          mode: '0755',
        },
      },
      {
        name: 'Run herdr install script',
        become_user: ctx.user.name,
        environment: {
          HOME: ctx.home,
        },
        command: '/tmp/herdr-install.sh',
      },
      {
        name: 'Remove herdr install script',
        file: {
          path: '/tmp/herdr-install.sh',
          state: 'absent',
        },
      },
    ],
  },
]
