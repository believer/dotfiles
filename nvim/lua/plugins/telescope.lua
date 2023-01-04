local map = require("utils").map
local telescope = require("telescope.builtin")

map("n", "<leader>;", telescope.find_files)
map("n", "??", telescope.live_grep)
map("n", "<leader>o", telescope.buffers)
map("n", "<leader>fh", telescope.help_tags)
map("n", "<leader>sd", telescope.lsp_document_symbols)
map("n", "<leader>sw", telescope.lsp_dynamic_workspace_symbols)

-- Workaround for treesitter folds when using Packer
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
})
