// Creating DConf task (username from ctx by default)
//
local ctx = import 'ctx.jsonnet';

function(title, key, value, username=ctx.user.name) {
  name: title,
  become_user: username,
  dconf: {
    key: key,
    value: value,
  },
}
