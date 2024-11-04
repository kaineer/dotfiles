-- config.lua

return function(wezterm)
  if wezterm.config_builder then
    return wezterm.config_builder()
  end
  return {}
end
