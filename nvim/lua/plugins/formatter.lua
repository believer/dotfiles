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
					css = { "biome-check" },
					-- Enable formatting of embedded languages using injected
					-- For example, sql from queries/go/injections.scm
					go = { "gofmt", "injected" },
					json = { "biome-check" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					ruby = { "rubyfmt" },
					rust = { "rustfmt" },
					sql = { "pg_format" },
					yaml = { "yamlfmt" },
				},
			}

			local js_types = require("filetypes").js

			for _, type in ipairs(js_types) do
				formatter_settings.formatters_by_ft[type] = { "biome-check" }
			end

			require("conform").setup(formatter_settings)
		end,
	},
}
