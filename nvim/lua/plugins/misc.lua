return {
	-- Easier comments (gc / gcc)
	{ "tpope/vim-commentary", event = "VeryLazy" },
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

	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			local machine = os.getenv("MACHINE")

			-- Set correct Node 16 version from fnm
			local copilot_node_command = vim.fn.expand("$HOME")
				.. "/Library/Caches/fnm_multishells/50473_1673852317829/bin/node"

			if machine == "home" then
				copilot_node_command = vim.fn.expand("$HOME")
					.. "/Library/Caches/fnm_multishells/45675_1674151559563/bin/node"
			end

			vim.defer_fn(function()
				require("copilot").setup({
					-- Tell GitHub Copilot to use Node 16
					copilot_node_command = copilot_node_command,
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
}
