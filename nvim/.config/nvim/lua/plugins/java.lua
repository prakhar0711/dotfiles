return {
    "mfussenegger/nvim-jdtls",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    ft = { "java" },

    config = function()
        local jdtls = require("jdtls")
        local jdtls_setup = require("jdtls.setup")

        ----------------------------------------------------------------------
        -- Project root detection
        ----------------------------------------------------------------------

        local root_dir = jdtls_setup.find_root({
            "mvnw",
            "gradlew",
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
            "settings.gradle",
            "settings.gradle.kts",
        })

        -- Fallback for standalone Java files
        if not root_dir then
            root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        end

        ----------------------------------------------------------------------
        -- Workspace isolation
        ----------------------------------------------------------------------

        local project_name = vim.fs.basename(root_dir) or "standalone-workspace"

        local workspace_dir = vim.fn.stdpath("cache")
            .. "/jdtls/workspace/"
            .. project_name

        ----------------------------------------------------------------------
        -- LSP configuration
        ----------------------------------------------------------------------

        local config = {
            cmd = {
                "jdtls",
                "-data",
                workspace_dir,
            },

            root_dir = root_dir,

            settings = {
                java = {
                    eclipse = {
                        downloadSources = true,
                    },

                    maven = {
                        downloadSources = true,
                    },

                    references = {
                        includeDecompiledSources = true,
                    },

                    configuration = {
                        updateBuildConfiguration = "interactive",
                    },

                    implementationsCodeLens = {
                        enabled = true,
                    },

                    referencesCodeLens = {
                        enabled = true,
                    },

                    format = {
                        enabled = true,
                    },

                    inlayHints = {
                        parameterNames = {
                            enabled = "all",
                        },
                    },
                },
            },

            flags = {
                allow_incremental_sync = true,
            },
        }

        jdtls.start_or_attach(config)

        ----------------------------------------------------------------------
        -- Refactoring keymaps
        ----------------------------------------------------------------------

        local opts = { buffer = true, silent = true }

        vim.keymap.set(
            "n",
            "<leader>jo",
            jdtls.organize_imports,
            vim.tbl_extend("force", opts, { desc = "Java: Organize Imports" })
        )

        vim.keymap.set(
            "n",
            "<leader>jv",
            jdtls.extract_variable,
            vim.tbl_extend("force", opts, { desc = "Java: Extract Variable" })
        )

        vim.keymap.set(
            "v",
            "<leader>jv",
            function()
                jdtls.extract_variable(true)
            end,
            vim.tbl_extend("force", opts, { desc = "Java: Extract Variable" })
        )

        vim.keymap.set(
            "v",
            "<leader>jm",
            function()
                jdtls.extract_method(true)
            end,
            vim.tbl_extend("force", opts, { desc = "Java: Extract Method" })
        )

        vim.keymap.set(
            "n",
            "<leader>jt",
            jdtls.test_nearest_method,
            vim.tbl_extend("force", opts, { desc = "Java: Run Nearest Test" })
        )

        vim.keymap.set(
            "n",
            "<leader>jT",
            jdtls.test_class,
            vim.tbl_extend("force", opts, { desc = "Java: Run Test Class" })
        )

        ----------------------------------------------------------------------
        -- Run current Java file
        ----------------------------------------------------------------------

        vim.keymap.set("n", "<leader>rj", function()
            vim.cmd.write()

            local java_file = vim.fn.expand("%:p")

            vim.cmd("vsplit")
            vim.cmd("terminal java " .. vim.fn.shellescape(java_file))
            vim.cmd("startinsert")
        end, vim.tbl_extend("force", opts, {
            desc = "Java: Run Current File",
        }))

        ----------------------------------------------------------------------
        -- Format on save
        ----------------------------------------------------------------------

        local group = vim.api.nvim_create_augroup(
            "java-format-on-save",
            { clear = false }
        )

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = 0,
            callback = function()
                vim.lsp.buf.format({
                    async = false,
                    timeout_ms = 3000,
                })
            end,
        })
    end,
}
