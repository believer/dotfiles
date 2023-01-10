local map = require("utils").map
local telescope = require("telescope.builtin")
local actions = require("telescope.actions")


map("n", "<leader>;", telescope.find_files)
-- Setup
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- Close telescope with <Esc> instead of switching to normal mode
				["<esc>"] = actions.close,
			},
		},
	},
})

-- Use git_files if in a git repo, otherwise use find_files
local function project_files()
	vim.fn.system("git rev-parse --is-inside-work-tree")

	if vim.v.shell_error == 0 then
		telescope.git_files()
	else
		telescope.find_files()
	end
end

-- Keybindings
map("n", "<leader>;", project_files)
map("n", "??", telescope.live_grep)
map("n", "<leader>o", telescope.buffers)
map("n", "<leader>fh", telescope.help_tags)
map("n", "<leader>sd", telescope.lsp_document_symbols)
map("n", "<leader>sw", telescope.lsp_dynamic_workspace_symbols)

-- Workaround for treesitter folds when using Packer
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
-- 	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
-- 	callback = function()
-- 		vim.opt.foldmethod = "expr"
-- 		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 	end,
-- })
