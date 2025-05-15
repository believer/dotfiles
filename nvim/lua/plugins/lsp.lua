return {
	{
		"mason-org/mason.nvim", -- Installer of LSPs and more
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = {
			"mason-org/mason-lspconfig.nvim", -- LSP configuration for Mason
		},
		config = function()
			-- Set up lspconfig.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Map the keys after the language server is attached to the buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args, bufnr)
					require("which-key").add({
						{ "gR", "<cmd>Trouble lsp_references<cr>", desc = "References" },
						{ "gV", "<cmd>vert winc ]<CR>", desc = "Go to definition (vertical)" },
						{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration", buffer = bufnr },
						{ "gd", vim.lsp.buf.definition, desc = "Go to definition", buffer = bufnr },
						{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation", buffer = bufnr },
						{ "<leader>rr", require("telescope.builtin").lsp_references, desc = "LSP references" },
						-- { "<leader>rn", vim.lsp.buf.rename, desc = "Rename", buffer = bufnr },
						-- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", buffer = bufnr },
					})
				end,
			})

			vim.o.winborder = "single"

			vim.diagnostic.config({
				virtual_lines = { current_line = true },
				virtual_text = { current_line = true },
				float = { border = "single" },
			})

			-- 	lspconfig.lua_ls.setup({
			-- 		capabilities = capabilities,
			-- 		settings = {
			-- 			Lua = {
			-- 				diagnostics = {
			-- 					enable = true,
			-- 					globals = { "vim", "love" },
			-- 				},
			-- 				format = { enable = true },
			-- 				hint = { enable = true },
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	lspconfig.rust_analyzer.setup({
			-- 		capabilities = capabilities,
			-- 		filetypes = { "rust" },
			-- 		root_dir = util.root_pattern("Cargo.toml"),
			-- 		settings = {
			-- 			["rust-analyzer"] = {
			-- 				cargo = {
			-- 					allFeatures = true,
			-- 				},
			-- 				checkOnSave = {
			-- 					command = "clippy",
			-- 				},
			-- 				diagnostics = {
			-- 					enable = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	lspconfig.rescriptls.setup({
			-- 		capabilities = capabilities,
			-- 		init_options = {
			-- 			extensionConfiguration = {
			-- 				askToStartBuild = false,
			-- 				inlayHints = {
			-- 					enable = true,
			-- 				},
			-- 				codeLens = true,
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	lspconfig.biome.setup({
			-- 		capabilities = capabilities,
			-- 	})
			--
			-- 	lspconfig.tailwindcss.setup({
			-- 		filetypes = {
			-- 			"astro",
			-- 			"astro-markdown",
			-- 			"gohtml",
			-- 			"gohtmltmpl",
			-- 			"handlebars",
			-- 			"hbs",
			-- 			"html",
			-- 			"html-eex",
			-- 			"markdown",
			-- 			"mdx",
			-- 			"css",
			-- 			"javascript",
			-- 			"javascriptreact",
			-- 			"rescript",
			-- 			"typescript",
			-- 			"typescriptreact",
			--
			-- 			-- Custom
			-- 			"templ",
			-- 		},
			-- 		capabilities = capabilities,
			-- 		settings = {
			-- 			tailwindCSS = {
			-- 				includeLanguages = {
			-- 					templ = "html",
			-- 				},
			-- 				experimental = {
			-- 					-- Support tailwind-variants
			-- 					classRegex = {
			-- 						{ "tv\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	lspconfig.cssls.setup({
			-- 		capabilities = capabilities,
			-- 		filetypes = { "css", "scss" },
			-- 		settings = {
			-- 			css = {
			-- 				validate = true,
			-- 				lint = {
			-- 					unknownAtRules = "ignore",
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	lspconfig.gopls.setup({
			-- 		capabilities = capabilities,
			-- 		settings = {
			-- 			gopls = {
			-- 				hints = {
			-- 					assignVariableTypes = true,
			-- 					compositeLiteralFields = true,
			-- 					compositeLiteralTypes = true,
			-- 					constantValues = true,
			-- 					functionTypeParameters = true,
			-- 					parameterNames = true,
			-- 					rangeVariableTypes = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			--
			-- 	if not configs.golangcilsp then
			-- 		configs.golangcilsp = {
			-- 			default_config = {
			-- 				cmd = { "golangci-lint-langserver" },
			-- 				root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
			-- 				init_options = {
			-- 					command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" },
			-- 				},
			-- 			},
			-- 		}
			-- 	end
			--
			-- 	lspconfig.golangci_lint_ls.setup({
			-- 		filetypes = { "go", "gomod" },
			-- 	})
			--
			-- 	lspconfig.templ.setup({
			-- 		capabilities = capabilities,
			-- 	})
			--
			-- 	-- lspconfig.htmx.setup({
			-- 	-- 	capabilities = capabilities,
			-- 	-- 	filetypes = {
			-- 	-- 		"html",
			-- 	-- 		"templ",
			-- 	-- 	},
			-- 	-- })
			--
			-- 	lspconfig.sourcekit.setup({
			-- 		capabilities = u.mergeTables(capabilities, {
			-- 			workspace = {
			-- 				didChangeWatchedFiles = {
			-- 					dynamicRegistration = true,
			-- 				},
			-- 			},
			-- 		}),
			-- 	})

			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	},

	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
}
