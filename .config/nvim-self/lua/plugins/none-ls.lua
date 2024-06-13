return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local sources = {
			require("none-ls.diagnostics.eslint_d"),
			require("none-ls.diagnostics.cpplint"),
			null_ls.builtins.formatting.stylua.with({
				filetypes = { "lua" },
			}),
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "html", "json", "yaml", "markdown", "js", "jsx", "ts", "tsx" },
			}),
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "html", "json", "yaml", "markdown", "js", "jsx", "ts", "tsx" },
			}),

			null_ls.builtins.formatting.clang_format.with({
				filetypes = { "c", "cpp", "objc", "objcpp" },
			}),
			null_ls.builtins.formatting.gofumpt.with({
				filetypes = { "go" },
			}),
		}
		null_ls.setup({ sources = sources })
		-- null_ls.setup({
		-- 	sources = {
		-- 		require("none-ls.diagnostics.eslint_d"),
		-- 		require("none-ls.diagnostics.cpplint"),
		-- 		null_ls.builtins.formatting.stylua,
		-- 		null_ls.builtins.formatting.prettier,
		-- 		null_ls.builtins.formatting.prettier,
		-- 		null_ls.builtins.formatting.clang_format,
		-- 		null_ls.builtins.formatting.stylua,
		-- 		null_ls.builtins.formatting.gofumpt,
		-- 	},
		-- })
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
