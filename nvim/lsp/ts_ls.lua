local settingsJsTs = {
	inlayHints = {
		includeInlayEnumMemberValueHints = true,
		includeInlayFunctionLikeReturnTypeHints = true,
		includeInlayFunctionParameterTypeHints = true,
		includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
		includeInlayParameterNameHintsWhenArgumentMatchesName = true,
		includeInlayPropertyDeclarationTypeHints = true,
		includeInlayVariableTypeHints = false,
	},
}

---@type vim.lsp.Config
return {
	cmd = { "bunx", "typescript-language-server", "--stdio" },
	filetypes = require("filetypes").js,
	completion = {
		completeFunctionCalls = true,
	},
	init_options = {
		preferences = {
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "minimal",
		},
	},
	settings = {
		javascript = settingsJsTs,
		typescript = settingsJsTs,
	},
}
