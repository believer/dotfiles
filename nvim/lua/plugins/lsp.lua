return {
	{
		"mason-org/mason.nvim", -- Installer of LSPs and more
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = {
			"mason-org/mason-lspconfig.nvim", -- LSP configuration for Mason
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Add capabilities to all filetypes
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if not client then
						return
					end

					-- Add Biome fix code action on save
					if client.name == "biome" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
							callback = function()
								vim.lsp.buf.code_action({
									context = {
										only = { "source.fixAll.biome" },
										diagnostics = {},
									},
									apply = true,
								})
							end,
						})
					end

					-- Map the keys after the language server is attached to the buffer.
					require("which-key").add({
						{ "gR", "<cmd>Trouble lsp_references<cr>", desc = "References" },
						{ "gV", "<cmd>vert winc ]<CR>", desc = "Go to definition (vertical)" },
						{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
						{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
						{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
						{ "<leader>rr", require("telescope.builtin").lsp_references, desc = "LSP references" },
					})
				end,
			})

			vim.diagnostic.config({
				virtual_text = { current_line = true },
				float = { border = "single" },
			})

			require("mason").setup()

			vim.lsp.enable({
				"biome",
				"cssls",
				"gopls",
				"htmx",
				"jsonls",
				"kotlin_language_server",
				"lua_ls",
				"prettierd",
				"stylua",
				"tailwindcss",
				"templ",
				"ts_ls",
				"yamlls",
				"yamlfmt",
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = function()
			require("lazydev").setup()
		end,
	},
}
