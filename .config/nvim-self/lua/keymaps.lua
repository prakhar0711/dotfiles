-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Move normally between wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Shift + q - Quit
vim.keymap.set("n", "Q", "<C-W>q")

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
vim.cmd("vnoremap <silent> y y`]")
vim.cmd("vnoremap <silent> p p`]")
vim.cmd("nnoremap <silent> p p`]")

-- Space + Space to clean search highlight
vim.keymap.set("n", "<Leader>h", ":noh<CR>", { silent = true })

-- Fixes pasting after visual selection.
vim.keymap.set("v", "p", '"_dP')
-- Save on Ctrl+S in insert mode
vim.keymap.set("i", "<C-s>", "<esc>:w<cr><esc>")
-- Save on Ctrl+S
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")

vim.keymap.set({ "n", "v" }, "<leader>q", "<cmd>q<cr>")
vim.keymap.set({ "n", "v" }, "<leader>qq", "<cmd>qall<cr>")

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>")

vim.keymap.set("n", "<leader>fw", "<cmd>HopWord<cr>")
vim.keymap.set("n", "<leader>fe", "<cmd>HopLine<cr>")

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
