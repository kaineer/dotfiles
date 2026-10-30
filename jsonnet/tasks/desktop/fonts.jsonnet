local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local firaDir = ctx.home + '/.local/share/fonts/FiraCode';

[
  F.Dir(
    firaDir,
    name='Prepare folder for fira code fonts',
  ),
  {
    name: 'Install fira nerd',
    'ansible.builtin.unarchive': {
      src: 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz',
      dest: firaDir,
      remote_src: true,
      creates: firaDir + '/FiraCodeNerdFont-Regular.ttf',
    },
  },
  F.Absent(
    ctx.home + '/.fonts',
    name='Remove .fonts dir',
  ),
  {
    name: 'Prepare fonts cache',
    'ansible.builtin.command': 'fc-cache -f',
    changed_when: false,
  },
]
