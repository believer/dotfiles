-- File tree
local map = require("utils").map

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		-- Add devicons
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					--auto close
					require("neo-tree").close_all()
				end,
			},
		},
		window = {
			position = "right",
			mappings = {
				["s"] = "open_vsplit",
				["<C-v>"] = "open_vsplit",
			},
		},
		filesystem = {
			components = {
				harpoon_index = function(config, node)
					local Marked = require("harpoon.mark")
					local path = node:get_id()
					local succuss, index = pcall(Marked.get_index_of, path)
					if succuss and index and index > 0 then
						return {
							text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					else
						return {}
					end
				end,
			},
			renderers = {
				file = {
					{ "icon" },
					{ "name", use_git_status_colors = true },
					{ "harpoon_index" }, --> This is what actually adds the component in where you want it
					{ "diagnostics" },
					{ "git_status", highlight = "NeoTreeDimText" },
				},
			},
		},
	},
	init = function()
		map("n", "<leader>d", vim.cmd.NeoTreeFocusToggle)
		map("n", "<leader>f", vim.cmd.NeoTreeReveal)
	end,
}
