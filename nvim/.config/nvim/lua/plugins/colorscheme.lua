function ColorMyPencils(color)
	color = color or "vague"
	vim.cmd.colorscheme(color)

	-- Main background transparency
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#313136" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#313136" }) -- subtle contrast for focused floats

	-- Float window borders and shadows
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#524f67", bg = "#313136" })
	vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#c4a7e7", bg = "#313136", bold = true })
	vim.api.nvim_set_hl(0, "FloatShadow", { bg = "#000000", blend = 10 })
	vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "#000000", blend = 10 })

	-- Popup and menu-like UIs (e.g., Pmenu, Telescope)
	vim.api.nvim_set_hl(0, "Pmenu", { fg = "#e0def4", bg = "#313136" })
	vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#313136", bg = "#c4a7e7", bold = true })
	vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#313136" })
	vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#c4a7e7" })

	-- Borders and separator elements
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#403d52", bg = "none" })

	-- Optional: LSP and diagnostic floating windows
	vim.api.nvim_set_hl(0, "LspFloatWinNormal", { link = "NormalFloat" })
	vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
end

return {
	{
		"erikbackman/brightburn.vim",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			ColorMyPencils()
		end,
	},
	-- Lazy
	{
		"vague2k/vague.nvim",
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				-- optional configuration here
				style = {
					-- "none" is the same thing as default. But "italic" and "bold" are also valid options
					comments = "none",
					strings = "none",
				},
				transparent = false,
			})
			ColorMyPencils()
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = false
			vim.g.gruvbox_material_transparent_background = 2
			vim.g.gruvbox_material_background = "hard"
		end,
	},
}
