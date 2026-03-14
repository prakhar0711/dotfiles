-- lua/sidebar.lua

-- Netrw core settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.netrw_keepdir = 0
vim.g.netrw_browse_split = 4

local SIDEBAR_WIDTH = 30

local function sidebar_window()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == "netrw" then
                        return win
                end
        end
        return nil
end

local function open_sidebar()
        vim.cmd("Vexplore")
        vim.cmd("vertical resize " .. SIDEBAR_WIDTH)
end

vim.api.nvim_create_autocmd("FileType", {
        pattern = "netrw",
        callback = function()
                vim.wo.winfixwidth = true
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.buflisted = false

                vim.keymap.set("n", "o", function()
                        local file = vim.fn.expand("<cfile>")
                        vim.cmd("wincmd p")
                        vim.cmd("edit " .. file)
                end, { buffer = true })

                vim.keymap.set("n", "%", function()
                        local name = vim.fn.input("New file: ")
                        if name ~= "" then
                                vim.cmd("wincmd p")
                                vim.cmd("edit " .. name)
                        end
                end, { buffer = true })
        end,
})

-- vim.keymap.set("n", "<leader>e", function()
--         local win = sidebar_window()
--         if win then
--                 vim.api.nvim_win_close(win, true)
--         else
--                 open_sidebar()
--         end
-- end)
