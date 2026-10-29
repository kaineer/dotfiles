local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  F.Link(
    ctx.files + '/bash/rc',
    ctx.home + '/.bashrc',
    name='Copy bashrc',
    mode='644',
  ),
  F.Link(
    ctx.files + '/bash/profile.sh',
    ctx.home + '/.profile',
    name='Copy profile',
    mode='644',
  ),
  F.Dir(
    ctx.home + '/.config/profile.d',
    name='Create profile directory',
  ),
]
