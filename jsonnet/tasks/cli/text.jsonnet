local bat = import 'cli/text/bat.jsonnet';
local eza = import 'cli/text/eza.jsonnet';
local fd = import 'cli/text/fd.jsonnet';
local hurl = import 'cli/text/hurl.jsonnet';
local jless = import 'cli/text/jless.jsonnet';
// local lig = import 'cli/text/lig.jsonnet';
local ripgrep = import 'cli/text/ripgrep.jsonnet';
local xq = import 'cli/text/xq.jsonnet';
local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
] + ripgrep + fd + jless + eza + bat + hurl + xq  // + lig
