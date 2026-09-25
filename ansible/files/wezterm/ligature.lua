-- ligature.disabled.lua
return function(config)
  -- ligatures
  config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
end
