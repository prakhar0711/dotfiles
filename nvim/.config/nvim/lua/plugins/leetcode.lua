return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",
    },
    opts = {
        provider = { picker = nil },
    },
}
