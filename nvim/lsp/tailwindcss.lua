---@type vim.lsp.Config
return {
	cmd = { "bunx", "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"gohtml",
		"gohtmltmpl",
		"html",
		"markdown",
		"css",
		"less",
		"sass",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"templ",
	},
	root_markers = { "tailwind.config.js" },
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			includeLanguages = {
				templ = "html",
			},
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			experimental = {
				-- Support tailwind-variants
				classRegex = {
					{ "tv\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
			validate = true,
		},
	},
}
