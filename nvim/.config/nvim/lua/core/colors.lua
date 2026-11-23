local function ColorMyPencils(color)
	color = color or "kanagawa"

	vim.cmd.colorscheme(color)

	-- transparency
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- enable the below only when using vague Optional: dim the background of non-active windows slightly
	-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- or some subtle shade

	-- transparent bufferline for kanagawa colorscheme
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
	local tabline = vim.api.nvim_get_hl(0, { name = "TabLine", link = false })
	vim.api.nvim_set_hl(0, "TabLine", { fg = tabline.fg, bg = "none" })

	-- Transparent BlinkCmp menus using the active theme's FloatBorder foreground
	local float_border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
	local blink_groups = {
		"BlinkCmpMenu",
		"BlinkCmpMenuBorder",
		"BlinkCmpDoc",
		"BlinkCmpDocBorder",
		"BlinkCmpSignatureHelp",
		"BlinkCmpSignatureHelpBorder",
	}

	for _, group in ipairs(blink_groups) do
		vim.api.nvim_set_hl(0, group, { fg = float_border.fg, bg = "none" })
	end
end

ColorMyPencils()
