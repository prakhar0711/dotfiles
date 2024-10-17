-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     require("rose-pine").setup {
--       styles = {
--         transparency = true,
--       },
--     }
--     vim.cmd "colorscheme rose-pine"
--   end,
return {
  "tanvirtin/monokai.nvim",
  lazy = false,
  priority = 1000,
  config = function() vim.cmd "colorscheme monokai" end,
}
