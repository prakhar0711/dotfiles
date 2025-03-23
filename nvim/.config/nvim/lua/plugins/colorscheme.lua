function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					bold = false,
					italic = false,
					-- transparency = true,
				},
				palette = {
					moon = {
						rose = "#e84d78",
						iris = "#ac77ed",
						base = "#191724",
						surface = "#1f1d2e",
						overlay = "#26233a",
						-- gold = "#ea9d34",
						-- text = "#ffffff",
						-- pine = "#203fbf",
						-- foam = "#f6c177",
					},
				},
			})
			-- vim.cmd("colorscheme rose-pine")

			-- ColorMyPencils()
		end,
	},

	{
		"tanvirtin/monokai.nvim",
		name = "monokai",
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = false },
					keywords = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for
				},
			}
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

			vim.cmd("colorscheme gruvbox-material")

			-- ColorMyPencils()
		end,
	},
}
