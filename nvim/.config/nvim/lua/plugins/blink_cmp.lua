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
        opts = {
            cmdline = {
                enabled = true,
                keymap = { preset = "cmdline" },
                completion = {
                    list = { selection = { preselect = false } },
                    menu = {
                        auto_show = true,
                    },
                    ghost_text = { enabled = true },
                },
            },
            keymap = {
                preset = "default",
                ["<C-x>"] = { "accept", "fallback" },
                ["<C-k>"] = false,
                ['<C-,>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                menu = {
                    draw = {
                        snippet_indicator = "~",
                        treesitter = { "lsp" },
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    return ctx.kind_icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    return { { group = ctx.kind_hl, priority = 20000 } }
                                end,
                            },

                            kind = {
                                ellipsis = false,
                                width = { fill = true },
                                text = function(ctx)
                                    return ctx.kind
                                end,
                                highlight = function(ctx)
                                    return ctx.kind_hl
                                end,
                            },

                            label = {
                                width = { fill = true, max = 20 },
                                text = function(ctx)
                                    return ctx.label .. ctx.label_detail
                                end,
                                highlight = function(ctx)
                                    -- label and label details
                                    local highlights = {
                                        {
                                            0,
                                            #ctx.label,
                                            group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
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
                                        table.insert(highlights, {
                                            idx,
                                            idx + 1,
                                            group = "BlinkCmpLabelMatch",
                                        })
                                    end

                                    return highlights
                                end,
                            },

                            label_description = {
                                width = { max = 30 },
                                text = function(ctx)
                                    return ctx.label_description
                                end,
                                highlight = "BlinkCmpLabelDescription",
                            },
                        },
                    },
                },

                ghost_text = {
                    enabled = false,
                },
            },
            signature = { enabled = true },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {

                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
