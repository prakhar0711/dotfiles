return {
    "kawre/leetcode.nvim",
    -- lazy = true,
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lang = "java",
        image_support = true,
        picker = { provider = nil },
        description = {
            position = "left",

        },
    },
}
