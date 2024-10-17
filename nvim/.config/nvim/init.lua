-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
require "keymaps"
require "options"

function Pencils(color)
  color = color or "monokai"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
Pencils()
require("monokai").setup {
  palette = {
    name = "monokai",
    -- base1 = "#272a30",
    -- base2 = "#26292C",
    base1 = "#000000",
    base2 = "#000000",

    base3 = "#2E323C",
    base4 = "#333842",
    base5 = "#4d5154",
    base6 = "#9ca0a4",
    base7 = "#b1b1b1",
    border = "#a1b5b1",
    brown = "#504945",
    white = "#f8f8f0",
    grey = "#8F908A",
    black = "#000000",
    pink = "#f92672",
    green = "#6DCD07",
    aqua = "#66d9ef",
    yellow = "#D2B43E",
    orange = "#fd971f",
    purple = "#ae81ff",
    red = "#D23845",
    diff_add = "#3d5213",
    diff_remove = "#4a0f23",
    diff_change = "#27406b",
    diff_text = "#23324d",
  },
  italics = false,
}
