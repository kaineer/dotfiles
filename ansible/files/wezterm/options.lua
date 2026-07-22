-- options.lua

return function(config)
  config.term = "xterm-256color"

	config.hide_tab_bar_if_only_one_tab = true
	config.window_background_opacity = 1
	config.window_decorations = "NONE"
	config.scrollback_lines = 3000
	config.default_workspace = "home" -- ???
	-- config.bold_brightens_ansi_colors = "BrightOnly" -- "BrightAndBold"
	config.bold_brightens_ansi_colors = "BrightAndBold"
	config.check_for_updates = false
end
