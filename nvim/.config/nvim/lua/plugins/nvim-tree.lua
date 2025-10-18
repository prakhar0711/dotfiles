return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim-Tree" })
        require("nvim-tree").setup({
            auto_reload_on_write = true,
            view = {
                width = 30,
                side = "right",
            },
            renderer = {
                icons = {
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                    },
                },
            },
            git = {
                enable = true, -- show git status
                ignore = true, -- show ignored files too
                timeout = 500,
            },
        })
    end,
}
