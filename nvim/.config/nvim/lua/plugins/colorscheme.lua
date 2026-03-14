return {
        {
                "rose-pine/neovim",
                name = "rose-pine",
                lazy = true,
                config = function()
                        require('rose-pine').setup({
                                disable_background = true,
                                styles = {
                                        italic = false,
                                },
                                enable = {
                                        terminal = false,
                                        legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
                                        migrations = false,        -- Handle deprecated options automatically
                                },
                        })
                end
        }, {
        "vague2k/vague.nvim",
        lazy = true,
        config = function()
                require("vague").setup({
                        -- on_highlights = function(highlights, colors) end,

                        -- Override colors
                        colors = {
                                bg = "#141415",
                                inactiveBg = "#1c1c24",
                                fg = "#cdcdcd",
                                floatBorder = "#878787",
                                line = "#252530",
                                comment = "#606079",
                                builtin = "#98d3ca",
                                error = "#c48282",
                                string = "#e8b589",
                                number = "#e0a363",
                                property = "#b1b1e2",
                                constant = "#9898ce",
                                parameter = "#c697c9",
                                visual = "#333738",
                                func = "#d8647e",
                                warning = "#f3be7c",
                                hint = "#7e98e8",
                                operator = "#90a0b5",
                                keyword = "#6e94b2",
                                type = "#9bb4bc",
                                search = "#405065",
                                plus = "#7fa563",
                                delta = "#f3be7c",
                        },
                        style = {
                                boolean = "none",
                                number = "none",
                                float = "none",
                                error = "none",
                                comments = "none",
                                conditionals = "none",
                                functions = "none",
                                headings = "none",
                                operators = "none",
                                strings = "none",
                                variables = "none",

                                -- keywords
                                keywords = "none",
                                keyword_return = "none",
                                keywords_loop = "none",
                                keywords_label = "none",
                                keywords_exception = "none",

                                -- builtin
                                builtin_constants = "none",
                                builtin_functions = "none",
                                builtin_types = "none",
                                builtin_variables = "none",
                        },
                        transparent = false,
                })
        end,
},
        {
                "sainnhe/gruvbox-material",
                lazy = true,
                config = function()
                        vim.g.gruvbox_material_enable_italic = false
                        vim.g.gruvbox_material_transparent_background = 0
                        vim.g.gruvbox_material_background = "hard"
                end,
        },
        {
                "rebelot/kanagawa.nvim",

                lazy = true,
                opts = {
                        dimInactive = true,
                        functionStyle = { italic = false },
                        keywordStyle = { italic = false },
                        colors = { theme = { all = { ui = { bg_gutter = "none" } } }, palette = { sumiInk1 = none },
                        },
                        overrides = function(colors)
                                local theme = colors.theme
                                local makeDiagnosticColor = function(color)
                                        local c = require("kanagawa.lib.color")
                                        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                                end
                                return {

                                        -- NormalFloat = { bg = "none" },
                                        -- FloatBorder = { bg = "none" },
                                        -- FloatTitle = { bg = "none" },
                                        --
                                        -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                                        -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                                        -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                                        PmenuSbar = { bg = theme.ui.bg_m1 },
                                        PmenuThumb = { bg = theme.ui.bg_p2 },
                                        DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
                                        DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
                                        DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
                                        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
                                }
                        end,
                },
                config = function(_, opts)
                        require("kanagawa").setup(opts) -- calling setup is optional
                end,
        },
        -- Using lazy.nvim
        {
                'deparr/tairiki.nvim',
                lazy = true,
                config = function()
                        require('tairiki').setup {
                                palette              = "dark", -- main palette, available options: dark, light, dimmed, tomorrow, light_legacy
                                default_dark         = "dark",
                                transparent          = false,  -- don't set background colors
                                terminal             = true,   -- override nvim terminal colors
                                end_of_buffer        = true,   -- show end of buffer filler lines (tildes)
                                visual_bold          = true,   -- bolden visual selections
                                cmp_itemkind_reverse = false,  -- reverse fg/bg on nvim-cmp item kinds

                                diagnostics          = {
                                        darker     = true, -- darken diagnostic virtual text
                                        background = true, -- add background to diagnostic virtual text
                                        undercurl  = true, -- use undercurls for inline diagnostics
                                },

                                code_style           = {
                                        comments = { italic = false },
                                        conditionals = {},
                                        keywords = {},
                                        functions = {},
                                        strings = {},
                                        variables = {},
                                        parameters = {},
                                        types = {},
                                },


                                -- which plugins to enable
                                plugins = {
                                        treesitter = true,
                                        semantic_tokens = false,
                                },

                        }
                end
        },
}
