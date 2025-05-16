---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
}
