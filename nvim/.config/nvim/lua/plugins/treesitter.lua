return {
    -- =====================================================================
    -- 1. NVIM-TREESITTER (MAIN BRANCH REWRITE)
    -- =====================================================================
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = function()
            -- In 'main', treesitter uses the CLI / native installer API
            require("nvim-treesitter").install({
                -- Core & Doc parsers
                "markdown",
                "markdown_inline",
                "comment",
                "diff",
                "query",
                "yaml",
                "toml",
                "bash",

                -- Code languages
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
            local ts = require("nvim-treesitter")

            -- Configure parsers to ensure installed
            ts.setup({
                install = {
                    prefer_git = true,
                },
            })

            -- Automatically enable native Treesitter highlighting on FileType
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
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
