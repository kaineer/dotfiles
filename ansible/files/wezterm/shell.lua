-- shell.lua
--
-- @link: [Change default shell](https://wezfurlong.org/wezterm/config/launch.html#changing-the-default-program)
--
return function(config)
	local user = os.getenv("USER")
	config.default_prog = { "/usr/bin/bash", "-i" }
	config.default_cwd = "/home/" .. user
end
