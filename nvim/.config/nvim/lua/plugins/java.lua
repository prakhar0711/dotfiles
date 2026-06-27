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
            vim.keymap.set('n', '<leader>rj', function()
                vim.cmd('w') -- Save your Java file

                -- FIX: Grab the file path right now while the Java file is active!
                local java_file = vim.fn.expand('%')

                -- 1. Create a hidden, completely unlisted scratch buffer
                local buf = vim.api.nvim_create_buf(false, true)

                -- 2. Open a clean horizontal split window using that buffer
                vim.cmd('vsplit')
                vim.api.nvim_set_current_buf(buf)

                -- 3. Run Java inside this specific scratch terminal using our saved variable
                vim.fn.termopen('java ' .. java_file)

                -- 4. Clean up: when you type ':q' or 'q', delete this temporary buffer
                vim.api.nvim_create_autocmd("TermClose", {
                    buffer = buf,
                    callback = function()
                        vim.keymap.set('n', 'q', ':bd!<CR>', { buffer = buf, silent = true })
                    end,
                })
            end, { buffer = true, desc = "Run Java Only in Split" })
        end
    }
}
