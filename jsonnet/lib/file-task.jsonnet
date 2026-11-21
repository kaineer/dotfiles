local ctx = import 'ctx.jsonnet';

local owned(f) = f + {
  owner: ctx.user.name,
  group: ctx.user.name,
};

local withWhen(task, when) =
  task + (if when != null then { when: when } else {});

// Ansible-safe register from a filesystem path.
local regFromPath(path) =
  local chars = std.stringChars(path);
  local out = [
    if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')
    then c
    else '_'
    for c in chars
  ];
  'dirlink_' + std.join('', out);

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

  // Symlink that may replace a leftover non-empty directory (ansible refuses
  // state=link on non-empty dirs even with force=true).
  // Returns a list of tasks — flatten at the call site.
  DirLink(src, dest, name=null, force=true)::
    local label = if name != null then name else dest;
    local reg = regFromPath(dest);
    [
      {
        name: 'Stat before dir-link ' + label,
        stat: { path: dest },
        register: reg,
      },
      {
        name: 'Remove non-symlink dir for ' + label,
        when: reg + '.stat.exists and ' + reg + '.stat.isdir and not ' + reg + '.stat.islnk',
        file: {
          path: dest,
          state: 'absent',
        },
      },
      $.Link(src, dest, name='Link ' + label, force=force),
    ],

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
