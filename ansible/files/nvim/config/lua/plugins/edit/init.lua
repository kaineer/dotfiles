-- plugins/edit/

local requireAll = require("core.utils").requireWithPrefix

return requireAll("plugins.edit.", {
	"trim", -- trim whitespaces
	"eyeliner", -- jump to symbol
	"hurl",
	-- "colorizer", -- устарел
	"todo",
	"trouble",
	"emmet",
	"snippets",
	"kanji",
})
