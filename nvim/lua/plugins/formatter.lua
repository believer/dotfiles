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
					css = { "prettier" },
					go = { "gofmt" },
					json = { "prettier" },
					markdown = { "prettier" },
					rust = { "rustfmt" },
					lua = { "stylua" },
					sql = { "pg_format" },
				},
			}

			-- Add same options for all JS/TS types
			local js_types = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

			for _, type in ipairs(js_types) do
				formatter_settings.formatters_by_ft[type] = {
					"biome-check",
				}
			end

			require("conform").setup(formatter_settings)
		end,
	},
}
