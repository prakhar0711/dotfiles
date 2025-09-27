return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim-Tree" })
		require("nvim-tree").setup({
			view = {
				side = "right",
				signcolumn = "no",
			},
			renderer = {
				highlight_git = "all",
				highlight_modified = "all",
				highlight_diagnostics = "icon",
				hidden_display = "all",
				indent_markers = {
					enable = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "├",
						none = " ",
					},
				},
			},
			git = {
				enable = true,
			},
			diagnostics = {
				enable = true,
			},
			modified = {
				enable = true,
			},
		})
	end,
}
