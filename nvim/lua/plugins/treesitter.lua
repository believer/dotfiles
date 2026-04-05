return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		dependencies = {
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
