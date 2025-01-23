-- plugins/navigation/projectionist.lua
--
-- gh link: https://github.com/tpope/vim-projectionist 
--
return {
  "tpope/vim-projectionist",
  config = function()
    local wk = require('which-key')

    wk.add({
      { "<leader>aa", "<cmd>A<cr>", desc = "Projectionist alternate" },
      { "<leader>as", "<cmd>AS<cr>", desc = "Projectionist alternate split" },
      { "<leader>av", "<cmd>AV<cr>", desc = "Projectionist alternate vsplit" },
    })
  end,
}

