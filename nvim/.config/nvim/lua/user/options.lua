vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.nu = true
vim.opt.relativenumber = true

vim.wo.cursorline = false
-- Set highlight on search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- No swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

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
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
