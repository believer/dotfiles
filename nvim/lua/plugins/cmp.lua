return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "VeryLazy",
		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority
						score_offset = 100,
					},
				},
			},

			completion = {
				documentation = {
					auto_show = true,
				},
				ghost_text = {
					enabled = false,
				},
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},

				accept = {
					auto_brackets = {
						semantic_token_resolution = {
							blocked_filetypes = { "typescriptreact" },
						},
					},
				},
			},

			keymap = {
				preset = "default",
				["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
				["S-<Tab>"] = { "snippet_backward", "select_prev", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}
