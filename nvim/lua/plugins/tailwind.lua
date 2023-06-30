return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					css = true,
					tailwind = true,
					sass = {
						enable = true,
						parsers = {
							"css",
						},
					},
				},
			})
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		event = "BufReadPre",
		config = function()
			require("tailwindcss-colorizer-cmp").setup()
		end,
	},
}
