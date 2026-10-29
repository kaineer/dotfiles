local ctx = import 'ctx.jsonnet';

local owned(f) = f + {
  owner: ctx.user.name,
  group: ctx.user.name,
};

{
  // Directory with default owner/group/mode.
  // Pass `name` to keep a readable ansible task title on failure.
  Dir(path, name=null, mode='755', recurse=false):: {
    name: if name != null then name else 'Create ' + path,
    file: owned({
      path: path,
      state: 'directory',
      mode: mode,
    } + (if recurse then { recurse: true } else {})),
  },

  // Symlink with default owner/group.
  Link(src, dest, name=null, force=true, mode=null):: {
    name: if name != null then name else 'Link ' + dest,
    file: owned({
      src: src,
      dest: dest,
      state: 'link',
      force: force,
    } + (if mode != null then { mode: mode } else {})),
  },

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
