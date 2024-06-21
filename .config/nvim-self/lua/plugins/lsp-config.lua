return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			capabilities.offsetEncoding = "utf-8"
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"clangd",
					"gopls",
					"html",
					"lua_ls",
					"eslint",
					"emmet_ls",
					"tailwindcss",
					"rust_analyzer",
				},
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
			-- local lspconfig = require("lspconfig")
			-- lspconfig.tsserver.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.gopls.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.clangd.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.html.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.lua_ls.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.eslint.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.emmet_ls.setup({
			--   capabilities = capabilities,
			-- })
			-- lspconfig.tailwindcss.setup({
			--   capabilities = capabilities,
			-- })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
