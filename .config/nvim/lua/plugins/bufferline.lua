return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<leader>bz", "<cmd>BufferLinePickClose<cr>", desc = "BufferLine PickClose" },
  },
  opts = {
    options = {
      themeable = true,
      separator_style = "slope",
      left_mouse_command = "buffer %d",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      middle_mouse_command = nil,
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",

      always_show_bufferline = false,
      indicator = {
        -- icon = "|",
        style = "underline",
      },

      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
