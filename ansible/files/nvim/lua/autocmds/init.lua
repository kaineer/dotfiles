--
-- autocmds/init.lua
--

local applyCmd = function(name)
  local au = require("kaineer.autocmd").au
  local mod = require("autocmds." .. name)
  local group = mod.name
  local fn = mod.config

  au(group, fn)
end

applyCmd("whitespaces")
applyCmd("direnv")
applyCmd("opls")
applyCmd("term")
