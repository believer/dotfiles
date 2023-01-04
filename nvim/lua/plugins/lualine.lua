require("lualine").setup({
	options = {
		theme = "tokyonight",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = { "branch" },
		lualine_x = {},
		lualine_y = { "filetype" },
		lualine_z = { "encoding", "location" },
	},
})
