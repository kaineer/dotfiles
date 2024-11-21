-- https://youtu.be/I3ipo8NxsjY

local wezterm = require("wezterm")
local config = require("./config")(wezterm)

local files = {
  "options",        -- options
  "ligature",
  "color_scheme",   -- nord color scheme
  "font",           -- fira code nerd
  "hyperlink",      -- custom hyperlinks
  "fullscreen",     -- open wezterm in fullscreen mode
}

for _, file in ipairs(files) do
  require("./" .. file)(config, wezterm)
end

return config
