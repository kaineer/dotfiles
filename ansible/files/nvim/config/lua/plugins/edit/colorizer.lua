-- local extensions = { "css", "javascript", "jsx", "tsx" }
local extensions = { "*" }

return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup(extensions)
	end,
}
