-- load plugin
vim.cmd("packadd which-key.nvim")

-- setup
require("which-key").setup({})

-- keymap
vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
