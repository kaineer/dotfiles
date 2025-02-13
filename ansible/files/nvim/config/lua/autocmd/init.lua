-- autocmd/init.lua

local applyCmd = function(name)
	local au = require("core.autocmd").au
	local mod = require("autocmd." .. name)
	local group = mod.name
	local fn = mod.config

	au(group, fn)
end

local each = require("core.utils").each

each({
	"direnv",
	"javascript",
	"terminal",
	"markdown",
}, applyCmd)
