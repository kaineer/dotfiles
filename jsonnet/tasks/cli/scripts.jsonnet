local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local data = import 'scripts-data.jsonnet';

[
  F.Dir(
    ctx.home + '/bin',
    name='Create scripts directory',
  ),
] + [
  F.Link(
    ctx.files + '/bash/scripts/' + item,
    ctx.home + '/bin/' + item,
    name='Link scripts: ' + item,
  )
  for item in data.scripts
] + [
  F.Link(
    ctx.files + '/bash/scripts/log',
    ctx.home + '/bin/' + item,
    name='Link logs: ' + item,
  )
  for item in data.logs
] + [
  F.Link(
    ctx.files + '/bash/scripts/gd.d/gd.json',
    ctx.home + '/var/dir.json',
    name='Link gd.json',
  ),
  F.Link(
    ctx.files + '/bash/scripts/lc.var',
    ctx.home + '/var/clip',
    name='Link clip directory',
  ),
]
