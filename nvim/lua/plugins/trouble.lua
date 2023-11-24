-- Pretty list of diagnostics
return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	config = function()
		require("trouble").setup({
			auto_close = true,
			signs = {
				error = "⊗",
				warning = "⚠",
				hint = "💡",
				information = "ⓘ",
				other = "ⓘ",
			},
		})
	end,
}
