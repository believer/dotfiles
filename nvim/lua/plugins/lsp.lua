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
				callback = function()
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

			vim.o.winborder = "rounded"
			vim.diagnostic.config({
				virtual_text = { current_line = true },
				float = { border = "single" },
			})

			require("mason").setup()

			local settingsJsTs = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';Add commentMore actions
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = false,
				},
			}

			vim.lsp.config.ts_ls = {
				completion = {
					completeFunctionCalls = true,
				},
				init_options = {
					preferences = {
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
						importModuleSpecifierPreference = "non-relative",
						importModuleSpecifierEnding = "minimal",
					},
				},
				settings = {
					javascript = settingsJsTs,
					typescript = settingsJsTs,
				},
			}

			vim.lsp.config.tailwindcss = {
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
						includeLanguages = {
							templ = "html",
						},
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						experimental = {
							-- Support tailwind-variants
							classRegex = {
								{ "tv\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
						validate = true,
					},
				},
			}

			vim.lsp.enable({
				"biome",
				"cssls",
				"gopls",
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
