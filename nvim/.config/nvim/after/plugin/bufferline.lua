vim.opt.termguicolors = true
-- Basic bufferline setup
require("bufferline").setup({
	options = {
		numbers = "ordinal", -- Shows buffer numbers
		diagnostics = "nvim_lsp", -- Show LSP diagnostics in bufferline
		show_buffer_close_icons = true,
		show_close_icon = true,
		always_show_bufferline = true,
		indicator = {
			style = "underline",
		},
	},
})

-- Keymaps for buffer navigation and management
local opts = { noremap = true, silent = true }

-- Navigate buffers
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- Move buffers
vim.api.nvim_set_keymap("n", "<A-l>", ":BufferLineMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-h>", ":BufferLineMovePrev<CR>", opts)

-- Pick buffer (helps quickly select a buffer by letter)
vim.api.nvim_set_keymap("n", "<leader>xp", ":BufferLinePick<CR>", opts)

-- Close buffer
vim.keymap.set("n", "<leader>xc", ":bdelete<CR>", opts, { desc = "Close current buffer" })

-- Close all buffers except current
vim.api.nvim_set_keymap("n", "<leader>xo", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)

-- Close buffers to the right
vim.api.nvim_set_keymap("n", "<leader>xr", ":BufferLineCloseRight<CR>", opts)

-- Close buffers to the left
vim.api.nvim_set_keymap("n", "<leader>xl", ":BufferLineCloseLeft<CR>", opts)
