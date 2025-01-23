local extensions = { "css", "javascript", "jsx", "tsx" }

return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup(extensions)
	end,
}
