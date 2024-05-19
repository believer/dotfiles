return {
	{
		"williamboman/mason.nvim", -- Installer of LSPs and more
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim", -- LSP configuration for Mason
		},
		opts = {
			ensure_installed = {
				"cssls",
				"eslint_d",
				"prettierd",
				"rescriptls",
				"rust_analyzer",
				"sumneko_lua",
				"tailwindcss",
				"volar",
			},
		},
	},

	{ "folke/neodev.nvim", opts = {} },

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("neodev").setup()
			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local wk = require("which-key")

			-- Map the keys after the language server is attached to the buffer.
			local on_attach = function(client, bufnr)
				if client.server_capabilities.codeLensProvider then
					local group = vim.api.nvim_create_augroup("LSP/CodeLens", { clear = true })
					vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold" }, {
						group = group,
						callback = vim.lsp.codelens.refresh,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufEnter", {
						group = group,
						callback = vim.lsp.codelens.refresh,
						buffer = bufnr,
						once = true,
					})
				end

				wk.register({
					g = {
						D = { vim.lsp.buf.declaration, "Go to declaration", buffer = bufnr },
						d = { vim.lsp.buf.definition, "Go to definition", buffer = bufnr },
						R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
						V = { "<cmd>vert winc ]<CR>", "Go to definition (vertical)" },
					},
					["<leader>rn"] = { vim.lsp.buf.rename, "Rename", buffer = bufnr },
					["<leader>ca"] = { vim.lsp.buf.code_action, "Code action", buffer = bufnr },
				})
			end

			-- Display a border around the hover window for better readability.
			local _border = "single"

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})

			vim.diagnostic.config({
				float = { border = _border },
			})

			-- Setup the LSPs.
			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end

			lspconfig.tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							enable = true,
							globals = { "vim" },
						},
						format = {
							enable = true,
						},
					},
				},
			})

			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "rust" },
				root_dir = util.root_pattern("Cargo.toml"),
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = {
							command = "clippy",
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})

			lspconfig.rescriptls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				init_options = {
					extensionConfiguration = {
						askToStartBuild = false,
						inlayHints = {
							enable = true,
						},
						codeLens = true,
					},
				},
			})

			lspconfig.biome.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				filetypes = {
					"astro",
					"astro-markdown",
					"gohtml",
					"gohtmltmpl",
					"handlebars",
					"hbs",
					"html",
					"html-eex",
					"markdown",
					"mdx",
					"css",
					"javascript",
					"javascriptreact",
					"rescript",
					"typescript",
					"typescriptreact",

					-- Custom
					"templ",
				},
				init_options = {
					userLanguages = {
						templ = "html",
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								-- Support cva
								{
									"cva\\(([^)]*)\\)",
									"[\"'`]([^\"'`]*).*?[\"'`]",
								},
								-- Support tailwind-variants
								{
									"tv\\(([^)]*)\\)",
									"[\"'`]([^\"'`]*).*?[\"'`]",
								},
								-- Support ts-pattern
								{
									"with\\((.*)\\)",
									"[\"'`]([^\"'`]*).*?[\"'`]",
								},
							},
						},
					},
				},
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "css", "scss" },
			})

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.templ.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.htmx.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"html",
					"templ",
				},
			})
		end,
	},
}
