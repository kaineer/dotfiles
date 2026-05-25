local dirvish = require("plugins.navigation.dirvish")
local tmuxNavigator = require("plugins.navigation.tmux-navigator")
local projectionist = require("plugins.navigation.projectionist")
local webIcons = require("plugins.navigation.web-icons")
local whichKey = require("plugins.navigation.which-key")

return {
  urls = {
    webIcons.url, whichKey.url,
    dirvish.url, tmuxNavigator.url,
    projectionist.url,
  },
  setup = function()
    webIcons.config()
    whichKey.config()

    dirvish.config()
    tmuxNavigator.setup()
    tmuxNavigator.config()

    projectionist.config()
  end,
}
