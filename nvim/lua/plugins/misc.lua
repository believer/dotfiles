return {
	{ "tpope/vim-surround", event = "BufRead" }, -- Actions that work on surrounding context
	{ "tpope/vim-fugitive", event = "VeryLazy" }, -- Git

	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.extra").setup()
			require("mini.pairs").setup()
			require("mini.pick").setup()

			local starter = require("mini.starter")

			starter.setup({
				evaluate_single = true,
				footer = "", -- Show nothing after, nil displays help
				items = {
					starter.sections.pick(),
					starter.sections.recent_files(10, true, false),
				},
				content_hooks = {
					starter.gen_hook.aligning("center", "center"),
					starter.gen_hook.indexing("all"),
				},
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		event = "BufRead",
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
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
}
