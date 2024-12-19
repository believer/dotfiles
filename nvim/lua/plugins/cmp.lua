return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
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
