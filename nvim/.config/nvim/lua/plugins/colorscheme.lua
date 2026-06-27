return {
    -- =====================================================================
    -- 1. VAGUE NEON COLORSCHEME
    -- =====================================================================
    {
        "vague2k/vague.nvim",
        lazy = true,
        config = function()
            require("vague").setup({
                italic = false,
                on_highlights = function(hl, colors)
                    -- =====================================================================
                    -- INLINE DIAGNOSTICS (VIRTUAL TEXT) STYLING
                    -- =====================================================================
                    -- These add a subtle, colored background box behind the inline text
                    -- at the end of the line so they stand out clearly from your code.

                    -- Error: Bright red text with a very dark reddish background
                    -- hl.DiagnosticVirtualTextError = { fg = "#ff5370", bg = "#2b181c" }

                    -- Warning: Yellow/Orange text with a dark yellowish/brown background
                    -- hl.DiagnosticVirtualTextWarn  = { fg = "#ffcb6b", bg = "#2b2318" }

                    -- Info: Blue text with a dark bluish background
                    -- hl.DiagnosticVirtualTextInfo  = { fg = "#82aaff", bg = "#18212f" }

                    -- Hint: Green text with a dark greenish background
                    -- hl.DiagnosticVirtualTextHint  = { fg = "#c3e88d", bg = "#1a251f" }


                    -- Optional: If you also want to make sure the squiggly underlines
                    -- under the actual broken code pop out more:
                    -- hl.DiagnosticUnderlineError = { sp = "#ff5370", undercurl = true }
                    -- hl.DiagnosticUnderlineWarn  = { sp = "#ffcb6b", undercurl = true }
                    -- hl.DiagnosticUnderlineInfo  = { sp = "#82aaff", undercurl = true }
                    -- hl.DiagnosticUnderlineHint  = { sp = "#c3e88d", undercurl = true }
                    -- =====================================================================
                    -- CUSTOM TABLINE STYLING FOR VAGUE (Only applies when using Vague)
                    -- =====================================================================
                    -- Active, current tab: stands out with stark white text and a clean dark blue highlight
                    hl.TabLineSel  = { fg = "#000000", bg = "#8AEEF0", bold = false }

                    -- Inactive background tabs: muted text color with a flat dark grey canvas
                    hl.TabLine     = { fg = "#5c6370", bg = "#0f111a" }

                    -- Empty right-hand spacer area: visually matches the inactive background
                    hl.TabLineFill = { bg = "#0f111a" }
                end,
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
                    keywords = "none",
                    keyword_return = "none",
                    keywords_loop = "none",
                    keywords_label = "none",
                    keywords_exception = "none",
                    builtin_constants = "none",
                    builtin_functions = "none",
                    builtin_types = "none",
                    builtin_variables = "none",
                },
                transparent = false,
            })
        end,
    },

    -- =====================================================================
    -- 2. GRUVBOX MATERIAL
    -- =====================================================================
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        config = function()
            vim.g.gruvbox_material_enable_italic = false
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_background = "hard"
        end,
    },

    -- =====================================================================
    -- 3. KANAGAWA
    -- =====================================================================
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        opts = {
            dimInactive = true,
            functionStyle = { italic = false },
            keywordStyle = { italic = false },
            colors = {
                theme = { all = { ui = { bg_gutter = "none" } } },
                palette = { sumiInk1 = "none" }, -- Wrapped syntax string
            },
            overrides = function(colors)
                local theme = colors.theme
                local makeDiagnosticColor = function(color)
                    local c = require("kanagawa.lib.color")
                    return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                end
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
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
            require("kanagawa").setup(opts)
        end,
    },

    -- =====================================================================
    -- 4. TAIRIKI
    -- =====================================================================
    {
        "deparr/tairiki.nvim",
        lazy = true,
        config = function()
            require("tairiki").setup({
                palette = "dark",
                transparent = false,
                terminal = true,
                end_of_buffer = true,
                visual_bold = true,
                cmp_itemkind_reverse = true,
                diagnostics = {
                    darker = true,
                    background = true,
                    undercurl = true,
                },
                code_style = {
                    comments = { italic = false },
                    conditionals = {},
                    keywords = {},
                    functions = {},
                    strings = {},
                    variables = {},
                    parameters = {},
                    types = {},
                },
                plugins = {
                    treesitter = true,
                    semantic_tokens = true,
                },
            })
        end,
    },

    -- =====================================================================
    -- 5. TOKYONIGHT
    -- =====================================================================
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            style = "night",
            transparent = false,
            styles = { sidebars = "transparent" },
            on_highlights = function(hl, c)
                hl.SignColumn = { bg = "none" } -- Fixed syntax string
            end,
        },
    },

    -- =====================================================================
    -- 6. MATERIAL
    -- =====================================================================
    {
        "marko-cerovac/material.nvim",
        lazy = true,
        config = function()
            require("material").setup({
                disable = {
                    colored_cursor = false,
                },
                high_visibility = {
                    darker = true,
                },
                custom_highlights = function(colors)
                    return {
                        TreesitterContext = { bg = "#27343a" },
                        -- BlinkCmpDoc = { bg = "#262b3e" },
                    }
                end,
            })
        end,
    },
    -- lua/plugins/rose-pine.lua
    {
        "rose-pine/neovim",
        lazy = true,
        name = "rose-pine",
        config = function()
        end
    }
}
