return {
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
}
