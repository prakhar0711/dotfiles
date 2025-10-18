return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
        -- 📁 File Search
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files (cwd)",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "Recent Files",
        },
        {
            "<leader>fp",
            function()
                require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
            end,
            desc = "Find Files (current dir)",
        },

        -- 🔍 Grep & Search
        {
            "<leader>fg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Live Grep",
        },
        {
            "<leader>fs",
            function()
                local fzf = require("fzf-lua")
                fzf.grep({ search = vim.fn.input("Grep > ") })
            end,
            desc = "Search String",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "Search Word Under Cursor",
        },
        {
            "<leader>fv",
            function()
                require("fzf-lua").grep_visual()
            end,
            mode = "v",
            desc = "Search Visual Selection",
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "Diagnostics (Document)",
        },
        {
            "<leader>fD",
            function()
                require("fzf-lua").diagnostics_workspace()
            end,
            desc = "Diagnostics (Workspace)",
        },

        -- 🧠 LSP
        {
            "<leader>ld",
            function()
                require("fzf-lua").lsp_definitions()
            end,
            desc = "LSP Definitions",
        },
        {
            "<leader>lr",
            function()
                require("fzf-lua").lsp_references()
            end,
            desc = "LSP References",
        },
        {
            "<leader>li",
            function()
                require("fzf-lua").lsp_implementations()
            end,
            desc = "LSP Implementations",
        },
        {
            "<leader>ls",
            function()
                require("fzf-lua").lsp_document_symbols()
            end,
            desc = "LSP Document Symbols",
        },
        {
            "<leader>lS",
            function()
                require("fzf-lua").lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
        {
            "<leader>la",
            function()
                require("fzf-lua").lsp_code_actions()
            end,
            desc = "Code Actions",
        },

        -- 📚 Buffers, Help, etc.
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Help Tags",
        },
        {
            "<leader>fc",
            function()
                require("fzf-lua").colorschemes()
            end,
            desc = "Colorschemes",
        },
        {
            "<leader>fm",
            function()
                require("fzf-lua").marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>frg",
            function()
                require("fzf-lua").registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>fk",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "Keymaps",
        },

        -- 🧩 Git
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gc",
            function()
                require("fzf-lua").git_commits()
            end,
            desc = "Git Commits",
        },
        {
            "<leader>gb",
            function()
                require("fzf-lua").git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                require("fzf-lua").git_bcommits()
            end,
            desc = "Git Commits (Current File)",
        },

        -- 🪄 Misc
        {
            "<leader><leader>",
            function()
                require("fzf-lua").resume()
            end,
            desc = "Resume Last Picker",
        },
        {
            "<leader>:",
            function()
                require("fzf-lua").commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>ch",
            function()
                require("fzf-lua").command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>sr",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>sb",
            function()
                require("fzf-lua").blines()
            end,
            desc = "Search in Current Buffer",
        },
    },
    config = function()
        require("fzf-lua").setup({
            "default-title",
            fzf_opts = { ["--wrap"] = true, ["--layout"] = "reverse-list", ["--info"] = "inline" },
            default_mode = "normal",
            previewers = {
                builtin = { syntax_limit_b = -102400 },
            },
            winopts = {
                -- this section controls the overall layout
                height = 0.85, -- total window height
                width = 0.80, -- total window width
                row = 0.5,
                col = 0.5,
                border = "rounded",

                preview = {
                    layout = "horizontal", -- telescope-like: list left, preview right
                    horizontal = "right:45%", -- preview takes 40% width
                    flip_columns = 120, -- auto flip to vertical if narrow
                    wrap = true,
                    title = true,
                    scrollbar = false,
                },
            },
            grep = {
                rg_glob = true,
                rg_glob_fn = function(query)
                    local regex, flags = query:match("^(.-)%s%-%-(.*)$")
                    return (regex or query), flags
                end,
            },
            defaults = {
                git_icons = true,
                file_icons = true,
                color_icons = true,
                formatter = "path.filename_first",
            },
        })
    end,
}
