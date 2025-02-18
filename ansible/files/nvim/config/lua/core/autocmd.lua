-- core/autocmd.lua

local types = require("core.types")
local M = {}

function M.au(name, fn)
	local api = vim.api
	local group_id = api.nvim_create_augroup(name, { clear = true })

	if types.fn(fn) then
		local cmd = function(event, opts)
			opts = opts or {}
			opts.group = opts.group or group_id
			api.nvim_create_autocmd(event, opts)
		end
		fn(cmd)
	end
end

return M
