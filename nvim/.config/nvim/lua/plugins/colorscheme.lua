return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			require("rose-pine").setup({
				styles = {
					bold = false,
					italic = false,
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine-moon")
		end,
	},
	{
		"tanvirtin/monokai.nvim",
		name = "monokai",
		config = function()
			require("monokai").setup({
				palette = {
					base2 = "#000000",
					base1 = "#000000",
				},
				italics = false,
			})
		end,
	},
}
