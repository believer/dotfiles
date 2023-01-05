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

-- Make : commands ignore casing
o.ignorecase = true
o.smartcase = true

-- Search
o.hlsearch = false
o.incsearch = true

-- Display line numbers and use relative numbering
o.number = true
o.relativenumber = true

-- Tabs
o.tabstop = 2 -- 1 tab = 2 spaces
o.shiftwidth = 2 -- indentation
o.autoindent = true
o.expandtab = true -- expand tabs to spaces
o.smartindent = true

-- Simplify moving between panes
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")

-- Persist undos after buffers are unloaded
o.undofile = true

-- Copy to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
