local map = require("utils").map
local o = vim.opt

-- Folds
-- o.foldcolumn = "1" -- '0' is not bad
-- o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- o.foldlevelstart = 99
-- o.foldenable = true
-- o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Keep cursor position when collapsing lines
map("J", "mzJ`z")

-- Remove arrow keys
map("<Up>", "<Nop>")
map("<Down>", "<Nop>")
map("<Left>", "<Nop>")
map("<Right>", "<Nop>")

-- Remap things I usually mistype
map("q:", "<Nop>")
map(":W", vim.cmd.w)

-- Close all buffers except the current one
vim.cmd([[command BufOnly silent! execute "%bd|e#|bd#"]])

-- Remove '-' from iskeyword so words-separated-by-dashes are treated as separate words
-- This is filetype dependent, so needs to be run everytime
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*", -- For all types, otherwise use pattern like below
	callback = function()
		vim.opt_local.iskeyword:remove("-")
	end,
})

-- Macros
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- Mark something and hit @l to create a print statement below it
vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "JSLogMacro",
	pattern = { "javascript", "typescript", "typescriptreact" },
	callback = function()
		vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:'," .. esc .. "a" .. esc .. "pa)" .. esc .. "")
	end,
})

-- Spell check English and Swedish
o.spelllang = { "en", "sv" }
