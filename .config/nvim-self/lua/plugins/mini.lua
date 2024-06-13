return {
	{
		"echasnovski/mini.pairs",
		version = "*",

		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.move",
		version = "*",
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
}
