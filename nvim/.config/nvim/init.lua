vim.loader.enable()
vim.g.mapleader = " "

-- require("vim._core.ui2").enable()
require("user.options")
require("config.lazy")
require("user.keymaps")
require("core.colors")
require("custom.bufferline")
-- require("custom.sidebar")
-- Remove tilde from end of buffer and replace with whitespace
-- vim.cmd("let &fillchars='eob: '")
vim.lsp.log.set_level("ERROR")
-- local group = vim.api.nvim_create_augroup("CapsEscapeToggle", { clear = true })
--
-- -- enable Caps → Esc when nvim starts
-- vim.api.nvim_create_autocmd("VimEnter", {
--         group = group,
--         callback = function()
--                 vim.fn.system("caps_on")
--         end,
-- })
--
-- -- restore normal Caps when nvim exits
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--         group = group,
--         callback = function()
--                 vim.fn.system("caps_off")
--         end,
-- })
