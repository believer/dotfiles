return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
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
