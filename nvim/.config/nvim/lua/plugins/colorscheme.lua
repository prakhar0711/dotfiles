return {
    -- =====================================================================
    -- 1. VAGUE NEON COLORSCHEME
    -- =====================================================================
    {
        "vague2k/vague.nvim",
        lazy = true,
        config = function()
            require("vague").setup({
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
                transparent = true,
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
        lazy = false,
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
        name = "rose-pine",
        config = function()
        end
    }
}
