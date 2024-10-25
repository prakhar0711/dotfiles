return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
    },
  },
  config = function(_, opts) require("neo-tree").setup(opts) end,
}
