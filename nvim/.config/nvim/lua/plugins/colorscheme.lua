return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				palette = {
					moon = {
						rose = "#eb6f92",
						pine = "#509fbf",
						iris = "#ac77ed",
						-- foam = "#4be0fa",
						base = "#000000",
					},
				},
			})
			-- vim.cmd.colorscheme("rose-pine-moon")
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
}
