local lsp_zero = require("lsp-zero")

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
end

local signs = {
	Error = "✘",
	Warn = "",
	Hint = "",
	Info = "",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = hl,
	})
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
require("fidget").setup({})
require("mason").setup({

	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	-- allows us to install through mason and not worry about it after that
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		zls = function()
			local lspconfig = require("lspconfig")
			lspconfig.zls.setup({
				root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
				settings = {
					zls = {
						enable_inlay_hints = true,
						enable_snippets = true,
						warn_style = true,
					},
				},
			})
			vim.g.zig_fmt_parse_errors = 0
			vim.g.zig_fmt_autosave = 0
		end,
		jdtls = function()
			local lspconfig = require("lspconfig")
			lspconfig.jdtls.setup({
				settings = {
					java = {
						errors = {
							inlayHints = false, -- Disable frequent inlay hint refreshes
						},
						validation = {
							enabled = false, -- Disable validation entirely
						},
						configuration = {
							runtimes = {
								{
									name = "JavaSE-23",
									path = "/usr/lib/jvm/java-23-openjdk/",
									sources = "/usr/lib/jvm/java-23-openjdk/src", -- Path to source files
								},
							},
						},
						signatureHelp = { enabled = true },
					},
				},
			})
		end,
		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "Lua 5.1" },
						diagnostics = {
							globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
						},
					},
				},
			})
		end,
	},
})

---
-- Autocompletion config
---
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_format = require("lsp-zero").cmp_format({ details = true })
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	window = {
		completion = cmp.config.window.bordered({
			scrollbar = true,
		}),
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "path", keyword_length = 5 },
	},
	-- sources = cmp.config.sources({
	-- 	{ name = "nvim_lsp" },
	-- 	{ name = "luasnip" }, -- For luasnip users.
	-- 	{ name = "path", keyword_length = 5 },
	-- }, {
	-- 	{ name = "buffer" },
	-- }),
	mapping = cmp.mapping.preset.insert({
		["<C-x>"] = cmp.mapping.confirm({ select = false }),

		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		["<C-n>"] = cmp_action.luasnip_jump_forward(),
		["<C-p>"] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	formatting = {
		fields = { "menu", "abbr" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "", -- LSP (alternative icons: , ,)
				luasnip = "", -- Snippet (alternative: ,)
				buffer = "", -- Buffer (alternative: , )
				path = "", -- Path (alternative: ﱮ, )
				nvim_lua = " ",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
		require("nvim-highlight-colors").format,
	},
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})