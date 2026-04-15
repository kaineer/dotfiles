local ctx = {
  user: {
    name: std.extVar("USER"),
    email: "kaineer@gmail.com"
  },
  hostname: std.extVar("HOSTNAME"),
};

local fn(ctx) = {
  username: ctx.user.name,
  hostname: ctx.hostname,
};

fn(ctx)
