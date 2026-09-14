vim.loader.enable()
vim.g.mapleader = " "

-- require("vim._core.ui2").enable({})
require("user.options")
require("config.lazy")
require("user.keymaps")
require("core.colors")
require("custom.bufferline")
-- require("custom.sidebar")
-- Remove tilde from end of buffer and replace with whitespace
-- vim.cmd("let &fillchars='eob: '")
vim.lsp.log.set_level("ERROR")
