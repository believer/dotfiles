local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Setup the LSPs.
local function TSOrganizeImports()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.organizeImports.ts" },
			diagnostics = {},
		},
	})
end

local TSRemoveUnused = function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.removeUnused.ts" },
			diagnostics = {},
		},
	})
end

local TSAddImports = function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.addMissingImports.ts" },
			diagnostics = {},
		},
	})
end

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

return {
	capabilities = capabilities,
	cmd = { "bunx", "typescript-language-server", "--stdio" },
	commands = {
		TSOrganizeImports = {
			TSOrganizeImports,
			description = "Organize Imports",
		},
		TSRemoveUnused = {
			TSRemoveUnused,
			description = "Remove unused",
		},
		TSAddImports = {
			TSAddImports,
			description = "Add imports",
		},
	},
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
