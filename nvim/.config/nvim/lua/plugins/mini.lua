return {
    {
        "echasnovski/mini.surround",
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    -- {
    --     "nvim-mini/mini.indentscope",
    --     version = false, -- wait till new 0.7.0 release to put it back on semver
    --     opts = {
    --         -- symbol = "▏",
    --         -- symbol = '╎',
    --         draw = { delay = 0 },
    --         symbol = "│",
    --         options = { try_as_border = true },
    --     },
    -- }
}
