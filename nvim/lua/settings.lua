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
o.hlsearch = true
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

-- Format Relay GraphQL queries in file
vim.cmd([[command FormatRelay execute "!yarn rescript-relay-cli format-single-graphql %"]])

-- Close all buffers except the current one
vim.cmd([[command BufOnly silent! execute "%bd|e#|bd#"]])
