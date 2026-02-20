local function ColorMyPencils(color)
        color = color or "tairiki"

        vim.cmd.colorscheme(color)

        -- transparency
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- enable the below only when using vague Optional: dim the background of non-active windows slightly
        -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" }) -- or some subtle shade
end

ColorMyPencils()
