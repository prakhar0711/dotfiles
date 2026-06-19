return {
        -- =====================================================================
        -- 1. NVIM-TREESITTER CORE PARSER
        -- =====================================================================
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                branch = "master",
                lazy = false,
                cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
                opts_extend = { "ensure_installed" },

                keys = {
                        { "<C-space>", desc = "Increment Selection" },
                        { "<BS>",      desc = "Decrement Selection", mode = "x" },
                },

                ---@type TSConfig
                ---@diagnostic disable-next-line: missing-fields
                opts = {
                        auto_install = true,

                        ensure_installed = {
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
                        },

                        highlight = {
                                enable = true,
                                additional_vim_regex_highlighting = false,
                        },

                        indent = {
                                enable = true,
                        },

                        incremental_selection = {
                                enable = true,
                                keymaps = {
                                        init_selection = "<C-space>",
                                        node_incremental = "<C-space>",
                                        scope_incremental = false,
                                        node_decremental = "<BS>",
                                },
                        },

                        textobjects = {
                                move = {
                                        enable = true,
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
                                },
                        },
                },
                ---@param opts TSConfig
                config = function(_, opts)
                        require("nvim-treesitter.configs").setup(opts)
                end,
        },

        -- =====================================================================
        -- 2. NVIM-TREESITTER CONTEXT STICKY HEADERS
        -- =====================================================================
        {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                        require("treesitter-context").setup({
                                enable = true,
                                max_lines = 0, -- No boundary limits on persistent structural views
                                trim_scope = "inner",
                        })
                end,
        },
}
