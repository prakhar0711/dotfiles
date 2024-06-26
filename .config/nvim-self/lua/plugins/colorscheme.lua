return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			theme = "wave",
			functionStyle = { italic = true },
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				}
			end,
		},
		config = function(_, opts)
			require("kanagawa").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	-- {
	--   "folke/tokyonight.nvim",
	--   lazy = false,
	--   priority = 1000,
	--   -- config = function()
	--   --   require("tokyonight").setup({
	--   --     style = "night",
	--   --     transparent = false,
	--   --     terminal_colors = true,
	--   --     styles = {
	--   --       comments = { italic = true },
	--   --       keywords = { italic = true },
	--   --       functions = { italic = true },
	--   --       sidebars = "dark",
	--   --       floats = "dark",
	--   --     },
	--   --   })
	--   --   --vim.cmd.colorscheme("tokyonight")
	--   -- end,
	-- },
	-- {
	--   "tiagovla/tokyodark.nvim",
	--   opts = {
	--     -- custom options here
	--   },
	--   -- config = function(_, opts)
	--   --   require("tokyodark").setup(opts) -- calling setup is optional
	--   --   -- vim.cmd([[colorscheme tokyodark]])
	--   -- end,
	-- },
}
