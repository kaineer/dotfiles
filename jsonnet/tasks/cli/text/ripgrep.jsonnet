local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local Pkg = import 'package-task.jsonnet';

local ripgrepConfigDir = ctx.home + '/.config/ripgrep';

[
  Pkg('Install ripgrep', 'ripgrep'),
  F.Link(
    ctx.files + '/ripgrep/profile',
    ctx.home + '/.config/profile.d/ripgrep',
    name='Configurate ripgrep through profile',
  ),
  F.Dir(
    ripgrepConfigDir,
    name='Create config file dir',
  ),
  F.Link(
    ctx.files + '/ripgrep/config',
    ripgrepConfigDir + '/config',
    name='Set link to ripgrep config',
  ),
]
