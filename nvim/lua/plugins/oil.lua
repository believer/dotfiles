return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			keymaps = {
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
			},
		})
	end,
}
