local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local profiles = [
  'aliases',
  'autocd',
  'browser',
  'bind',
  'direnv',
  'editor',
  'fasd',
  'fzf',
  'node',
  'path',
  'containers',
  'ssh',
  'vivid',
  'xdg',
  'zed',
  'not_found',
];

[
  F.Dir(
    ctx.home + '/.config/profile.d',
    name='Create profile directory',
  ),
] + [
  F.Link(
    ctx.files + '/bash/profile/' + item,
    ctx.home + '/.config/profile.d/' + item,
    name='Link profile files: ' + item,
  )
  for item in profiles
]
