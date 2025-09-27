return {
	-- Actions that work on surrounding context
	{ "tpope/vim-surround", event = "VeryLazy" },
	-- Git
	{ "tpope/vim-fugitive", event = "VeryLazy" },

	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			-- Use this when pum supports winborder?
			-- https://github.com/neovim/neovim/pull/25541
			--
			-- require("mini.completion").setup({
			-- 	window = {
			-- 		info = { height = 25, width = 80, border = "rounded" },
			-- 		signature = { height = 25, width = 80, border = "rounded" },
			-- 	},
			-- })
			--
			-- -- Navigate with tab/s-tab
			-- local imap_expr = function(lhs, rhs)
			-- 	vim.keymap.set("i", lhs, rhs, { expr = true })
			-- end
			--
			-- -- Add <CR> for selection
			-- _G.cr_action = function()
			-- 	-- If there is selected item in popup, accept it with <C-y>
			-- 	if vim.fn.complete_info()["selected"] ~= -1 then
			-- 		return "\25"
			-- 	end
			-- 	-- Fall back to plain `<CR>`. You might want to customize according
			-- 	-- to other plugins. For example if 'mini.pairs' is set up, replace
			-- 	-- next line with `return MiniPairs.cr()`
			-- 	return "\r"
			-- end
			--
			-- vim.keymap.set("i", "<CR>", "v:lua.cr_action()", { expr = true })
			-- imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
			-- imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

			require("mini.extra").setup()
			require("mini.pairs").setup()
			require("mini.pick").setup()
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
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},
}
