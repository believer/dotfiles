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

	{ "folke/lazydev.nvim", ft = "lua", opts = {} },

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local wk = require("which-key")
			local u = require("utils")

			-- Map the keys after the language server is attached to the buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args, bufnr)
					wk.add({
						{ "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "References" },
						{ "gV", "<cmd>vert winc ]<CR>", desc = "Go to definition (vertical)" },
						{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration", buffer = bufnr },
						{ "gd", vim.lsp.buf.definition, desc = "Go to definition", buffer = bufnr },
						{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename", buffer = bufnr },
						{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", buffer = bufnr },
					})
				end,
			})

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
			local function TSOrganizeImports()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports.ts" },
						diagnostics = {},
					},
				})
			end

			local TSRemoveUnused = function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.removeUnused.ts" },
						diagnostics = {},
					},
				})
			end

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				cmd = { "bunx", "typescript-language-server", "--stdio" },
				commands = {
					TSOrganizeImports = {
						TSOrganizeImports,
						description = "Organize Imports",
					},
					TSRemoveUnused = {
						TSRemoveUnused,
						description = "Remove unused",
					},
				},
				completions = {
					completeFunctionCalls = true,
				},
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},

					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							enable = true,
							globals = { "vim" },
						},
						format = { enable = true },
						hint = { enable = true },
					},
				},
			})

			lspconfig.rust_analyzer.setup({
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
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				cmd = { "bunx", "tailwindcss-language-server", "--stdio" },
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
				capabilities = capabilities,
				filetypes = { "css", "scss" },
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.templ.setup({
				capabilities = capabilities,
			})

			lspconfig.htmx.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"templ",
				},
			})

			lspconfig.sourcekit.setup({
				capabilities = u.mergeTables(capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
			})
		end,
	},
}
