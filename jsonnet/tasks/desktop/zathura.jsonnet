local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  {
    name: 'Check if zathura is installed',
    stat: { path: '/bin/zathura' },
    register: 'zathura_bin',
  },
  {
    name: 'Configure zathura',
    when: 'zathura_bin.stat.exists',
    block: [
      F.Dir(
        ctx.home + '/.config/zathura',
        name='Create config dir',
        mode='0755',
      ),
      F.Link(
        ctx.files + '/zathura/rc',
        ctx.home + '/.config/zathura/zathurarc',
        name='Link zathura config',
      ),
    ],
  },
]
