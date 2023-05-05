return {
	{
		"NvChad/nvim-colorizer.lua",
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
		config = function()
			require("tailwindcss-colorizer-cmp").setup()
		end,
	},
}
