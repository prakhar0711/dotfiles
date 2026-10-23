return {
	-- =====================================================================
	-- 1. NVIM-TREESITTER (MAIN BRANCH REWRITE)
	-- =====================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			require("nvim-treesitter").install({
				"markdown",
				"markdown_inline",
				"comment",
				"diff",
				"query",
				"yaml",
				"toml",
				"bash",
				"c",
				"cpp",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"regex",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			})
		end,
		config = function()
			-- Automatically enable native Treesitter highlighting on valid code buffers
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Skip special UI/scratch/terminal buffers (Snacks, Telescope, quickfix, etc.)
					if vim.bo[args.buf].buftype ~= "" then
						return
					end

					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if not lang then
						return
					end

					-- Safely verify that a parser binary exists before calling start
					local ok, parser = pcall(vim.treesitter.get_parser, args.buf, lang)
					if ok and parser then
						pcall(vim.treesitter.start, args.buf, lang)
					end
				end,
			})
		end,
	},

	-- =====================================================================
	-- 2. NVIM-TREESITTER TEXTOBJECTS (MAIN BRANCH REWRITE)
	-- =====================================================================
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local move = require("nvim-treesitter-textobjects.move")

			local maps = {
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
				},
			}

			for method, map in pairs(maps) do
				for key, query in pairs(map) do
					vim.keymap.set({ "n", "x", "o" }, key, function()
						move[method](query)
					end, { desc = "Treesitter Move: " .. query })
				end
			end
		end,
	},

	-- =====================================================================
	-- 3. NVIM-TREESITTER CONTEXT STICKY HEADERS
	-- =====================================================================
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			enable = true,
			max_lines = 0,
			trim_scope = "inner",
		},
	},
}
