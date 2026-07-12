local function bufferline()
    local current = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()
    local parts = {}

    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
            local name = vim.api.nvim_buf_get_name(buf)

            if name == "" then
                name = "[No Name]"
            else
                name = vim.fn.fnamemodify(name, ":t")

                -- prevent a single long filename from consuming the entire tabline
                if #name > 30 then
                    name = name:sub(1, 27) .. "..."
                end
            end

            local modified = vim.bo[buf].modified and " ●" or ""
            local hl = buf == current and "%#TabLineSel#" or "%#TabLine#"

            parts[#parts + 1] = string.format(
                "%s %d:%s%s ",
                hl,
                buf,
                name,
                modified
            )
        end
    end

    return table.concat(parts) .. "%#TabLineFill#"
end

_G.bufferline = bufferline

vim.opt.showtabline = 2 -- always show tabline
vim.opt.tabline = "%!v:lua.bufferline()"

local group = vim.api.nvim_create_augroup("CustomBufferline", { clear = true })

vim.api.nvim_create_autocmd({
    "BufAdd",
    "BufDelete",
    "BufEnter",
    "BufModifiedSet",
}, {
    group = group,
    callback = function()
        vim.cmd.redrawtabline()
    end,
})
