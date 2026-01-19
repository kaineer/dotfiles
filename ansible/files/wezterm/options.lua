-- options.lua

return function(config)
  config.hide_tab_bar_if_only_one_tab = true
  config.window_background_opacity = 1
  config.window_decorations = "NONE"
  config.scrollback_lines = 3000
  config.default_workspace = "home" -- ???
  config.bold_brightens_ansi_colors = "BrightOnly" -- "BrightAndBold"
  config.check_for_updates = false
end
