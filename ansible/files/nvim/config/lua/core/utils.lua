local M = {}

function M.assign(target, source)
	for key, value in pairs(source) do
		target[key] = value
	end
end

function M.tap(obj, fn)
	fn(obj)
	return obj
end

function M.each(tbl, fn)
	for i, v in ipairs(tbl) do
		fn(v, i)
	end
end

function M.map(tbl, fn)
	local result = {}
	for i, v in ipairs(tbl) do
		table.insert(result, fn(v, i))
	end
	return result
end

function M.prefix(pre, table)
	return M.map(table, function(value)
		return pre .. value
	end)
end

function M.requireWithPrefix(pre, table)
	return M.map(M.prefix(pre, table), require)
end

--
-- @param target table to put result
-- @param ... sources to get data from
-- @return result of merging target and sources
--
function M.merge(target, ...)
	local sources = { ... }
	local result = {}

	-- First, copy target to result
	for key, value in pairs(target) do
		result[key] = value
	end

	-- Then copy all sources to result
	for _, source in ipairs(sources) do
		M.assign(result, source)
	end

	return result
end

function M.buildMkcmd(message)
	return function(name)
		local runcmd = function()
			vim.api.nvim_command(":" .. name)
		end
		return function()
			if not pcall(runcmd) then
				print(message)
			end
		end
	end
end

return M
