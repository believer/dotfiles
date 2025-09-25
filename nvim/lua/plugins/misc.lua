return {
	-- Actions that work on surrounding context
	{ "tpope/vim-surround", event = "VeryLazy" },
	-- Git
	{ "tpope/vim-fugitive", event = "VeryLazy" },

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local map = vim.keymap.set
			local ls = require("luasnip")

			ls.setup({
				enable_autosnippets = true,
			})

			require("luasnip.loaders.from_lua").load({
				paths = "~/.dotfiles/nvim/lua/snippets",
			})

			map("i", "<C-e>", function()
				ls.expand_or_jump(1)
			end, { silent = true })
			map({ "i", "s" }, "<C-J>", function()
				ls.jump(1)
			end, { silent = true })
			map({ "i", "s" }, "<C-K>", function()
				ls.jump(-1)
			end, { silent = true })
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},
}
