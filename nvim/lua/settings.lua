local map = require("utils").map
local g = vim.g
local o = vim.opt

-- Leader
g.mapleader = " "
g.maplocalleader = " "

-- set termguicolors to enable highlight groups
o.termguicolors = true

-- Always display the sign column (where errors are displayed)
o.signcolumn = "yes"
vim.cmd("highlight clear SignColumn") -- Remove highlighting of sign column

-- Split new buffers to the right
o.splitright = true

-- Folds
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Make : commands ignore casing
o.ignorecase = true
o.smartcase = true

-- Search
o.hlsearch = true
o.incsearch = true

-- Display line numbers and use relative numbering
o.number = true
o.relativenumber = true

o.linebreak = true -- wrap long lines with full words

-- Tabs
o.tabstop = 2 -- 1 tab = 2 spaces
o.shiftwidth = 2 -- indentation
o.autoindent = true
o.expandtab = true -- expand tabs to spaces
o.smartindent = true

-- Hide partial commands in status bar
o.showcmd = false

-- Simplify moving between panes
map("<C-J>", "<C-W><C-J>")
map("<C-K>", "<C-W><C-K>")
map("<C-L>", "<C-W><C-L>")
map("<C-H>", "<C-W><C-H>")

-- Persist undos after buffers are unloaded
o.undofile = true

-- Keep cursor position when collapsing lines
map("J", "mzJ`z")

-- Center cursor when scrolling up and down
map("<C-d>", "<C-d>zz")
map("<C-u>", "<C-u>zz")

-- Center search results
map("n", "nzzzv")
map("N", "Nzzzv")

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
o.spell = true
o.spelllang = { "en", "sv" }
