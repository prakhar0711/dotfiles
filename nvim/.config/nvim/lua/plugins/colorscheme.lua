return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
        config=function()
            require('rose-pine').setup({
variant="main",
                styles={
                bold=false,
                italic=false,
                transparency=true,
                }
            })
        end,
	},
	{
		"tanvirtin/monokai.nvim",
		name = "monokai",
        config=function()
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
