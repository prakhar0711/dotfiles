vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Default Explorer" })
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

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- vim.keymap.set("n", "<leader>fw", "<cmd>HopWord<cr>")
-- vim.keymap.set("n", "<leader>fz", "<cmd>HopLine<cr>")

-- move selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace current word" }
)

vim.keymap.set("n", "<leader>sdf", function()
	-- Get the word under the cursor
	local current_word = vim.fn.expand("<cword>")
	-- Prompt for the replacement word
	local replacement_word = vim.fn.input("Replace with: ", current_word)
	-- Use the count for line range, default to 1 if no count is provided
	local count = vim.v.count1
	-- Construct the substitution command with confirmation
	local cmd = string.format(".,.+%ds/\\<%s\\>/%s/gcI", count - 1, current_word, replacement_word)
	-- Execute the command
	vim.cmd(cmd)
end, { desc = "Replace current word in specified number of lines" })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
	vim.lsp.buf.format({ async = false }) -- Format the file
	vim.cmd("write") -- Save the file
	vim.cmd("stopinsert") -- Return to Normal mode
end, { desc = "Save, format, and exit to Normal mode" })

-- Resize with Ctrl + Shift + Arrow keys
vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-Right>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-Left>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert mode with jj" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert mode with jk" })

vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "lg", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostic in Float" })

-- disable arrow keys
local arrows = { "<Left>", "<Right>", "<Up>", "<Down>" }

for _, key in ipairs(arrows) do
	vim.keymap.set("n", key, "<Nop>", { noremap = true, silent = true })
end
