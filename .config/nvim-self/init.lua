local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")
require("lazy").setup("plugins")

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	vim.g.neovide_refresh_rate = 60

	vim.g.neovide_cursor_animate_in_insert_mode = true
end
