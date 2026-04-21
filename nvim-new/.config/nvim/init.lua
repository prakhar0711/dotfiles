-- if vim.loader then
--     vim.loader.enable()
-- end

require("user.options")
require("user.keymaps")
require("custom.bufferline")

--plugins
require("plugins")
-- configs (order matters)
require("config.colors")
require("config.snacks")
require("config.lsp")
require("config.mason")
require("config.blink")
require("config.treesitter")
require("config.flash")
require("config.whichkey")
require("config.highlight-colors")

--colorscheme
require("core.colors").ColorMyPencils()
--require("custom.sidebar")

-- Remove tilde from end of buffer and replace with whitespace
-- vim.cmd("let &fillchars='eob: '")

vim.lsp.log.set_level("ERROR")
local group = vim.api.nvim_create_augroup("CapsEscapeToggle", { clear = true })

-- enable Caps → Esc when nvim starts
vim.api.nvim_create_autocmd("VimEnter", {
        group = group,
        callback = function()
                vim.fn.system("caps_on")
        end,
})

-- restore normal Caps when nvim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
                vim.fn.system("caps_off")
        end,
})
