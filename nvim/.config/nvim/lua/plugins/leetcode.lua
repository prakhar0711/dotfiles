return {
    "kawre/leetcode.nvim",
    -- lazy = true,
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lang = "cpp",
        image_support = true,
        picker = { provider = nil },
        description = {
            position = "left",

        },
    },
}
