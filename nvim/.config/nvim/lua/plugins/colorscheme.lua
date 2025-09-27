function ColorMyPencils(color)
	-- color = color or "rose-pine-moon"
	color = color or "vague"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- enable the below only when using vague
	-- Optional: dim the background of non-active windows slightly
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- or some subtle shade
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
				transparent = true,
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
