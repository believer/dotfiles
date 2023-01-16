return {
	-- Easier comments (gc / gcc)
	{ "tpope/vim-commentary", event = "VeryLazy" },
	-- Actions that work on surrounding context
	{ "tpope/vim-surround", event = "VeryLazy" },

	"tpope/vim-fugitive", -- Git

	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					-- Tell GitHub Copilot to use Node 16
					copilot_node_command = vim.fn.expand("$HOME")
						.. "/Library/Caches/fnm_multishells/50473_1673852317829/bin/node",
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

	-- Additional tools when working with TypeScript (add/organize imports)
	{ "jose-elias-alvarez/typescript.nvim", ft = "typescript" },
}
