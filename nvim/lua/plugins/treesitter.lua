local add_autocommands = require("utils").add_autocommands

require("nvim-treesitter.configs").setup({
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

local autocommands = {
	-- Workaround for folds combined with Packer
	add_folds = {
		triggers = { "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" },
		callback = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},

	-- Open all folds when opening file
	open_all_folds = {
		triggers = { "BufReadPost", "FileReadPost" },
		callback = function()
			vim.cmd("normal zR")
		end,
	},
}

add_autocommands(autocommands)
