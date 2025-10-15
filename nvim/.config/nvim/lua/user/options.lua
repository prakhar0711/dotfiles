vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.nu = true
vim.opt.relativenumber = true

vim.wo.cursorline = false
-- Set highlight on search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Make line numbers default
-- vim.wo.number = true

-- Sync clipboard between OS and Neovim.
if vim.fn.has("clipboard") == 1 then
	vim.o.clipboard = "unnamedplus"
end

-- No swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.opt.scrolloff = 8 -- Always keep 8 lines above/below cursor
vim.opt.signcolumn = "yes" -- Always show the sign column (for Git/diagnostics)
vim.opt.isfname:append("@-@") -- Allow `@` in filenames

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
vim.opt.guicursor = ""

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- " Open splits on the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- " update vim after file update from outside
vim.opt.autoread = true

-- " Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- " Always use spaces insted of tabs
vim.opt.expandtab = true

-- " Don't wrap lines
vim.opt.wrap = true
-- " Wrap lines at convenient points
vim.opt.linebreak = true
-- " Show line breaks
vim.opt.showbreak = "↳"
vim.opt.breakindent = true

-- " Start scrolling when we'are 8 lines aways from borders
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 5
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.colorcolumn = "90"
vim.opt.errorbells = false
vim.opt.visualbell = false
-- Enable smooth scrolling in Neovim >= 0.10
vim.opt.smoothscroll = true
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, { command = "checktime" })
-- vim.o.winborder = "rounded"
