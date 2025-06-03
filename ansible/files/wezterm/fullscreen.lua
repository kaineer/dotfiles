-- fullscreen.lua

return function(_config, wezterm)
  local mux = wezterm.mux

  wezterm.on("gui-startup", function()
    local _tab, _pane, window = mux.spawn_window({})
    window:gui_window():maximize()
  end)
end
