-- ~/.config/nvim-new/lua/lsp.lua
vim.lsp.enable({
  "bashls",
  "gopls",
  "lua_ls",
  "rust-analyzer",
})
vim.diagnostic.config({ virtual_text = true })

