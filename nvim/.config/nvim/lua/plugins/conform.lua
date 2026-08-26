return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			json = { "prettier" },
			markdown = { "prettier" },
			-- Any filetype not explicitly defined will fall back to its LSP formatter (e.g. rustfmt via rust_analyzer)
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			-- local formatters = require("conform").list_formatters(bufnr)
			-- local names = {}
			-- for _, f in ipairs(formatters) do
			-- 	table.insert(names, f.name)
			-- end
			--
			-- local used = #names > 0 and table.concat(names, ", ") or "LSP fallback"
			-- vim.notify("Formatting with: " .. used, vim.log.levels.INFO, { title = "Conform" })

			return {
				timeout_ms = 1000,
				lsp_format = "fallback",
			}
		end,
	},
}
