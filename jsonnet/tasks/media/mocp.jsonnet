local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local dirs = ['themes', 'pid'];
local links = [
  { name: 'config', path: 'config' },
  { name: 'keymap', path: 'keymap' },
  { name: 'theme', path: 'themes/theme' },
];

[
  F.Dir(
    ctx.home + '/.moc/' + dir,
    name='Mkdir for mocp configs: ' + dir,
    recurse=true,
  )
  for dir in dirs
] + [
  F.Link(
    ctx.files + '/mocp/' + item.name,
    ctx.home + '/.moc/' + item.path,
    name='Link mocp config: ' + item.name,
  )
  for item in links
]
