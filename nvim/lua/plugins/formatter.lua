return {
	{
		"laytan/tailwind-sorter.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		config = function()
			require("tailwind-sorter").setup({
				on_save_enabled = true,
			})
		end,
	},
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
					sql = {
						require("formatter.filetypes.sql").pgformat,
					},
					ocaml = {
						function()
							local util = require("formatter.util")

							return {
								exe = "ocamlformat",
								args = {
									"--enable-outside-detected-project",
									util.escape_path(util.get_current_buffer_file_path()),
								},
								stdin = true,
							}
						end,
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
		end,
	},
}
