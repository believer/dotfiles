return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		oil.setup({
			keymaps = {
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-h>"] = false, -- Original select_split
				["<C-l>"] = false, -- Original refresh
				["<C-r>"] = "actions.refresh",
			},
		})

		oil.set_is_hidden_file(function(name)
			return name:match("^%.") ~= nil or vim.endswith(name, "_templ.go")
		end)
	end,
}
