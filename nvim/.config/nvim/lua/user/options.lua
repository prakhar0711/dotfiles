-- =====================================================================
-- 📊 MINIMAL CUSTOM STATUSLINE
-- =====================================================================
vim.opt.statusline = "%f %m %r %= %y %l:%c"

-- =====================================================================
-- 📦 GENERAL & FILE SYSTEM SETTINGS
-- =====================================================================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true -- Enabled persistent undo storage history!
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Sync file transformations instantly if modified outside of Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
        group = vim.api.nvim_create_augroup("auto_checktime", { clear = true }),
        command = "checktime"
})

-- =====================================================================
-- 🪟 UI, SCROLLING & APPEARANCE PRESETS
-- =====================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false -- Keeping cursorline turned off for speed
vim.opt.signcolumn = "yes" -- Prevents shifting layout layout frames on diagnostics
vim.opt.termguicolors = true
vim.opt.synmaxcol = 200    -- Limits syntax rendering on long strings for speed

-- Screen Real Estate Paddings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 5
vim.opt.colorcolumn = "100"

-- Modern Floating Interface Configuration
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.smoothscroll = true -- Native smooth scrolling container physics

-- Cursor State Indicators (Gives an explicit line inside insert layouts)
vim.opt.guicursor = "a:block"

-- =====================================================================
-- 🔍 SEARCH & PATTERN LOGIC
-- =====================================================================
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- =====================================================================
-- 🧠 BEHAVIOR, PIPES & PERFORMANCE TIMERS
-- =====================================================================
vim.opt.updatetime = 100 -- Fast context evaluation (critical for diagnostics)
vim.opt.timeoutlen = 300 -- Controls multi-key timeout actions speed

if vim.fn.has("clipboard") == 1 then
        vim.opt.clipboard = "unnamedplus"
end

-- =====================================================================
-- 🧱 REFINED INDENTATION DEFINITIONS (Java & DSA Friendly)
-- =====================================================================
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- Swapped standard structural dimensions to 4 columns (ideal for Java nesting)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- =====================================================================
-- 📄 TEXT WRAPPING & SPLITS DEFINITIONS
-- =====================================================================
vim.opt.wrap = true
vim.opt.linebreak = true   -- Wrap long lines wrap cleanly at word boundaries
vim.opt.breakindent = true -- Matches indented blocks on continuation lines
vim.opt.showbreak = "↳ "

vim.opt.splitbelow = true
vim.opt.splitright = true

-- File naming match exceptions
vim.opt.isfname:append("@-@")

-- =====================================================================
-- 🛠️ AUTOMATED EVENT HANDLERS (AUTOCMDS)
-- =====================================================================
local custom_events = vim.api.nvim_create_augroup("custom_core_events", { clear = true })

-- Dynamic Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
        group = custom_events,
        pattern = "*",
        desc = "Highlight selection on yank",
        callback = function()
                vim.highlight.on_yank({ timeout = 150, visual = true })
        end,
})

-- Force documentation files to open in far right side splits
vim.api.nvim_create_autocmd("FileType", {
        group = custom_events,
        pattern = { "help", "man" },
        command = "wincmd L",
})

-- Auto-balance splits when the shell window is resized
vim.api.nvim_create_autocmd("VimResized", {
        group = custom_events,
        command = "wincmd =",
})

-- Discipline line wrapper comment loops (stops automatic comment creation on Enter)
vim.api.nvim_create_autocmd("FileType", {
        group = custom_events,
        callback = function()
                vim.opt_local.formatoptions:remove({ "c", "r", "o" })
        end,
})
