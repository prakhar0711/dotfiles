return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { "Cargo.toml", "rust-project.json", ".git" })
        local final_root = root or (fname ~= "" and vim.fs.dirname(fname)) or vim.uv.cwd()
        if on_dir then
            on_dir(final_root)
        end
        return final_root
    end,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allTargets = true, autoreload = true },
            check = { command = "clippy" },
            diagnostics = { enable = true },
            procMacro = { enable = true },
        },
    },
}
