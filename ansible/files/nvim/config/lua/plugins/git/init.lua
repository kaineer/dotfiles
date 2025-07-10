-- plugins/git/

local requireAll = require("core.utils").requireWithPrefix

return requireAll("plugins.git.", {
  "fugitive",
  -- "gitlab",
  "messenger",
  "gist2",
  "gh",
})
