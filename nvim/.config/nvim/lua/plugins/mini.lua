return {
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	config = function()
	-- 		require("mini.indentscope").setup({
	--
	-- 			symbol = "│",
	-- 			options = { try_as_border = true, indent_at_cursor = true },
	-- 		})
	-- 	end,
	-- },
}
