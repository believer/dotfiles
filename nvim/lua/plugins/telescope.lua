return {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local actions = require("telescope.actions")

			-- Load fzf support
			require("telescope").load_extension("fzf")

			-- Setup
			require("telescope").setup({
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
					},
				},
				defaults = {
					mappings = {
						i = {
							-- Close telescope with <Esc> instead of switching to normal mode
							["<esc>"] = actions.close,
						},
					},
				},
			})
		end,
	},
}
