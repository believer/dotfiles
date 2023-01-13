local api = vim.api
local M = {}

function M.map(mode, from, to, opts)
	local options = { noremap = true, silent = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, from, to, options)
end

function M.add_autocommands(definitions)
	for group_name, definition in pairs(definitions) do
		local triggers = definition.triggers
		local callback = definition.callback
		local pattern = definition.pattern or "*"
		local group_opts = definition.group_opts or {}

		api.nvim_create_autocmd(triggers, {
			group = vim.api.nvim_create_augroup(group_name, group_opts),
			pattern = pattern,
			callback = callback,
		})
	end
end

return M
