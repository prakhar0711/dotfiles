vim.cmd("packadd mason.nvim")
vim.cmd("packadd mason-lspconfig.nvim")
vim.cmd("packadd mason-tool-installer.nvim")

require("mason").setup()
