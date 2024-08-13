-- https://youtu.be/I3ipo8NxsjY

local wezterm = require("wezterm")
local bindings = require("./bindings")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true

-- Color scheme
--
-- Link: https://wezfurlong.org/wezterm/colorschemes/index.html
--
config.color_scheme = "nord"

-- Font
config.font_size = 16.0

-- To get available font names use
--
-- $ wezterm ls-fonts --list-system
--
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",   -- firacode, it is more compact
  "GitLab Mono",          -- gitlab eyecandy
})

--
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.scrollback_lines = 3000
config.default_workspace = "home" -- ???

bindings(config)

config.hyperlink_rules = require("./hyperlink")

return config
