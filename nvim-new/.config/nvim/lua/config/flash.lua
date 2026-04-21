-- lazy load on first key press (replacement for event = "VeryLazy")

local function load_flash()
        vim.cmd("packadd flash.nvim")
        return require("flash")
end

-- setup (run once after load)
local function setup_flash()
        local flash = load_flash()
        flash.setup({})
end

-- ensure setup runs only once
local initialized = false
local function ensure()
        if not initialized then
                setup_flash()
                initialized = true
        end
end

-- keymaps
vim.keymap.set({ "n", "x", "o" }, "s", function()
        ensure()
        require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
        ensure()
        require("flash").treesitter()
end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function()
        ensure()
        require("flash").remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
        ensure()
        require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<C-s>", function()
        ensure()
        require("flash").toggle()
end, { desc = "Toggle Flash Search" })
