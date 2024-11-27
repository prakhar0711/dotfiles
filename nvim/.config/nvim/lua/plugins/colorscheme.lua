return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = false,
					italic = false,
					transparency = true,
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
		end,
	},
	{
		"tanvirtin/monokai.nvim",
		name = "monokai",
		config = function()
			require("monokai").setup({
				palette = {
					base2 = "#00000000",
					base1 = "#00000000",
				},
				italics = false,
			})
		end,
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
}
