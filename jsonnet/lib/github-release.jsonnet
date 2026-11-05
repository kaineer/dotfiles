// Helpers for "stat binary → include_role github-release" pattern.
local ctx = import 'ctx.jsonnet';

{
  Check(path, register, name=null):: {
    name: if name != null then name else 'Check if installed: ' + path,
    stat: { path: path },
    register: register,
  },

  Install(register, vars, name):: {
    name: name,
    when: 'not ' + register + '.stat.exists',
    include_role: {
      name: 'ansible-role-github-release',
    },
    vars: { owner: ctx.user.name } + vars,
  },
}
