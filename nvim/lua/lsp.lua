require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"volar",
		"tailwindcss",
		"cssls",
		"rescriptls",
	},
})

local map = require("utils").map

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- Map the keys after the language server is attached to the buffer.
local on_attach = function(_, bufnr)
	local bufopts = { buffer = bufnr }

	map("n", "gD", vim.lsp.buf.declaration, bufopts)
	map("n", "gd", vim.lsp.buf.definition, bufopts)
	map("n", "K", vim.lsp.buf.hover, bufopts)
	map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
end

lspconfig.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	-- Use Volar for all JavaScript and TypeScript code as it also handles Vue correctly
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = { "vim" },
			},
		},
	},
})

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.rescriptls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("typescript").setup({
	server = {
		on_attach = on_attach,
	},
})
