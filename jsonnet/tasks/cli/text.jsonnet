local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local ripgrep = import 'cli/text/ripgrep.jsonnet';
local fd = import 'cli/text/fd.jsonnet';
local jless = import 'cli/text/jless.jsonnet';
local eza = import 'cli/text/eza.jsonnet';
local bat = import 'cli/text/bat.jsonnet';
local hurl = import 'cli/text/hurl.jsonnet';
local xq = import 'cli/text/xq.jsonnet';

[
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
] + ripgrep + fd + jless + eza + bat + hurl + xq
