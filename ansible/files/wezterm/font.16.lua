-- font.lua

return function(config, wezterm)
  config.font_size = 16.0

  -- To get available font names use
  --
  -- $ wezterm ls-fonts --list-system
  --
  config.font = wezterm.font_with_fallback({
    "FiraCode Nerd Font", -- firacode, it is more compact
    "GitLab Mono", -- gitlab eyecandy
  })
end
