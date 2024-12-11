require("user")
require("config")
-- Remove tilde from end of buffer and replace with whitespace
vim.cmd("let &fillchars='eob: '")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.cmd.colorscheme("rose-pine-moon")
-- vim.cmd.colorscheme("solarized-osaka-night")
