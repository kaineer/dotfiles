-- shell.lua
--
-- @link: [Change default shell](https://wezfurlong.org/wezterm/config/launch.html#changing-the-default-program)
--
return function(config)
  config.default_prog = { '/bin/bash', '-i' }
end
