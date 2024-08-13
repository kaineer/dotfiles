-- hyperlinks

local wezterm = require("wezterm")
local config = wezterm.default_hyperlink_rules()

table.insert(config, { -- xn:javp+mom
  regex = 'xn:([\\w\\+]+)',
  format = 'https://xnxx.com/search/hd-only/$1',
  highlight = 0,
})

table.insert(config, { -- gh:kaineer/bin-scripts
  regex = 'gh:([-\\w]+/[-\\w]+)',
  format = 'https://github.com/$1',
  highlight = 0,
})

return config
