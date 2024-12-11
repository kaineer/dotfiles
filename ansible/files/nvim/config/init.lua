-- init.lua

local fn = require("kaineer.fn")

fn.forEach({
  "options",
  "autocmds",
  "bindings",
  "plugins",
}, require)
