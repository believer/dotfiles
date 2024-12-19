return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					mode = "virtualtext",
					css = true,
					tailwind = true,
				},
			})
		end,
	},
}
