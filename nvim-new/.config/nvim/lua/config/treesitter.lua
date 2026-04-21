vim.cmd("packadd nvim-treesitter")
vim.cmd("packadd nvim-treesitter-context")

-- load plugin
vim.cmd("packadd nvim-treesitter")

-- basic setup (new API)
require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
})

-- install parsers (async)
require("nvim-treesitter").install({
        "lua",
        "rust",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "html",
        "json",
        "java",
        "vim",
})
vim.api.nvim_create_autocmd("FileType", {
        callback = function()
                pcall(vim.treesitter.start)
        end,
})
require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "inner",
})
