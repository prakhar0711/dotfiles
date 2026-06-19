return {
        "neovim/nvim-lspconfig",
        dependencies = {
                { "williamboman/mason.nvim", opts = {} },
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
                -- =====================================================================
                -- 1. DIAGNOSTIC CONFIGURATION (Quality of Life Changes)
                -- =====================================================================
                local signs = { Error = "✘ ", Warn = " ", Hint = "⚑ ", Info = " " }
                for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
                end

                vim.diagnostic.config({
                        severity_sort = true,
                        underline = { severity = vim.diagnostic.severity.ERROR },
                        signs = true,

                        -- Elegant Virtual Text Spacing Tweak
                        virtual_text = {
                                prefix = "  ● ", -- Pushes text back dynamically by adding explicit prefix padding
                                spacing = 8, -- Guarantees 8 exact blank columns after code ends before rendering text
                                source = "if_many",
                        },

                        -- Floating window presets
                        float = {
                                focusable = false,
                                style = "minimal",
                                border = "rounded",
                                source = "always",
                                header = "",
                                prefix = "",
                        },
                })

                -- =====================================================================
                -- 2. LSP ATTACH HOOKS (Keymaps & Autocmds)
                -- =====================================================================
                vim.api.nvim_create_autocmd("LspAttach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                        callback = function(event)
                                local map = function(keys, func, desc, mode)
                                        vim.keymap.set(mode or "n", keys, func,
                                                { buffer = event.buf, desc = "LSP: " .. desc })
                                end

                                -- Legacy Neovim version helper function
                                local function client_supports_method(client, method, bufnr)
                                        if vim.fn.has("nvim-0.11") == 1 then
                                                return client:supports_method(method, bufnr)
                                        else
                                                return client.supports_method(method, { bufnr = bufnr })
                                        end
                                end

                                local client = vim.lsp.get_client_by_id(event.data.client_id)

                                -- Document Highlighting when sitting on variables
                                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                                        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight",
                                                { clear = false })

                                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                                buffer = event.buf,
                                                group = highlight_augroup,
                                                callback = vim.lsp.buf.document_highlight,
                                        })

                                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                                buffer = event.buf,
                                                group = highlight_augroup,
                                                callback = vim.lsp.buf.clear_references,
                                        })

                                        vim.api.nvim_create_autocmd("LspDetach", {
                                                group = vim.api.nvim_create_augroup("kickstart-lsp-detach",
                                                        { clear = true }),
                                                callback = function(event2)
                                                        vim.lsp.buf.clear_references()
                                                        vim.api.nvim_clear_autocmds({
                                                                group = "kickstart-lsp-highlight",
                                                                buffer =
                                                                    event2.buf
                                                        })
                                                end,
                                        })
                                end

                                -- Inlay Hints Toggle Map
                                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                                        map("<leader>th", function()
                                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                                                        bufnr =
                                                            event.buf
                                                }))
                                        end, "[T]oggle Inlay [H]ints")
                                end
                        end,
                })

                -- =====================================================================
                -- 3. LANGUAGE SERVER REGISTRATION
                -- =====================================================================
                local og_capabilities = vim.lsp.protocol.make_client_capabilities()
                local capabilities = require("blink.cmp").get_lsp_capabilities(og_capabilities)

                -- Register your servers list here
                local servers = {
                        lua_ls = {
                                settings = {
                                        Lua = {
                                                completion = { callSnippet = "Replace" },
                                                diagnostics = { disable = { "missing-fields" } }, -- Stops noisy UI notifications on configurations
                                        },
                                },
                        },
                }

                -- Automatically process installations using tool installers
                local ensure_installed = vim.tbl_keys(servers or {})
                require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

                require("mason-lspconfig").setup({
                        ensure_installed = {},
                        automatic_installation = false,
                        handlers = {
                                function(server_name)
                                        local server = servers[server_name] or {}
                                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                                                server.capabilities or {})

                                        -- Using standard lspconfig setup layout for better runtime reliability
                                        require("lspconfig")[server_name].setup(server)
                                end,
                        },
                })
        end,
}
