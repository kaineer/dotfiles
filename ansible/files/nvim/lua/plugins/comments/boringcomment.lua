--
-- link: https://github.com/alexshelto/boringcomment.nvim
--
-- should work in both block and normal modes

return {
  "alexshelto/boringcomment.nvim",
  config = function()
    local bc = require("boringcomment.commenter")

    vim.keymap.set('x', "gc", function()
      bc.comment_visual_selection()
    end)

    vim.keymap.set('n', "gc", function ()
      bc.comment_current_line()
    end)
  end,
}
