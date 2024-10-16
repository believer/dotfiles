return {
	-- Actions that work on surrounding context
	{ "tpope/vim-surround", event = "VeryLazy" },
	-- Git
	{ "tpope/vim-fugitive", event = "VeryLazy" },

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- GitHub Copilot
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup({
	-- 				panel = {
	-- 					auto_refresh = false,
	-- 					keymap = {
	-- 						accept = "<CR>",
	-- 						jump_prev = "[[",
	-- 						jump_next = "]]",
	-- 						refresh = "gr",
	-- 						open = "<M-CR>",
	-- 					},
	-- 				},
	-- 				suggestion = {
	-- 					auto_trigger = true,
	-- 					keymap = {
	-- 						accept = "<C-j>",
	-- 						prev = "<M-[>",
	-- 						next = "<M-]>",
	-- 						dismiss = "<C-]>",
	-- 					},
	-- 				},
	-- 			})
	-- 		end, 100)
	-- 	end,
	-- },

	-- Emmet
	{ "mattn/emmet-vim", event = "VeryLazy" },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
	},
}
