-- options.lua

return function(config)
  config.term = "xterm-256color"

	config.hide_tab_bar_if_only_one_tab = true
	-- 1.0 can leave the text cursor unpainted until the first Enter (#4224)
	config.window_background_opacity = 0.99
	config.window_decorations = "RESIZE"
	config.default_cursor_style = "SteadyBlock"
	config.scrollback_lines = 3000
	config.default_workspace = "home" -- ???
	-- config.bold_brightens_ansi_colors = "BrightOnly" -- "BrightAndBold"
	config.bold_brightens_ansi_colors = "BrightAndBold"
	config.check_for_updates = false
end
