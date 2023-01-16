vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nkrkv/nvim-treesitter-rescript", -- Support for ReScript
				ft = "rescript",
			},
			"windwp/nvim-ts-autotag", -- Automatically close/update HTML tags
		},
		opts = {
			-- Turn on highlighting
			highlight = {
				additional_vim_regex_highlighting = false,
				enable = true,
			},

			-- Enable windwp/nvim-ts-autotag for close/update tags
			autotag = { enable = true },

			-- Enable autopairs
			autopairs = { enable = true },

			-- Enable indent
			indent = { enable = true },

			-- Enable incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},

			-- Ensure that certain syntaxes are installed
			ensure_installed = {
				"css",
				"javascript",
				"json",
				"lua",
				"markdown",
				"scss",
				"typescript",
				"vue",
			},
		},
	},
}
