-- lua/plugins/navigation/projectionist.lua

-- DONE: add commands to switch between alternatives

return {
  "tpope/vim-projectionist",
  config = function()
    local failMessage = "Could not find projectionist alternate"
    local mkcmd = require("kaineer.cmd").buildMkcmd(failMessage)

    require("which-key").add({
      { " aa", mkcmd("A"), desc = "Projectionist alternate" },
      { " as", mkcmd("AS"), desc = "Projectionist alternate split" },
      { " av", mkcmd("AV"), desc = "Projectionist alternate vsplit" },
    })
  end,
}
