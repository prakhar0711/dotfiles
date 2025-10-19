-- === Minimal bufferline ===
local function bufferline()
    local s = ""
    local current = vim.api.nvim_get_current_buf()

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
            local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
            if name == "" then name = "[No Name]" end

            local mod = vim.bo[buf].modified and " ●" or ""
            local hl = (buf == current) and "%#TabLineSel#" or "%#TabLine#"
            s = s .. hl .. " " .. buf .. ":" .. name .. mod .. " "
        end
    end

    return s .. "%#TabLineFill#"
end

function _G.Bufferline()
    return bufferline()
end

vim.o.showtabline = 2 -- always show tabline
vim.o.tabline = "%!v:lua.Bufferline()"

-- refresh when buffers change
vim.api.nvim_create_autocmd(
    { "BufAdd", "BufDelete", "BufEnter", "BufWritePost" },
    { callback = function() vim.cmd("redrawtabline") end }
)

-- basic navigation bindings
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { silent = true })
