local bindings = {
	{ "<a-s>", ":!tmux new-window 'slides %'<cr>" },
}

return {
	name = "MarkdownBindings",
	config = function(cmd)
		cmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.diagnostic.enable(false)
				require("core.map").buffer(bindings, { silent = true })
			end,
		})
	end,
}
