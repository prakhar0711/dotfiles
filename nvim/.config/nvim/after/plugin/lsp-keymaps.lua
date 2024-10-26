local lspconfig = require('lspconfig')
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP Declaration" })
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP Definition" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP Hover" })
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP Implementation" })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP Signature Help" })
        vim.keymap.set('n', '<leader>ga', vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "Add Workspace Folder" })
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "Remove Workspace Folder" })
        vim.keymap.set('n', '<leader>gl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = ev.buf, desc = "List Workspace Folders" })
        vim.keymap.set('n', '<leader>gz', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type Definition" })
        vim.keymap.set('n', '<leader>gx', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        vim.keymap.set('n', '<leader>gc', vim.lsp.buf.references, { buffer = ev.buf, desc = "Find References" })
    end,
})
