---@type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/Mastersam07/maestro-workbench/refs/heads/dev/schema/schema.v0.json"] = "/apps/blackbird/.maestro/**/*.yaml",
			},
		},
	},
}
