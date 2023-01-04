local M = {}

function M.map(mode, from, to, opts)
	local options = { noremap = true, silent = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, from, to, options)
end

return M
