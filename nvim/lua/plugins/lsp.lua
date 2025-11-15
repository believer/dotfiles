return {
	{
		"mason-org/mason.nvim", -- Installer of LSPs and more
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Add capabilities to all filetypes
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

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

			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			vim.lsp.config.yamlls = {
				settings = {
					yaml = {
						format = {
							enable = true,
						},
						schemas = {
							["https://raw.githubusercontent.com/nexlabstudio/maestro-workbench/refs/heads/dev/schema/schema.v0.json"] = "/apps/blackbird/.maestro/**/*",
							["https://www.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
			}

			vim.lsp.enable({
				"biome",
				"cssls",
				"gopls",
				"jsonls",
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
}
