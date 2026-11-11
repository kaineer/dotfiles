local dirvish = require("plugins.navigation.dirvish")
local multiplexorNav = require("plugins.navigation.multiplexor-nav")
local projectionist = require("plugins.navigation.projectionist")
local webIcons = require("plugins.navigation.web-icons")
local whichKey = require("plugins.navigation.which-key")

return {
  urls = {
    webIcons.url, whichKey.url,
    dirvish.url, multiplexorNav.url,
    projectionist.url,
  },
  setup = function()
    webIcons.config()
    whichKey.config()

    dirvish.config()
    multiplexorNav.setup()
    multiplexorNav.config()

    projectionist.config()
  end,
}
