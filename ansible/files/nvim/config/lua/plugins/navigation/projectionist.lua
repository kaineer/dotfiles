-- plugins/navigation/projectionist.lua
--
-- gh link: https://github.com/tpope/vim-projectionist 
--
return {
  url = "https://github.com/tpope/vim-projectionist",
  config = function()
    local wk = require('which-key')

    wk.add({
      { "<leader>aa", "<cmd>A<cr>", desc = "-> alternate" },
      { "<leader>ec", "<cmd>Ecomponent<cr>", desc = "-> component" },
      { "<leader>em", "<cmd>Ecssmodule<cr>", desc = "-> css module" },
      { "<leader>es", "<cmd>Estories<cr>", desc = "-> stories" },
    })
  end,
}

