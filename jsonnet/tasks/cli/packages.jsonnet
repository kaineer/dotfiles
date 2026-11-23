local S = import 'split.jsonnet';
local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

// System packages + cleanup; ~/bin is user-side.
S.Merge([
  S.System([
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
  ]),
  S.User([
    F.Dir(
      ctx.home + '/bin',
      name='Create bin directory',
    ),
  ]),
])
