local map = require("utils").map

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	view = {
		side = "right",
	},
	renderer = {
		icons = {
			show = {
				file = false,
				folder = false,
			},
		},
	},
})

map("n", "<leader>d", vim.cmd.NvimTreeToggle)
map("n", "<leader>f", vim.cmd.NvimTreeFocus)
