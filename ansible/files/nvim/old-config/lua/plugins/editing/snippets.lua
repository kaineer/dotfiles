--
return {
	"garymjr/nvim-snippets",

	config = function()
		require("snippets").setup({
			create_cmp_source = true,
			friendly_snippets = true,
			extended_filetypes = {
				typescript = { "javascript" },
			},
		})
	end,
}
