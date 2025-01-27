-- plugins/edit/

local requireAll = require("core.utils").requireWithPrefix

return requireAll("plugins.edit.", {
	"trim", -- trim whitespaces
	"eyeliner", -- jump to symbol
	"hurl",
	"colorizer",
	"todo",
	"trouble",
	"emmet",
})
