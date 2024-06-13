return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				cpp = { "clang-format" },
				rust = { "rustfmt" },
			},
			format_on_save = true,
		})
	end,
}
