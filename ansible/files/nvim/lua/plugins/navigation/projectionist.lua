-- lua/plugins/navigation/projectionist.lua

-- DONE: add commands to switch between alternatives

return {
  "tpope/vim-projectionist",
  config = function()
    local failMessage = "Could not find projectionist alternate"
    local mkcmd = require("kaineer.cmd").buildMkcmd(failMessage)

    require("which-key").register({
      a = {
        a = { mkcmd("A"), "Projectionist alternate" },
        s = { mkcmd("AS"), "Projectionist alternate split" },
        v = { mkcmd("AV"), "Projectionist alternate vsplit" },
      }
    })
  end,
}
