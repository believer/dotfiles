vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		dependencies = {
			{
				"nkrkv/nvim-treesitter-rescript", -- Support for ReScript
				ft = "rescript",
			},
			"windwp/nvim-ts-autotag", -- Automatically close/update HTML tags
			"vrischmann/tree-sitter-templ", -- Support for templ
		},
		config = function()
			local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()

			require("nvim-treesitter.configs").setup({
				autopairs = { enable = true },
				indent = { enable = true },
				highlight = {
					additional_vim_regex_highlighting = false,
					enable = true,
				},

				-- Enable windwp/nvim-ts-autotag for close/update tags
				autotag = { enable = true },

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
					"go",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"rust",
					"scss",
					"typescript",
					"vue",
				},
			})

			-- Setup templ
			require("tree-sitter-templ").setup({})

			treesitter_parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}

			vim.treesitter.language.register("templ", "templ")
		end,
	},
}
