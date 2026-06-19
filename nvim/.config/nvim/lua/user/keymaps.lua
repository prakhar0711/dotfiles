-- =====================================================================
-- 🔑 LEADER KEY CONFIGURATION
-- =====================================================================
vim.g.mapleader = " "

-- =====================================================================
-- 🗂️ FILE, PLUGIN & CORE SHORTCUTS
-- =====================================================================
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader>r", "<cmd>source $MYVIMRC<cr>", { desc = "Reload Config Workspace" })

-- Toggle LSP diagnostics visibility cleanly
local diagnostics_active = true
vim.keymap.set("n", "<leader>td", function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
                vim.diagnostic.show()
                print("LSP diagnostics: ON")
        else
                vim.diagnostic.hide()
                print("LSP diagnostics: OFF")
        end
end, { desc = "Toggle Diagnostics Visibility" })

-- =====================================================================
-- 🪟 WINDOW MANAGEMENT & NAVIGATION
-- =====================================================================
vim.keymap.set("n", "vv", "<C-w>v", { desc = "Vertical Split Window" })
vim.keymap.set("n", "ss", "<C-w>s", { desc = "Horizontal Split Window" })

-- Quick window navigation using explicit direction vectors
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus Left Split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus Down Split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus Up Split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus Right Split" })

-- Resize splits with Alt + Arrows
vim.keymap.set("n", "<M-Up>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })

-- =====================================================================
-- 📄 BUFFER MANAGEMENT
-- =====================================================================
vim.keymap.set("n", "<leader>xc", "<cmd>bd<cr>", { desc = "Close Current Buffer", silent = true })
vim.keymap.set("n", "H", "<cmd>bprevious<cr>", { desc = "Go to Prev Buffer", silent = true })
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Go to Next Buffer", silent = true })

-- =====================================================================
-- 🧭 NAVIGATION ENHANCEMENTS & SMOOTH SCROLLING
-- =====================================================================
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line keeping cursor stationary" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down + Center Screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up + Center Screen" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match centered" }) -- QoL addition
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev match centered" }) -- QoL addition

-- =====================================================================
-- ✍️ EDITING UTILITIES & REFACTORING
-- =====================================================================
-- Move blocks of code up/down smoothly in visual modes
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })

-- Dynamic shifting without breaking visual selections
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection block" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection block" })

-- Blackhole deletion modifications (Prevent yank stack pollution)
vim.keymap.set({ "v", "x" }, "p", '"_dP', { desc = "Paste preserving register data" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })

-- Global Word Modification Search & Replace Matrix
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = "Replace Word Globally" })

vim.keymap.set("n", "<leader>sdf", function()
        local current_word = vim.fn.expand("<cword>")
        local replacement_word = vim.fn.input("Replace with: ", current_word)
        local count = vim.v.count1
        local cmd = string.format(".,.+%ds/\\<%s\\>/%s/gcI", count - 1, current_word, replacement_word)
        vim.cmd(cmd)
end, { desc = "Replace current word within targeted line count block" })

-- =====================================================================
-- 💾 SAVE & INLINE LSP INTERACTIONS
-- =====================================================================
vim.keymap.set("n", "<leader>lg", function() vim.diagnostic.open_float() end, { desc = "Open Diagnostic Float Overlay" })

-- Atomic Command Execution for fast formatting + syncing writing operations
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
        vim.lsp.buf.format({ async = false })
        vim.cmd("write")
        vim.cmd("stopinsert")
end, { desc = "Format Document + Flush Changes to Disk" })

-- =====================================================================
-- 🧷 SYSTEM CLIPBOARD PASSTHROUGHS
-- =====================================================================
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank Selection to System Clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yy', { desc = "Yank Absolute Line to System Clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Append Clipboard Data Next" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Prepend Clipboard Data Before" })

-- =====================================================================
-- 🖊️ DISCIPLINE MATRIX & INSERT/TERMINAL UTILITIES
-- =====================================================================
-- Disable hard arrow components in normal states to maintain clean muscle memory
for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>" }) do
        vim.keymap.set("n", key, "<Nop>", { noremap = true, silent = true })
end

-- Escape Sequence Overlays
vim.keymap.set("i", "jj", "<Esc>", { desc = "Break to Normal Mode" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Break to Normal Mode" })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, desc = "Break out of Active Terminal Buffer" })

-- Quick navigation inside insert rows without handling arrow paths
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
