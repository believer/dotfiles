local api = vim.api
local M = {}

function M.map(lhs, rhs, mode, opts)
	local options = { noremap = true, silent = true }
	mode = mode or "n"

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, lhs, rhs, options)
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

function M.mergeTables(t1, t2)
	local merged = {}
	for k, v in pairs(t1) do
		merged[k] = v
	end
	for k, v in pairs(t2) do
		merged[k] = v
	end
	return merged
end

function M.add_word_to_lang(lang)
	local word = vim.fn.expand("<cword>")
	if word == "" then
		print("No word under cursor.")
		return
	end

	local original_lang = vim.opt.spelllang:get()
	local original_spellfile = vim.opt.spellfile
	local spellfile_path = vim.fn.expand(string.format("~/.dotfiles/nvim/spell/%s.utf-8.add", lang))

	vim.opt.spelllang = { lang }
	vim.opt.spellfile = spellfile_path

	vim.cmd("silent! spellgood " .. word)
	vim.cmd("silent! mkspell! " .. spellfile_path)

	-- Restore original settings
	vim.opt.spelllang = original_lang
	vim.opt.spellfile = original_spellfile

	print("Added '" .. word .. "' to " .. lang)
end

return M
