local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

// System packages + cleanup + ~/bin (runs on every host).
[
  {
    name: 'Install missing packages',
    package: {
      name: '{{ system_packages }}',
      state: 'present',
    },
  },
  {
    name: 'Remove unnecessary packages',
    apt: {
      name: '{{ obsolete_packages }}',
      state: 'absent',
      autoremove: true,
    },
  },
  F.Dir(
    ctx.home + '/bin',
    name='Create bin directory',
  ),
]
