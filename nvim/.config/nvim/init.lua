if vim.loader then
    vim.loader.enable()
end
require("user.options")
require("user.keymaps")
require("config.lazy")
require("custom.bufferline")
-- Remove tilde from end of buffer and replace with whitespace
-- vim.cmd("let &fillchars='eob: '")
