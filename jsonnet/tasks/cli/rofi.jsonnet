local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

[
  F.Link(
    ctx.files + '/rofi',
    ctx.home + '/.config/rofi',
    name='Link config for rofi',
  ),
]
