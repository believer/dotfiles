return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")

		-- Shorten timeout to wait for mappings to complete
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local harpoon_mark = require("harpoon.mark")
		local harpoon_ui = require("harpoon.ui")
		local telescope_builtin = require("telescope.builtin")

		wk.setup()
		wk.register({
			["<leader>"] = {
				a = {
					name = "actions",
					b = { '"_', "Black hole register" },
					d = { 'diwxda"<CR>', "Delete HTML attribute" },
					e = { "<cmd>EslintFixAll<CR>", "Fix all ESLint errors" },
					t = { vim.cmd.OrganizeImports, "Organize imports" },
				},

				-- Diagnostics
				e = {
					name = "diagnostics",
					d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show error in float window" },
					l = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Display diagnostics to location list" },
					n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
					p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
				},

				-- Tree view
				d = { vim.cmd.NeoTreeFocusToggle, "Toggle the tree view" },
				f = { vim.cmd.NeoTreeReveal, "Reveal the current file in the tree view" },

				-- Git
				g = {
					name = "git",
					b = { telescope_builtin.git_branches, "Git branches" },
					c = {
						b = { telescope_builtin.git_bcommits, "Buffer commits" },
						c = { telescope_builtin.git_commits, "Git commits" },
					},
					p = { "<cmd>Git push<CR>", "git push" },
					s = { "<cmd>Git<CR>", "git status" },
					u = { "<cmd>!git up<CR>", "git up" },
					z = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blame on line" },
				},

				-- Harpoon
				h = {
					name = "harpoon",
					a = { harpoon_mark.add_file, "Add file to harpoon" },
					c = { harpoon_mark.clear_all, "Clear all files from harpoon" },
					l = { harpoon_ui.toggle_quick_menu, "Toggle quick menu" },
					n = { harpoon_ui.nav_next, "Next file" },
					p = { harpoon_ui.nav_prev, "Previous file" },
					r = { harpoon_mark.rm_file, "Remove file from harpoon" },
					["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Navigate to file 1" },
					["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Navigate to file 2" },
					["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Navigate to file 3" },
					["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Navigate to file 4" },
				},

				l = { "<cmd>Lazy<CR>", "Update plugins" },

				s = { vim.cmd.update, "Save" },

				-- Telescope
				[";"] = { telescope_builtin.find_files, "Find files" },
				["?"] = { telescope_builtin.live_grep, "Grep in all files" },
				t = {
					name = "telescope",
					b = { telescope_builtin.buffers, "Open buffers" },
					d = { telescope_builtin.lsp_document_symbols, "Symbols in document" },
					h = { telescope_builtin.help_tags, "Telescope help tags" },
					m = { telescope_builtin.marks, "Telescope marks" },
					o = { telescope_builtin.oldfiles, "Recently opened files" },
					s = { telescope_builtin.spell_suggest, "Suggest spelling" },
					t = { "<cmd>TodoTelescope<CR>", "Todo list" },
					w = { telescope_builtin.lsp_dynamic_workspace_symbols, "Symbols in workspace" },
				},

				y = { '"+y', "Copy to system clipboard", mode = "v" },

				x = {
					name = "trouble",
					x = { "<cmd>TroubleToggle<cr>", "Open Trouble list" },
					w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
					d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document Diagnostics" },
					q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
					l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
				},
			},
		})
	end,
}
