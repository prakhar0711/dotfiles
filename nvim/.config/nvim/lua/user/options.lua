-- ========================================
-- 📦 General Settings
-- ========================================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, { command = "checktime" })

vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.termguicolors = true
vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 200

-- ========================================
-- 🪟 UI & Appearance
-- ========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.cursorline = false
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 5
vim.opt.colorcolumn = "80"

-- Transparency blending (disable if using Picom/WezTerm opacity)
vim.opt.pumblend = 0
vim.opt.winblend = 0

-- Smooth scrolling (Neovim ≥ 0.10)
vim.opt.smoothscroll = true

-- ========================================
-- 🔍 Search
-- ========================================
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- ========================================
-- 🧠 Behavior & Performance
-- ========================================
vim.o.updatetime = 100
vim.o.timeoutlen = 300

-- ========================================
-- 📋 Clipboard
-- ========================================
if vim.fn.has("clipboard") == 1 then
    vim.o.clipboard = "unnamedplus"
end

-- ========================================
-- 💬 Completion
-- ========================================
vim.o.completeopt = "menuone,noselect"

-- ========================================
-- 🧱 Indentation
-- ========================================
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- ========================================
-- 📄 Text Wrapping
-- ========================================
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳"

-- ========================================
-- 🔲 Window Splits
-- ========================================
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ========================================
-- 🧭 Misc
-- ========================================
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""
