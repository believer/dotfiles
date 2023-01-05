local null_ls = require("null-ls")
local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	-- Format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,

	sources = {
		b.code_actions.eslint_d,
		b.completion.spell,
		b.diagnostics.eslint_d,
		b.formatting.prettierd,
		b.formatting.eslint_d,
		b.formatting.stylua,
		b.formatting.rescript,
		b.formatting.rustfmt,
		require("typescript.extensions.null-ls.code-actions"),
	},
})
