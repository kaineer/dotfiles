return {
  url = "https://github.com/lmilojevicc/herdr-splits.nvim",
  setup = function()
    require("herdr-splits").setup({})

    local hs = require("herdr-splits")
    local wk = require("which-key")

    wk.add({
      { "<M-h>", function() require("herdr-splits").move_cursor_left() end, desc = "Navigate left" },
      { "<M-l>", function() require("herdr-splits").move_cursor_right() end, desc = "Navigate right" },
      { "<M-j>", function() require("herdr-splits").move_cursor_down() end, desc = "Navigate down" },
      { "<M-k>", function() require("herdr-splits").move_cursor_up() end, desc = "Navigate up" },
    })
  end,
}

-- require("which-key").add({
--   { "<leader>pu", function()
--     vim.pack.update(nil, { force = true })
--     vim.schedule(function()
--       vim.notify("vim.pack: update finished", vim.log.levels.INFO)
--     end)
--   end, desc = "Force update" },

