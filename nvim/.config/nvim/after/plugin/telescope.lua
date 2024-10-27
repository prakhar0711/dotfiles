require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

-- KEYMAPS --
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files Current Dir" })
vim.keymap.set("n", "<leader>fz", builtin.find_files, { desc = "Find Files Current Dir" })
vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope Grep String" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffers fuzzy find" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope keymaps <cr>", { desc = "Keymaps" })
