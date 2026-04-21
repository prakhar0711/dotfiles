--------------------------------------------------
-- Diagnostics
--------------------------------------------------
vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        virtual_text = {
                prefix = "●",
        },
        float = {
                border = "rounded",
        },
})

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- servers
local servers = {
        lua_ls = {
                settings = {
                        Lua = {
                                completion = { callSnippet = "Replace" },
                        },
                },
        },
        rust_analyzer = {},
        clangd = {},
        gopls = {}
}

-- register configs
for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend(
                "force",
                {},
                capabilities,
                config.capabilities or {}
        )

        vim.lsp.config(name, config)
end

-- enable
vim.lsp.enable(vim.tbl_keys(servers))
--------------------------------------------------
-- Mason installer
--------------------------------------------------
require("mason-tool-installer").setup({
        ensure_installed = vim.tbl_keys(servers),
})

--------------------------------------------------
-- LSP attach
--------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client:supports_method("textDocument/inlayHint") then
                        vim.keymap.set("n", "<leader>th", function()
                                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                                vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
                        end, {
                                buffer = event.buf,
                                desc = "Toggle Inlay Hints",
                        })
                end
        end,
})

-- local lspconfig = require("lspconfig")
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP Declaration" })
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP Definition" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP Hover" })
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "LSP Implementation" })
                vim.keymap.set("n", "<C-q>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP Signature Help" })
                vim.keymap.set(
                        "n",
                        "<leader>ga",
                        vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "Add Workspace Folder" }
                )
                vim.keymap.set(
                        "n",
                        "<leader>gr",
                        vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "Remove Workspace Folder" }
                )
                vim.keymap.set("n", "<leader>gl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = ev.buf, desc = "List Workspace Folders" })
                vim.keymap.set("n", "<leader>gz", vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "Type Definition" })
                vim.keymap.set("n", "<leader>gx", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "Code Action" })
                vim.keymap.set("n", "<leader>gc", vim.lsp.buf.references, { buffer = ev.buf, desc = "Find References" })
        end,
})
