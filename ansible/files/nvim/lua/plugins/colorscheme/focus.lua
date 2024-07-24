-- lua/plugins/colorscheme/focus.lua

local M = {}

local defaultColors = {
  active = " guibg=#2e3440",
  inactive = " guibg=#4b556a",
}

local defaultBackgrounds = {
  "Normal",
  "LineNr",
  "SignColumn",
}

function M.setup(opts)
  local au = require("kaineer.autocmd").au
  local forEach = require("kaineer.fn").forEach
  local colors = opts.colors or defaultColors
  local backgrounds = opts.backgrounds or defaultBackgrounds

  local activeSuffix = "Active"
  local inactiveSuffix = "Inactive"

  local as, is = activeSuffix, inactiveSuffix
  local activate, deactivate = "set winhighlight=", "set winhighlight="
  local first = true

  forEach(backgrounds, function(name)
    vim.cmd("hi " .. as .. name .. " " .. colors.active)
    vim.cmd("hi " .. is .. name .. " " .. colors.inactive)

    if not first then
      activate = activate .. ","
      deactivate = deactivate .. ","
    end

    activate = activate .. name .. ":" .. as .. name
    deactivate = deactivate .. name .. ":" .. is .. name

    first = false
  end)

  au("FocusBackgrounds", function(cmd)
    cmd("WinEnter", { pattern = "*", command = activate })
    cmd("WinLeave", { pattern = "*", command = deactivate })
    cmd("FocusGained", { pattern = "*", command = activate })
    cmd("FocusLost", { pattern = "*", command = deactivate })
  end)
end

return M
