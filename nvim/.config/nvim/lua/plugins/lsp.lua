return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- 1. DIAGNOSTICS CONFIGURATION
		local signs = { Error = "✘ ", Warn = " ", Hint = "⚑ ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			severity_sort = true,
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = true,
			virtual_text = { prefix = "  ● ", spacing = 8, source = "if_many" },
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
			},
		})

		-- 2. LSP ATTACH HOOK (Snacks Pickers, Keymaps, Highlighting, Inlay Hints)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-native", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Enable omnifunc fallback
				vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Snacks.nvim Picker-Powered LSP Navigation
				map("n", "<leader>gd", function()
					Snacks.picker.lsp_definitions()
				end, "Go to Definition")
				map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to Declaration")
				map("n", "<leader>gi", function()
					Snacks.picker.lsp_implementations()
				end, "Go to Implementation")
				map("n", "<leader>gz", function()
					Snacks.picker.lsp_type_definitions()
				end, "Go to Type Definition")
				map("n", "<leader>gc", function()
					Snacks.picker.lsp_references()
				end, "References")
				map("n", "<leader>gs", function()
					Snacks.picker.lsp_symbols()
				end, "Document Symbols")

				-- Standard Actions & Docs
				map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
				map("n", "<C-q>", vim.lsp.buf.signature_help, "Signature Help")
				map("n", "<leader>gx", vim.lsp.buf.rename, "Rename Symbol")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

				-- Workspace Management
				map("n", "<leader>ga", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
				map("n", "<leader>gr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
				map("n", "<leader>gl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "List Workspace Folders")

				-- Inlay Hints Toggle
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
							{ bufnr = event.buf }
						)
					end, "Toggle Inlay Hints")
				end

				-- Document Highlighting
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
						callback = function()
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_group })
						end,
					})
				end
			end,
		})

		-- 3. GLOBAL CAPABILITIES
		local og_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(og_capabilities)

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- 4. MASON TOOL INSTALLER
		require("mason-tool-installer").setup({
			ensure_installed = { -- LSP Language Servers
				"lua-language-server",
				"rust-analyzer",
				"clangd",
				"jdtls",

				-- Formatters (for conform.nvim)
				"stylua",
				"clang-format",
				"prettier", -- if you format JSON, Markdown, YAML, etc.
			},
		})

		-- 5. MASON-LSPCONFIG HANDLER
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					-- Sourced automatically from after/lsp/<server>.lua and nvim-lspconfig defaults
					vim.lsp.enable(server_name)
				end,
			},
		})
	end,
}
