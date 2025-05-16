return {
	{
		"mason-org/mason.nvim", -- Installer of LSPs and more
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = {
			"mason-org/mason-lspconfig.nvim", -- LSP configuration for Mason
		},
		config = function()
			-- Add capabilities to all filetypes
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Map the keys after the language server is attached to the buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function()
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
			require("mason-lspconfig").setup()
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
