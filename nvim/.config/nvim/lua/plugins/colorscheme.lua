function ColorMyPencils(color)
    color = color or "kanagawa-wave"
    -- color = color or "rose-pine-moon"
    -- color = color or "vague"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- enable the below only when using vague
    -- Optional: dim the background of non-active windows slightly
    -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- or some subtle shade
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })

            ColorMyPencils()
        end,
    },
    -- Lazy
    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({
                style = {
                    comments = "none",
                    strings = "none",
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
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_background = "hard"
        end,
    },
    {
        "rebelot/kanagawa.nvim",

        opts = {
            dimInactive = true,
            functionStyle = { italic = false },
            keywordStyle = { italic = false },
            colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
            overrides = function(colors)
                local theme = colors.theme
                local makeDiagnosticColor = function(color)
                    local c = require("kanagawa.lib.color")
                    return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                end
                return {

                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

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
            ColorMyPencils()
            require("kanagawa").setup(opts) -- calling setup is optional
        end,
    },
}
