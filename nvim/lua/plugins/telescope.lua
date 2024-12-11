return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		event = "VeryLazy",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim", -- Display vim.ui.select in telescope
			"jvgrootveld/telescope-zoxide",
		},
		config = function()
			local actions = require("telescope.actions")

			-- Extensions
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope._extensions.zoxide.utils")

			-- Setup
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
					},
					git_branches = {
						mappings = {
							i = { ["<cr>"] = actions.git_switch_branch },
						},
					},
				},
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = { "node_modules" },
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					-- Developer configurations: Not meant for general override
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
					mappings = {
						i = {
							-- Close telescope with <Esc> instead of switching to normal mode
							["<esc>"] = actions.close,
						},
					},
				},
			})
		end,
	},
}
