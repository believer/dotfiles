require("settings")
require("plugins")
require("lsp")
require("snippets")

local map = require("utils").map

-- Color scheme
vim.cmd("colorscheme tokyonight-night")

-- Git
map("n", "<leader>gp", ":Git push<cr>")
map("n", "<leader>up", ":!git up<cr>")
map("n", ":gss", vim.cmd.Git)

-- Highlight on yank
-- Taken from kickstart.nvim
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
