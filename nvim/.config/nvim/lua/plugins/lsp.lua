return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- =====================================================================
        -- 1. DIAGNOSTICS CONFIGURATION
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
            virtual_text = {
                prefix = "  ● ",
                spacing = 8,
                source = "if_many",
            },
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
        -- 2. LSP ATTACH HOOKS (Keymaps, Highlighting, Inlay Hints)
        -- =====================================================================
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach-native", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local map = function(keys, func, desc, mode)
                    vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Document Highlighting
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })

                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_group,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_group,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
                        callback = function()
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = highlight_group })
                        end,
                    })
                end

                -- Inlay Hints Toggle
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
                            { bufnr = event.buf })
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- =====================================================================
        -- 3. NATIVE SERVER DEFINITIONS & CAPABILITIES
        -- =====================================================================
        local og_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(og_capabilities)

        -- Apply default capabilities to all LSP servers
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- Lua Language Server
        vim.lsp.config("lua_ls", {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
            settings = {
                Lua = {
                    completion = { callSnippet = "Replace" },
                    diagnostics = { disable = { "missing-fields" } },
                },
            },
        })

        -- Rust Analyzer (Configured for projects and standalone files)
        vim.lsp.config("rust_analyzer", {
            cmd = { "rust-analyzer" },
            filetypes = { "rust", "rs" },
            root_markers = { "Cargo.toml", "rust-project.json", "*.rs" },
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        enable = false, -- Disabled to prevent cargo check failures on standalone files
                    },
                    checkOnSave = false,
                    diagnostics = {
                        enable = true,
                        experimental = { enable = true },
                    },
                    detachedFiles = {},
                    procMacro = { enable = true },
                    cargo = { autoreload = true },
                },
            },
        })
        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
            },

            filetypes = { "c", "cpp", "objc", "objcpp" },

            root_markers = {
                "compile_commands.json",
                "compile_flags.txt",
                "*.c",
                "*.cpp"
            },


        })


        -- =====================================================================
        -- 4. INSTALL TOOLS & ENABLE SERVERS
        -- =====================================================================
        require("mason-tool-installer").setup({
            ensure_installed = { "lua-language-server", "rust-analyzer" },
        })

        -- Enable configured servers globally
        vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd" })
    end,
}
