-- vv - Makes vertical split
vim.keymap.set("n", "vv", "<C-W>v")
-- ss - Makes horizontal split
vim.keymap.set("n", "ss", "<C-W>s")

-- Quick jumping between splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Indenting in visual mode (tab/shift+tab)
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Move to the end of yanked text after yank and paste
vim.cmd "vnoremap <silent> y y`]"
vim.cmd "vnoremap <silent> p p`]"
vim.cmd "nnoremap <silent> p p`]"

-- Space + Space to clean search highlight
vim.keymap.set("n", "<Leader>h", ":noh<CR>", { silent = true })

-- Fixes pasting after visual selection.
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>")

vim.keymap.set("n", "<leader>fw", "<cmd>HopWord<cr>")
vim.keymap.set("n", "<leader>fz", "<cmd>HopLine<cr>")
