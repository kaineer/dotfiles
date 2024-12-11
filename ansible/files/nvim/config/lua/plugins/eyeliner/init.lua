return {
  'jinh0/eyeliner.nvim',
  config = function()
    require('eyeliner').setup {
      match = "[A-Za-z0-9.]",
      highlight_on_key = true, -- show highlights only after keypress
      dim = true,              -- dim all other characters if set to true (recommended!)
    }
  end
}
