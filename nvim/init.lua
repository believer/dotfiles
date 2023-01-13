require("settings")
require("plugins")
require("lsp")
require("snippets")

local U = require("utils")

-- Color scheme
vim.cmd("colorscheme tokyonight-night")

-- Git
U.map("n", "<leader>gp", ":Git push<cr>")
U.map("n", "<leader>up", ":!git up<cr>")
U.map("n", ":gss", vim.cmd.Git)
U.map("n", ":Gss", vim.cmd.Git)

-- Highlight on yank
-- Taken from kickstart.nvim
local autocommands = {
	highlight_yank = {
		group_opts = { clear = true },
		triggers = { "TextYankPost" },
		callback = function()
			vim.highlight.on_yank()
		end,
	},
}

U.add_autocommands(autocommands)
