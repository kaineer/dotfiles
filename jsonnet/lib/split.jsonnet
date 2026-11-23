// Split task lists into system (root/become) vs user (home) plays.
// Plain arrays are treated as user-only for gradual migration.
{
  System(tasks):: { system: tasks, user: [] },
  User(tasks):: { system: [], user: tasks },

  coerce(x)::
    if std.type(x) == 'array' then
      $.User(x)
    else if std.type(x) == 'object' && std.objectHas(x, 'system') && std.objectHas(x, 'user') then
      x
    else
      error 'split.coerce: expected task array or {system, user}',

  Merge(parts)::
    local norm = [$.coerce(p) for p in parts];
    {
      system: std.flattenArrays([p.system for p in norm]),
      user: std.flattenArrays([p.user for p in norm]),
    },
}
