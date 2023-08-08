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

			-- Map the keys after the language server is attached to the buffer.
			local on_attach = function(client, bufnr)
				local wk = require("which-key")

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
						v = { "<cmd>vert winc ]<CR>", "Go to definition (vertical)" },
					},
					["K"] = { vim.lsp.buf.hover, "Hover", buffer = bufnr },
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
					},
				},
			})

			lspconfig.eslint.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass", "style" },
					},
				},
			})

			lspconfig.stylelint_lsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "css", "scss", "vue" },
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "css", "scss" },
			})

			lspconfig.rescriptls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				init_options = {
					extensionConfiguration = {
						askToStartBuild = false,
						codeLens = true,
						inlayHints = {
							enable = true,
						},
					},
				},
			})

			lspconfig.ocamllsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "ocaml" },
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		config = function()
			vim.api.nvim_create_autocmd("BufWritePost", { command = "FormatWriteLock" })

			local formatter_settings = {
				logging = true,
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					css = {
						require("formatter.filetypes.css").prettierd,
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
