-- plugins/completion/sources/tmux.lua

local quoteTrigger = { '"' }

return {
	name = "tmux",
	option = {
		label = " tmux",
		trigger_characters_ft = {
			javascript = quoteTrigger,
			typescript = quoteTrigger,
			yaml = quoteTrigger,
			json = quoteTrigger,
			lua = quoteTrigger,
			markdown = { "# " },
		},
		capture_history = true,
	},
}
