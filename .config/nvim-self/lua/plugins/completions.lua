return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require("lspkind")
			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								copilot = "[Copilot]",
								codeium = "[Codeium]",
								luasnip = "[Snippet]",
								buffer = "[Buffer]",
								path = "[Path]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "codeium" },
					{ name = "copilot" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VeryLazy",
		config = function()
			local cmp = require("cmp")
			local mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			}

			-- Use buffer source for `/`.
			cmp.setup.cmdline("/", {
				preselect = "none",
				completion = {
					completeopt = "menu,preview,menuone,noselect",
				},
				mapping = mapping,
				sources = {
					{ name = "buffer" },
				},
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})

			-- Use cmdline & path source for ':'.
			cmp.setup.cmdline(":", {
				preselect = "none",
				completion = {
					completeopt = "menu,preview,menuone,noselect",
				},
				mapping = mapping,
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})
		end,
	},
}
