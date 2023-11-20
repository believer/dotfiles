return {
	{
		"mhartington/formatter.nvim",
		config = function()
			vim.api.nvim_create_autocmd("BufWritePost", { command = "FormatWriteLock" })

			local formatter_settings = {
				filetype = {
					go = {
						require("formatter.filetypes.go").gofmt,
					},
					html = {
						require("formatter.filetypes.html").prettierd,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					css = {
						require("formatter.filetypes.css").prettierd,
					},
					json = {
						require("formatter.filetypes.json").prettierd,
					},
					markdown = {
						require("formatter.filetypes.markdown").prettierd,
					},
					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},
					sql = {
						require("formatter.filetypes.sql").pgformat,
					},
				},
			}

			-- Add same settings for all javascript filetypes
			local js_types = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

			for _, type in ipairs(js_types) do
				formatter_settings.filetype[type] = {
					require("formatter.filetypes.typescript").prettierd,
					require("formatter.filetypes.typescript").eslint_d,
				}
			end

			require("formatter").setup(formatter_settings)

			vim.api.nvim_create_autocmd({
				-- 'BufWritePre' event triggers just before a buffer is written to file.
				"BufWritePre",
			}, {
				pattern = { "*.templ" },
				callback = function()
					-- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
					vim.lsp.buf.format()
				end,
			})
		end,
	},
}
