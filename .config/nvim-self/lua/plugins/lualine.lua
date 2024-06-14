return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "kanagawa",
        icons_enabled = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
    })
  end,
}
