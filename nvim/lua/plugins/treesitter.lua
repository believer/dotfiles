require("nvim-treesitter.configs").setup({
	-- Turn on highlighting
	highlight = { enable = true },

	-- Enable windwp/nvim-ts-autotag for close/update tags
	autotag = { enable = true },

	-- Enable autopairs
	autopairs = { enable = true },

	-- Enable indent
	indent = { enable = true },

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
})
