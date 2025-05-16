---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = { "vim", "love" },
			},
			format = { enable = true },
			hint = { enable = true },
		},
	},
}
