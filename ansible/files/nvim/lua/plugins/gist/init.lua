--- lua/plugins/gist/init.lua

return {
  "mattn/vim-gist",
  requires = "mattn/webapi-vim",
  config = function()
    local assign = require("kaineer.fn").assign

    assign(vim.g, {
      github_user = "kaineer",
      gist_token = require("plugins.gist.secret"),

      gist_show_privates = 1,
      gist_open_browser_after_post = 1,
      gist_browser_comand = "brave-browser %URL% &",
      gist_get_multiple_file = 1,
      gist_clip_command = "xclip -selection clipboard",
    })
  end,
}
