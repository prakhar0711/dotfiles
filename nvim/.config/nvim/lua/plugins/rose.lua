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
  -- Lazy

  "tanvirtin/monokai.nvim",
  config = function() vim.cmd "colorscheme monokai" end,
}
