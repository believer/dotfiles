require("luasnip").setup({
	enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").load({ paths = "~/.dotfiles/nvim/lua/snippets" })
