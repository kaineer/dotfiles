local nord = require("plugins.colors.nord")

return {
  urls = {
    nord.url,
  },
  setup = function()
    nord.setup{}
  end,
}
