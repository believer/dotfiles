return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
				},
				ghost_text = {
					enabled = true,
				},
			},

			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}
