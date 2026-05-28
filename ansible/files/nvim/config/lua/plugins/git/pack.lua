local fugitive = require("plugins.git.fugitive")
local gist = require("plugins.git.gist")

return {
  urls = {
    fugitive.url,
    fugitive.githubUrl,
    fugitive.versionsUrl,
    fugitive.gutterUrl,

    --
    gist.apiUrl,
    gist.url,
  },

  setup = function()
    gist.config()
  end,
}
