function Pencils(color)
	color = color
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Pencils()

local monokai = require("monokai")
monokai.setup({
	palette = {
		base2 = "#000000",
		base1 = "#000000",
	},
	italics = false,
})
