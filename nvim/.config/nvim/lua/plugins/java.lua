return {
        -- Core plugin for Java-specific features in Neovim
        {
                "mfussenegger/nvim-jdtls",
                dependencies = { "neovim/nvim-lspconfig" },
                ft = { "java" },
                config = function()
                        -- 1. Try to find a project root first
                        local root_file = vim.fs.find({ 'pom.xml', 'build.gradle', 'gradlew' }, { upward = true })[1]

                        -- 2. If a project root exists, use its directory. Otherwise, fallback to the current file's directory.
                        local root_dir = root_file and vim.fs.dirname(root_file) or
                            vim.fs.dirname(vim.api.nvim_buf_get_name(0))

                        -- 3. Isolate workspaces to prevent data collisions between different single files
                        local project_name = vim.fs.basename(root_dir) or "standalone-workspace"
                        local data_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

                        local config = {
                                cmd = { "jdtls", "-data", data_dir },
                                root_dir = root_dir,
                        }

                        require('jdtls').start_or_attach(config)

                        -- Quick runner map for convenience
                        vim.keymap.set('n', '<leader>rj', ':w | split | terminal java %<CR>',
                                { buffer = true, desc = "Run Java" })
                end
        }
}
