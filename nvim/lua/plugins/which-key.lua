return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		-- Shorten timeout to wait for mappings to complete
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local harpoon_mark = require("harpoon.mark")
		local harpoon_ui = require("harpoon.ui")
		local telescope_builtin = require("telescope.builtin")
		local ufo = require("ufo")

		wk.setup()
		wk.register({
			["-"] = { vim.cmd.Oil, "Open oil.nvim" },
			["<leader>"] = {
				a = {
					name = "actions",
					b = { '"_', "Black hole register" },
					c = { "<cmd>ColorizerToggle<CR>", "Toggle colorizer" },
					d = { 'diwxda"<CR>', "Delete HTML attribute" },
					e = { "<cmd>EslintFixAll<CR>", "Fix all ESLint errors" },
					i = {
						function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end,
						"Toggle inlay hints",
					},
					K = { vim.lsp.buf.hover, "Show hover" },
					r = { vim.cmd.TSRemoveUnused, "Remove unused imports" },
					t = { vim.cmd.TSOrganizeImports, "Organize imports" },
				},

				-- Diagnostics
				e = {
					name = "trouble",
					e = { "<cmd>TroubleToggle<cr>", "Open Trouble list" },
					w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
					d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
					q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
					l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
				},

				-- Git
				g = {
					name = "git",
					b = { telescope_builtin.git_branches, "Git branches" },
					c = {
						name = "Commit history",
						b = { telescope_builtin.git_bcommits, "Buffer commits" },
						c = { telescope_builtin.git_commits, "Git commits" },
						s = { telescope_builtin.git_stash, "Git stash" },
					},
					-- Signs
					h = {
						name = "Git signs",
						p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
						r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
						s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
						-- Toggle highlights
						t = {
							name = "Toggle highlights",
							b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blame on line" },
							l = { "<cmd>Gitsigns toggle_linehl<CR>", "Toggle line highlights" },
							n = { "<cmd>Gitsigns toggle_numhl<CR>", "Toggle number highlights" },
							s = { "<cmd>Gitsigns toggle_signs<CR>", "Toggle signs" },
							w = { "<cmd>Gitsigns toggle_word_diff<CR>", "Toggle word diff highlights" },
						},
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

				s = { vim.cmd.update, "Save" },

				-- Telescope
				[";"] = { telescope_builtin.find_files, "Find files" },
				["'"] = { telescope_builtin.git_status, "Changed files" },
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
					z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
				},

				y = { '"+y', "Copy to system clipboard", mode = "v" },
			},

			["z"] = {
				K = {
					function()
						local winid = require("ufo").peekFoldedLinesUnderCursor()

						if not winid then
							vim.lsp.buf.hover()
						end
					end,
					"Peek fold",
				},
				M = { ufo.closeAllFolds, "Close all folds" },
				R = { ufo.openAllFolds, "Open all folds" },
			},
		})
	end,
}
