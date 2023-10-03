return {
	-- Easier comments (gc / gcc)
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
	-- Actions that work on surrounding context
	{ "tpope/vim-surround", event = "VeryLazy" },
	-- Git
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	-- Pretty list of diagnostics
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			require("trouble").setup()
		end,
	},

	{
		"folke/zen-mode.nvim",
	},

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
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					panel = {
						auto_refresh = false,
						keymap = {
							accept = "<CR>",
							jump_prev = "[[",
							jump_next = "]]",
							refresh = "gr",
							open = "<M-CR>",
						},
					},
					suggestion = {
						auto_trigger = true,
						keymap = {
							accept = "<C-j>",
							prev = "<M-[>",
							next = "<M-]>",
							dismiss = "<C-]>",
						},
					},
				})
			end, 100)
		end,
	},

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
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
}
