local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c", "cpp" },
		}),
		null_ls.builtins.formatting.google_java_format.with({
			filetypes = { "java" },
		}),
	},
})
