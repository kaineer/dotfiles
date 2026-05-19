local ctx = {
  user: {
    name: std.extVar('USER'),
    email: 'kaineer@gmail.com',
    fullname: 'Tangerine Cat',
  },
  hostname: std.extVar('HOSTNAME'),
};

local fn(ctx) = {
  username: ctx.user.name,
  hostname: ctx.hostname,
  email: ctx.user.email,
  fullname: ctx.user.fullname,
  gitname: ctx.user.fullname + ' <' + ctx.user.email + '>',
};

fn(ctx)
