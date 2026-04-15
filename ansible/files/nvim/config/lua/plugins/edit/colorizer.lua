-- local extensions = { "css", "javascript", "jsx", "tsx" }
local extensions = { "*" }

-- return {
-- 	"norcalli/nvim-colorizer.lua",
-- 	config = function()
-- 		require("colorizer").setup(extensions)
-- 	end,
-- }

return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "*" }, -- Highlight all filetypes
    user_commands = true, -- Enable commands like :ColorizerToggle
    options = {
      parsers = {
        css = true, -- Enable all CSS color formats
        tailwind = { enable = true, lsp = true }, -- Use LSP for custom Tailwind colors
      },
      display = {
        mode = "background", -- "background", "foreground", "underline", "virtualtext"
      },
    },
  },
}
