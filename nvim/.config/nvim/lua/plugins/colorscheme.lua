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
						rose = "#eb6f92",
						-- pine = "#509fbf",
						iris = "#ac77ed",
						-- foam = "#4be0fa",
						-- base = "#000000",
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
