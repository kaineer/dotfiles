local ctx = import 'ctx.jsonnet';

local owned(f) = f + {
  owner: ctx.user.name,
  group: ctx.user.name,
};

local withWhen(task, when) =
  task + (if when != null then { when: when } else {});

{
  // Directory with default owner/group/mode.
  // Pass `name` to keep a readable ansible task title on failure.
  Dir(path, name=null, mode='755', recurse=false, when=null):: withWhen({
    name: if name != null then name else 'Create ' + path,
    file: owned({
      path: path,
      state: 'directory',
      mode: mode,
    } + (if recurse then { recurse: true } else {})),
  }, when),

  // Symlink with default owner/group.
  Link(src, dest, name=null, force=true, mode=null, when=null):: withWhen({
    name: if name != null then name else 'Link ' + dest,
    file: owned({
      src: src,
      dest: dest,
      state: 'link',
      force: force,
    } + (if mode != null then { mode: mode } else {})),
  }, when),

  Absent(path, name=null, when=null):: withWhen({
    name: if name != null then name else 'Remove ' + path,
    file: {
      path: path,
      state: 'absent',
    },
  }, when),

  // Expand list of {src, dest, name?} into Link tasks
  Links(items):: [
    $.Link(
      item.src,
      item.dest,
      name=std.get(item, 'name', null),
    )
    for item in items
  ],
}
