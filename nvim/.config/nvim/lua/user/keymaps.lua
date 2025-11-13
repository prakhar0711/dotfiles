-- ========================================
-- 🔑 Leader Key
-- ========================================
vim.g.mapleader = " "

-- Toggle LSP diagnostics (virtual text, signs, underline)
local diagnostics_active = true

vim.keymap.set("n", "<leader>td", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.enable()
        print("LSP diagnostics: ON")
    else
        vim.diagnostic.disable()
        print("LSP diagnostics: OFF")
    end
end, { desc = "Toggle LSP diagnostics" })
-- ========================================
-- 🗂️ File & Plugin Shortcuts
-- ========================================
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Default Explorer" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload config" })

-- ========================================
-- 🪟 Window Management
-- ========================================
vim.keymap.set("n", "vv", "<C-W>v", { desc = "Vertical split" })
vim.keymap.set("n", "ss", "<C-W>s", { desc = "Horizontal split" })

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize splits with Alt + Arrows
vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Left>", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-Right>", ":vertical resize -2<CR>", { desc = "Decrease window width" })

-- ========================================
-- 📄 Buffer Management
-- ========================================
vim.keymap.set("n", "<leader>xc", ":bd<CR>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- ========================================
-- 🧭 Navigation Enhancements
-- ========================================
vim.keymap.set("n", "J", "mzJ`z")       -- keep cursor centered when joining lines
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- scroll half page down + center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- scroll half page up + center
-- vim.keymap.set("n", "n", "nzzzv")       -- center next search
-- vim.keymap.set("n", "N", "Nzzzv")       -- center previous search

-- ========================================
-- ✍️ Editing Utilities
-- ========================================
-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Indent / unindent in visual mode
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Fix pasting behavior in visual mode (don’t overwrite default register)
vim.keymap.set("v", "p", '"_dP')

-- Replace current word globally
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word globally" }
)

-- Replace current word in a specific line range (count-based)
vim.keymap.set("n", "<leader>sdf", function()
    local current_word = vim.fn.expand("<cword>")
    local replacement_word = vim.fn.input("Replace with: ", current_word)
    local count = vim.v.count1
    local cmd = string.format(".,.+%ds/\\<%s\\>/%s/gcI", count - 1, current_word, replacement_word)
    vim.cmd(cmd)
end, { desc = "Replace current word in N lines" })

-- ========================================
-- 🧰 LSP / Diagnostics
-- ========================================
vim.keymap.set("n", "<leader>lg", function()
    vim.diagnostic.open_float()
end, { desc = "Open diagnostic float" })

-- ========================================
-- 💾 Save & Format
-- ========================================
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("write")
    vim.cmd("stopinsert")
end, { desc = "Format + Save" })

-- ========================================
-- 🧷 Clipboard Integrations
-- ========================================
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yy', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- ========================================
-- 🚫 Disable Arrow Keys
-- ========================================
for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>" }) do
    vim.keymap.set("n", key, "<Nop>", { noremap = true, silent = true })
end

-- ========================================
-- 🖊️ Insert & Terminal Mode
-- ========================================
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode with jj" })

-- Insert mode arrow alternatives
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
