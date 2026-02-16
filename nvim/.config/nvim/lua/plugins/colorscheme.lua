function ColorMyPencils(color)
    color = color or "kanagawa-wave"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- enable the below only when using vague Optional: dim the background of non-active windows slightly
    -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- or some subtle shade
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                -- disable_background = true,
                dim_inactive_windows = true,
                -- enable = {
                --     -- terminal = true,
                --     -- legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                --     -- migrations = true,        -- Handle deprecated options automatically
                -- },
                styles = {
                    italic = false,
                    bold = false,
                    -- transparency = true,
                },
                highlight_groups = {
                    CurSearch = { fg = "base", bg = "leaf", inherit = false },
                    Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
                },
                palette = {
                    moon = {
                        rose = '#eb6f92',
                        -- overlay = '#221f33',
                        -- surface = '#11101a',
                    },

                    main = {
                        rose = '#eb6f92',
                        -- overlay = '#221f33',
                        -- surface = '#11101a',
                    },
                },
            })
            ColorMyPencils();
        end,
    },
    -- Lazy
    {
        "vague2k/vague.nvim",
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
            ColorMyPencils()
        end,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            ColorMyPencils()
            vim.g.gruvbox_material_enable_italic = false
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_background = "hard"
        end,
    },
    {
        "rebelot/kanagawa.nvim",

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
            ColorMyPencils()
        end,
    },
}
