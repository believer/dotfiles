return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo" },
		config = function()
			local formatter_settings = {
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					css = { "prettierd" },
					go = { "gofmt" },
					json = { "prettierd" },
					markdown = { "prettierd" },
					rust = { "rustfmt" },
					lua = { "stylua" },
					sql = { "pg_format" },
					yaml = { "yamlfmt" },
				},
			}

			require("conform").setup(formatter_settings)
		end,
	},
}
