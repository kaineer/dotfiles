// Creating DConf task (runs in the user play as the invoking user).
//
local ctx = import 'ctx.jsonnet';

function(title, key, value, username=ctx.user.name) {
  name: title,
  dconf: {
    key: key,
    value: value,
  },
}
