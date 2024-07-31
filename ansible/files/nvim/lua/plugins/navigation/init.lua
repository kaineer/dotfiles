-- lua/plugins/navigation/init.lua

local packages = {
  "autosave",
  "tmux",
  -- "oil",
  "dirvish",
  -- "triptych",
  "projectionist",
  "url"
}

return function(use)
  local require_plugin = function(name)
    use(require("plugins.navigation." .. name))
  end

  require("kaineer.fn").forEach(packages, require_plugin)
end
