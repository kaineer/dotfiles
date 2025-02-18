-- autocmd/javascript.lua

local bindings = {
	{ "<c-r>", ":!node %<cr>" },
	{ "<c-d>", ":lua vim.diagnostic.disable()<cr>" },
	{ "<c-e>", ":lua vim.diagnostic.enable()<cr>" },
}

return {
	name = "Javascript",
	config = function(cmd)
		cmd("FileType", {
			pattern = "javascript",
			callback = function()
				vim.diagnostic.enable(false)
				require("core.map").buffer(bindings, { silent = true })
			end,
		})
	end,
}
