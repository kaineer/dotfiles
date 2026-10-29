local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  F.Link(
    ctx.files + '/tmux/tmux.conf',
    ctx.home + '/.tmux.conf',
    name='Copy .tmux.conf',
    mode='644',
  ),
  F.Link(
    ctx.files + '/tmux/config/',
    ctx.home + '/.config/tmux',
    name='Set tmux config link',
  ),
  F.Link(
    ctx.files + '/tmux/profile/tmux',
    ctx.home + '/.config/profile.d/tmux',
    name='Set profile link',
  ),
]
