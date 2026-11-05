local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

// Drop leftover lf binary/symlink from ~/bin (yazi replaces it).
[
  F.Absent(
    ctx.home + '/bin/lf',
    name='Remove ~/bin/lf',
  ),
]
