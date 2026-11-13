-- fullscreen.lua

return function(_config, wezterm)
  local mux = wezterm.mux

  wezterm.on("gui-startup", function(cmd)
    local _tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
    -- WM applies maximize asynchronously; the first prompt may paint before
    -- resize settles and leave the text cursor hidden until Enter.
    wezterm.time.call_after(0.15, function()
      pane:inject_output("\x1b[?25h")
    end)
  end)
end
