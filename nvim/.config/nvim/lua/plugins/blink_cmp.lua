return {
        {
                "saghen/blink.compat",
                version = "*",
                lazy = true,
                opts = {},
        },
        {
                "saghen/blink.cmp",
                dependencies = {
                        "rafamadriz/friendly-snippets",
                },
                version = "1.*",
                ---@module 'blink.cmp'
                ---@type blink.cmp.Config
                init = function()
                        -- =====================================================================
                        -- CUSTOM MATERIAL DEEP OCEAN HIGHLIGHTS FOR BLINK
                        -- =====================================================================
                        local set_hl = vim.api.nvim_set_hl

                        -- Main Menu Window Styling
                        set_hl(0, "BlinkCmpMenu", { bg = "#0f111a", fg = "#b0bec5" })
                        set_hl(0, "BlinkCmpMenuBorder", { fg = "#1f2233", bg = "#0f111a" })
                        set_hl(0, "BlinkCmpMenuSelection", { bg = "#1f2233", fg = "#80cbc4", bold = true })

                        -- Fuzzy Matching & Label Pops
                        set_hl(0, "BlinkCmpLabelMatch", { fg = "#80cbc4", bold = true })
                        set_hl(0, "BlinkCmpLabel", { fg = "#b0bec5" })
                        set_hl(0, "BlinkCmpLabelDescription", { fg = "#464b5d" })

                        -- Source Name Tags
                        set_hl(0, "BlinkCmpSourceLsp", { fg = "#00e5ff", italic = true })
                        set_hl(0, "BlinkCmpSourcePath", { fg = "#c3e88d" })
                        set_hl(0, "BlinkCmpSourceSnippets", { fg = "#ff5370" })
                        set_hl(0, "BlinkCmpSourceBuffer", { fg = "#ffcb6b" })
                end,
                opts = {
                        -- =====================================================================
                        -- 1. KEYMAPS & COMMAND LINE
                        -- =====================================================================
                        keymap = {
                                preset = "default",
                                ["<C-x>"] = { "accept", "fallback" },
                                ["<C-k>"] = false,
                                ["<C-,>"] = { "show_signature", "hide_signature", "fallback" },
                        },

                        cmdline = {
                                enabled = true,
                                keymap = { preset = "cmdline" },
                                completion = {
                                        list = { selection = { preselect = false } },
                                        menu = { auto_show = true },
                                        ghost_text = { enabled = true },
                                },
                        },

                        signature = { enabled = true },

                        -- =====================================================================
                        -- 2. GLOBAL APPEARANCE
                        -- =====================================================================
                        appearance = {
                                use_nvim_cmp_as_default = false,
                                nerd_font_variant = "mono",
                        },

                        -- =====================================================================
                        -- 3. COMPLETION MENU & ENGINE
                        -- =====================================================================
                        completion = {
                                ghost_text = { enabled = false },

                                documentation = {
                                        auto_show = true,
                                        auto_show_delay_ms = 200,
                                        treesitter_highlighting = true,
                                        draw = function(opts) opts.default_implementation() end,
                                },

                                menu = {
                                        border = "rounded",
                                        winhighlight =
                                        "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

                                        draw = {
                                                snippet_indicator = "~",
                                                treesitter = { "lsp" },

                                                -- MAINTAINED YOUR EXACT COLUMNS LAYOUT
                                                columns = {
                                                        { "label",     "label_description", gap = 1 },
                                                        { "kind_icon", "kind",              "source_name", gap = 1 }
                                                },

                                                components = {
                                                        kind_icon = {
                                                                ellipsis = false,
                                                                text = function(ctx)
                                                                        local icon = ctx.kind_icon
                                                                        if ctx.item.kind == vim.lsp.protocol.CompletionItemKind.Color then
                                                                                local doc = ctx.item.documentation
                                                                                if type(doc) == "string" and doc:match("^#%x%x%x%x%x%x$") then
                                                                                        local color_icon = require(
                                                                                        "nvim-highlight-colors").format(
                                                                                        doc, { kind = "Color" })
                                                                                        if color_icon then return
                                                                                                color_icon end
                                                                                end
                                                                        end
                                                                        return icon .. ctx.icon_gap
                                                                end,
                                                                highlight = function(ctx)
                                                                        return { { group = ctx.kind_hl, priority = 20000 } }
                                                                end,
                                                        },

                                                        kind = {
                                                                ellipsis = false,
                                                                width = { fill = true },
                                                                text = function(ctx) return ctx.kind end,
                                                                highlight = function(ctx)
                                                                        return { { group = ctx.kind_hl, priority = 20000 } }
                                                                end,
                                                        },

                                                        label = {
                                                                width = { fill = true, max = 20 },
                                                                text = function(ctx) return ctx.label .. ctx
                                                                        .label_detail end,
                                                                highlight = function(ctx)
                                                                        local highlights = {
                                                                                {
                                                                                        0,
                                                                                        #ctx.label,
                                                                                        group = ctx.deprecated and
                                                                                        "BlinkCmpLabelDeprecated" or
                                                                                        "BlinkCmpLabel",
                                                                                },
                                                                        }
                                                                        if ctx.label_detail then
                                                                                table.insert(highlights, {
                                                                                        #ctx.label,
                                                                                        #ctx.label + #ctx.label_detail,
                                                                                        group = "BlinkCmpLabelDetail",
                                                                                })
                                                                        end
                                                                        for _, idx in ipairs(ctx.label_matched_indices) do
                                                                                table.insert(highlights,
                                                                                        { idx, idx + 1, group =
                                                                                        "BlinkCmpLabelMatch" })
                                                                        end
                                                                        return highlights
                                                                end,
                                                        },

                                                        label_description = {
                                                                width = { max = 30 },
                                                                text = function(ctx) return ctx.label_description end,
                                                                highlight = "BlinkCmpLabelDescription",
                                                        },

                                                        -- Styled source components preserving structural integration
                                                        source_name = {
                                                                text = function(ctx) return "[" ..
                                                                        ctx.source_name:upper() .. "]" end,
                                                                highlight = function(ctx)
                                                                        return "BlinkCmpSource" ..
                                                                        ctx.source_name:sub(1, 1):upper() ..
                                                                        ctx.source_name:sub(2)
                                                                end,
                                                        },
                                                },
                                        },
                                },
                        },

                        -- =====================================================================
                        -- 4. SOURCES & FUZZY BACKEND
                        -- =====================================================================
                        sources = {
                                default = { "lsp", "path", "snippets", "buffer" },
                                providers = {},
                        },

                        fuzzy = { implementation = "prefer_rust_with_warning" },
                },
                opts_extend = { "sources.default" },
        },
}
